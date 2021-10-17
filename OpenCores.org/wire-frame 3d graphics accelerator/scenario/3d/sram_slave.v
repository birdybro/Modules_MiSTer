//=======================================================================
// Project Monophony
//   Wire-Frame 3D Graphics Accelerator IP Core
//
// File:
//   sram_slave.v
//
// Abstract:
//   SRAM slave model with random read data delay.
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

module sram_slave #(
  parameter P_ADRS_WIDTH = 24,
  parameter P_BE_WIDTH   = 4,
  parameter P_DATA_WIDTH = 32,
  parameter P_BLEN_WIDTH = 6,
  parameter P_SEED = 'd0
)
  (
    input clk_core,
    input rst_x,
    input i_req,
    input i_wr,
    input [P_ADRS_WIDTH-1:0] i_adrs,
    input [P_BLEN_WIDTH-1:0] i_blen,
    output o_ack,
    input i_strw,
    input [P_BE_WIDTH-1:0]   i_be,
    input [P_DATA_WIDTH-1:0] i_dbw,
    output o_ackw,
    output o_strr,
    output [P_DATA_WIDTH-1:0] o_dbr
 );

//////////////////////////////////
// parameter
//////////////////////////////////
  localparam P_IDLE     = 2'h0;
  localparam P_IN_WRITE = 2'h1;
  localparam P_IN_READ  = 2'h2;

  localparam P_READ_DELAY  = 'd15;

//////////////////////////////////
// wire 
//////////////////////////////////
    wire           w_req;
    wire [29:0]
                   w_fifo_cin;
    wire [29:0]
                   w_fifo_cout;
    wire [32+4-1:0]
                   w_fifo_din;
    wire [32+4-1:0]
                   w_fifo_dout;
    wire           w_cfifo_ack;
    wire           w_dfifo_ack;
    wire           w_read_req;
    wire [1:0]     w_mcmd_f;
    wire [P_ADRS_WIDTH-1:0]
                   w_maddr_f;
    wire [P_BLEN_WIDTH-1:0]
                   w_mburst_length_f;
    wire           w_command_valid;
    wire           w_burst_end;
    wire [P_ADRS_WIDTH-1:0]
                   w_sram_addr;
    wire [P_BE_WIDTH-1:0]
                   w_sram_byte_en;
    wire [P_DATA_WIDTH-1:0]
                   w_sram_wdata;
    wire [P_DATA_WIDTH-1:0]
                   w_sram_rdata;
    wire           w_sram_write;
    wire           w_datain_valid;
    wire           w_dfifi_idle_ack;
    wire [P_DATA_WIDTH-1:0] w_dbr;
    wire           w_act;
//////////////////////////////////
// reg 
//////////////////////////////////
    reg  [1:0]     r_state;
    reg  [P_ADRS_WIDTH-1:0]
                   r_maddr;
    reg  [P_BLEN_WIDTH-1:0]
                   r_clength;
    reg  [P_BLEN_WIDTH-1:0]
                   r_mburst_length;
    reg            r_read_req_1z;
    reg            r_read_req_2z;
    reg [7:0] 	   r_rand;
    reg [7:0] 	   r_rand_rd;
    reg [31:0] 	   r_rand_seed;
    reg [31:0] 	   r_rand_rd_seed;
//////////////////////////////////
// assign 
//////////////////////////////////
//    assign o_strr = r_read_req_2z;
    assign w_burst_end = (r_mburst_length == r_clength);
    assign w_sram_addr = (r_state == P_IDLE) ? i_adrs : r_maddr;
    assign w_sram_write = ((r_state == P_IN_WRITE)&i_strw) |
                               (i_req & i_wr & o_ack &  w_act);
    assign o_ack = (r_state == P_IDLE) & w_act;
    assign o_ackw = 1'b1;
    assign  w_read_req = (i_req & !i_wr & o_ack & w_act) | (r_state == P_IN_READ);
    assign w_act = (r_rand < 'h80);
//////////////////////////////////
// always 
//////////////////////////////////
   
  initial begin
    $display("RANDOM SEED = %d %m",P_SEED);
    r_rand_seed = P_SEED;
    r_rand_rd_seed = P_SEED;
  end
  always @(negedge clk_core) begin
    r_rand <= $random(r_rand_seed);
    //r_rand <= 1;
  end

  always @(posedge clk_core or negedge rst_x) begin
    if (~rst_x) begin
      r_state <= P_IDLE;
    end else begin
      case (r_state)
        P_IDLE : begin
          if (i_req & (i_blen != 'd1) & w_act) begin
           if (i_wr == 'd1) begin
             r_state <= P_IN_WRITE;
           end else begin
             r_rand_rd <= $random(r_rand_rd_seed);
             //r_rand_rd <= 0;
             r_state <= P_IN_READ;
           end
         end
       end
       P_IN_WRITE : begin
         if ((w_burst_end)&i_strw) r_state <= P_IDLE;
       end
       P_IN_READ : begin
         if (w_burst_end) r_state <= P_IDLE;
       end
     endcase
   end
 end

always @(posedge clk_core) begin
  if ((r_state == P_IDLE)&i_req & w_act) begin
    r_maddr <= i_adrs + 1'b1;
    r_mburst_length <= i_blen;
    r_clength <= 'd2;
  end else if (r_state == P_IN_WRITE) begin
    if (i_strw) begin
      r_maddr <= r_maddr + 1'b1;
      r_clength <= r_clength + 1'b1;
    end
  end else begin
    r_maddr <= r_maddr + 1'b1;
    r_clength <= r_clength + 1'b1;
  end
end

 
  always @(posedge clk_core or negedge rst_x) begin
    if (~rst_x) begin
      r_read_req_1z <= 1'b0;
      r_read_req_2z <= 1'b0;
    end else begin
      r_read_req_1z <= w_read_req;
      r_read_req_2z <= r_read_req_1z;
    end
  end

//////////////////////////////////
// module instantiation
//////////////////////////////////
// delay module

rand_delay # (1,16) u_delay_strr (
  .clk_core(clk_core),
  .rst_x(rst_x),
  .i_en(r_read_req_2z),
  .i_delay(r_rand_rd),
  .i_data(r_read_req_2z),
  .o_data(),
  .o_en(o_strr)
);

rand_delay #(P_DATA_WIDTH,16) u_delay_dbr (
  .clk_core(clk_core),
  .rst_x(rst_x),
  .i_en(r_read_req_2z),
  .i_delay(r_rand_rd),
  .i_data(w_dbr),
  .o_data(o_dbr),
  .o_en()
);


memory_sram #(P_ADRS_WIDTH)  u_memory (
  .clk(clk_core),
  .adr(w_sram_addr),
  .din(i_dbw),
  .be(i_be),
  .dout(w_dbr),
  .rdb(~w_read_req),
  .wrb(~w_sram_write),
  .rstb(rst_x)
);

endmodule
