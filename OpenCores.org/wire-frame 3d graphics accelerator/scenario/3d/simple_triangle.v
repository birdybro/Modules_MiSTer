//=======================================================================
// Project Monophony
//   Wire-Frame 3D Graphics Accelerator IP Core
//
// File:
//   simple_triangle.v
//
// Abstract:
//   simple cube rendering
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

`timescale 1ns/1ns
`include "fm_3d_define.v"
module top();

`define VERBOSE
//`define WAVE_OUT
`ifdef D3D_WISHBONE
`include "tb_instance_wb.v"
`else
`include "tb_instance.v"
`endif
`include "tb_init.v"
`include "tb_task.v"

`define PP_BASE_ADDR 'h0

`ifdef WAVE_OUT
initial begin
    $dumpvars;
end
`endif

reg [31:0] rd;

// VGA
localparam P_SCREEN_WIDTH=640;
localparam P_SCREEN_HEIGHT=480;
// SVGA
//localparam P_SCREEN_WIDTH=800;
//localparam P_SCREEN_HEIGHT=600;
// XGA
//localparam P_SCREEN_WIDTH=1024;
//localparam P_SCREEN_HEIGHT=768;
// SXGA
//localparam P_SCREEN_WIDTH=1280;
//localparam P_SCREEN_HEIGHT=1024;
// UXGA
//localparam P_SCREEN_WIDTH=1600;
//localparam P_SCREEN_HEIGHT=1200;
// QXGA
//localparam P_SCREEN_WIDTH=2048;
//localparam P_SCREEN_HEIGHT=1536;


localparam P_FB_TOP_ADDR='h8_0000;
   

/***********************************************
  Main test routine
***********************************************/

integer i,j;
integer pm;
initial pm = 0;

initial begin
  reset;
  repeat (100) @(posedge clk_core);
   for (i=0;i<3;i=i+1) begin
     for (j=0;j<3;j=j+1) begin
       render_triangle(j,i);
     end
   end
  save_frame_buffer(P_FB_TOP_ADDR, P_SCREEN_WIDTH,P_SCREEN_HEIGHT,"frame_buffer.dat");
  repeat (100) @(posedge clk_core);
  $finish;
end
   
   
task reset;
  begin
    rst_x = 0;
    repeat (10) @(posedge clk_core);
    @(negedge clk_core);
    rst_x = 1;
    @(posedge clk_core);
  end
endtask

task render_triangle;
  input [1:0] x_pos;
  input [1:0] y_pos;
  real x_bias;
  real y_bias;
  real z_bias;
  reg [31:0] r_32;
  reg [21:0] r_22;
   begin
  reg_write('h08,'hf,'h000_0000);  // DMA top address
  $to_float32(rd,2.79903817);
  reg_write('h10,'hf,rd);  // m00
  $to_float32(rd,0.0);
  reg_write('h14,'hf,rd);  // m01
  $to_float32(rd,0.0);
  reg_write('h18,'hf,rd);  // m02
  $to_float32(rd,0.0);
  reg_write('h1c,'hf,rd);  // m03
  $to_float32(rd,0.0);
  reg_write('h20,'hf,rd);  // m10
  $to_float32(rd,3.73205090);
  reg_write('h24,'hf,rd);  // m11
  $to_float32(rd,0.0);
  reg_write('h28,'hf,rd);  // m12
  $to_float32(rd,0.0);
  reg_write('h2c,'hf,rd);  // m13
  $to_float32(rd,0.0);
  reg_write('h30,'hf,rd);  // m20
  $to_float32(rd,0.0);
  reg_write('h34,'hf,rd);  // m21
  $to_float32(rd,-1.02020204);
  reg_write('h38,'hf,rd);  // m22
  $to_float32(rd,1.04040408);
  reg_write('h3c,'hf,rd);  // m23
  $to_float32(rd,0.0);
  reg_write('h40,'hf,rd);  // m30
  $to_float32(rd,0.0);
  reg_write('h44,'hf,rd);  // m31
  $to_float32(rd,-1.00000000);
  reg_write('h48,'hf,rd);  // m32
  $to_float32(rd,3.0);
  reg_write('h4c,'hf,rd);  // m33
  reg_write('h64,'hf,P_FB_TOP_ADDR);  // Pixel top address
  reg_write('h68,'hf,'hff);           // Pixel color

  // screen width/height
  $to_float32(rd,P_SCREEN_WIDTH);
  reg_write('h50,'hf,rd);   // Screen Width (Floating point)
  $to_float32(rd,P_SCREEN_HEIGHT);
  reg_write('h54,'hf,rd);   // Screen Height (Floating point)

  reg_write('h58,'hf,P_SCREEN_WIDTH-1);  // Screen Width-1 (Integer)
  reg_write('h5c,'hf,P_SCREEN_HEIGHT-1); // Screen Width-1 (Integer)
  reg_write('h60,'hf,P_SCREEN_WIDTH);    // Screen Width (Integer)
  // simple test
  x_bias = 0.0;
  y_bias = 0.0;
  z_bias = 0.0;
  // bias
  case (x_pos)
    'd0: x_bias = -0.7;
    'd1: x_bias = 0.0;
    'd2: x_bias = 0.7;
  endcase
  case (y_pos)
    'd0: y_bias = -0.7;
    'd1: y_bias = 0.0;
    'd2: y_bias = 0.7;
  endcase
  // pixel color RGB = 2:3:3
  case (y_pos)
    'd0: reg_write('h68,'hf,'h0c0);  // R y-flip:bit8
    'd1: reg_write('h68,'hf,'h038);  // G
    'd2: reg_write('h68,'hf,'h007);  // B
  endcase
  

  pm = 0;

  // triangle0
    $to_float32(rd,0.25+x_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,0.25+y_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,0.25);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,-0.25+x_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,0.25+y_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,0.25);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,-0.25+x_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,-0.25+y_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,0.25);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
  // triangle1
    $to_float32(rd,0.25+x_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,0.25+y_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,0.25);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,-0.25+x_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,-0.25+y_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,0.25);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,0.25+x_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,-0.25+y_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,0.25);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
  // triangle2
    $to_float32(rd,0.25+x_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,0.25+y_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,0.0);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,-0.25+x_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,0.25+y_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,0.0);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,-0.25+x_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,0.25+y_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,0.25);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
  // triangle3
    $to_float32(rd,0.25+x_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,0.25+y_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,0.0);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,-0.25+x_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,0.25+y_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,0.25);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,0.25+x_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,0.25+y_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,0.25);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
  // triangle4
    $to_float32(rd,0.25+x_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,-0.25+y_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,0.25);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,-0.25+x_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,-0.25+y_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,0.25);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,-0.25+x_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,-0.25+y_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,0.0);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
  // triangle5
    $to_float32(rd,0.25+x_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,-0.25+y_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,0.25);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,-0.25+x_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,-0.25+y_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,0.0);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,0.25+x_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,-0.25+y_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,0.0);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
  // triangle6
    $to_float32(rd,-0.25+x_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,0.25+y_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,0.25);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,-0.25+x_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,0.25+y_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,0.0);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,-0.25+x_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,-0.25+y_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,0.0);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
  // triangle7
    $to_float32(rd,-0.25+x_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,0.25+y_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,0.25);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,-0.25+x_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,-0.25+y_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,0.0);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,-0.25+x_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,-0.25+y_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,0.0);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
  // triangle8
    $to_float32(rd,0.25+x_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,0.25+y_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,0.0);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,0.25+x_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,0.25+y_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,0.25);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,0.25+x_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,-0.25+y_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,0.25);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
  // triangle9
    $to_float32(rd,0.25+x_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,0.25+y_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,0.0);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,0.25+x_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,-0.25+y_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,0.25);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,0.25+x_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,-0.25+y_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,0.0);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
  // triangle10
    $to_float32(rd,-0.25+x_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,0.25+y_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,0.0);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,0.25+x_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,0.25+y_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,0.0);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,0.25+x_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,-0.25+y_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,0.0);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
  // triangle11
    $to_float32(rd,-0.25+x_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,0.25+y_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,0.0);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,0.25+x_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,-0.25+y_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,0.0);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,-0.25+x_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,-0.25+y_bias);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
    $to_float32(rd,0.0);
    $display("rd %h",rd);
    u_sram_slave.u_memory.mem[pm] = rd;
    pm = pm + 1;
  reg_write('h0c,'hf,12*3*3);  // DMA size 12triangle *3vertex*3
  reg_write('h04,'hf,'h10);  // DMA mask
  reg_write('h01,'hf,1);  // DMA start
  while (!o_int)
    @(posedge clk_core);
  reg_write('h04,'hf,0);  // int clear
  end
endtask


task save_frame_buffer;
    input [25:0] adrs;
    input [15:0] width;
    input [15:0] height;
    input [64*8:1] file_name;
    integer x;
    integer y;
    integer fp;
    reg [1:0]  stat;
    reg        hw_sel;
    reg [1:0]  bank_sel;
    reg [25:0] adr_pix;

    reg [31:0] tmp_data32;
    reg [7:0] tmp_data;
    reg [7:0]  cr;
    reg [7:0]  cg;
    reg [7:0]  cb;
    reg [7:0]  ca;
    begin
        $display("saving rendering result...");
        fp = $fopen(file_name);
        for (y = 0; y < height; y = y + 1) begin
            for (x = 0; x < width; x = x + 1) begin
               adr_pix = adrs + width * y + x;  // per 8bit (per pixel)
	       
               tmp_data32 = top.u_sram_slave.u_memory.mem[adr_pix[25:2]];
                case (adr_pix[1:0])
		  2'b00:tmp_data = tmp_data32[7:0];
		  2'b01:tmp_data = tmp_data32[15:8];
		  2'b10:tmp_data = tmp_data32[23:16];
		  2'b11:tmp_data = tmp_data32[31:24];
		endcase // case (adr_pix[1:0])
	        //RGB = 2:3:3
                cr = {4{tmp_data[7:6]}};
                cg = {tmp_data[5:3],tmp_data[5:3],tmp_data[5:2]};
                cb = {tmp_data[2:0],tmp_data[2:0],tmp_data[2:1]};
                ca = 8'hff;
                $fwrite(fp,"%h\n", {ca,cb,cg,cr});
            end
       end
       $fclose(fp);
    end
endtask
endmodule
