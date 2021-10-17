//=======================================================================
// Project Monophony
//   Wire-Frame 3D Graphics Accelerator IP Core
//
// File:
//   fm_hvc_data.v
//
// Abstract:
//   LCD output color data construction
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

module fm_hvc_data (
    clk_core,
    clk_vi,
    rst_x,
    // sdram interface
    i_rstr,
    i_rd,
    // timing input
    i_h_active,
    i_first_line,
    i_hsync,
    i_vsync,
    o_fifo_available,
    i_fifo_available_ack,
    // configuration
    i_video_start,
    i_color_mode,
    // test color input
    i_test_r,
    i_test_g,
    i_test_b,
    // color out
    o_r,
    o_g,
    o_b,
    o_a
);

//////////////////////////////////
// I/O port definition
//////////////////////////////////
    input          clk_core;
    input          clk_vi;     // 25MHz
    input          rst_x;
    // sdram interface
    input          i_rstr;
`ifdef PP_BUSWIDTH_64
    input  [63:0]  i_rd;
`else
    input  [31:0]  i_rd;
`endif
    // timing input
    input          i_h_active;
    input          i_first_line;
    input          i_hsync;
    input          i_vsync;
    output         o_fifo_available;
    input          i_fifo_available_ack;
    // configuration
    input          i_video_start;
    input  [1:0]   i_color_mode;
    // test color input
    input  [7:0]  i_test_r;
    input  [7:0]  i_test_g;
    input  [7:0]  i_test_b;

    output [7:0]   o_r;
    output [7:0]   o_g;
    output [7:0]   o_b;
    output [7:0]   o_a;
//////////////////////////////////
// reg
//////////////////////////////////
    reg    [9:0]   r_pix_cnt;
    reg            r_fifo_available;

    reg    [7:0]   r_r;
    reg    [7:0]   r_g;
    reg    [7:0]   r_b;

    reg    [7:0]   r_r_neg;
    reg    [7:0]   r_g_neg;
    reg    [7:0]   r_b_neg;

    reg            r_fifo_available_ack_1z;
    reg            r_fifo_available_ack_2z;
    reg            r_fifo_available_ack_3z;

//////////////////////////////////
// wire
//////////////////////////////////
    wire           w_rstr_base;
    wire           w_rstr_upper;
    wire   [15:0]  w_di;
    wire   [31:0]  w_do;
    wire   [31:0]  w_do_normal;
    wire   [7:0]   w_r_aa;
    wire   [7:0]   w_g_aa;
    wire   [7:0]   w_b_aa;
    wire   [7:0]   w_r_f;
    wire   [7:0]   w_g_f;
    wire   [7:0]   w_b_f;

    wire   [7:0]   w_r;
    wire   [7:0]   w_g;
    wire   [7:0]   w_b;

    wire           w_ren;
    wire           w_fifo_reset_x;
    wire           w_fifo_available_ack_rise;
    wire           w_pix_av_c0;
    wire           w_pix_av_c2;
    wire           w_pix_av_c3;
   
//////////////////////////////////
// assign
//////////////////////////////////
    assign w_fifo_available_ack_rise = r_fifo_available_ack_2z &
                                       !r_fifo_available_ack_3z;
    assign w_fifo_reset_x = i_vsync & rst_x;
    assign w_rstr_base = i_rstr;
    assign w_rstr_upper = i_rstr;
    assign w_ren = i_h_active;

    assign w_r_f = w_do_normal[31:24];
    assign w_g_f = w_do_normal[23:16];
    assign w_b_f = w_do_normal[15:8];
    assign w_do_normal = f_get_color(w_di,i_color_mode);

    assign w_b = (!i_video_start) ? i_test_b :
                 (i_h_active )?     w_b_f :
                                    8'h00;
    assign w_g = (!i_video_start) ? i_test_g :
                  (i_h_active )?    w_g_f :
                                    8'h00;
    assign w_r = (!i_video_start) ? i_test_r :
                  (i_h_active )?    w_r_f :
                                    8'h00;
    assign o_b = r_b;  //r_b_neg
    assign o_g = r_g;  // r_g_neg
    assign o_r = r_r;  // r_r_neg

    assign o_fifo_available = r_fifo_available;

    assign w_pix_av_c0 = ((i_color_mode == 'd0)&(r_pix_cnt == 'd63));
    assign w_pix_av_c2 = ((i_color_mode == 'd2)&(r_pix_cnt == 'd127));
    assign w_pix_av_c3 = ((i_color_mode == 'd3)&(r_pix_cnt == 'd255));
//////////////////////////////////
// always
//////////////////////////////////

    always @(posedge clk_vi or negedge rst_x) begin
        if (~rst_x) begin
            r_pix_cnt <= 10'd0;
        end else begin
            if (~i_hsync) r_pix_cnt <= 10'd0;
	    else if (w_pix_av_c0|w_pix_av_c2|w_pix_av_c3)r_pix_cnt <= 10'd0;
            else if (w_ren) r_pix_cnt <= r_pix_cnt + 1'b1;
        end
    end

    always @(posedge clk_vi or negedge rst_x) begin
        if (~rst_x) begin
            r_fifo_available <= 1'b0;
        end else begin
            if (w_pix_av_c0|w_pix_av_c2|w_pix_av_c3) r_fifo_available <= 1'b1;  // 32 x 2
            else if (~i_hsync | w_fifo_available_ack_rise) r_fifo_available <= 1'b0;
        end
    end


    always @(posedge clk_vi or negedge rst_x) begin
        if (~rst_x) begin
            r_fifo_available_ack_1z <= 1'b0;
            r_fifo_available_ack_2z <= 1'b0;
            r_fifo_available_ack_3z <= 1'b0;
        end else begin
            r_fifo_available_ack_1z <= i_fifo_available_ack;
            r_fifo_available_ack_2z <= r_fifo_available_ack_1z;
            r_fifo_available_ack_3z <= r_fifo_available_ack_2z;
        end
    end

    always @(posedge clk_vi) begin
        r_r <= w_r;
        r_g <= w_g;
        r_b <= w_b;
    end

//////////////////////////////////
// function
//////////////////////////////////
    function [31:0] f_get_color;
        input [15:0] idata;
        input [1:0]  mode;
        reg [7:0] r;
        reg [7:0] g;
        reg [7:0] b;
        reg [7:0] a;
        begin
            case (mode)
                2'b00 : begin
                    // color mode 5:6:5
                    r = {idata[15:11],idata[15:13]};
                    g = {idata[10:5],idata[10:9]};
                    b = {idata[4:0],idata[4:2]};
                    a = 8'h0;
                end
                2'b01 : begin
                    // color mode 5:5:5:1
                    r = {idata[15:11],idata[15:13]};
                    g = {idata[10:6],idata[10:8]};
                    b = {idata[5:1],idata[5:3]};
                    a = {idata[0],7'b0};
                end
                2'b10 : begin
                    // color mode 2:3:3
                    r = {'d4{idata[7:6]}};
                    g = {idata[5:3],idata[5:3],idata[5:4]};
                    b = {idata[2:0],idata[2:0],idata[2:1]};
                    a = 8'h0;
                end
                default : begin
                    // color mode 1:2:2
                    r = {'d8{idata[3]}};
                    g = {'d4{idata[2:1]}};
                    b = {'d8{idata[0]}};
                    a = 8'h0;
                end
            endcase
            f_get_color = {r,g,b,a};
        end
    endfunction


//////////////////////////////////
// module instance
//////////////////////////////////
// 32bit x 128 entry fifo for current line
fm_afifo fm_afifo_c (
  .clk_core(clk_core),
  .clk_vi(clk_vi),
  .rst_x(w_fifo_reset_x),
  .i_color_mode(i_color_mode),
  .i_wstrobe(w_rstr_base),
  .i_dt(i_rd),
  .o_full(),
  .i_renable(w_ren),
  .o_dt(w_di),
  .o_empty(),
  .o_dnum()
);


endmodule
