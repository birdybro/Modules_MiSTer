//=======================================================================
// Project Monophony
//   Wire-Frame 3D Graphics Accelerator IP Core
//
// File:
//   fm_avalon.v
//
// Abstract:
//   AVALON interface
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

`include "fm_3d_define.v"
module fm_3d_wrapper (
  // system
  input clk_core,
  input rst_x,
  output o_int,
  // avalon slave I/F
  input  [5:0]    i_avs_adr,
  input  [3:0]    i_avs_be,
  input           i_avs_r,
  output [31:0]   o_avs_rd,
  input           i_avs_w,
  input  [31:0]   i_avs_wd,
  output          o_avs_wait,
  // avalon geometry DMA I/F
  output [25:0]   o_avm_adr,
  output [3:0]    o_avm_be,
  output [31:0]   o_avm_wd,
  output [2:0]    o_avm_blen,
  output          o_avm_r,
  output          o_avm_w,
  input           i_avm_wait,
  input           i_avm_rvalid,
  input  [31:0]   i_avm_rd
);

wire w_req;
wire w_wr;
wire [5:0] w_adrs;
wire w_ack;
wire [3:0] w_be;
wire [31:0] w_wd;
wire w_rstr;
wire [31:0] w_rd;
wire [3:0] w_avm_be;
wire w_avm_ack;

wire w_req_m;
wire w_wr_m;
`ifdef D3D_WISHBONE
reg r_state;
assign o_avm_r = w_req_m & (~w_wr_m) & (r_state == P_IDLE);
assign w_avm_ack = (r_state == P_READ) ? i_avm_rvalid :
                                         (!i_avm_wait & w_wr_m);
localparam P_IDLE = 1'b0;
localparam P_READ = 1'b1;
always @(posedge clk_core or  negedge rst_x) begin
  if (~rst_x) begin
    r_state <= P_IDLE;
  end else begin
    case (r_state)
      P_IDLE: if (w_req_m & !i_avm_wait & !w_wr_m) r_state <= P_READ;
      P_READ:  if (i_avm_rvalid ) r_state <= P_IDLE;
    endcase
  end
end
`else
assign o_avm_r = w_req_m & (~w_wr_m);
`endif
assign o_avm_w = w_req_m & (w_wr_m);
assign o_avm_be = (~w_wr_m) ? 4'hff: w_avm_be;  // byte enable must be 'hff in read mode to get right data
   
`ifdef D3D_WISHBONE
fm_avalon_wb #(.P_AVALON_ADR_WIDTH(6)) u_avalon_wb (
`else
fm_avalon #(.P_AVALON_ADR_WIDTH(6)) u_avalon (
`endif
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
`ifdef D3D_WISHBONE
`else
  .i_rstr(w_rstr),
`endif
  .i_rd(w_rd)
);
`ifdef D3D_WISHBONE
assign o_avm_blen = 3'd1;
wire [25:2]   w_avm_adr_t;
assign o_avm_adr = {w_avm_adr_t,2'b00};
`endif

fm_3d_core u_3d_core (
  .clk_i(clk_core),
  .rst_i(~rst_x),
  .int_o(o_int),
`ifdef D3D_WISHBONE
  // internal side
  .s_wb_stb_i(w_req),
  .s_wb_we_i(w_wr),
  .s_wb_adr_i(w_adrs),
  .s_wb_ack_o(w_ack),
  .s_wb_sel_i(w_be),
  .s_wb_dat_i(w_wd),
  .s_wb_dat_o(w_rd),
  // geometry DMA, pixel write
  .m_wb_stb_o(w_req_m),
  .m_wb_we_o(w_wr_m),
  .m_wb_adr_o(w_avm_adr_t),
  .m_wb_ack_i(w_avm_ack),
  .m_wb_sel_o(w_avm_be),
  .m_wb_dat_o(o_avm_wd),
  .m_wb_dat_i(i_avm_rd),
`else
  // internal side
  .i_req_s(w_req),
  .i_wr_s(w_wr),
  .i_adrs_s({w_adrs,2'b0}),
  .o_ack_s(w_ack),
  .i_be_s(w_be),
  .i_dbw_s(w_wd),
  .o_strr_s(w_rstr),
  .o_dbr_s(w_rd),
  // geometry DMA, pixel write
  .o_req_m(w_req_m),
  .o_wr_m(w_wr_m),
  .o_adrs_m(o_avm_adr),
  .o_len_m(o_avm_blen),
  .i_ack_m(!i_avm_wait),
  .o_be_m(w_avm_be),
  .o_dbw_m(o_avm_wd),
  .i_strr_m(i_avm_rvalid),
  .i_dbr_m(i_avm_rd)
`endif
);

endmodule
