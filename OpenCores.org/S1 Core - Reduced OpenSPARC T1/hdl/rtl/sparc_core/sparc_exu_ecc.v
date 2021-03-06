// ========== Copyright Header Begin ==========================================
// 
// OpenSPARC T1 Processor File: sparc_exu_ecc.v
// Copyright (c) 2006 Sun Microsystems, Inc.  All Rights Reserved.
// DO NOT ALTER OR REMOVE COPYRIGHT NOTICES.
// 
// The above named program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public
// License version 2 as published by the Free Software Foundation.
// 
// The above named program is distributed in the hope that it will be 
// useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
// General Public License for more details.
// 
// You should have received a copy of the GNU General Public
// License along with this work; if not, write to the Free Software
// Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA.
// 
// ========== Copyright Header End ============================================
`ifdef SIMPLY_RISC_TWEAKS
`define SIMPLY_RISC_SCANIN .si(0)
`else
`define SIMPLY_RISC_SCANIN .si()
`endif
////////////////////////////////////////////////////////////////////////
/*
//  Module Name: sparc_exu_ecc
//	Description: This block performs the ecc check and correction as well as
// 			doing the w2 write port arbitration and the w2 ecc generation.
*/
module sparc_exu_ecc (/*AUTOARG*/
   // Outputs
   so, ecc_ecl_rs1_ce, ecc_ecl_rs1_ue, ecc_ecl_rs2_ce, 
   ecc_ecl_rs2_ue, ecc_ecl_rs3_ce, ecc_ecl_rs3_ue, 
   ecc_byp_ecc_result_m, exu_ifu_err_synd_m, 
   // Inputs
   rclk, se, si, byp_ecc_rcc_data_e, ecl_ecc_rs1_use_rf_e, 
   byp_ecc_rs1_synd_d, byp_alu_rs2_data_e, ecl_ecc_rs2_use_rf_e, 
   byp_ecc_rs2_synd_d, byp_ecc_rs3_data_e, ecl_ecc_rs3_use_rf_e, 
   byp_ecc_rs3_synd_d, ecl_ecc_sel_rs1_m_l, ecl_ecc_sel_rs2_m_l, 
   ecl_ecc_sel_rs3_m_l, ecl_ecc_log_rs1_m, ecl_ecc_log_rs2_m, 
   ecl_ecc_log_rs3_m
   ) ;
   input rclk;
   input se;
   input si;
   input [63:0] byp_ecc_rcc_data_e;
   input        ecl_ecc_rs1_use_rf_e;
   input [7:0]  byp_ecc_rs1_synd_d;
   input [63:0] byp_alu_rs2_data_e;
   input        ecl_ecc_rs2_use_rf_e;
   input [7:0]  byp_ecc_rs2_synd_d;
   input [63:0] byp_ecc_rs3_data_e;
   input        ecl_ecc_rs3_use_rf_e;
   input [7:0]  byp_ecc_rs3_synd_d;
   input        ecl_ecc_sel_rs1_m_l;
   input        ecl_ecc_sel_rs2_m_l;
   input        ecl_ecc_sel_rs3_m_l;
   input        ecl_ecc_log_rs1_m;
   input        ecl_ecc_log_rs2_m;
   input        ecl_ecc_log_rs3_m;

   output       so;
   output       ecc_ecl_rs1_ce;
   output       ecc_ecl_rs1_ue;
   output       ecc_ecl_rs2_ce;
   output       ecc_ecl_rs2_ue;
   output       ecc_ecl_rs3_ce;
   output       ecc_ecl_rs3_ue;

   output [63:0] ecc_byp_ecc_result_m;
   output [6:0]  exu_ifu_err_synd_m;

   wire          clk;
   wire         sel_rs1_m;
   wire         sel_rs2_m;
   wire         sel_rs3_m;
   wire [7:0]   rs1_ecc_e;
   wire [6:0]   rs1_err_e;      // syndrome generated by checker
   wire [6:0]   rs1_err_m;      // syndrome generated by checker
   wire [7:0]   rs2_ecc_e;
   wire [6:0]   rs2_err_e;      // syndrome generated by checker
   wire [6:0]   rs2_err_m;      // syndrome generated by checker
   wire [7:0]   rs3_ecc_e;
   wire [6:0]   rs3_err_e;      // syndrome generated by checker
   wire [6:0]   rs3_err_m;      // syndrome generated by checker
   wire [6:0]   err_m;
   wire [63:0]  ecc_datain_m;
   wire [63:0]  byp_ecc_rcc_data_m;
   wire [63:0]  byp_alu_rs2_data_m;
   wire [63:0]  exu_lsu_rs3_data_m;
   wire [63:0]  error_data_m;

   assign       clk = rclk;
   // Pass along ecc parity bits from RF
   dff_s #(8) rs1_ecc_d2e(.din(byp_ecc_rs1_synd_d[7:0]), .clk(clk), .q(rs1_ecc_e[7:0]),
                      .se(se), `SIMPLY_RISC_SCANIN, .so());
   dff_s #(8) rs2_ecc_d2e(.din(byp_ecc_rs2_synd_d[7:0]), .clk(clk), .q(rs2_ecc_e[7:0]),
                      .se(se), `SIMPLY_RISC_SCANIN, .so());
   dff_s #(8) rs3_ecc_d2e(.din(byp_ecc_rs3_synd_d[7:0]), .clk(clk), .q(rs3_ecc_e[7:0]),
                      .se(se), `SIMPLY_RISC_SCANIN, .so());
   
   // Check the ecc for all 4 outputs from RF
   zzecc_exu_chkecc2 chk_rs1(.d(byp_ecc_rcc_data_e[63:0]),
                            .vld(ecl_ecc_rs1_use_rf_e),
                            .p(rs1_ecc_e[7:0]),
                            .q(rs1_err_e[6:0]),
                            .ce(ecc_ecl_rs1_ce), .ue(ecc_ecl_rs1_ue), .ne());
   zzecc_exu_chkecc2 chk_rs2(.d(byp_alu_rs2_data_e[63:0]),
                            .vld(ecl_ecc_rs2_use_rf_e),
                            .p(rs2_ecc_e[7:0]),
                            .q(rs2_err_e[6:0]),
                            .ce(ecc_ecl_rs2_ce), .ue(ecc_ecl_rs2_ue), .ne());
   zzecc_exu_chkecc2 chk_rs3(.d(byp_ecc_rs3_data_e[63:0]),
                                .vld(ecl_ecc_rs3_use_rf_e),
                                .p(rs3_ecc_e[7:0]),
                                .q(rs3_err_e[6:0]),
                                .ce(ecc_ecl_rs3_ce), .ue(ecc_ecl_rs3_ue), .ne());

   // Put results from checkers into flops
   dff_s #(7) rs1_err_e2m(.din(rs1_err_e[6:0]), .clk(clk), .q(rs1_err_m[6:0]),
                      .se(se), `SIMPLY_RISC_SCANIN, .so());
   dff_s #(7) rs2_err_e2m(.din(rs2_err_e[6:0]), .clk(clk), .q(rs2_err_m[6:0]),
                      .se(se), `SIMPLY_RISC_SCANIN, .so());
   dff_s #(7) rs3o_err_e2m(.din(rs3_err_e[6:0]), .clk(clk), .q(rs3_err_m[6:0]),
                      .se(se), `SIMPLY_RISC_SCANIN, .so());

   // Pass along RF data to M stage
   dff_s #(64) rs1_data_e2m(.din(byp_ecc_rcc_data_e[63:0]), .clk(clk), .q(byp_ecc_rcc_data_m[63:0]),
                        .se(se), `SIMPLY_RISC_SCANIN, .so());
   dff_s #(64) rs2_data_e2m(.din(byp_alu_rs2_data_e[63:0]), .clk(clk), .q(byp_alu_rs2_data_m[63:0]),
                        .se(se), `SIMPLY_RISC_SCANIN, .so());
   dff_s #(64) rs3_data_e2m(.din(byp_ecc_rs3_data_e[63:0]), .clk(clk), 
                         .q(exu_lsu_rs3_data_m[63:0]),
                         .se(se), `SIMPLY_RISC_SCANIN, .so());

   // Mux between 3 different ports for syndrome and data
   assign       sel_rs1_m = ~ecl_ecc_sel_rs1_m_l;
   assign       sel_rs2_m = ~ecl_ecc_sel_rs2_m_l;
   assign       sel_rs3_m = ~ecl_ecc_sel_rs3_m_l;
   mux3ds #(7) syn_mux(.dout(err_m[6:0]),
                     .in0(rs1_err_m[6:0]),
                     .in1(rs2_err_m[6:0]),
                     .in2(rs3_err_m[6:0]),
                     .sel0(sel_rs1_m),
                     .sel1(sel_rs2_m),
                     .sel2(sel_rs3_m));
   mux3ds #(64) data_m_mux(.dout(ecc_datain_m[63:0]),
                     .in0(byp_ecc_rcc_data_m[63:0]),
                     .in1(byp_alu_rs2_data_m[63:0]),
                     .in2(exu_lsu_rs3_data_m[63:0]),
                     .sel0(sel_rs1_m),
                     .sel1(sel_rs2_m),
                     .sel2(sel_rs3_m));

   mux3ds #(7) syn_log_mux(.dout(exu_ifu_err_synd_m[6:0]),
                           .in0(rs1_err_m[6:0]),
                           .in1(rs2_err_m[6:0]),
                           .in2(rs3_err_m[6:0]),
                           .sel0(ecl_ecc_log_rs1_m),
                           .sel1(ecl_ecc_log_rs2_m),
                           .sel2(ecl_ecc_log_rs3_m));
   // Decode syndrome from checker
   sparc_exu_ecc_dec decode(.e          (error_data_m[63:0]),
                            .q          (err_m[6:0]));
   assign       ecc_byp_ecc_result_m[63:0] = ecc_datain_m[63:0] ^ error_data_m[63:0];


endmodule // sparc_exu_ecc
