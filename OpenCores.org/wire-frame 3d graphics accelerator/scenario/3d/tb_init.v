//=======================================================================
// Project Monophony
//   Wire-Frame 3D Graphics Accelerator IP Core
//
// File:
//  tb_init.v
//
// Abstract:
//   Initialize simulation registers
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

initial begin
  clk_core = 1;
  forever begin
    #5 clk_core = ~clk_core;
  end
end
`ifdef D3D_WISHBONE
initial begin
  s_wb_stb_i = 0;
  s_wb_we_i = 0;
  s_wb_adr_i = 0;
  s_wb_ack_o = 0;
  s_wb_sel_i = 0;
  s_wb_dat_i = 0;
  s_wb_dat_o = 0;
  s_wb_stb_i_d = 0;
  s_wb_we_i_d = 0;
  s_wb_adr_i_d = 0;
  s_wb_sel_i_d = 0;
  s_wb_dat_i_d = 0;
end
`else
initial begin
  i_req_s = 0;
  i_wr_s = 0;
  i_adrs_s = 0;
  o_ack_s = 0;
  i_be_s = 0;
  i_dbw_s = 0;
  o_strr_s = 0;
  o_dbr_s = 0;
  i_req_s_d = 0;
  i_wr_s_d = 0;
  i_adrs_s_d = 0;
  i_be_s_d = 0;
  i_dbw_s_d = 0;
end
`endif
   



