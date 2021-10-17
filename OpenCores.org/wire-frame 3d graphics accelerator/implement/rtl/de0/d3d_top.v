//=======================================================================
// Project Monophony
//   Wire-Frame 3D Graphics Accelerator IP Core
//
// File:
//   d3d_top.v
//
// Abstract:
//   DE0 RTL top module
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

module d3d_top (
// system
input CLK,
input RST,
// SDRAM
output DRAM_CLK,
output [11:0] DRAM_ADDR,
output [1:0] DRAM_BA,
output DRAM_CAS_N,
output DRAM_CKE,
output DRAM_CS_N,
inout[15:0] DRAM_DQ,
output [1:0] DRAM_DQM,
output DRAM_RAS_N,
output DRAM_WE_N,
input [3:0] SW,
// USB
//inout USB_DP,
//inout USB_DN,
// VGA
output [3:0] VGA_R,
output [3:0] VGA_G,
output [3:0] VGA_B,
output VGA_VS,
output VGA_HS,
// FLASH
output DCLK,
output SCE,
output SDO,
input DATA
);

d3d_system u0 (
  .clk_clk(CLK),
  .reset_reset_n(RST),
  .altpll_0_c1_clk(DRAM_CLK),
  .sdram0_wire_addr(DRAM_ADDR),
  .sdram0_wire_ba(DRAM_BA),
  .sdram0_wire_cas_n(DRAM_CAS_N),
  .sdram0_wire_cke(DRAM_CKE),
  .sdram0_wire_cs_n(DRAM_CS_N),
  .sdram0_wire_dq(DRAM_DQ),
  .sdram0_wire_dqm(DRAM_DQM),
  .sdram0_wire_ras_n(DRAM_RAS_N),
  .sdram0_wire_we_n(DRAM_WE_N),
  .altpll_0_areset_conduit_export(),
  .altpll_0_locked_conduit_export(),
  .altpll_0_phasedone_conduit_export(),
  .pio_0_in_export(SW[3:0]),
  //.usb_inout_dp(USB_DP),
  //.usb_inout_dn(USB_DN),
  .vga_out_cr(VGA_R),
  .vga_out_cg(VGA_G),
  .vga_out_cb(VGA_B),
  .vga_out_vsync_x(VGA_VS),
  .vga_out_hsync_x(VGA_HS),
  .epcs_flash_controller_0_external_dclk  (DCLK),
  .epcs_flash_controller_0_external_sce   (SCE),
  .epcs_flash_controller_0_external_sdo   (SDO),
  .epcs_flash_controller_0_external_data0 (DATA) 
);

endmodule
