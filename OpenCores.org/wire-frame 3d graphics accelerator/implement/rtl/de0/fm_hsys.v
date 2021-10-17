//=======================================================================
// Project Monophony
//   Wire-Frame 3D Graphics Accelerator IP Core
//
// File:
//   fm_hsys.v
//
// Abstract:
//   System register module
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

module fm_hsys (
    clk_core,
    rst_x,
    // internal interface
    i_req,
    i_wr,
    i_adrs,
    o_ack,
    i_be,
    i_wd,
    o_rstr,
    o_rd,
    // configuration output
    //   Video controller
    o_video_start,
    o_aa_en,
    o_fb0_offset,
    o_fb1_offset,
    o_color_mode,
    o_front_buffer,
    o_fb_blend_en,
    // status from Video controller
    i_vint_x,
    i_vint_edge,
    // status from 3D core
    i_vtx_int,
    // int out
    o_int
);
//////////////////////////////////
// I/O port definition
//////////////////////////////////
    input          clk_core;
    input          rst_x;
    // internal interface
    input          i_req;
    input          i_wr;
    input  [3:0]   i_adrs;
    output         o_ack;
    input  [3:0]   i_be;
    input  [31:0]  i_wd;
    output         o_rstr;
    output [31:0]  o_rd;
    // configuration output
    //   Video controller
    output         o_video_start;
    output [2:0]   o_aa_en;
    output [6:0]   o_fb0_offset;
    output [6:0]   o_fb1_offset;
    output [1:0]   o_color_mode;
    output         o_front_buffer;
    output         o_fb_blend_en;
    // status from Video controller
    input          i_vint_x;
    input          i_vint_edge;
    // status from 3D core
    input          i_vtx_int;
    // int out
    output reg     o_int;

//////////////////////////////////
// regs 
//////////////////////////////////
    reg            r_video_start;
    reg    [2:0]   r_aa_en;
    reg    [6:0]   r_fb0_offset;
    reg    [6:0]   r_fb1_offset;
    reg    [1:0]   r_color_mode;
    reg            r_fb_blend_en;

    reg            r_rstr;
    reg    [31:0]  r_rd;

    reg            r_vint_x;
    reg    [2:0]   r_mask;
    reg            r_front_buffer;

    reg            r_vint_clear;
//////////////////////////////////
// wire
//////////////////////////////////
    wire           w_hit0;
    wire           w_hit1;
    wire           w_hit2;
    wire           w_hit3;
    wire           w_hit4;
    wire           w_hit5;
    wire           w_hit8;
    wire           w_hit9;
    wire           w_hitA;
    wire           w_hitB;
    wire           w_hitC;
    wire           w_hitD;
    wire           w_hitE;
    wire           w_hitF;
    wire           w_hit10;
    wire           w_hit11;
    wire           w_hit12;
    wire           w_hit13;

    wire           w_hit0_w;
    wire           w_hit1_w;
    wire           w_hit2_w;
    wire           w_hit3_w;
    wire           w_hit4_w;
    wire           w_hit5_w;
    wire           w_hit9_w;
    wire           w_hitA_w;
    wire           w_hitB_w;

    wire   [31:0]  w_rd;
    wire           w_rstr;
    wire           w_vint_x;
    wire           w_vint_on;
    wire   [2:0]   w_int;
//////////////////////////////////
// assign
//////////////////////////////////
assign w_hit0 = (i_adrs[3:0] == 4'h0);  // 0
assign w_hit1 = (i_adrs[3:0] == 4'h1);  // 4
assign w_hit2 = (i_adrs[3:0] == 4'h2);  // 8
assign w_hit3 = (i_adrs[3:0] == 4'h3);  // c
assign w_hit4 = (i_adrs[3:0] == 4'h4);  // 10
assign w_hit5 = (i_adrs[3:0] == 4'h5);  // 14
assign w_hit8 = (i_adrs[3:0] == 4'h8);  // 20
assign w_hit9 = (i_adrs[3:0] == 4'h9);  // 24
assign w_hitA = (i_adrs[3:0] == 4'ha);  // 28
assign w_hitB = (i_adrs[3:0] == 4'hb);  // 2c

assign w_hit0_w = w_hit0 & i_wr & i_req;
assign w_hit1_w = w_hit1 & i_wr & i_req;
assign w_hit2_w = w_hit2 & i_wr & i_req;
assign w_hit3_w = w_hit3 & i_wr & i_req;
assign w_hit4_w = w_hit4 & i_wr & i_req;
assign w_hit5_w = w_hit5 & i_wr & i_req;
assign w_hit9_w = w_hit9 & i_wr & i_req;
assign w_hitA_w = w_hitA & i_wr & i_req;
assign w_hitB_w = w_hitB & i_wr & i_req;

assign w_rstr = i_req & !i_wr;
assign w_rd = (w_hit0) ? {16'hbeef,5'b0,r_aa_en,7'b0,r_video_start} :
              (w_hit1) ? {6'b0,r_fb0_offset,19'b0} :
              (w_hit2) ? {6'b0,r_fb1_offset,19'b0} :
              (w_hit5) ? {30'b0,r_color_mode} :
              (w_hit8) ? {29'b0,i_vtx_int,!i_vint_x,!r_vint_x} :
              (w_hit9) ? {31'b0,r_vint_clear} :
              (w_hitA) ? {29'b0,r_mask} :
                         {31'b0,r_front_buffer};

             
assign w_vint_on = i_vint_edge;  // falling edge detect
assign w_vint_x = ~r_vint_clear | i_vint_x;

assign w_int[0] = (r_mask[0]) ? 1'b0 : ~r_vint_x;
assign w_int[1] = 1'b0;
assign w_int[2] = (r_mask[2]) ? 1'b0 : i_vtx_int;

assign o_rstr  = r_rstr;
assign o_rd = r_rd;
assign o_ack = i_req;

assign o_video_start = r_video_start;
assign o_aa_en = r_aa_en;
assign o_fb0_offset = r_fb0_offset;
assign o_fb1_offset = r_fb1_offset;
assign o_color_mode = r_color_mode;
assign o_front_buffer = r_front_buffer;
assign o_fb_blend_en = r_fb_blend_en;

//////////////////////////////////
// always
//////////////////////////////////

always @(posedge clk_core or negedge rst_x) begin
    if (~rst_x) begin
        r_video_start <= 1'b0;
    end else begin
        if (w_hit0_w) begin
            if (i_be[0]) r_video_start   <= i_wd[0];
            if (i_be[1]) r_aa_en         <= i_wd[10:8];
            if (i_be[2]) r_fb_blend_en   <= i_wd[16];
        end
    end
end

// register holds 32-bit address
always @(posedge clk_core or negedge rst_x) begin
    if (~rst_x) begin
        r_fb0_offset <= 7'b0;
    end else begin
        if (w_hit1_w) begin
            if (i_be[2]) r_fb0_offset[4:0] <= i_wd[23:19];
            if (i_be[3]) r_fb0_offset[6:5] <= i_wd[25:24];
        end
    end
end

always @(posedge clk_core or negedge rst_x) begin
    if (~rst_x) begin
        r_fb1_offset <= 7'b0;
    end else begin
        if (w_hit2_w) begin
            if (i_be[2]) r_fb1_offset[4:0] <= i_wd[23:19];
            if (i_be[3]) r_fb1_offset[6:5] <= i_wd[25:24];
        end
    end
end

always @(posedge clk_core or negedge rst_x) begin
    if (~rst_x) begin
        r_color_mode <= 2'b0;
    end else begin
        if (w_hit5_w) begin
            if (i_be[0]) r_color_mode   <= i_wd[1:0];
        end
    end
end

always @(posedge clk_core or negedge rst_x) begin
    if (~rst_x) begin
        r_vint_clear <= 1'b0;
    end else begin
        if (w_hit9_w) begin
            if (i_be[0]) r_vint_clear <= i_wd[0];
        end else if (w_vint_on) begin
            r_vint_clear <= 1'b1;
        end
    end
end

always @(posedge clk_core or negedge rst_x) begin
    if (~rst_x) begin
        r_mask <= 2'b11;
    end else begin
        if (w_hitA_w) begin
            if (i_be[0]) r_mask   <= i_wd[1:0];
        end
    end
end

always @(posedge clk_core or negedge rst_x) begin
    if (~rst_x) begin
        r_front_buffer <= 1'b0;
    end else begin
        if (w_hitB_w) begin
            if (i_be[0]) r_front_buffer   <= i_wd[0];
        end
    end
end


always @(posedge clk_core) begin
    r_rd <= w_rd;
end

always @(posedge clk_core or negedge rst_x) begin
    if (~rst_x) begin
        r_rstr <= 1'b0;
    end else begin
        r_rstr <= w_rstr;
    end
end


always @(posedge clk_core or negedge rst_x) begin
    if (~rst_x) begin
        r_vint_x <= 1'b1;
    end else begin
        r_vint_x <= w_vint_x;
    end
end

always @(posedge clk_core or negedge rst_x) begin
    if (~rst_x) begin
        o_int <= 1'b0;
    end else begin
        o_int <= |w_int;
    end
end

endmodule
