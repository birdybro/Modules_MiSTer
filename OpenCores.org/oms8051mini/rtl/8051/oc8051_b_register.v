//////////////////////////////////////////////////////////////////////
////                                                              ////
////  8051 cores b register                                       ////
////                                                              ////
////  This file is part of the 8051 cores project                 ////
////  http://www.opencores.org/cores/oms8051mini/                 ////
////                                                              ////
////  Description                                                 ////
////   b register for 8051 core                                   ////
////                                                              ////
////  To Do:                                                      ////
////   Nothing                                                    ////
////                                                              ////
////  Author(s):                                                  ////
////      - Simon Teran, simont@opencores.org                     ////
////      - Dinesh Annayya, dinesha@opencores.org                 ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////   v0.0 - Dinesh A, 5th Jan 2017
////        1. Active edge of reset changed from High to Low
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2000 Authors and OPENCORES.ORG                 ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
// CVS Revision History
//
// $Log: not supported by cvs2svn $
// Revision 1.8  2003/04/07 14:58:02  simont
// change sfr's interface.
//
// Revision 1.7  2003/01/13 14:14:40  simont
// replace some modules
//
// Revision 1.6  2002/09/30 17:33:59  simont
// prepared header
//
//

`include "top_defines.v"


module oc8051_b_register (clk, resetn, bit_in, data_in, wr, wr_bit,
              wr_addr, data_out);


input clk, resetn, wr, wr_bit, bit_in;
input [7:0] wr_addr, data_in;

output [7:0] data_out;

reg [7:0] data_out;

//
//writing to b
//must check if write high and correct address
always @(posedge clk or negedge resetn)
begin
  if (resetn == 1'b0)
    data_out <=`OC8051_RST_B;
  else if (wr) begin
    if (!wr_bit) begin
      if (wr_addr==`OC8051_SFR_B)
        data_out <=data_in;
    end else begin
      if (wr_addr[7:3]==`OC8051_SFR_B_B)
        data_out[wr_addr[2:0]] <=bit_in;
    end
  end
end

endmodule
