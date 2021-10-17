//=======================================================================
// Project Monophony
//   Wire-Frame 3D Graphics Accelerator IP Core
//
// File:
//   fm_cmn_bram_01.v
//
// Abstract:
//   Dual-port RAM(will be mapped onto block ram)
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

// synthesis attribute ram_style of fm_cmn_bram_01 is block;

module fm_cmn_bram_01 (
    clk,
    we,
    a,
    dpra,
    di,
    spo,
    dpo
 );

//////////////////////////////////
// parameter
//////////////////////////////////
    parameter P_WIDTH = 32;
    parameter P_RANGE = 2;
    parameter P_DEPTH = 1 << P_RANGE;
//////////////////////////////////
// I/O port definition
//////////////////////////////////
    input                clk;
    input                we;
    input  [P_RANGE-1:0] a;
    input  [P_RANGE-1:0] dpra;
    input  [P_WIDTH-1:0] di;
    output [P_WIDTH-1:0] spo;
    output [P_WIDTH-1:0] dpo;

//////////////////////////////////
// reg 
//////////////////////////////////
    reg [P_WIDTH-1:0] ram [P_DEPTH-1:0];
    reg [P_WIDTH-1:0] spo;
    reg [P_WIDTH-1:0] dpo;

//////////////////////////////////
// always
//////////////////////////////////
    // port A: write-first
    always @(posedge clk) begin
        if (we) begin
            ram[a] <= di;
            spo <= di;
        end else begin
            spo <= ram[a];
        end
    end

    // port B: read-first
    always @(posedge clk) begin
        dpo <= ram[dpra];
    end
   
endmodule
