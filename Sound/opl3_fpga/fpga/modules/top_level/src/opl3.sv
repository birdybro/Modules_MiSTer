/*******************************************************************************
#   +html+<pre>
#
#   FILENAME: opl3.sv
#   AUTHOR: Greg Taylor     CREATION DATE: 24 Feb 2015
#
#   DESCRIPTION:
#
#   CHANGE HISTORY:
#   24 Feb 2015        Greg Taylor
#       Initial version
#
#   Copyright (C) 2014 Greg Taylor <gtaylor@sonic.net>
#    
#   This file is part of OPL3 FPGA.
#    
#   OPL3 FPGA is free software: you can redistribute it and/or modify
#   it under the terms of the GNU Lesser General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#   
#   OPL3 FPGA is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU Lesser General Public License for more details.
#   
#   You should have received a copy of the GNU Lesser General Public License
#   along with OPL3 FPGA.  If not, see <http://www.gnu.org/licenses/>.
#   
#   Original Java Code: 
#   Copyright (C) 2008 Robson Cozendey <robson@cozendey.com>
#   
#   Original C++ Code: 
#   Copyright (C) 2012  Steffen Ohrendorf <steffen.ohrendorf@gmx.de>
#   
#   Some code based on forum posts in: 
#   http://forums.submarine.org.uk/phpBB/viewforum.php?f=9,
#   Copyright (C) 2010-2013 by carbon14 and opl3    
#   
#******************************************************************************/
`timescale 1ns / 1ps
`default_nettype none // disable implicit net type declarations

`include "top_level/pkg/opl3_pkg.sv"
import opl3_pkg::*;

module opl3 #(
    parameter integer C_S_AXI_DATA_WIDTH = 0,
    parameter NUM_AXI_REGISTERS = 0
) (
    input wire clk125,
    output wire clk,
    output wire i2s_sclk,
    output wire i2s_ws,
    output wire i2s_sd,
    output logic ac_mute_n,
    output logic [3:0] led,
    output logic clk_locked,
    input wire [7:0] slv8_reg[NUM_AXI_REGISTERS*4]
);
    logic reset;
    wire sample_clk_en;
    
    wire [REG_TIMER_WIDTH-1:0] timer1;
    wire [REG_TIMER_WIDTH-1:0] timer2;
    wire irq_rst;
    wire mt1;
    wire mt2;
    wire st1;
    wire st2;
    wire [REG_CONNECTION_SEL_WIDTH-1:0] connection_sel;
    wire is_new;
    wire nts;                     // keyboard split selection     
    wire [REG_FNUM_WIDTH-1:0] fnum [2][9];
    wire [REG_MULT_WIDTH-1:0] mult [2][18];
    wire [REG_BLOCK_WIDTH-1:0] block [2][9];
    wire [REG_WS_WIDTH-1:0] ws [2][18];
    wire vib [2][18];
    wire dvb;
    wire kon [2][9];  
    wire [REG_ENV_WIDTH-1:0] ar [2][18]; // attack rate
    wire [REG_ENV_WIDTH-1:0] dr [2][18]; // decay rate
    wire [REG_ENV_WIDTH-1:0] sl [2][18]; // sustain level
    wire [REG_ENV_WIDTH-1:0] rr [2][18]; // release rate
    wire [REG_TL_WIDTH-1:0] tl [2][18];  // total level
    wire ksr [2][18];                    // key scale rate
    wire [REG_KSL_WIDTH-1:0] ksl [2][18]; // key scale level
    wire egt [2][18];                     // envelope type
    wire am [2][18];                      // amplitude modulation (tremolo)
    wire dam;                             // depth of tremolo
    wire ryt;
    wire bd;
    wire sd;
    wire tom;
    wire tc;
    wire hh;
    wire cha [2][9];
    wire chb [2][9];
    wire chc [2][9];
    wire chd [2][9];
    wire [REG_FB_WIDTH-1:0] fb [2][9];
    wire cnt [2][9];
    wire irq;

    logic signed [DAC_OUTPUT_WIDTH-1:0] sample_l = 0;
    logic signed [DAC_OUTPUT_WIDTH-1:0] sample_r = 0;
    wire signed [SAMPLE_WIDTH-1:0] channel_a;
    wire signed [SAMPLE_WIDTH-1:0] channel_b;
    wire signed [SAMPLE_WIDTH-1:0] channel_c;
    wire signed [SAMPLE_WIDTH-1:0] channel_d;   
    
    /*
     * Generate the 12.727MHz clock
     */
    clk_gen clk_gen (
        .*
    );
    always_comb reset = !clk_locked;
    
    /*
     * Generate the 12.727MHz/256 sample clock enable
     */
    clk_div #(
        .INPUT_CLK_FREQ(CLK_FREQ),       
        .OUTPUT_CLK_EN_FREQ(SAMPLE_FREQ) 
    ) sample_clk_gen (
        .clk_en(sample_clk_en),
        .*
    );
    
    channels channels (
        .*
    );
    
    /*
     * The 4 16-bit output channels are normally combined in the analog domain
     * after the YAC512 DAC outputs. Here we'll just add and output to our DAC
     * in 24-bit mode.
     */
    always_ff @(posedge clk) begin
        sample_l <= (channel_a + channel_c) <<< 6;
        sample_r <= (channel_b + channel_d) <<< 6;
    end
    
    i2s i2s (
        .left_channel(sample_l),
        .right_channel(sample_r),
        .*
    );
    
    always_comb led[0] = kon[0][0];
    always_comb led[1] = kon[0][1];
    always_comb led[2] = kon[0][2];
    always_comb led[3] = kon[0][3];
    
    always_comb ac_mute_n = 1;
        
    register_file_axi #(
        .C_S_AXI_DATA_WIDTH(C_S_AXI_DATA_WIDTH),
        .NUM_AXI_REGISTERS(NUM_AXI_REGISTERS)
    ) register_file_axi (
        .*
    ); 
        
    /*
     * If we don't need timers, don't instantiate to save area
     */    
    generate
    if (INSTANTIATE_TIMERS)
        timers timers (
            .*
        );
    endgenerate        
endmodule
`default_nettype wire  // re-enable implicit net type declarations
