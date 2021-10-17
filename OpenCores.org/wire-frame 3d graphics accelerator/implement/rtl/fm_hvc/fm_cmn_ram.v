//=======================================================================
// Project Monophony
//   Wire-Frame 3D Graphics Accelerator IP Core
//
// File:
//   fm_cmn_ram.v
//
// Abstract:
//   Dualport RAM, this will be mapped to block ram
//   with different clocks
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

module fm_cmn_ram (
    clka,
    clkb,
    wea,
    addra,
    addrb,
    dia,
    doa,
    dob
 );

//////////////////////////////////
// parameter
//////////////////////////////////
    parameter P_RAM_TYPE="TYPE_A";
    parameter P_WIDTH = 32;
    parameter P_RANGE = 2;
    parameter P_DEPTH = 1 << P_RANGE;
//////////////////////////////////
// I/O port definition
//////////////////////////////////
    input                clka;
    input                clkb;
    input                wea;
    input  [P_RANGE-1:0] addra;
    input  [P_RANGE-1:0] addrb;
    input  [P_WIDTH-1:0] dia;
    output [P_WIDTH-1:0] doa;
    output [P_WIDTH-1:0] dob;

//////////////////////////////////
// reg 
//////////////////////////////////
    reg [P_WIDTH-1:0] ram [P_DEPTH-1:0];
    reg [P_WIDTH-1:0] doa;
    reg [P_WIDTH-1:0] dob;

//////////////////////////////////
// always
//////////////////////////////////
generate
  if (P_RAM_TYPE=="TYPE_A") begin
    always @(posedge clka) begin
        if (wea) ram[addra] <= dia;
    end

    always @(posedge clkb) begin
        dob <= ram[addrb];
    end
  end else begin
    // port A: write-first
    always @(posedge clka) begin
        if (wea) begin
            ram[addra] <= dia;
            doa <= dia;
        end else begin
            doa <= ram[addra];
        end
    end

    // port B: read-first
    always @(posedge clkb) begin
        dob <= ram[addrb];
    end
  end
endgenerate
endmodule
