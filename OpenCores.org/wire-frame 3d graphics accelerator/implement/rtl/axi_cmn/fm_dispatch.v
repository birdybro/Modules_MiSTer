//=======================================================================
// Project Monophony
//   Wire-Frame 3D Graphics Accelerator IP Core
//
// File:
//   fm_dispatch.v
//
// Abstract:
//   Register access dispatcher
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


// memory mapping
//
//  address(byte)                      address(/32bit)
//
//  0x0000_03ff +------------------+ 0x0080_0ff
//              |          (8MB)   |         
//  0x0000_0300 +------------------+ 0x0080_0c0
//              |          (8MB)   |         
//  0x0000_0200 +------------------+ 0x0000_080
//              |  3D      (8MB)   |
//  0x0000_0100 +------------------+ 0x0000_040
//              |  System  (8MB)   |
//  0x0000_0000 +------------------+ 0x0000_000
//

module fm_dispatch (
    clk_core,
    rst_x,
    // local interface
    i_req,
    i_wr,
    i_adrs,
    o_ack,
    i_be,
    i_wd,
    o_rstr,
    o_rd,
    // internal side
    o_req_sys,
    o_req_3d,
    o_wr,
    o_adrs,
    i_ack_sys,
    i_ack_3d,
    o_be,
    o_wd,
    i_rstr_sys,
    i_rstr_3d,
    i_rd_sys,
    i_rd_3d
);
//////////////////////////////////
// I/O port definition
//////////////////////////////////
    input           clk_core;
    input           rst_x;
    // sh4 local interface
    input           i_req;
    input           i_wr;
    input  [23:0]   i_adrs;
    output          o_ack;
    input  [3:0]    i_be;
    input  [31:0]   i_wd;
    output          o_rstr;
    output [31:0]   o_rd;
    // internal side
    output          o_req_sys;
    output          o_req_3d;
    output          o_wr;
    output [21:0]   o_adrs;
    input           i_ack_sys;
    input           i_ack_3d;
    output [3:0]    o_be;
    output [31:0]   o_wd;
    input           i_rstr_sys;
    input           i_rstr_3d;
    input  [31:0]   i_rd_sys;
    input  [31:0]   i_rd_3d;
//////////////////////////////////
// reg
//////////////////////////////////
//////////////////////////////////
// wire
//////////////////////////////////
    wire            w_sys_hit;
    wire            w_3d_hit;

    wire   [23:0]   w_adrs;
    wire            w_req;

//////////////////////////////////
// assign
//////////////////////////////////
    assign     w_adrs = i_adrs;
    assign     w_req = i_req;

    assign     w_sys_hit = (w_adrs[9:8] == 2'b00);  // byte address
    assign     w_3d_hit = !w_sys_hit;

    assign     o_ack = (w_sys_hit & i_ack_sys)|
                       (w_3d_hit &i_ack_3d);
    assign     o_rstr = i_rstr_3d | i_rstr_sys;
    assign     o_rd = (i_rstr_sys) ? i_rd_sys :
                      (i_rstr_3d)  ? i_rd_3d :
                                     32'h0;
    assign     o_req_sys = w_req & w_sys_hit;
    assign     o_req_3d = w_req & w_3d_hit;
    assign     o_adrs = w_adrs[21:0];
    assign     o_wr = i_wr;
    assign     o_be = i_be;
    assign     o_wd = i_wd;

endmodule
