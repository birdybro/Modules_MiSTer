//=======================================================================
// Project Monophony
//   Wire-Frame 3D Graphics Accelerator IP Core
//
// File:
//   fm_mic_cnv.v
//
// Abstract:
//   32-64 bit data bus width conversion
//
// Author:
//   Kenji Ishimaru (info.info.wf3d@gmail.com)
//
//======================================================================
//
// Copyright (c) 2016, Kenji Ishimaru
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

module fm_mic_cnv (
    clk_core,
    rst_x,
  // incoming
    i_req_in,
    i_wr_in,
    i_adrs_in,
    i_len_in,
    o_ack_in,
    i_be_in,
    i_wdata_in,
    o_rstr_in,
    o_rdata_in,
  // outcoming
    o_req_out,
    o_wr_out,
    o_adrs_out,
    o_len_out,
    i_ack_out,
    o_be_out,
    o_wdata_out,
    i_rstr_out,
    i_rdata_out
);
`include "polyphony_params.v"
//////////////////////////////////
// I/O port definition
//////////////////////////////////
input          clk_core;
input          rst_x;
// incoming
input          i_req_in;
input          i_wr_in;
input [31:2]   i_adrs_in;
input [2:0]    i_len_in;
output         o_ack_in;
input [3:0]    i_be_in;
input [31:0]   i_wdata_in;
output         o_rstr_in;
output [31:0]  o_rdata_in;
// outcoming
output         o_req_out;
output         o_wr_out;
output [31:3]  o_adrs_out;
output [5:0]   o_len_out;
input          i_ack_out;
output [7:0]   o_be_out;
output [63:0]  o_wdata_out;
input          i_rstr_out;
input [63:0]   i_rdata_out;
//////////////////////////////////
// regs 
//////////////////////////////////
reg [2:0] r_cnt;
//////////////////////////////////
// wires 
//////////////////////////////////
wire w_sel;
wire w_fifo_write;
wire [3:0] w_fifo_din;
wire w_fifo_full;
wire w_read_end;
wire [3:0] w_fifo_dout;
wire w_empty;
wire w_add_lsb;
wire w_add_lsb_out;
wire [2:0] w_len;

wire w_dread_end;
wire [63:0]w_dfifo_dout;
wire w_dempty;

//////////////////////////////////
// assign statement 
//////////////////////////////////
assign o_req_out = i_req_in;
assign {o_adrs_out[31:3],w_add_lsb} = i_adrs_in[31:2];
assign o_len_out = i_len_in[2:1] + i_len_in[0];
assign o_be_out = (w_add_lsb) ? {i_be_in,4'h0} : {4'h0,i_be_in};
assign o_wdata_out = (w_add_lsb) ? {i_wdata_in,32'h0} : {32'h0,i_wdata_in};
assign o_wr_out = i_wr_in;
// command
assign w_fifo_din = {w_add_lsb,i_len_in};
assign {w_add_lsb_out,w_len} = w_fifo_dout;
assign w_fifo_write = o_req_out & i_ack_out & (!i_wr_in);
assign w_read_end = (!w_dempty) & (w_len == r_cnt);
assign o_ack_in = i_ack_out & !w_fifo_full;
// data
assign w_sel = (w_add_lsb_out) ?  r_cnt[0] : ~r_cnt[0]; 
assign w_dread_end = w_sel | w_read_end;
assign o_rstr_in = !w_dempty;
assign o_rdata_in = (w_sel) ? w_dfifo_dout[63:32] :w_dfifo_dout[31:0];
//////////////////////////////////
// module instantiation
//////////////////////////////////
always @(posedge clk_core or negedge rst_x) begin
  if (~rst_x) begin
    r_cnt <= 'd1;
  end else begin
    if (!w_dempty) begin
      if (w_len == r_cnt) r_cnt <= 'd1;
      else r_cnt <= r_cnt + 1'b1;
    end
  end
end

// len, lsb
fm_cmn_bfifo #(4,4) u_fifo (
  .clk_core(clk_core),
  .rst_x(rst_x),
  .i_wstrobe(w_fifo_write),
  .i_dt(w_fifo_din),
  .o_full(w_fifo_full),
  .i_renable(w_read_end),
  .o_dt(w_fifo_dout),
  .o_empty(w_empty),
  .o_dnum()
);

fm_cmn_bfifo #(64,4) u_dfifo (
  .clk_core(clk_core),
  .rst_x(rst_x),
  .i_wstrobe(i_rstr_out),
  .i_dt(i_rdata_out),
  .o_full(),
  .i_renable(w_dread_end),
  .o_dt(w_dfifo_dout),
  .o_empty(w_dempty),
  .o_dnum()
);

endmodule
