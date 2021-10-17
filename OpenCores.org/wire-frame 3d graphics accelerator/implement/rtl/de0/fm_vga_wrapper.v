//=======================================================================
// Project Monophony
//   Wire-Frame 3D Graphics Accelerator IP Core
//
// File:
//   fm_vga_wrapper.v
//
// Abstract:
//   AVALON VGA Master
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

module fm_vga_wrapper (
  // Avalon-MM Slave Interface
  input           clk_core,
  input           rst_x,
  input  [3:0]    i_avs_adr,
  input  [3:0]    i_avs_be,
  input           i_avs_r,
  output [31:0]   o_avs_rd,
  input           i_avs_w,
  input  [31:0]   i_avs_wd,
  output          o_avs_wait,
  // Avalon-MM Master Interface
  output [23:0]   o_avm_adr,
  output [3:0]    o_avm_be,
  output [5:0]    o_avm_blen,
  output          o_avm_r,
  input           i_avm_wait,
  input           i_avm_rvalid,
  input  [31:0]   i_avm_rd,
  // Vsync int
  output o_int,
  // VGA output
  input        clk25m,
  output [3:0] o_cr,
  output [3:0] o_cg,
  output [3:0] o_cb,
  output o_vsync_x,
  output o_hsync_x
);

// bridge
  wire        w_req;
  wire        w_wr;
  wire [3:0]  w_adrs;
  wire        w_ack;
  wire [3:0]  w_be;
  wire [31:0] w_wd;
  wire        w_rstr;
  wire [31:0] w_rd;

  wire w_video_start;
  wire [6:0] w_fb0_offset;
  wire [6:0] w_fb1_offset;
  wire [1:0] w_color_mode;
  wire w_front_buffer;
   
  wire w_vint_x;
  wire w_vint_edge;

  wire [7:0] w_cr;
  wire [7:0] w_cg;
  wire [7:0] w_cb;
  wire [25:0] w_avm_adr;

  assign o_cr = w_cr[7:4];
  assign o_cg = w_cg[7:4];
  assign o_cb = w_cb[7:4];
  assign o_avm_adr = {w_avm_adr,2'b00};  // byte address
  assign o_avm_be = 4'hf;

fm_avalon #(.P_AVALON_ADR_WIDTH(4)) u_avalon (
  .clk_core(clk_core),
  .rst_x(rst_x),
  // AVALON slave bus
  .i_av_adr(i_avs_adr),
  .i_av_be(i_avs_be),
  .i_av_r(i_avs_r),
  .o_av_rd(o_avs_rd),
  .i_av_w(i_avs_w),
  .i_av_wd(i_avs_wd),
  .o_av_wait(o_avs_wait),
  // internal side
  .o_req(w_req),
  .o_wr(w_wr),
  .o_adrs(w_adrs),
  .i_ack(w_ack),
  .o_be(w_be),
  .o_wd(w_wd),
  .i_rstr(w_rstr),
  .i_rd(w_rd)
);

// System controller
fm_hsys fm_hsys (
  .clk_core(clk_core),
  .rst_x(rst_x),
  // internal interface
  .i_req(w_req),
  .i_wr(w_wr),
  .i_adrs(w_adrs),
  .o_ack(w_ack),
  .i_be(w_be),
  .i_wd(w_wd),
  .o_rstr(w_rstr),
  .o_rd(w_rd),
  // configuration output
  //   Video controller
  .o_video_start(w_video_start),
  .o_aa_en(),
  .o_fb0_offset(w_fb0_offset),
  .o_fb1_offset(w_fb1_offset),
  .o_color_mode(w_color_mode),
  .o_front_buffer(w_front_buffer),
  .o_fb_blend_en(),
  // vint
  .i_vint_x(w_vint_x),
  .i_vint_edge(w_vint_edge),
  // vertex dma int
  .i_vtx_int(1'b0),
  // int out
  .o_int(o_int)
);

// Video controller
fm_hvc fm_hvc (
  .clk_core(clk_core),
  .clk_vi(clk25m),
  .rst_x(rst_x),
  // configuration registers
  .i_video_start(w_video_start),
  .i_fb0_offset(w_fb0_offset),
  .i_fb1_offset(w_fb1_offset),
  .i_color_mode(w_color_mode),
  .i_front_buffer(w_front_buffer),
  // status out
  .o_vint_x(w_vint_x),
  .o_vint_edge(w_vint_edge),
  // dram if
  .o_req(o_avm_r),
  .o_adrs(w_avm_adr),
  .o_len(o_avm_blen),
  .i_ack(!i_avm_wait),
  .i_rstr(i_avm_rvalid),
  .i_rd(i_avm_rd),
  // video out
  .clk_vo(),
  .o_r(w_cr),
  .o_g(w_cg),
  .o_b(w_cb),
  .o_vsync_x(o_vsync_x),
  .o_hsync_x(o_hsync_x),
  .o_blank_x(),
  .o_de()
);

endmodule
