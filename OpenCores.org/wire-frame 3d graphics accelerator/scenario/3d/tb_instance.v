//=======================================================================
// Project Monophony
//   Wire-Frame 3D Graphics Accelerator IP Core
//
// File:
//  tb_instance.v
//
// Abstract:
//   module instantiation
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

// 3D Core
parameter P_SEED = 'd0;
initial $display("P_SEED %d",P_SEED);
   
  // system
  reg         clk_core;
  reg         rst_x;
  wire        o_int;
  // register I/F
  reg         i_req_s;
  reg         i_wr_s;
  reg  [7:0]  i_adrs_s;
  reg         o_ack_s;
  reg  [3:0]  i_be_s;
  reg  [31:0] i_dbw_s;
  reg         o_strr_s;
  reg  [31:0] o_dbr_s;

  reg         i_req_s_d;
  reg         i_wr_s_d;
  reg  [7:0]  i_adrs_s_d;
  wire        o_ack_s_d;
  reg  [3:0]  i_be_s_d;
  reg  [31:0] i_dbw_s_d;
  wire        o_strr_s_d;
  wire [31:0] o_dbr_s_d;

  // Master I/F
  wire        w_req_m;
  wire        w_wr_m;
  wire [31:0] w_adrs_m;
  wire [2:0]  w_len_m;
  wire        w_ack_m; 
  wire [3:0]  w_be_m;
  wire [31:0] w_dbw_m;
  wire        w_strr_m;
  wire [31:0] w_dbr_m;

always @* begin
  i_req_s_d <= #1 i_req_s;
  i_wr_s_d <= #1 i_wr_s;
  i_adrs_s_d <= #1 i_adrs_s;
  o_ack_s <= #1 o_ack_s_d;
  i_be_s_d <= #1 i_be_s;
  i_dbw_s_d <= #1 i_dbw_s;
  o_strr_s <= #1 o_strr_s_d;
  o_dbr_s <= #1 o_dbr_s_d;

end

fm_3d_core u_3d_core (
  // system
  .clk_i(clk_core),
  .rst_i(~rst_x),
  .int_o(o_int),
  // register I/F
  .i_req_s(i_req_s_d),
  .i_wr_s(i_wr_s_d),
  .i_adrs_s(i_adrs_s_d),
  .o_ack_s(o_ack_s_d),
  .i_be_s(i_be_s_d),
  .i_dbw_s(i_dbw_s_d),
  .o_strr_s(o_strr_s_d),
  .o_dbr_s(o_dbr_s_d),
  // Master I/F
  .o_req_m(w_req_m),
  .o_wr_m(w_wr_m),
  .o_adrs_m(w_adrs_m),
  .o_len_m(w_len_m),
  .i_ack_m(w_ack_m),
  .o_be_m(w_be_m),
  .o_dbw_m(w_dbw_m),
  .i_strr_m(w_strr_m),
  .i_dbr_m(w_dbr_m)
);
  
sram_slave #(
  .P_ADRS_WIDTH(22),
  .P_BE_WIDTH(4),
  .P_DATA_WIDTH(32),
  .P_BLEN_WIDTH(3),
  .P_SEED(P_SEED)) u_sram_slave (
    .clk_core(clk_core),
    .rst_x(rst_x),
    .i_req(w_req_m),
    .i_adrs(w_adrs_m[23:2]),  // word address
    .i_wr(w_wr_m),
    .i_blen(w_len_m),
    .o_ack(w_ack_m),
    .i_strw(w_req_m & w_wr_m),
    .i_be(w_be_m),
    .i_dbw(w_dbw_m),
    .o_ackw(),
    .o_strr(w_strr_m),
    .o_dbr(w_dbr_m)
 );
