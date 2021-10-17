//=======================================================================
// Project Monophony
//   Wire-Frame 3D Graphics Accelerator IP Core
//
// File:
//   memory_sram.v
//
// Abstract:
//   sram memory for simulation
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

module memory_sram (
  clk,
  adr,
  din,
  be,
  dout,
  rdb,
  wrb,
  rstb
);

/////////////////////////////////////
// parameter
////////////////////////////////////
  parameter P_ADRS_WIDTH = 22;
  parameter P_DATA_WIDTH = 32;
  parameter P_BE_WIDTH = P_DATA_WIDTH/8;
/////////////////////////////////////
// Port Definition
////////////////////////////////////
  input          clk;
  input  [P_ADRS_WIDTH-1:0]
                 adr;
  input  [P_DATA_WIDTH-1:0]
                 din;
  input  [P_BE_WIDTH-1:0]
                 be;
  output [P_DATA_WIDTH-1:0]
                 dout;
  input          rdb;
  input          wrb;
  input          rstb;
/////////////////////////////////////
// reg
////////////////////////////////////
// memory instance
  reg  [31:0] mem[0:(1 << P_ADRS_WIDTH)-1];

  reg  [P_DATA_WIDTH-1:0]
             r_dout_1z;
  reg  [P_DATA_WIDTH-1:0]
             r_dout_2z;
/////////////////////////////////////
// wire
////////////////////////////////////
  wire [P_DATA_WIDTH-1:0]
             w_dout;
  wire [P_DATA_WIDTH-1:0]
             w_din;
/////////////////////////////////////
// assign
////////////////////////////////////
  assign w_dout = mem[adr];
  assign w_din = f_new_data(din,be,mem[adr]);
  assign dout = r_dout_2z;
/////////////////////////////////////
// always
////////////////////////////////////
   integer i;
   initial begin
   for (i=0;i<(1 << P_ADRS_WIDTH);i=i+1)
      mem[i] = 32'h00000000;
   end
  always @(posedge clk) begin
    if (wrb == 1'b0) begin
      mem[adr] <= w_din;
    end
  end

//`ifdef RTL_DEBUG
//  always @(posedge clk) begin
//    if (wrb == 1'b0) begin
//      $display("a4 a d = %h %h",adr,adr<<2,w_din);
//    end
//  end
//`endif

  always @(posedge clk) begin
    r_dout_1z <= w_dout;
    r_dout_2z <= r_dout_1z;
  end


  function [P_DATA_WIDTH-1:0] f_new_data;
      input [P_DATA_WIDTH-1:0] new_data;
      input [P_BE_WIDTH-1:0]   be;
      input [P_DATA_WIDTH-1:0] cur_data;
      reg   [P_DATA_WIDTH-1:0] result; 
      begin
          result = cur_data;
          if (be[0]) result[7:0] = new_data[7:0];
          if (be[1]) result[15:8] = new_data[15:8];
          if (be[2]) result[23:16] = new_data[23:16];
          if (be[3]) result[31:24] = new_data[31:24];
          f_new_data = result;
      end
  endfunction


endmodule

