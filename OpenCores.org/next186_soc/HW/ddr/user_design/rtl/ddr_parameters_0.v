//*****************************************************************************
// DISCLAIMER OF LIABILITY
//
// This file contains proprietary and confidential information of
// Xilinx, Inc. ("Xilinx"), that is distributed under a license
// from Xilinx, and may be used, copied and/or disclosed only
// pursuant to the terms of a valid license agreement with Xilinx.
//
// XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION
// ("MATERIALS") "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
// EXPRESSED, IMPLIED, OR STATUTORY, INCLUDING WITHOUT
// LIMITATION, ANY WARRANTY WITH RESPECT TO NONINFRINGEMENT,
// MERCHANTABILITY OR FITNESS FOR ANY PARTICULAR PURPOSE. Xilinx
// does not warrant that functions included in the Materials will
// meet the requirements of Licensee, or that the operation of the
// Materials will be uninterrupted or error-free, or that defects
// in the Materials will be corrected. Furthermore, Xilinx does
// not warrant or make any representations regarding use, or the
// results of the use, of the Materials in terms of correctness,
// accuracy, reliability or otherwise.
//
// Xilinx products are not designed or intended to be fail-safe,
// or for use in any application requiring fail-safe performance,
// such as life-support or safety devices or systems, Class III
// medical devices, nuclear facilities, applications related to
// the deployment of airbags, or any other applications that could
// lead to death, personal injury or severe property or
// environmental damage (individually and collectively, "critical
// applications"). Customer assumes the sole risk and liability
// of any use of Xilinx products in critical applications,
// subject only to applicable laws and regulations governing
// limitations on product liability.
//
// Copyright 2005, 2006, 2007 Xilinx, Inc.
// All rights reserved.
//
// This disclaimer and copyright notice must be retained as part
// of this file at all times.
//*****************************************************************************
//   ____  ____
//  /	/\/   /
// /___/  \  /   Vendor		    : Xilinx
// \   \   \/    Version            : 3.6.1
//  \	\        Application		: MIG
//  /	/        Filename		: ddr_parameters_0.v
// /___/   /\    Date Last Modified : $Date: 2010/11/26 18:25:42 $
// \   \  /  \   Date Created	    : Mon May 2 2005
//  \___\/\___\
// Device	: Spartan-3/3A/3A-DSP
// Design Name	: DDR2 SDRAM
// Purpose	: This module has the parameters used in the design
//*****************************************************************************

`timescale 1ns/100ps

// The reset polarity is set to active low by default. 
// You can change this by editing the parameter RESET_ACTIVE_LOW.
// Please do not change any of the other parameters directly by editing the RTL. 
// All other changes should be done through the GUI.

`define   DATA_WIDTH                               16
`define   DATA_STROBE_WIDTH                        2
`define   DATA_MASK_WIDTH                          2
`define   CLK_WIDTH                                1
`define   CKE_WIDTH                                1
`define   ROW_ADDRESS                              13
`define   MEMORY_WIDTH                             8
`define   REGISTERED                               0
`define   DATABITSPERSTROBE                        8
`define   RESET_PORT                               0
`define   MASK_ENABLE                              1
`define   USE_DM_PORT                              1
`define   COLUMN_ADDRESS                           10
`define   BANK_ADDRESS                             2
`define   DEBUG_EN                                 0
`define   LOAD_MODE_REGISTER                       13'b0010100110010
`define   EXT_LOAD_MODE_REGISTER                   13'b0000000000000
`define   RESET_ACTIVE_LOW                         1'b1
`define   RAS_COUNT_VALUE                          5'b00101
`define   RP_COUNT_VALUE                           3'b001
`define   RFC_COUNT_VALUE                          8'b00001101
`define   TWR_COUNT_VALUE                          3'b010
`define   MAX_REF_WIDTH                            10
`define   MAX_REF_CNT                              10'b1111100111
