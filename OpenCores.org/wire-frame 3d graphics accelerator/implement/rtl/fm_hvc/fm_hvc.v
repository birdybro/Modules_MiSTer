//=======================================================================
// Project Monophony
//   Wire-Frame 3D Graphics Accelerator IP Core
//
// File:
//   fm_hvc.v
//
// Abstract:
//   VGA LCD Controller
//
// Author:
//   Kenji Ishimaru (info.info.wf3d@gmail.com)
//
//======================================================================
//
// Copyright (c) 2015, Kenji Ishimaru
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
//  -Redistributions of source code must retain the above copyright notice,
//   this list of conditions and the following disclaimer.
//  -Redistributions in binary form must reproduce the above copyright notice,
//   this list of conditions and the following disclaimer in the documentation
//   and/or other materials provided with the distribution.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
// THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
// PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
// CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
// EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
// PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
// OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
// WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
// OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
// EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// Revision History
// 2016/08/14 64-bit bus support

module fm_hvc (
    clk_core,
    clk_vi,
    rst_x,
    // configuration registers
    i_video_start,
    i_fb0_offset,
    i_fb1_offset,
    i_color_mode,
    i_front_buffer,
    // status out
    o_vint_x,
    o_vint_edge,
    // dram if
    o_req,
    o_adrs,
    o_len,
    i_ack,
    i_rstr,
    i_rd,
    // video out
    clk_vo,
    o_r,
    o_g,
    o_b,
    o_vsync_x,
    o_hsync_x,
    o_blank_x,
    o_de
);
localparam P_IB_LEN_WIDTH  = 'd6;
`ifdef PP_BUSWIDTH_64
localparam P_IB_BASE_WIDTH = 'd12;
localparam P_IB_ADDR_WIDTH = 'd29;
localparam P_IB_DATA_WIDTH = 'd64;
`else
localparam P_IB_BASE_WIDTH = 'd7;
localparam P_IB_ADDR_WIDTH = 'd24;
localparam P_IB_DATA_WIDTH = 'd32;
`endif
//////////////////////////////////
// I/O port definition
//////////////////////////////////
    input          clk_core;
    input          clk_vi;     // 25MHz
    input          rst_x;
    // configuration registers
    input          i_video_start;
    input  [P_IB_BASE_WIDTH-1:0]   i_fb0_offset;
    input  [P_IB_BASE_WIDTH-1:0]   i_fb1_offset;
    input  [1:0]   i_color_mode;
    input          i_front_buffer;
    // status out
    output         o_vint_x;
    output         o_vint_edge;
    // dram if
    output        o_req;
    output [P_IB_ADDR_WIDTH-1:0]
                  o_adrs;
    output [P_IB_LEN_WIDTH-1:0]
                  o_len;
    input         i_ack;
    input         i_rstr;
    input  [P_IB_DATA_WIDTH-1:0]
                  i_rd;

    output         clk_vo;
    output [7:0]   o_r;
    output [7:0]   o_g;
    output [7:0]   o_b;
    output         o_vsync_x;
    output         o_hsync_x;
    output         o_blank_x;
    output         o_de;

//////////////////////////////////
// wire
//////////////////////////////////
    wire   [7:0]   w_test_r;
    wire   [7:0]   w_test_g;
    wire   [7:0]   w_test_b;

    wire           w_vsync_i;
    wire           w_hsync_i;
    wire           w_active;
    wire           w_first_line;
    wire           w_fifo_available;
    wire           w_fifo_available_ack;
//////////////////////////////////
// assign
//////////////////////////////////
    assign clk_vo = clk_vi;
///////////////////////////
//  module instance
//////////////////////////

fm_hvc_core fm_hvc_core (
    .clk_vi(clk_vi),
    .rst_x(rst_x),
    // configuration registers
    .i_video_start(i_video_start),
    // control out (only for internal use)
    .o_vsync_i(w_vsync_i),
    .o_hsync_i(w_hsync_i),
    // video out timing
    .o_active(w_active),
    .o_first_line(w_first_line),
    .o_r(w_test_r),
    .o_g(w_test_g),
    .o_b(w_test_b),
    .o_vsync_x(o_vsync_x),
    .o_hsync_x(o_hsync_x),
    .o_blank_x(o_blank_x),
    .o_de(o_de)
);

`ifdef PP_USE_AXI
`ifdef PP_BUSWIDTH_64
`else
   wire w_req;
   wire [P_IB_ADDR_WIDTH-1:0]
       w_adrs;
   wire [P_IB_LEN_WIDTH-1:0]
       w_len;
   wire w_ack;
fm_rd_split fm_rd_split (
    .clk_core(clk_core),
    .rst_x(rst_x),
    .i_req(w_req),
    .i_adrs(w_adrs),
    .i_len(w_len),
    .o_ack(w_ack),
    // dram if
    .o_req(o_req),
    .o_adrs(o_adrs),
    .o_len(o_len),
    .i_ack(i_ack)
);
`endif
`endif
   
fm_hvc_dma #(.P_IB_ADDR_WIDTH(P_IB_ADDR_WIDTH),
             .P_IB_LEN_WIDTH(P_IB_LEN_WIDTH))
  fm_hvc_dma (
    .clk_core(clk_core),
    .rst_x(rst_x),
    .i_color_mode(i_color_mode),
    .i_video_start(i_video_start),
    .i_vsync(w_vsync_i),
    .i_hsync(w_hsync_i),
    .i_fb0_offset(i_fb0_offset),
    .i_fb1_offset(i_fb1_offset),
    .i_front_buffer(i_front_buffer),
    .i_fifo_available(w_fifo_available),
    .o_fifo_available_ack(w_fifo_available_ack),
    .o_vsync(o_vint_x),
    .o_vsync_edge(o_vint_edge),
    // dram if
`ifdef PP_USE_AXI
`ifdef PP_BUSWIDTH_64
    .o_req(o_req),
    .o_adrs(o_adrs),
    .o_len(o_len),
    .i_ack(i_ack)
`else
    .o_req(w_req),
    .o_adrs(w_adrs),
    .o_len(w_len),
    .i_ack(w_ack)
`endif
`else
    .o_req(o_req),
    .o_adrs(o_adrs),
    .o_len(o_len),
    .i_ack(i_ack)
`endif
);

fm_hvc_data fm_hvc_data (
    .clk_core(clk_core),
    .clk_vi(clk_vi),
    .rst_x(rst_x),
    // sdram interface
    .i_rstr(i_rstr),
    .i_rd(i_rd),
    // timing control
    .i_h_active(w_active),
    .i_first_line(w_first_line),
    .i_hsync(w_hsync_i),
    .i_vsync(w_vsync_i),
    .o_fifo_available(w_fifo_available),
    .i_fifo_available_ack(w_fifo_available_ack),
    // configuration
    .i_video_start(i_video_start),
    .i_color_mode(i_color_mode),
    // test color input
    .i_test_r(w_test_r),
    .i_test_g(w_test_g),
    .i_test_b(w_test_b),
    // color out
    .o_r(o_r),
    .o_g(o_g),
    .o_b(o_b),
    .o_a()
);


endmodule
