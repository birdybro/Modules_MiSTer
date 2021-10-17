//=======================================================================
// Project Monophony
//   Wire-Frame 3D Graphics Accelerator IP Core
//
// File:
//   fm_4k_split.v
//
// Abstract:
//   command split module by 4KB address boundary
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


`include "polyphony_def.v"
module fm_4k_split (
  clk_core,
  rst_x,
  // incoming
  i_brg_req,
  i_brg_adrs,
  i_brg_rw,
  i_brg_len,
  o_brg_ack,
  // outgoing
  o_brg_adrs,
  o_brg_len,
  i_brg_ack
);
`include "polyphony_axi_def.v"
//////////////////////////////////
// I/O port definition
//////////////////////////////////
  // system
  input clk_core;
  input rst_x;
  // incoming
  input          i_brg_req;
  input  [P_IB_ADDR_WIDTH-1:0]
                 i_brg_adrs;
  input          i_brg_rw;
  input  [P_IB_LEN_WIDTH-1:0]
                 i_brg_len;
  output         o_brg_ack;
  // outgoing
  output [P_IB_ADDR_WIDTH-1:0]
                 o_brg_adrs;
  output [P_IB_LEN_WIDTH-1:0]
                 o_brg_len;
  input          i_brg_ack;
//////////////////////////////////
// parameter definition
//////////////////////////////////
localparam P_IDLE = 1'b0;
localparam P_2ND = 1'b1;
//////////////////////////////////
// reg
//////////////////////////////////
  reg         r_state;
//////////////////////////////////
// wire
//////////////////////////////////
  wire [P_IB_ADDR_WIDTH-1:0]
              w_2nd_adrs;
  wire        w_4k_boundary;
  wire        w_4k_ack;
   
//////////////////////////////////
// assign
//////////////////////////////////
  assign w_2nd_adrs = i_brg_adrs + 1'b1;  // add 8byte address
  assign w_4k_boundary = (i_brg_adrs[P_IB_ADDR_WIDTH-1:(11-3)] != 
                          w_2nd_adrs[P_IB_ADDR_WIDTH-1:(11-3)]) & !i_brg_rw;

  assign w_4k_ack = (r_state == P_2ND) & i_brg_ack ;
  assign o_brg_adrs = (r_state == P_2ND) ? w_2nd_adrs : i_brg_adrs;
  assign o_brg_ack = (!i_brg_req) ? i_brg_ack :
                                    (w_4k_boundary) ? w_4k_ack : i_brg_ack;

  assign o_brg_len = (w_4k_boundary) ?  'd1 : i_brg_len;
//////////////////////////////////
// always
//////////////////////////////////

always @(posedge clk_core or negedge rst_x) begin
  if (~rst_x) begin
    r_state <= P_IDLE;
  end else begin
    case (r_state)
      P_IDLE: begin
        if (i_brg_req & i_brg_ack) begin
          if (w_4k_boundary) r_state <= P_2ND;
        end
      end
      P_2ND: begin
        if (i_brg_ack) begin
          r_state <= P_IDLE;
        end
      end
    endcase
  end
end


endmodule
