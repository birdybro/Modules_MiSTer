`timescale 1ns / 1ps
// ============================================================================
//        __
//   \\__/ o\    (C) 2007-2017  Robert Finch, Waterloo
//    \  __ /    All rights reserved.
//     \/_//     robfinch<remove>@finitron.ca
//       ||
//
// PSGToneGenerator.v
//
// This source file is free software: you can redistribute it and/or modify 
// it under the terms of the GNU Lesser General Public License as published 
// by the Free Software Foundation, either version 3 of the License, or     
// (at your option) any later version.                                      
//                                                                          
// This source file is distributed in the hope that it will be useful,      
// but WITHOUT ANY WARRANTY; without even the implied warranty of           
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the            
// GNU General Public License for more details.                             
//                                                                          
// You should have received a copy of the GNU General Public License        
// along with this program.  If not, see <http://www.gnu.org/licenses/>.    
//                                                                          
//=============================================================================

module PSGToneGenerator(rst, clk, ack, test, vt, freq, pw, acc, prev_acc, wave, sync, ringmod, o);
input rst;
input clk;
input ack;              // wave table input acknowledge
input [11:0] wave;      // wave table data input
input test;
input [5:0] vt;         // voice type
input [23:0] freq;
input [23:0] pw;        // pulse width
input sync;
input ringmod;
input  [31:0] prev_acc;  // from previous voice
output [31:0] acc;	     // 1.023MHz / 2^ 24 = 0.06Hz resolution
output [11:0] o;

reg [31:0] accd;    // cycle delayed accumulator

integer n;

reg [11:0] outputT;
reg [11:0] outputW;
reg [22:0] lfsr;

wire synca = ~prev_acc[31]&acc[31]&sync;


PSGHarmonicSynthesizer u2
(
    .rst(rst),
    .clk(clk),
    .test(test),
    .sync(synca),
    .freq({8'h00,freq}),
    .o(acc)
);

// capture wave input
always @(posedge clk)
if (rst)
    outputW <= 0;
else if (ack)
    outputW <= wave;

// Noise generator
always @(posedge clk)
	if (acc[18] != acc[22])
		lfsr <= {lfsr[21:0],~(lfsr[22]^lfsr[17])};

// Triangle wave, ring modulation
wire msb = ringmod ? acc[27]^prev_acc[27] : acc[27];
always @(acc or msb)
	outputT <= msb ? ~acc[26:15] : acc[26:15];

// Other waveforms, ho-hum
wire [11:0] outputP = {12{acc[27:16] < pw}};
wire [11:0] outputS = vt[5] ? ~acc[27:16] : acc[27:16];
wire [11:0] outputN = lfsr[11:0];

wire [11:0] out;
PSGNoteOutMux #(12) u4 (.s(vt), .a(outputT), .b(outputS), .c(outputP), .d(outputN), .e(outputW), .o(out) );
assign o = out;

endmodule

