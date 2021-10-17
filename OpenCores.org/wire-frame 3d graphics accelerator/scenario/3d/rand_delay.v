//=======================================================================
// Project Monophony
//   Wire-Frame 3D Graphics Accelerator IP Core
//
// File:
//   rand_delay.v
//
// Abstract:
//   Pipeline delay module (without reset)
//       parameters :
//                WIDTH      data width (default value is 8)
//                NUM_DELAY  number of delay cycle  (default value is 8)
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

module rand_delay (
    clk_core,
    rst_x,
    i_en,
    i_delay,
    i_data,
    o_data,
    o_en
);

////////////////////////////
// parameter
////////////////////////////
    parameter P_WIDTH     = 8;
    parameter P_NUM_DELAY = 8;
////////////////////////////
// I/O definition
////////////////////////////
    input                clk_core;
    input                rst_x;
    input                i_en;
    input  [7:0] 	 i_delay;
    input  [P_WIDTH-1:0] i_data;
    output [P_WIDTH-1:0] o_data;
    output o_en;
////////////////////////////
// wire
////////////////////////////
  wire w_full;
  wire w_ren;
  wire [P_WIDTH-1:0] w_dt;
  wire w_empty;

////////////////////////////
// reg
////////////////////////////
localparam P_IDLE = 'd0;
localparam P_WAIT = 'd1;
    reg [1:0] r_state;
    reg [7:0] r_cnt;
    reg [7:0] r_end;

////////////////////////////
// assign
////////////////////////////
    assign w_ren = ((r_state == P_IDLE) & (i_delay == 'd0))|
                   ((r_state == P_WAIT) & (r_end == r_cnt));
    // in/out port connection
    assign o_data =  (w_empty) ? 'd0 : w_dt;
    assign o_en = w_ren & !w_empty;
////////////////////////////
// always
////////////////////////////
    always @(posedge clk_core or negedge rst_x) begin
      if (~rst_x) begin
        r_state <= P_IDLE;
      end else begin
        case (r_state)
          P_IDLE:begin
            if (~w_empty) begin
              if (i_delay != 0) begin
                r_end <= i_delay;
                r_cnt <= 'd0;
                r_state <= P_WAIT;
              end
            end
          end
          P_WAIT:begin
            r_cnt <= r_cnt + 1;
            if (r_end == r_cnt) begin
              r_state <= P_IDLE;
            end
          end
        endcase
      end
    end

mfifo #(P_WIDTH,8) u_fifo (
  .i_wstrobe(i_en),
  .i_dt(i_data),
  .o_full(w_full),
  .i_renable(w_ren),
  .o_dt(w_dt),
  .o_empty(w_empty),
  .o_dnum(),
  .clk(clk_core),
  .rst_x(rst_x)
);

endmodule
