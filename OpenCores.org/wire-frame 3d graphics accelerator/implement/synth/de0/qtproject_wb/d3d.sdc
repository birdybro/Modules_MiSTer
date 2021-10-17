## Generated SDC file "usbhost.out.sdc"

## Copyright (C) 1991-2013 Altera Corporation
## Your use of Altera Corporation's design tools, logic functions 
## and other software and tools, and its AMPP partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Altera Program License 
## Subscription Agreement, Altera MegaCore Function License 
## Agreement, or other applicable license agreement, including, 
## without limitation, that your use is for the sole purpose of 
## programming logic devices manufactured by Altera and sold by 
## Altera or its authorized distributors.  Please refer to the 
## applicable agreement for further details.


## VENDOR  "Altera"
## PROGRAM "Quartus II"
## VERSION "Version 13.0.1 Build 232 06/12/2013 Service Pack 1 SJ Web Edition"

## DATE    "Fri Jul 12 07:20:51 2013"

##
## DEVICE  "EP3C16U484C6"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {altera_reserved_tck} -period 100.000 -waveform { 0.000 50.000 } [get_ports {altera_reserved_tck}]
create_clock -name {CLK} -period 20.000 -waveform { 0.000 10.000 } [get_ports {CLK}]


#**************************************************************
# Create Generated Clock
#**************************************************************

create_generated_clock -name {u0|altpll_0|sd1|pll7|clk[0]} -source [get_pins {u0|altpll_0|sd1|pll7|inclk[0]}] -duty_cycle 50.000 -multiply_by 1 -divide_by 1 -master_clock {CLK} [get_pins {u0|altpll_0|sd1|pll7|clk[0]}] 
create_generated_clock -name {u0|altpll_0|sd1|pll7|clk[1]} -source [get_pins {u0|altpll_0|sd1|pll7|inclk[0]}] -duty_cycle 50.000 -multiply_by 1 -divide_by 1 -phase -60.000 -master_clock {CLK} [get_pins {u0|altpll_0|sd1|pll7|clk[1]}] 
create_generated_clock -name {u0|altpll_0|sd1|pll7|clk[2]} -source [get_pins {u0|altpll_0|sd1|pll7|inclk[0]}] -duty_cycle 50.000 -multiply_by 24 -divide_by 25 -master_clock {CLK} [get_pins {u0|altpll_0|sd1|pll7|clk[2]}] 
create_generated_clock -name {u0|altpll_0|sd1|pll7|clk[3]} -source [get_pins {u0|altpll_0|sd1|pll7|inclk[0]}] -duty_cycle 50.000 -multiply_by 1 -divide_by 2 -master_clock {CLK} [get_pins {u0|altpll_0|sd1|pll7|clk[3]}] 
#create_generated_clock -name {u0|altpll_0|sd1|pll7|clk[4]} -source [get_pins {u0|altpll_0|sd1|pll7|inclk[0]}] -duty_cycle 50.000 -multiply_by 3 -master_clock {CLK} [get_pins {u0|altpll_0|sd1|pll7|clk[4]}] 

#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************

set_clock_uncertainty -rise_from [get_clocks {u0|altpll_0|sd1|pll7|clk[0]}] -rise_to [get_clocks {u0|altpll_0|sd1|pll7|clk[0]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {u0|altpll_0|sd1|pll7|clk[0]}] -fall_to [get_clocks {u0|altpll_0|sd1|pll7|clk[0]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {u0|altpll_0|sd1|pll7|clk[0]}] -rise_to [get_clocks {CLK}] -setup 0.100  
set_clock_uncertainty -rise_from [get_clocks {u0|altpll_0|sd1|pll7|clk[0]}] -rise_to [get_clocks {CLK}] -hold 0.070  
set_clock_uncertainty -rise_from [get_clocks {u0|altpll_0|sd1|pll7|clk[0]}] -fall_to [get_clocks {CLK}] -setup 0.100  
set_clock_uncertainty -rise_from [get_clocks {u0|altpll_0|sd1|pll7|clk[0]}] -fall_to [get_clocks {CLK}] -hold 0.070  
set_clock_uncertainty -rise_from [get_clocks {u0|altpll_0|sd1|pll7|clk[0]}] -rise_to [get_clocks {u0|altpll_0|sd1|pll7|clk[3]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {u0|altpll_0|sd1|pll7|clk[0]}] -fall_to [get_clocks {u0|altpll_0|sd1|pll7|clk[3]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {u0|altpll_0|sd1|pll7|clk[0]}] -rise_to [get_clocks {u0|altpll_0|sd1|pll7|clk[0]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {u0|altpll_0|sd1|pll7|clk[0]}] -fall_to [get_clocks {u0|altpll_0|sd1|pll7|clk[0]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {u0|altpll_0|sd1|pll7|clk[0]}] -rise_to [get_clocks {CLK}] -setup 0.100  
set_clock_uncertainty -fall_from [get_clocks {u0|altpll_0|sd1|pll7|clk[0]}] -rise_to [get_clocks {CLK}] -hold 0.070  
set_clock_uncertainty -fall_from [get_clocks {u0|altpll_0|sd1|pll7|clk[0]}] -fall_to [get_clocks {CLK}] -setup 0.100  
set_clock_uncertainty -fall_from [get_clocks {u0|altpll_0|sd1|pll7|clk[0]}] -fall_to [get_clocks {CLK}] -hold 0.070  
set_clock_uncertainty -fall_from [get_clocks {u0|altpll_0|sd1|pll7|clk[0]}] -rise_to [get_clocks {u0|altpll_0|sd1|pll7|clk[3]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {u0|altpll_0|sd1|pll7|clk[0]}] -fall_to [get_clocks {u0|altpll_0|sd1|pll7|clk[3]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {CLK}] -rise_to [get_clocks {u0|altpll_0|sd1|pll7|clk[0]}] -setup 0.070  
set_clock_uncertainty -rise_from [get_clocks {CLK}] -rise_to [get_clocks {u0|altpll_0|sd1|pll7|clk[0]}] -hold 0.100  
set_clock_uncertainty -rise_from [get_clocks {CLK}] -fall_to [get_clocks {u0|altpll_0|sd1|pll7|clk[0]}] -setup 0.070  
set_clock_uncertainty -rise_from [get_clocks {CLK}] -fall_to [get_clocks {u0|altpll_0|sd1|pll7|clk[0]}] -hold 0.100  
set_clock_uncertainty -rise_from [get_clocks {CLK}] -rise_to [get_clocks {CLK}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {CLK}] -fall_to [get_clocks {CLK}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {CLK}] -rise_to [get_clocks {u0|altpll_0|sd1|pll7|clk[0]}] -setup 0.070  
set_clock_uncertainty -fall_from [get_clocks {CLK}] -rise_to [get_clocks {u0|altpll_0|sd1|pll7|clk[0]}] -hold 0.100  
set_clock_uncertainty -fall_from [get_clocks {CLK}] -fall_to [get_clocks {u0|altpll_0|sd1|pll7|clk[0]}] -setup 0.070  
set_clock_uncertainty -fall_from [get_clocks {CLK}] -fall_to [get_clocks {u0|altpll_0|sd1|pll7|clk[0]}] -hold 0.100  
set_clock_uncertainty -fall_from [get_clocks {CLK}] -rise_to [get_clocks {CLK}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {CLK}] -fall_to [get_clocks {CLK}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {altera_reserved_tck}] -rise_to [get_clocks {altera_reserved_tck}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {altera_reserved_tck}] -fall_to [get_clocks {altera_reserved_tck}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {altera_reserved_tck}] -rise_to [get_clocks {altera_reserved_tck}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {altera_reserved_tck}] -fall_to [get_clocks {altera_reserved_tck}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {u0|altpll_0|sd1|pll7|clk[3]}] -rise_to [get_clocks {u0|altpll_0|sd1|pll7|clk[0]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {u0|altpll_0|sd1|pll7|clk[3]}] -fall_to [get_clocks {u0|altpll_0|sd1|pll7|clk[0]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {u0|altpll_0|sd1|pll7|clk[3]}] -rise_to [get_clocks {u0|altpll_0|sd1|pll7|clk[3]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {u0|altpll_0|sd1|pll7|clk[3]}] -fall_to [get_clocks {u0|altpll_0|sd1|pll7|clk[3]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {u0|altpll_0|sd1|pll7|clk[3]}] -rise_to [get_clocks {u0|altpll_0|sd1|pll7|clk[0]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {u0|altpll_0|sd1|pll7|clk[3]}] -fall_to [get_clocks {u0|altpll_0|sd1|pll7|clk[0]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {u0|altpll_0|sd1|pll7|clk[3]}] -rise_to [get_clocks {u0|altpll_0|sd1|pll7|clk[3]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {u0|altpll_0|sd1|pll7|clk[3]}] -fall_to [get_clocks {u0|altpll_0|sd1|pll7|clk[3]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {u0|altpll_0|sd1|pll7|clk[2]}] -rise_to [get_clocks {u0|altpll_0|sd1|pll7|clk[2]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {u0|altpll_0|sd1|pll7|clk[2]}] -fall_to [get_clocks {u0|altpll_0|sd1|pll7|clk[2]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {u0|altpll_0|sd1|pll7|clk[2]}] -rise_to [get_clocks {u0|altpll_0|sd1|pll7|clk[2]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {u0|altpll_0|sd1|pll7|clk[2]}] -fall_to [get_clocks {u0|altpll_0|sd1|pll7|clk[2]}]  0.020  


#**************************************************************
# Set Input Delay
#**************************************************************



#**************************************************************
# Set Output Delay
#**************************************************************



#**************************************************************
# Set Clock Groups
#**************************************************************

set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 


#**************************************************************
# Set False Path
#**************************************************************

set_false_path  -from  [get_clocks {u0|altpll_0|sd1|pll7|clk[0]}]  -to  [get_clocks {u0|altpll_0|sd1|pll7|clk[2]}]
set_false_path  -from  [get_clocks {u0|altpll_0|sd1|pll7|clk[2]}]  -to  [get_clocks {u0|altpll_0|sd1|pll7|clk[0]}]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|jupdate}] -to [get_registers {*|alt_jtag_atlantic:*|jupdate1*}]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|rdata[*]}] -to [get_registers {*|alt_jtag_atlantic*|td_shift[*]}]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|read}] -to [get_registers {*|alt_jtag_atlantic:*|read1*}]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|read_req}] 
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|rvalid}] -to [get_registers {*|alt_jtag_atlantic*|td_shift[*]}]
set_false_path -from [get_registers {*|t_dav}] -to [get_registers {*|alt_jtag_atlantic:*|tck_t_dav}]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|user_saw_rvalid}] -to [get_registers {*|alt_jtag_atlantic:*|rvalid0*}]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|wdata[*]}] -to [get_registers *]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|write}] -to [get_registers {*|alt_jtag_atlantic:*|write1*}]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|write_stalled}] -to [get_registers {*|alt_jtag_atlantic:*|t_ena*}]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|write_stalled}] -to [get_registers {*|alt_jtag_atlantic:*|t_pause*}]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|write_valid}] 
set_false_path -from [get_registers {*altera_avalon_st_clock_crosser:*|in_data_buffer*}] -to [get_registers {*altera_avalon_st_clock_crosser:*|out_data_buffer*}]
set_false_path -to [get_keepers {*altera_std_synchronizer:*|din_s1}]


#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************

