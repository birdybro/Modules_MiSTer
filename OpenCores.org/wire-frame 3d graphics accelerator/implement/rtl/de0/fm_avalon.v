//=======================================================================
// Project Monophony
//   Wire-Frame 3D Graphics Accelerator IP Core
//
// File:
//   fm_3d_wrapper.v
//
// Abstract:
//   Monophony core top module AVALON version
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

module fm_avalon(
    clk_core,
    rst_x,
    // AVALON bus
    i_av_adr,
    i_av_be,
    i_av_r,
    o_av_rd,
    i_av_w,
    i_av_wd,
    o_av_wait,
    // internal side
    o_req,
    o_wr,
    o_adrs,
    i_ack,
    o_be,
    o_wd,
    i_rstr,
    i_rd
);
parameter P_AVALON_ADR_WIDTH='d10;
parameter P_AVALON_BE_WIDTH='d4;
parameter P_AVALON_DATA_WIDTH='d32;
parameter P_INTERNAL_ADR_WIDTH=P_AVALON_ADR_WIDTH;
parameter P_INTERNAL_BE_WIDTH=P_AVALON_BE_WIDTH;
parameter P_INTERNAL_DATA_WIDTH=P_AVALON_DATA_WIDTH;
   

//////////////////////////////////
// I/O port definition
//////////////////////////////////
    input           clk_core;
    input           rst_x;
    // AVALON Bus
    input  [P_AVALON_ADR_WIDTH-1:0]
                   i_av_adr;
    input  [P_AVALON_BE_WIDTH-1:0]
                   i_av_be;
    input          i_av_r;
    output [P_AVALON_DATA_WIDTH-1:0]
                   o_av_rd;
    input          i_av_w;
    input  [P_AVALON_DATA_WIDTH-1:0]
                   i_av_wd;
    output         o_av_wait;
    // internal side
    output          o_req;
    output          o_wr;
    output [P_INTERNAL_ADR_WIDTH-1:0]
                    o_adrs;
    input           i_ack;
    output [P_INTERNAL_BE_WIDTH-1:0]
                    o_be;
    output [P_INTERNAL_DATA_WIDTH-1:0]
                    o_wd;
    input           i_rstr;
    input  [P_INTERNAL_DATA_WIDTH-1:0]
                    i_rd;

//////////////////////////////////
// parameter definition
//////////////////////////////////
    localparam P_IDLE         = 2'h0;
    localparam P_WAIT_ACK     = 2'h1;
    localparam P_R_WAIT_RDATA = 2'h2;
    localparam P_ACK_OUT      = 2'h3;
//////////////////////////////////
// reg
//////////////////////////////////
    reg  [1:0]  r_state;
    reg         r_req;
    reg         r_wr;
    reg  [P_INTERNAL_ADR_WIDTH-1:0]
                r_adrs;
    reg  [P_INTERNAL_DATA_WIDTH-1:0]
                r_rdata;
    reg  [P_INTERNAL_BE_WIDTH-1:0]
                r_be;
    reg  [P_INTERNAL_DATA_WIDTH-1:0]
                r_wd;

//////////////////////////////////
// wire
//////////////////////////////////
    wire  [P_INTERNAL_ADR_WIDTH-1:0]
                w_adrs;
    wire  [P_INTERNAL_DATA_WIDTH-1:0]
                w_rdata;
    wire  [P_INTERNAL_BE_WIDTH-1:0]
                w_be;
    wire  [P_INTERNAL_DATA_WIDTH-1:0]
                w_wd;
//////////////////////////////////
// assign
//////////////////////////////////
    generate
      if (P_INTERNAL_DATA_WIDTH == 'd8) begin
        wire [1:0] w_ba;
        assign o_av_rd = {'d4{r_rdata}};
        assign w_ba = i_av_be[1] ? 2'd1 :
		      i_av_be[2] ? 2'd2 : 
		      i_av_be[3] ? 2'd3 : 
                                   2'd0 ;
         assign w_adrs = {i_av_adr,w_ba};
        assign w_be = i_av_be[w_ba];
        assign w_wd = (w_ba == 'd1) ? i_av_wd[15:8]:
                      (w_ba == 'd2) ? i_av_wd[23:16]:
                      (w_ba == 'd3) ? i_av_wd[31:24]:
                                      i_av_wd[7:0];
	 
      end else begin
        assign o_av_rd = r_rdata;
        assign w_adrs = i_av_adr;
        assign w_be = i_av_be;
        assign w_wd = i_av_wd;
      end
    endgenerate
    assign o_req = r_req;
    assign o_wr = r_wr;
    assign o_adrs = r_adrs;
    assign o_be = r_be;
    assign o_wd = r_wd;
    assign o_av_wait = !(!(i_av_r|i_av_w) & (r_state == P_IDLE) |
                         (r_state == P_ACK_OUT));


//////////////////////////////////
// always
//////////////////////////////////
    // core clock domain 
    always @(posedge clk_core or negedge rst_x) begin
      if (~rst_x) begin
        r_state <= P_IDLE;
        r_req <= 1'b0;
        r_wr <= 1'b0;
        r_adrs <= {P_INTERNAL_ADR_WIDTH{1'b0}};
        r_rdata <= {P_INTERNAL_DATA_WIDTH{1'b0}};
        r_be <= {P_INTERNAL_BE_WIDTH{1'b0}};
        r_wd <= {P_INTERNAL_DATA_WIDTH{1'b0}};
      end else begin
        case (r_state)
          P_IDLE: begin
            if (i_av_w) begin
              // write
              r_req <= 1'b1;
              r_wr <= 1'b1;    
              r_adrs <= w_adrs;
              r_be <= w_be;
              r_wd <= w_wd;
              r_state <= P_WAIT_ACK;
            end else if (i_av_r) begin
              // read
              r_req <= 1'b1;
              r_wr <= 1'b0;    
              r_adrs <= w_adrs;
              r_state <= P_WAIT_ACK;
		    end
          end
          P_WAIT_ACK: begin
            if (i_ack) begin
              r_req <= 1'b0;
              if (r_wr) begin
                // write
                r_state <= P_ACK_OUT;
              end else begin
                if (i_rstr) begin
                  r_rdata <= i_rd;
                  r_state <= P_ACK_OUT;
                end else begin
                  r_state <= P_R_WAIT_RDATA;
                end
              end
            end
          end
          P_R_WAIT_RDATA: begin
            if (i_rstr) begin
              r_rdata <= i_rd;
              r_state <= P_ACK_OUT;
            end 
          end
          P_ACK_OUT: begin
            r_state <= P_IDLE;
          end
        endcase
      end
    end

endmodule
