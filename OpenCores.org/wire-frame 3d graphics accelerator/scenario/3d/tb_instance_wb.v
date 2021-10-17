//=======================================================================
// Project Monophony
//   Wire-Frame 3D Graphics Accelerator IP Core
//
// File:
//  tb_instance_wb.v
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
  reg         s_wb_stb_i;
  reg         s_wb_we_i;
  reg  [7:0]  s_wb_adr_i;
  reg        s_wb_ack_o;
  reg  [3:0]  s_wb_sel_i;
  reg  [31:0] s_wb_dat_i;
  reg [31:0] s_wb_dat_o;
  reg         s_wb_stb_i_d;
  reg         s_wb_we_i_d;
  reg  [7:0]  s_wb_adr_i_d;
  wire        s_wb_ack_o_d;
  reg  [3:0]  s_wb_sel_i_d;
  reg  [31:0] s_wb_dat_i_d;
  wire [31:0] s_wb_dat_o_d;
  // Master I/F
  wire        w_req_m;
  wire        w_wr_m;
  wire [31:2] w_adrs_m;
  wire [2:0]  w_len_m;
  wire        w_ack_m; 
  wire [3:0]  w_be_m;
  wire [31:0] w_dbw_m;
  wire        w_strr_m;
  wire [31:0] w_dbr_m;

always @* begin
  s_wb_stb_i_d <= #1 s_wb_stb_i;
  s_wb_we_i_d <= #1 s_wb_we_i;
  s_wb_adr_i_d <= #1 s_wb_adr_i;
  s_wb_ack_o <= #1 s_wb_ack_o_d;
  s_wb_sel_i_d <= #1 s_wb_sel_i;
  s_wb_dat_i_d <= #1 s_wb_dat_i;
  s_wb_dat_o <= #1 s_wb_dat_o_d;
end

fm_3d_core u_3d_core (
  // system
  .clk_i(clk_core),
  .rst_i(~rst_x),
  .int_o(o_int),
  // register I/F
  .s_wb_stb_i(s_wb_stb_i_d),
  .s_wb_we_i(s_wb_we_i_d),
  .s_wb_adr_i(s_wb_adr_i_d[7:2]),
  .s_wb_ack_o(s_wb_ack_o_d),
  .s_wb_sel_i(s_wb_sel_i_d),
  .s_wb_dat_i(s_wb_dat_i_d),
  .s_wb_dat_o(s_wb_dat_o_d),
  // Master I/F
  .m_wb_stb_o(w_req_m),
  .m_wb_we_o(w_wr_m),
  .m_wb_adr_o(w_adrs_m),
  .m_wb_ack_i(w_ack_m),
  .m_wb_sel_o(w_be_m),
  .m_wb_dat_o(w_dbw_m),
  .m_wb_dat_i(w_dbr_m)
);
  
sram_slave_wb #(
  .P_ADRS_WIDTH(24),
  .P_BE_WIDTH(4),
  .P_DATA_WIDTH(32),
  .P_BLEN_WIDTH(3),
  .P_SEED(P_SEED)) u_sram_slave (
    .clk_core(clk_core),
    .rst_x(rst_x),
    .i_req(w_req_m),
    .i_adrs(w_adrs_m[25:2]),  // word address
    .i_wr(w_wr_m),
    .i_blen(3'd1),
    .o_ack(w_ack_m),
    .i_strw(w_req_m & w_wr_m),
    .i_be(w_be_m),
    .i_dbw(w_dbw_m),
    .o_ackw(),
    .o_strr(w_strr_m),
    .o_dbr(w_dbr_m)
 );
