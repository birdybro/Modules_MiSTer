//=======================================================================
// Project Monophony
//   Wire-Frame 3D Graphics Accelerator IP Core
//
// File:
//  tb_task.v
//
// Abstract:
//   simulation tasks
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

`ifdef D3D_WISHBONE
task reg_write;
  input [7:0] adrs;
  input [3:0] be;
  input [31:0] wd;
  begin
    s_wb_stb_i = 1;
    s_wb_we_i = 1;
    s_wb_adr_i = adrs;
    s_wb_sel_i = be;
    s_wb_dat_i = wd;
    @(posedge clk_core);
    while (!s_wb_ack_o)
      @(posedge clk_core);
    s_wb_stb_i = 0;
    @(posedge clk_core);
  end
endtask

task reg_read;
  input [7:0] adrs;
  output [31:0] rd;
  begin
    s_wb_stb_i = 1;
    s_wb_we_i = 0;
    s_wb_adr_i = adrs;
    @(posedge clk_core);
    while (!s_wb_ack_o)
      @(posedge clk_core);
    s_wb_stb_i = 0;
    rd = s_wb_dat_o; 
    @(posedge clk_core);
 end
endtask
`else
task reg_write;
  input [7:0] adrs;
  input [3:0] be;
  input [31:0] wd;
  begin
    i_req_s = 1;
    i_wr_s = 1;
    i_adrs_s = adrs;
    i_be_s = be;
    i_dbw_s = wd;
    @(posedge clk_core);
    while (!o_ack_s)
      @(posedge clk_core);
    i_req_s = 0;
    @(posedge clk_core);
  end
endtask

task reg_read;
  input [7:0] adrs;
  output [31:0] rd;
  begin
    i_req_s = 1;
    i_wr_s = 0;
    i_adrs_s = adrs;
    @(posedge clk_core);
    while (!o_ack_s)
      @(posedge clk_core);
    while (!o_strr_s) begin
      i_req_s = 0;
      @(posedge clk_core);
    end
    rd = o_dbr_s; 
    @(posedge clk_core);
 end
endtask

`endif

