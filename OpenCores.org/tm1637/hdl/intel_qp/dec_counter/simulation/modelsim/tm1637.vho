-- Copyright (C) 2020  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and any partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details, at
-- https://fpgasoftware.intel.com/eula.

-- VENDOR "Altera"
-- PROGRAM "Quartus Prime"
-- VERSION "Version 20.1.0 Build 711 06/05/2020 SJ Lite Edition"

-- DATE "03/13/2021 16:24:05"

-- 
-- Device: Altera EP4CE6E22C8 Package TQFP144
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY CYCLONEIVE;
LIBRARY IEEE;
USE CYCLONEIVE.CYCLONEIVE_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	hard_block IS
    PORT (
	devoe : IN std_logic;
	devclrn : IN std_logic;
	devpor : IN std_logic
	);
END hard_block;

-- Design Ports Information
-- ~ALTERA_ASDO_DATA1~	=>  Location: PIN_6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ~ALTERA_FLASH_nCE_nCSO~	=>  Location: PIN_8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ~ALTERA_DCLK~	=>  Location: PIN_12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ~ALTERA_DATA0~	=>  Location: PIN_13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ~ALTERA_nCEO~	=>  Location: PIN_101,	 I/O Standard: 2.5 V,	 Current Strength: 8mA


ARCHITECTURE structure OF hard_block IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL \~ALTERA_ASDO_DATA1~~padout\ : std_logic;
SIGNAL \~ALTERA_FLASH_nCE_nCSO~~padout\ : std_logic;
SIGNAL \~ALTERA_DATA0~~padout\ : std_logic;
SIGNAL \~ALTERA_ASDO_DATA1~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_FLASH_nCE_nCSO~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_DATA0~~ibuf_o\ : std_logic;

BEGIN

ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
END structure;


LIBRARY ALTERA;
LIBRARY CYCLONEIVE;
LIBRARY IEEE;
USE ALTERA.ALTERA_PRIMITIVES_COMPONENTS.ALL;
USE CYCLONEIVE.CYCLONEIVE_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	tm1637_toplevel IS
    PORT (
	clk25 : IN std_logic;
	clk : BUFFER std_logic;
	dio : BUFFER std_logic
	);
END tm1637_toplevel;

-- Design Ports Information
-- clk	=>  Location: PIN_132,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- dio	=>  Location: PIN_128,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- clk25	=>  Location: PIN_25,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF tm1637_toplevel IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_clk25 : std_logic;
SIGNAL ww_clk : std_logic;
SIGNAL ww_dio : std_logic;
SIGNAL \clk25~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \dio~output_o\ : std_logic;
SIGNAL \clk~output_o\ : std_logic;
SIGNAL \clk25~input_o\ : std_logic;
SIGNAL \clk25~inputclkctrl_outclk\ : std_logic;
SIGNAL \tec|Add1~1\ : std_logic;
SIGNAL \tec|Add1~2_combout\ : std_logic;
SIGNAL \dc|clkdiv[0]~12_combout\ : std_logic;
SIGNAL \dc|clkdiv[0]~13\ : std_logic;
SIGNAL \dc|clkdiv[1]~14_combout\ : std_logic;
SIGNAL \dc|clkdiv[1]~15\ : std_logic;
SIGNAL \dc|clkdiv[2]~16_combout\ : std_logic;
SIGNAL \dc|clkdiv[2]~17\ : std_logic;
SIGNAL \dc|clkdiv[3]~18_combout\ : std_logic;
SIGNAL \dc|LessThan0~1_combout\ : std_logic;
SIGNAL \dc|clkdiv[3]~19\ : std_logic;
SIGNAL \dc|clkdiv[4]~20_combout\ : std_logic;
SIGNAL \dc|clkdiv[4]~21\ : std_logic;
SIGNAL \dc|clkdiv[5]~22_combout\ : std_logic;
SIGNAL \dc|clkdiv[5]~23\ : std_logic;
SIGNAL \dc|clkdiv[6]~24_combout\ : std_logic;
SIGNAL \dc|clkdiv[6]~25\ : std_logic;
SIGNAL \dc|clkdiv[7]~26_combout\ : std_logic;
SIGNAL \dc|clkdiv[7]~27\ : std_logic;
SIGNAL \dc|clkdiv[8]~28_combout\ : std_logic;
SIGNAL \dc|LessThan0~0_combout\ : std_logic;
SIGNAL \dc|LessThan0~2_combout\ : std_logic;
SIGNAL \dc|clkdiv[8]~29\ : std_logic;
SIGNAL \dc|clkdiv[9]~30_combout\ : std_logic;
SIGNAL \dc|clkdiv[9]~31\ : std_logic;
SIGNAL \dc|clkdiv[10]~32_combout\ : std_logic;
SIGNAL \dc|clkdiv[10]~33\ : std_logic;
SIGNAL \dc|clkdiv[11]~34_combout\ : std_logic;
SIGNAL \dc|LessThan0~3_combout\ : std_logic;
SIGNAL \dc|ce~q\ : std_logic;
SIGNAL \tec|Add1~3\ : std_logic;
SIGNAL \tec|Add1~4_combout\ : std_logic;
SIGNAL \tec|Add1~5\ : std_logic;
SIGNAL \tec|Add1~6_combout\ : std_logic;
SIGNAL \tec|Add1~7\ : std_logic;
SIGNAL \tec|Add1~8_combout\ : std_logic;
SIGNAL \tec|Equal0~3_combout\ : std_logic;
SIGNAL \tec|Equal19~0_combout\ : std_logic;
SIGNAL \tec|sm_counter~4_combout\ : std_logic;
SIGNAL \tec|Add1~9\ : std_logic;
SIGNAL \tec|Add1~10_combout\ : std_logic;
SIGNAL \tec|Add1~11\ : std_logic;
SIGNAL \tec|Add1~12_combout\ : std_logic;
SIGNAL \tec|Add1~13\ : std_logic;
SIGNAL \tec|Add1~14_combout\ : std_logic;
SIGNAL \tec|Add1~15\ : std_logic;
SIGNAL \tec|Add1~16_combout\ : std_logic;
SIGNAL \tec|sm_counter~3_combout\ : std_logic;
SIGNAL \tec|Add1~17\ : std_logic;
SIGNAL \tec|Add1~18_combout\ : std_logic;
SIGNAL \tec|sm_counter~2_combout\ : std_logic;
SIGNAL \tec|Add1~19\ : std_logic;
SIGNAL \tec|Add1~20_combout\ : std_logic;
SIGNAL \tec|sm_counter~1_combout\ : std_logic;
SIGNAL \tec|Add1~21\ : std_logic;
SIGNAL \tec|Add1~22_combout\ : std_logic;
SIGNAL \tec|Add1~23\ : std_logic;
SIGNAL \tec|Add1~24_combout\ : std_logic;
SIGNAL \tec|Add1~25\ : std_logic;
SIGNAL \tec|Add1~26_combout\ : std_logic;
SIGNAL \tec|sm_counter~0_combout\ : std_logic;
SIGNAL \tec|Equal142~6_combout\ : std_logic;
SIGNAL \tec|Equal142~7_combout\ : std_logic;
SIGNAL \tec|Add1~27\ : std_logic;
SIGNAL \tec|Add1~28_combout\ : std_logic;
SIGNAL \tec|Add1~29\ : std_logic;
SIGNAL \tec|Add1~30_combout\ : std_logic;
SIGNAL \tec|Add1~31\ : std_logic;
SIGNAL \tec|Add1~32_combout\ : std_logic;
SIGNAL \tec|Add1~33\ : std_logic;
SIGNAL \tec|Add1~34_combout\ : std_logic;
SIGNAL \tec|Add1~35\ : std_logic;
SIGNAL \tec|Add1~36_combout\ : std_logic;
SIGNAL \tec|Add1~37\ : std_logic;
SIGNAL \tec|Add1~38_combout\ : std_logic;
SIGNAL \tec|Add1~39\ : std_logic;
SIGNAL \tec|Add1~40_combout\ : std_logic;
SIGNAL \tec|Add1~41\ : std_logic;
SIGNAL \tec|Add1~42_combout\ : std_logic;
SIGNAL \tec|Add1~43\ : std_logic;
SIGNAL \tec|Add1~44_combout\ : std_logic;
SIGNAL \tec|Add1~45\ : std_logic;
SIGNAL \tec|Add1~46_combout\ : std_logic;
SIGNAL \tec|Equal142~3_combout\ : std_logic;
SIGNAL \tec|Equal142~4_combout\ : std_logic;
SIGNAL \tec|Add1~47\ : std_logic;
SIGNAL \tec|Add1~48_combout\ : std_logic;
SIGNAL \tec|Add1~49\ : std_logic;
SIGNAL \tec|Add1~50_combout\ : std_logic;
SIGNAL \tec|Add1~51\ : std_logic;
SIGNAL \tec|Add1~52_combout\ : std_logic;
SIGNAL \tec|Add1~53\ : std_logic;
SIGNAL \tec|Add1~54_combout\ : std_logic;
SIGNAL \tec|Add1~55\ : std_logic;
SIGNAL \tec|Add1~56_combout\ : std_logic;
SIGNAL \tec|Add1~57\ : std_logic;
SIGNAL \tec|Add1~58_combout\ : std_logic;
SIGNAL \tec|Add1~59\ : std_logic;
SIGNAL \tec|Add1~60_combout\ : std_logic;
SIGNAL \tec|Add1~61\ : std_logic;
SIGNAL \tec|Add1~62_combout\ : std_logic;
SIGNAL \tec|Equal142~1_combout\ : std_logic;
SIGNAL \tec|Equal142~2_combout\ : std_logic;
SIGNAL \tec|Equal142~5_combout\ : std_logic;
SIGNAL \tec|Equal142~0_combout\ : std_logic;
SIGNAL \tec|Equal142~8_combout\ : std_logic;
SIGNAL \tec|Add1~0_combout\ : std_logic;
SIGNAL \tec|sm_counter~5_combout\ : std_logic;
SIGNAL \tec|Equal7~0_combout\ : std_logic;
SIGNAL \tec|Equal64~1_combout\ : std_logic;
SIGNAL \tec|Equal24~2_combout\ : std_logic;
SIGNAL \tec|Equal64~0_combout\ : std_logic;
SIGNAL \tec|Equal80~0_combout\ : std_logic;
SIGNAL \dc|d1Next[0]~2_combout\ : std_logic;
SIGNAL \dc|d1Next~1_combout\ : std_logic;
SIGNAL \dc|d1Curr[3]~feeder_combout\ : std_logic;
SIGNAL \dc|d1Next~0_combout\ : std_logic;
SIGNAL \dc|d1Curr[1]~feeder_combout\ : std_logic;
SIGNAL \dc|Add4~0_combout\ : std_logic;
SIGNAL \dc|Equal3~0_combout\ : std_logic;
SIGNAL \dc|d10Next~0_combout\ : std_logic;
SIGNAL \dc|Add3~0_combout\ : std_logic;
SIGNAL \dc|d10Next~3_combout\ : std_logic;
SIGNAL \dc|Equal2~0_combout\ : std_logic;
SIGNAL \dc|d10Next~1_combout\ : std_logic;
SIGNAL \dc|d10Curr[1]~feeder_combout\ : std_logic;
SIGNAL \dc|d10Next~2_combout\ : std_logic;
SIGNAL \dc|d10Curr[2]~feeder_combout\ : std_logic;
SIGNAL \tec|Equal71~0_combout\ : std_logic;
SIGNAL \tec|Equal143~2_combout\ : std_logic;
SIGNAL \tec|rdy~q\ : std_logic;
SIGNAL \tec|reg_digit0[3]~0_combout\ : std_logic;
SIGNAL \tec|reg_digit2[1]~feeder_combout\ : std_logic;
SIGNAL \tec|Mux16~0_combout\ : std_logic;
SIGNAL \tec|Selector1~4_combout\ : std_logic;
SIGNAL \tec|Equal8~0_combout\ : std_logic;
SIGNAL \tec|Equal8~1_combout\ : std_logic;
SIGNAL \dc|d100Next~0_combout\ : std_logic;
SIGNAL \dc|d100Curr[0]~feeder_combout\ : std_logic;
SIGNAL \dc|process_1~0_combout\ : std_logic;
SIGNAL \dc|Add2~0_combout\ : std_logic;
SIGNAL \dc|d100Next~3_combout\ : std_logic;
SIGNAL \dc|process_1~1_combout\ : std_logic;
SIGNAL \dc|process_1~2_combout\ : std_logic;
SIGNAL \dc|d100Next~1_combout\ : std_logic;
SIGNAL \dc|d100Curr[1]~feeder_combout\ : std_logic;
SIGNAL \dc|d100Next~2_combout\ : std_logic;
SIGNAL \dc|d100Curr[2]~feeder_combout\ : std_logic;
SIGNAL \tec|Mux13~0_combout\ : std_logic;
SIGNAL \tec|Equal9~1_combout\ : std_logic;
SIGNAL \tec|Selector1~6_combout\ : std_logic;
SIGNAL \tec|Mux15~0_combout\ : std_logic;
SIGNAL \tec|Equal1~2_combout\ : std_logic;
SIGNAL \tec|Selector1~5_combout\ : std_logic;
SIGNAL \tec|Equal37~0_combout\ : std_logic;
SIGNAL \tec|Mux25~0_combout\ : std_logic;
SIGNAL \tec|Selector1~3_combout\ : std_logic;
SIGNAL \tec|Selector1~7_combout\ : std_logic;
SIGNAL \tec|Mux9~0_combout\ : std_logic;
SIGNAL \tec|Equal64~2_combout\ : std_logic;
SIGNAL \tec|Equal64~3_combout\ : std_logic;
SIGNAL \tec|Selector1~9_combout\ : std_logic;
SIGNAL \tec|Mux10~0_combout\ : std_logic;
SIGNAL \tec|Selector1~8_combout\ : std_logic;
SIGNAL \dc|d1000Next~0_combout\ : std_logic;
SIGNAL \dc|Add1~0_combout\ : std_logic;
SIGNAL \dc|d1000Next~3_combout\ : std_logic;
SIGNAL \dc|d1000Curr[3]~feeder_combout\ : std_logic;
SIGNAL \dc|process_1~3_combout\ : std_logic;
SIGNAL \dc|d1000Next~1_combout\ : std_logic;
SIGNAL \dc|d1000Next~2_combout\ : std_logic;
SIGNAL \tec|reg_digit0[3]~feeder_combout\ : std_logic;
SIGNAL \tec|Mux2~0_combout\ : std_logic;
SIGNAL \tec|Equal47~0_combout\ : std_logic;
SIGNAL \tec|Equal7~1_combout\ : std_logic;
SIGNAL \tec|Selector1~10_combout\ : std_logic;
SIGNAL \tec|Mux1~0_combout\ : std_logic;
SIGNAL \tec|Equal37~1_combout\ : std_logic;
SIGNAL \tec|Selector1~11_combout\ : std_logic;
SIGNAL \tec|Selector1~12_combout\ : std_logic;
SIGNAL \tec|Equal77~0_combout\ : std_logic;
SIGNAL \tec|Mux20~0_combout\ : std_logic;
SIGNAL \tec|Equal27~0_combout\ : std_logic;
SIGNAL \tec|Equal89~0_combout\ : std_logic;
SIGNAL \tec|Selector1~25_combout\ : std_logic;
SIGNAL \tec|Mux19~0_combout\ : std_logic;
SIGNAL \tec|Selector1~26_combout\ : std_logic;
SIGNAL \tec|Mux17~0_combout\ : std_logic;
SIGNAL \tec|Equal69~0_combout\ : std_logic;
SIGNAL \tec|Mux18~0_combout\ : std_logic;
SIGNAL \tec|Selector1~27_combout\ : std_logic;
SIGNAL \tec|Selector1~28_combout\ : std_logic;
SIGNAL \tec|Mux11~0_combout\ : std_logic;
SIGNAL \tec|Mux4~0_combout\ : std_logic;
SIGNAL \tec|Equal18~0_combout\ : std_logic;
SIGNAL \tec|Equal18~1_combout\ : std_logic;
SIGNAL \tec|Selector1~31_combout\ : std_logic;
SIGNAL \tec|Selector1~32_combout\ : std_logic;
SIGNAL \tec|Mux12~0_combout\ : std_logic;
SIGNAL \tec|Selector1~30_combout\ : std_logic;
SIGNAL \tec|Equal7~2_combout\ : std_logic;
SIGNAL \tec|Equal76~0_combout\ : std_logic;
SIGNAL \tec|Equal76~1_combout\ : std_logic;
SIGNAL \tec|Mux14~0_combout\ : std_logic;
SIGNAL \tec|Selector1~29_combout\ : std_logic;
SIGNAL \tec|Selector1~33_combout\ : std_logic;
SIGNAL \tec|Equal96~0_combout\ : std_logic;
SIGNAL \tec|Equal97~2_combout\ : std_logic;
SIGNAL \tec|Mux0~0_combout\ : std_logic;
SIGNAL \tec|Mux21~0_combout\ : std_logic;
SIGNAL \tec|Equal2~3_combout\ : std_logic;
SIGNAL \tec|Equal2~4_combout\ : std_logic;
SIGNAL \tec|Equal10~0_combout\ : std_logic;
SIGNAL \tec|Equal43~0_combout\ : std_logic;
SIGNAL \tec|Selector1~23_combout\ : std_logic;
SIGNAL \tec|Equal99~2_combout\ : std_logic;
SIGNAL \tec|Mux22~0_combout\ : std_logic;
SIGNAL \tec|Mux3~0_combout\ : std_logic;
SIGNAL \tec|Equal16~1_combout\ : std_logic;
SIGNAL \tec|Selector1~22_combout\ : std_logic;
SIGNAL \tec|Selector1~24_combout\ : std_logic;
SIGNAL \tec|Mux7~0_combout\ : std_logic;
SIGNAL \tec|Equal56~2_combout\ : std_logic;
SIGNAL \tec|Equal56~4_combout\ : std_logic;
SIGNAL \tec|Equal56~3_combout\ : std_logic;
SIGNAL \tec|Selector1~15_combout\ : std_logic;
SIGNAL \tec|Mux5~0_combout\ : std_logic;
SIGNAL \tec|Equal53~0_combout\ : std_logic;
SIGNAL \tec|Equal16~0_combout\ : std_logic;
SIGNAL \tec|Selector1~18_combout\ : std_logic;
SIGNAL \tec|Mux26~0_combout\ : std_logic;
SIGNAL \tec|Equal74~0_combout\ : std_logic;
SIGNAL \tec|Equal74~1_combout\ : std_logic;
SIGNAL \tec|Selector1~19_combout\ : std_logic;
SIGNAL \tec|Equal63~0_combout\ : std_logic;
SIGNAL \tec|Mux8~0_combout\ : std_logic;
SIGNAL \tec|Mux27~0_combout\ : std_logic;
SIGNAL \tec|Selector1~17_combout\ : std_logic;
SIGNAL \tec|Selector1~20_combout\ : std_logic;
SIGNAL \tec|Mux24~0_combout\ : std_logic;
SIGNAL \tec|Selector1~13_combout\ : std_logic;
SIGNAL \tec|Mux23~0_combout\ : std_logic;
SIGNAL \tec|Selector1~14_combout\ : std_logic;
SIGNAL \tec|Mux6~0_combout\ : std_logic;
SIGNAL \tec|Selector1~16_combout\ : std_logic;
SIGNAL \tec|Selector1~21_combout\ : std_logic;
SIGNAL \tec|Selector1~34_combout\ : std_logic;
SIGNAL \tec|Selector1~0_combout\ : std_logic;
SIGNAL \tec|Equal40~0_combout\ : std_logic;
SIGNAL \tec|Equal113~3_combout\ : std_logic;
SIGNAL \tec|Equal117~0_combout\ : std_logic;
SIGNAL \tec|Equal8~2_combout\ : std_logic;
SIGNAL \tec|Selector3~1_combout\ : std_logic;
SIGNAL \tec|Equal128~0_combout\ : std_logic;
SIGNAL \tec|Equal128~1_combout\ : std_logic;
SIGNAL \tec|Equal140~0_combout\ : std_logic;
SIGNAL \tec|Equal1~0_combout\ : std_logic;
SIGNAL \tec|Equal0~0_combout\ : std_logic;
SIGNAL \tec|Equal1~1_combout\ : std_logic;
SIGNAL \tec|Equal68~0_combout\ : std_logic;
SIGNAL \tec|Selector3~3_combout\ : std_logic;
SIGNAL \tec|Equal136~1_combout\ : std_logic;
SIGNAL \tec|Equal0~1_combout\ : std_logic;
SIGNAL \tec|Selector3~2_combout\ : std_logic;
SIGNAL \tec|Equal4~0_combout\ : std_logic;
SIGNAL \tec|Equal38~0_combout\ : std_logic;
SIGNAL \tec|Selector3~4_combout\ : std_logic;
SIGNAL \tec|Equal63~1_combout\ : std_logic;
SIGNAL \tec|Equal119~0_combout\ : std_logic;
SIGNAL \tec|Equal23~0_combout\ : std_logic;
SIGNAL \tec|Equal133~0_combout\ : std_logic;
SIGNAL \tec|Equal39~0_combout\ : std_logic;
SIGNAL \tec|Selector1~1_combout\ : std_logic;
SIGNAL \tec|Selector1~2_combout\ : std_logic;
SIGNAL \tec|Selector1~35_combout\ : std_logic;
SIGNAL \tec|Equal2~1_combout\ : std_logic;
SIGNAL \tec|Equal32~0_combout\ : std_logic;
SIGNAL \tec|Equal0~2_combout\ : std_logic;
SIGNAL \tec|Equal2~0_combout\ : std_logic;
SIGNAL \tec|Equal34~0_combout\ : std_logic;
SIGNAL \tec|Selector3~6_combout\ : std_logic;
SIGNAL \tec|Equal36~0_combout\ : std_logic;
SIGNAL \tec|Equal70~0_combout\ : std_logic;
SIGNAL \tec|Equal112~0_combout\ : std_logic;
SIGNAL \tec|Equal22~0_combout\ : std_logic;
SIGNAL \tec|Equal30~0_combout\ : std_logic;
SIGNAL \tec|Selector3~5_combout\ : std_logic;
SIGNAL \tec|Equal24~4_combout\ : std_logic;
SIGNAL \tec|Equal138~0_combout\ : std_logic;
SIGNAL \tec|Equal24~3_combout\ : std_logic;
SIGNAL \tec|Selector3~7_combout\ : std_logic;
SIGNAL \tec|Selector3~8_combout\ : std_logic;
SIGNAL \tec|Equal59~0_combout\ : std_logic;
SIGNAL \tec|Equal128~3_combout\ : std_logic;
SIGNAL \tec|WideOr6~2_combout\ : std_logic;
SIGNAL \tec|Equal3~0_combout\ : std_logic;
SIGNAL \tec|WideOr6~1_combout\ : std_logic;
SIGNAL \tec|Equal88~2_combout\ : std_logic;
SIGNAL \tec|Equal88~3_combout\ : std_logic;
SIGNAL \tec|WideOr6~0_combout\ : std_logic;
SIGNAL \tec|Equal113~2_combout\ : std_logic;
SIGNAL \tec|Equal128~2_combout\ : std_logic;
SIGNAL \tec|WideOr6~3_combout\ : std_logic;
SIGNAL \tec|WideOr6~4_combout\ : std_logic;
SIGNAL \tec|WideNor0~28_combout\ : std_logic;
SIGNAL \tec|WideNor0~34_combout\ : std_logic;
SIGNAL \tec|WideNor0~29_combout\ : std_logic;
SIGNAL \tec|WideNor0~17_combout\ : std_logic;
SIGNAL \tec|WideNor0~18_combout\ : std_logic;
SIGNAL \tec|WideNor0~21_combout\ : std_logic;
SIGNAL \tec|WideNor0~22_combout\ : std_logic;
SIGNAL \tec|WideNor0~20_combout\ : std_logic;
SIGNAL \tec|WideNor0~23_combout\ : std_logic;
SIGNAL \tec|WideNor0~19_combout\ : std_logic;
SIGNAL \tec|WideNor0~33_combout\ : std_logic;
SIGNAL \tec|WideNor0~24_combout\ : std_logic;
SIGNAL \tec|WideNor0~25_combout\ : std_logic;
SIGNAL \tec|WideNor0~32_combout\ : std_logic;
SIGNAL \tec|WideNor0~16_combout\ : std_logic;
SIGNAL \tec|WideNor0~26_combout\ : std_logic;
SIGNAL \tec|WideNor0~11_combout\ : std_logic;
SIGNAL \tec|WideNor0~10_combout\ : std_logic;
SIGNAL \tec|WideNor0~9_combout\ : std_logic;
SIGNAL \tec|WideNor0~8_combout\ : std_logic;
SIGNAL \tec|WideNor0~12_combout\ : std_logic;
SIGNAL \tec|WideNor0~31_combout\ : std_logic;
SIGNAL \tec|WideNor0~15_combout\ : std_logic;
SIGNAL \tec|WideNor0~13_combout\ : std_logic;
SIGNAL \tec|Equal26~0_combout\ : std_logic;
SIGNAL \tec|Equal2~2_combout\ : std_logic;
SIGNAL \tec|WideNor0~14_combout\ : std_logic;
SIGNAL \tec|WideNor0~27_combout\ : std_logic;
SIGNAL \tec|dio~41_combout\ : std_logic;
SIGNAL \tec|dio~39_combout\ : std_logic;
SIGNAL \tec|Equal9~0_combout\ : std_logic;
SIGNAL \tec|dio~40_combout\ : std_logic;
SIGNAL \tec|Equal88~4_combout\ : std_logic;
SIGNAL \tec|dio~42_combout\ : std_logic;
SIGNAL \tec|Equal128~4_combout\ : std_logic;
SIGNAL \tec|dio~43_combout\ : std_logic;
SIGNAL \tec|dio~46_combout\ : std_logic;
SIGNAL \tec|dio~16_combout\ : std_logic;
SIGNAL \tec|dio~17_combout\ : std_logic;
SIGNAL \tec|dio~18_combout\ : std_logic;
SIGNAL \tec|Equal66~0_combout\ : std_logic;
SIGNAL \tec|dio~21_combout\ : std_logic;
SIGNAL \tec|dio~19_combout\ : std_logic;
SIGNAL \tec|dio~22_combout\ : std_logic;
SIGNAL \tec|dio~20_combout\ : std_logic;
SIGNAL \tec|dio~23_combout\ : std_logic;
SIGNAL \tec|Equal122~0_combout\ : std_logic;
SIGNAL \tec|dio~26_combout\ : std_logic;
SIGNAL \tec|dio~47_combout\ : std_logic;
SIGNAL \tec|dio~24_combout\ : std_logic;
SIGNAL \tec|dio~48_combout\ : std_logic;
SIGNAL \tec|Equal18~2_combout\ : std_logic;
SIGNAL \tec|Equal10~1_combout\ : std_logic;
SIGNAL \tec|dio~25_combout\ : std_logic;
SIGNAL \tec|dio~27_combout\ : std_logic;
SIGNAL \tec|Equal54~2_combout\ : std_logic;
SIGNAL \tec|dio~36_combout\ : std_logic;
SIGNAL \tec|Equal28~0_combout\ : std_logic;
SIGNAL \tec|dio~35_combout\ : std_logic;
SIGNAL \tec|dio~34_combout\ : std_logic;
SIGNAL \tec|Equal52~0_combout\ : std_logic;
SIGNAL \tec|dio~37_combout\ : std_logic;
SIGNAL \tec|dio~31_combout\ : std_logic;
SIGNAL \tec|dio~32_combout\ : std_logic;
SIGNAL \tec|dio~50_combout\ : std_logic;
SIGNAL \tec|dio~49_combout\ : std_logic;
SIGNAL \tec|dio~28_combout\ : std_logic;
SIGNAL \tec|Equal20~0_combout\ : std_logic;
SIGNAL \tec|Equal20~1_combout\ : std_logic;
SIGNAL \tec|Equal20~2_combout\ : std_logic;
SIGNAL \tec|dio~29_combout\ : std_logic;
SIGNAL \tec|Equal48~0_combout\ : std_logic;
SIGNAL \tec|dio~30_combout\ : std_logic;
SIGNAL \tec|dio~33_combout\ : std_logic;
SIGNAL \tec|dio~38_combout\ : std_logic;
SIGNAL \tec|dio~44_combout\ : std_logic;
SIGNAL \tec|WideNor0~30_combout\ : std_logic;
SIGNAL \tec|dio~45_combout\ : std_logic;
SIGNAL \tec|dio~reg0_q\ : std_logic;
SIGNAL \tec|dio~en_q\ : std_logic;
SIGNAL \tec|Equal136~0_combout\ : std_logic;
SIGNAL \tec|Selector3~0_combout\ : std_logic;
SIGNAL \tec|Selector3~9_combout\ : std_logic;
SIGNAL \tec|Selector3~10_combout\ : std_logic;
SIGNAL \tec|clk~q\ : std_logic;
SIGNAL \dc|d1000Next\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \dc|d100Next\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \dc|d10Next\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \tec|reg_digit2\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \tec|reg_digit3\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \dc|d100Curr\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \tec|sm_counter\ : std_logic_vector(31 DOWNTO 0);
SIGNAL \dc|clkdiv\ : std_logic_vector(11 DOWNTO 0);
SIGNAL \dc|d1Next\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \tec|reg_digit1\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \dc|d1000Curr\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \tec|reg_digit0\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \dc|d1Curr\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \dc|d10Curr\ : std_logic_vector(3 DOWNTO 0);

COMPONENT hard_block
    PORT (
	devoe : IN std_logic;
	devclrn : IN std_logic;
	devpor : IN std_logic);
END COMPONENT;

BEGIN

ww_clk25 <= clk25;
clk <= ww_clk;
dio <= ww_dio;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\clk25~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \clk25~input_o\);
auto_generated_inst : hard_block
PORT MAP (
	devoe => ww_devoe,
	devclrn => ww_devclrn,
	devpor => ww_devpor);

-- Location: IOOBUF_X16_Y24_N16
\dio~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \tec|dio~reg0_q\,
	oe => \tec|dio~en_q\,
	devoe => ww_devoe,
	o => \dio~output_o\);

-- Location: IOOBUF_X13_Y24_N16
\clk~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \tec|clk~q\,
	devoe => ww_devoe,
	o => \clk~output_o\);

-- Location: IOIBUF_X0_Y11_N22
\clk25~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_clk25,
	o => \clk25~input_o\);

-- Location: CLKCTRL_G3
\clk25~inputclkctrl\ : cycloneive_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \clk25~inputclkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \clk25~inputclkctrl_outclk\);

-- Location: LCCOMB_X17_Y9_N0
\tec|Add1~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Add1~0_combout\ = \tec|sm_counter\(0) $ (VCC)
-- \tec|Add1~1\ = CARRY(\tec|sm_counter\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \tec|sm_counter\(0),
	datad => VCC,
	combout => \tec|Add1~0_combout\,
	cout => \tec|Add1~1\);

-- Location: LCCOMB_X17_Y9_N2
\tec|Add1~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Add1~2_combout\ = (\tec|sm_counter\(1) & (!\tec|Add1~1\)) # (!\tec|sm_counter\(1) & ((\tec|Add1~1\) # (GND)))
-- \tec|Add1~3\ = CARRY((!\tec|Add1~1\) # (!\tec|sm_counter\(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \tec|sm_counter\(1),
	datad => VCC,
	cin => \tec|Add1~1\,
	combout => \tec|Add1~2_combout\,
	cout => \tec|Add1~3\);

-- Location: LCCOMB_X23_Y13_N6
\dc|clkdiv[0]~12\ : cycloneive_lcell_comb
-- Equation(s):
-- \dc|clkdiv[0]~12_combout\ = \dc|clkdiv\(0) $ (VCC)
-- \dc|clkdiv[0]~13\ = CARRY(\dc|clkdiv\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010110101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \dc|clkdiv\(0),
	datad => VCC,
	combout => \dc|clkdiv[0]~12_combout\,
	cout => \dc|clkdiv[0]~13\);

-- Location: FF_X23_Y13_N7
\dc|clkdiv[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \dc|clkdiv[0]~12_combout\,
	sclr => \dc|LessThan0~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \dc|clkdiv\(0));

-- Location: LCCOMB_X23_Y13_N8
\dc|clkdiv[1]~14\ : cycloneive_lcell_comb
-- Equation(s):
-- \dc|clkdiv[1]~14_combout\ = (\dc|clkdiv\(1) & (!\dc|clkdiv[0]~13\)) # (!\dc|clkdiv\(1) & ((\dc|clkdiv[0]~13\) # (GND)))
-- \dc|clkdiv[1]~15\ = CARRY((!\dc|clkdiv[0]~13\) # (!\dc|clkdiv\(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \dc|clkdiv\(1),
	datad => VCC,
	cin => \dc|clkdiv[0]~13\,
	combout => \dc|clkdiv[1]~14_combout\,
	cout => \dc|clkdiv[1]~15\);

-- Location: FF_X23_Y13_N9
\dc|clkdiv[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \dc|clkdiv[1]~14_combout\,
	sclr => \dc|LessThan0~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \dc|clkdiv\(1));

-- Location: LCCOMB_X23_Y13_N10
\dc|clkdiv[2]~16\ : cycloneive_lcell_comb
-- Equation(s):
-- \dc|clkdiv[2]~16_combout\ = (\dc|clkdiv\(2) & (\dc|clkdiv[1]~15\ $ (GND))) # (!\dc|clkdiv\(2) & (!\dc|clkdiv[1]~15\ & VCC))
-- \dc|clkdiv[2]~17\ = CARRY((\dc|clkdiv\(2) & !\dc|clkdiv[1]~15\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \dc|clkdiv\(2),
	datad => VCC,
	cin => \dc|clkdiv[1]~15\,
	combout => \dc|clkdiv[2]~16_combout\,
	cout => \dc|clkdiv[2]~17\);

-- Location: FF_X23_Y13_N11
\dc|clkdiv[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \dc|clkdiv[2]~16_combout\,
	sclr => \dc|LessThan0~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \dc|clkdiv\(2));

-- Location: LCCOMB_X23_Y13_N12
\dc|clkdiv[3]~18\ : cycloneive_lcell_comb
-- Equation(s):
-- \dc|clkdiv[3]~18_combout\ = (\dc|clkdiv\(3) & (!\dc|clkdiv[2]~17\)) # (!\dc|clkdiv\(3) & ((\dc|clkdiv[2]~17\) # (GND)))
-- \dc|clkdiv[3]~19\ = CARRY((!\dc|clkdiv[2]~17\) # (!\dc|clkdiv\(3)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \dc|clkdiv\(3),
	datad => VCC,
	cin => \dc|clkdiv[2]~17\,
	combout => \dc|clkdiv[3]~18_combout\,
	cout => \dc|clkdiv[3]~19\);

-- Location: FF_X23_Y13_N13
\dc|clkdiv[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \dc|clkdiv[3]~18_combout\,
	sclr => \dc|LessThan0~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \dc|clkdiv\(3));

-- Location: LCCOMB_X23_Y13_N4
\dc|LessThan0~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \dc|LessThan0~1_combout\ = (!\dc|clkdiv\(2) & (!\dc|clkdiv\(3) & ((!\dc|clkdiv\(0)) # (!\dc|clkdiv\(1)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000100010001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \dc|clkdiv\(2),
	datab => \dc|clkdiv\(3),
	datac => \dc|clkdiv\(1),
	datad => \dc|clkdiv\(0),
	combout => \dc|LessThan0~1_combout\);

-- Location: LCCOMB_X23_Y13_N14
\dc|clkdiv[4]~20\ : cycloneive_lcell_comb
-- Equation(s):
-- \dc|clkdiv[4]~20_combout\ = (\dc|clkdiv\(4) & (\dc|clkdiv[3]~19\ $ (GND))) # (!\dc|clkdiv\(4) & (!\dc|clkdiv[3]~19\ & VCC))
-- \dc|clkdiv[4]~21\ = CARRY((\dc|clkdiv\(4) & !\dc|clkdiv[3]~19\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \dc|clkdiv\(4),
	datad => VCC,
	cin => \dc|clkdiv[3]~19\,
	combout => \dc|clkdiv[4]~20_combout\,
	cout => \dc|clkdiv[4]~21\);

-- Location: FF_X23_Y13_N15
\dc|clkdiv[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \dc|clkdiv[4]~20_combout\,
	sclr => \dc|LessThan0~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \dc|clkdiv\(4));

-- Location: LCCOMB_X23_Y13_N16
\dc|clkdiv[5]~22\ : cycloneive_lcell_comb
-- Equation(s):
-- \dc|clkdiv[5]~22_combout\ = (\dc|clkdiv\(5) & (!\dc|clkdiv[4]~21\)) # (!\dc|clkdiv\(5) & ((\dc|clkdiv[4]~21\) # (GND)))
-- \dc|clkdiv[5]~23\ = CARRY((!\dc|clkdiv[4]~21\) # (!\dc|clkdiv\(5)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \dc|clkdiv\(5),
	datad => VCC,
	cin => \dc|clkdiv[4]~21\,
	combout => \dc|clkdiv[5]~22_combout\,
	cout => \dc|clkdiv[5]~23\);

-- Location: FF_X23_Y13_N17
\dc|clkdiv[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \dc|clkdiv[5]~22_combout\,
	sclr => \dc|LessThan0~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \dc|clkdiv\(5));

-- Location: LCCOMB_X23_Y13_N18
\dc|clkdiv[6]~24\ : cycloneive_lcell_comb
-- Equation(s):
-- \dc|clkdiv[6]~24_combout\ = (\dc|clkdiv\(6) & (\dc|clkdiv[5]~23\ $ (GND))) # (!\dc|clkdiv\(6) & (!\dc|clkdiv[5]~23\ & VCC))
-- \dc|clkdiv[6]~25\ = CARRY((\dc|clkdiv\(6) & !\dc|clkdiv[5]~23\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \dc|clkdiv\(6),
	datad => VCC,
	cin => \dc|clkdiv[5]~23\,
	combout => \dc|clkdiv[6]~24_combout\,
	cout => \dc|clkdiv[6]~25\);

-- Location: FF_X23_Y13_N19
\dc|clkdiv[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \dc|clkdiv[6]~24_combout\,
	sclr => \dc|LessThan0~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \dc|clkdiv\(6));

-- Location: LCCOMB_X23_Y13_N20
\dc|clkdiv[7]~26\ : cycloneive_lcell_comb
-- Equation(s):
-- \dc|clkdiv[7]~26_combout\ = (\dc|clkdiv\(7) & (!\dc|clkdiv[6]~25\)) # (!\dc|clkdiv\(7) & ((\dc|clkdiv[6]~25\) # (GND)))
-- \dc|clkdiv[7]~27\ = CARRY((!\dc|clkdiv[6]~25\) # (!\dc|clkdiv\(7)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \dc|clkdiv\(7),
	datad => VCC,
	cin => \dc|clkdiv[6]~25\,
	combout => \dc|clkdiv[7]~26_combout\,
	cout => \dc|clkdiv[7]~27\);

-- Location: FF_X23_Y13_N21
\dc|clkdiv[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \dc|clkdiv[7]~26_combout\,
	sclr => \dc|LessThan0~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \dc|clkdiv\(7));

-- Location: LCCOMB_X23_Y13_N22
\dc|clkdiv[8]~28\ : cycloneive_lcell_comb
-- Equation(s):
-- \dc|clkdiv[8]~28_combout\ = (\dc|clkdiv\(8) & (\dc|clkdiv[7]~27\ $ (GND))) # (!\dc|clkdiv\(8) & (!\dc|clkdiv[7]~27\ & VCC))
-- \dc|clkdiv[8]~29\ = CARRY((\dc|clkdiv\(8) & !\dc|clkdiv[7]~27\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \dc|clkdiv\(8),
	datad => VCC,
	cin => \dc|clkdiv[7]~27\,
	combout => \dc|clkdiv[8]~28_combout\,
	cout => \dc|clkdiv[8]~29\);

-- Location: FF_X23_Y13_N23
\dc|clkdiv[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \dc|clkdiv[8]~28_combout\,
	sclr => \dc|LessThan0~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \dc|clkdiv\(8));

-- Location: LCCOMB_X23_Y13_N2
\dc|LessThan0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \dc|LessThan0~0_combout\ = ((!\dc|clkdiv\(6)) # (!\dc|clkdiv\(8))) # (!\dc|clkdiv\(7))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011111111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \dc|clkdiv\(7),
	datac => \dc|clkdiv\(8),
	datad => \dc|clkdiv\(6),
	combout => \dc|LessThan0~0_combout\);

-- Location: LCCOMB_X23_Y13_N30
\dc|LessThan0~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \dc|LessThan0~2_combout\ = (\dc|LessThan0~0_combout\) # ((\dc|LessThan0~1_combout\ & (!\dc|clkdiv\(4) & !\dc|clkdiv\(5))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110011001110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \dc|LessThan0~1_combout\,
	datab => \dc|LessThan0~0_combout\,
	datac => \dc|clkdiv\(4),
	datad => \dc|clkdiv\(5),
	combout => \dc|LessThan0~2_combout\);

-- Location: LCCOMB_X23_Y13_N24
\dc|clkdiv[9]~30\ : cycloneive_lcell_comb
-- Equation(s):
-- \dc|clkdiv[9]~30_combout\ = (\dc|clkdiv\(9) & (!\dc|clkdiv[8]~29\)) # (!\dc|clkdiv\(9) & ((\dc|clkdiv[8]~29\) # (GND)))
-- \dc|clkdiv[9]~31\ = CARRY((!\dc|clkdiv[8]~29\) # (!\dc|clkdiv\(9)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \dc|clkdiv\(9),
	datad => VCC,
	cin => \dc|clkdiv[8]~29\,
	combout => \dc|clkdiv[9]~30_combout\,
	cout => \dc|clkdiv[9]~31\);

-- Location: FF_X23_Y13_N25
\dc|clkdiv[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \dc|clkdiv[9]~30_combout\,
	sclr => \dc|LessThan0~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \dc|clkdiv\(9));

-- Location: LCCOMB_X23_Y13_N26
\dc|clkdiv[10]~32\ : cycloneive_lcell_comb
-- Equation(s):
-- \dc|clkdiv[10]~32_combout\ = (\dc|clkdiv\(10) & (\dc|clkdiv[9]~31\ $ (GND))) # (!\dc|clkdiv\(10) & (!\dc|clkdiv[9]~31\ & VCC))
-- \dc|clkdiv[10]~33\ = CARRY((\dc|clkdiv\(10) & !\dc|clkdiv[9]~31\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \dc|clkdiv\(10),
	datad => VCC,
	cin => \dc|clkdiv[9]~31\,
	combout => \dc|clkdiv[10]~32_combout\,
	cout => \dc|clkdiv[10]~33\);

-- Location: FF_X23_Y13_N27
\dc|clkdiv[10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \dc|clkdiv[10]~32_combout\,
	sclr => \dc|LessThan0~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \dc|clkdiv\(10));

-- Location: LCCOMB_X23_Y13_N28
\dc|clkdiv[11]~34\ : cycloneive_lcell_comb
-- Equation(s):
-- \dc|clkdiv[11]~34_combout\ = \dc|clkdiv[10]~33\ $ (\dc|clkdiv\(11))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111110000",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datad => \dc|clkdiv\(11),
	cin => \dc|clkdiv[10]~33\,
	combout => \dc|clkdiv[11]~34_combout\);

-- Location: FF_X23_Y13_N29
\dc|clkdiv[11]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \dc|clkdiv[11]~34_combout\,
	sclr => \dc|LessThan0~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \dc|clkdiv\(11));

-- Location: LCCOMB_X23_Y13_N0
\dc|LessThan0~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \dc|LessThan0~3_combout\ = (\dc|clkdiv\(11) & (((\dc|clkdiv\(10)) # (\dc|clkdiv\(9))) # (!\dc|LessThan0~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110011000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \dc|LessThan0~2_combout\,
	datab => \dc|clkdiv\(11),
	datac => \dc|clkdiv\(10),
	datad => \dc|clkdiv\(9),
	combout => \dc|LessThan0~3_combout\);

-- Location: FF_X23_Y13_N1
\dc|ce\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \dc|LessThan0~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \dc|ce~q\);

-- Location: FF_X17_Y9_N3
\tec|sm_counter[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \tec|Add1~2_combout\,
	ena => \dc|ce~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \tec|sm_counter\(1));

-- Location: LCCOMB_X17_Y9_N4
\tec|Add1~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Add1~4_combout\ = (\tec|sm_counter\(2) & (\tec|Add1~3\ $ (GND))) # (!\tec|sm_counter\(2) & (!\tec|Add1~3\ & VCC))
-- \tec|Add1~5\ = CARRY((\tec|sm_counter\(2) & !\tec|Add1~3\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \tec|sm_counter\(2),
	datad => VCC,
	cin => \tec|Add1~3\,
	combout => \tec|Add1~4_combout\,
	cout => \tec|Add1~5\);

-- Location: FF_X17_Y9_N5
\tec|sm_counter[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \tec|Add1~4_combout\,
	ena => \dc|ce~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \tec|sm_counter\(2));

-- Location: LCCOMB_X17_Y9_N6
\tec|Add1~6\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Add1~6_combout\ = (\tec|sm_counter\(3) & (!\tec|Add1~5\)) # (!\tec|sm_counter\(3) & ((\tec|Add1~5\) # (GND)))
-- \tec|Add1~7\ = CARRY((!\tec|Add1~5\) # (!\tec|sm_counter\(3)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(3),
	datad => VCC,
	cin => \tec|Add1~5\,
	combout => \tec|Add1~6_combout\,
	cout => \tec|Add1~7\);

-- Location: FF_X17_Y9_N7
\tec|sm_counter[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \tec|Add1~6_combout\,
	ena => \dc|ce~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \tec|sm_counter\(3));

-- Location: LCCOMB_X17_Y9_N8
\tec|Add1~8\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Add1~8_combout\ = (\tec|sm_counter\(4) & (\tec|Add1~7\ $ (GND))) # (!\tec|sm_counter\(4) & (!\tec|Add1~7\ & VCC))
-- \tec|Add1~9\ = CARRY((\tec|sm_counter\(4) & !\tec|Add1~7\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \tec|sm_counter\(4),
	datad => VCC,
	cin => \tec|Add1~7\,
	combout => \tec|Add1~8_combout\,
	cout => \tec|Add1~9\);

-- Location: LCCOMB_X18_Y17_N30
\tec|Equal0~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal0~3_combout\ = (!\tec|sm_counter\(2) & (!\tec|sm_counter\(1) & !\tec|sm_counter\(0)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000100000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(2),
	datab => \tec|sm_counter\(1),
	datac => \tec|sm_counter\(0),
	combout => \tec|Equal0~3_combout\);

-- Location: LCCOMB_X17_Y16_N16
\tec|Equal19~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal19~0_combout\ = (\tec|sm_counter\(4) & !\tec|sm_counter\(3))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \tec|sm_counter\(4),
	datac => \tec|sm_counter\(3),
	combout => \tec|Equal19~0_combout\);

-- Location: LCCOMB_X16_Y9_N18
\tec|sm_counter~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|sm_counter~4_combout\ = (\tec|Add1~8_combout\ & (((!\tec|Equal19~0_combout\) # (!\tec|Equal0~3_combout\)) # (!\tec|Equal142~8_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Equal142~8_combout\,
	datab => \tec|Add1~8_combout\,
	datac => \tec|Equal0~3_combout\,
	datad => \tec|Equal19~0_combout\,
	combout => \tec|sm_counter~4_combout\);

-- Location: FF_X16_Y9_N19
\tec|sm_counter[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \tec|sm_counter~4_combout\,
	ena => \dc|ce~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \tec|sm_counter\(4));

-- Location: LCCOMB_X17_Y9_N10
\tec|Add1~10\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Add1~10_combout\ = (\tec|sm_counter\(5) & (!\tec|Add1~9\)) # (!\tec|sm_counter\(5) & ((\tec|Add1~9\) # (GND)))
-- \tec|Add1~11\ = CARRY((!\tec|Add1~9\) # (!\tec|sm_counter\(5)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(5),
	datad => VCC,
	cin => \tec|Add1~9\,
	combout => \tec|Add1~10_combout\,
	cout => \tec|Add1~11\);

-- Location: FF_X17_Y9_N11
\tec|sm_counter[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \tec|Add1~10_combout\,
	ena => \dc|ce~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \tec|sm_counter\(5));

-- Location: LCCOMB_X17_Y9_N12
\tec|Add1~12\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Add1~12_combout\ = (\tec|sm_counter\(6) & (\tec|Add1~11\ $ (GND))) # (!\tec|sm_counter\(6) & (!\tec|Add1~11\ & VCC))
-- \tec|Add1~13\ = CARRY((\tec|sm_counter\(6) & !\tec|Add1~11\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(6),
	datad => VCC,
	cin => \tec|Add1~11\,
	combout => \tec|Add1~12_combout\,
	cout => \tec|Add1~13\);

-- Location: FF_X17_Y9_N13
\tec|sm_counter[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \tec|Add1~12_combout\,
	ena => \dc|ce~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \tec|sm_counter\(6));

-- Location: LCCOMB_X17_Y9_N14
\tec|Add1~14\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Add1~14_combout\ = (\tec|sm_counter\(7) & (!\tec|Add1~13\)) # (!\tec|sm_counter\(7) & ((\tec|Add1~13\) # (GND)))
-- \tec|Add1~15\ = CARRY((!\tec|Add1~13\) # (!\tec|sm_counter\(7)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \tec|sm_counter\(7),
	datad => VCC,
	cin => \tec|Add1~13\,
	combout => \tec|Add1~14_combout\,
	cout => \tec|Add1~15\);

-- Location: FF_X17_Y9_N15
\tec|sm_counter[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \tec|Add1~14_combout\,
	ena => \dc|ce~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \tec|sm_counter\(7));

-- Location: LCCOMB_X17_Y9_N16
\tec|Add1~16\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Add1~16_combout\ = (\tec|sm_counter\(8) & (\tec|Add1~15\ $ (GND))) # (!\tec|sm_counter\(8) & (!\tec|Add1~15\ & VCC))
-- \tec|Add1~17\ = CARRY((\tec|sm_counter\(8) & !\tec|Add1~15\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \tec|sm_counter\(8),
	datad => VCC,
	cin => \tec|Add1~15\,
	combout => \tec|Add1~16_combout\,
	cout => \tec|Add1~17\);

-- Location: LCCOMB_X16_Y9_N6
\tec|sm_counter~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|sm_counter~3_combout\ = (\tec|Add1~16_combout\ & (((!\tec|Equal19~0_combout\) # (!\tec|Equal0~3_combout\)) # (!\tec|Equal142~8_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Equal142~8_combout\,
	datab => \tec|Add1~16_combout\,
	datac => \tec|Equal0~3_combout\,
	datad => \tec|Equal19~0_combout\,
	combout => \tec|sm_counter~3_combout\);

-- Location: FF_X16_Y9_N7
\tec|sm_counter[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \tec|sm_counter~3_combout\,
	ena => \dc|ce~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \tec|sm_counter\(8));

-- Location: LCCOMB_X17_Y9_N18
\tec|Add1~18\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Add1~18_combout\ = (\tec|sm_counter\(9) & (!\tec|Add1~17\)) # (!\tec|sm_counter\(9) & ((\tec|Add1~17\) # (GND)))
-- \tec|Add1~19\ = CARRY((!\tec|Add1~17\) # (!\tec|sm_counter\(9)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(9),
	datad => VCC,
	cin => \tec|Add1~17\,
	combout => \tec|Add1~18_combout\,
	cout => \tec|Add1~19\);

-- Location: LCCOMB_X16_Y9_N12
\tec|sm_counter~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|sm_counter~2_combout\ = (\tec|Add1~18_combout\ & (((!\tec|Equal19~0_combout\) # (!\tec|Equal0~3_combout\)) # (!\tec|Equal142~8_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Equal142~8_combout\,
	datab => \tec|Add1~18_combout\,
	datac => \tec|Equal0~3_combout\,
	datad => \tec|Equal19~0_combout\,
	combout => \tec|sm_counter~2_combout\);

-- Location: FF_X16_Y9_N13
\tec|sm_counter[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \tec|sm_counter~2_combout\,
	ena => \dc|ce~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \tec|sm_counter\(9));

-- Location: LCCOMB_X17_Y9_N20
\tec|Add1~20\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Add1~20_combout\ = (\tec|sm_counter\(10) & (\tec|Add1~19\ $ (GND))) # (!\tec|sm_counter\(10) & (!\tec|Add1~19\ & VCC))
-- \tec|Add1~21\ = CARRY((\tec|sm_counter\(10) & !\tec|Add1~19\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(10),
	datad => VCC,
	cin => \tec|Add1~19\,
	combout => \tec|Add1~20_combout\,
	cout => \tec|Add1~21\);

-- Location: LCCOMB_X16_Y9_N2
\tec|sm_counter~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|sm_counter~1_combout\ = (\tec|Add1~20_combout\ & (((!\tec|Equal142~8_combout\) # (!\tec|Equal0~3_combout\)) # (!\tec|Equal19~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010101010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Add1~20_combout\,
	datab => \tec|Equal19~0_combout\,
	datac => \tec|Equal0~3_combout\,
	datad => \tec|Equal142~8_combout\,
	combout => \tec|sm_counter~1_combout\);

-- Location: FF_X16_Y9_N3
\tec|sm_counter[10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \tec|sm_counter~1_combout\,
	ena => \dc|ce~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \tec|sm_counter\(10));

-- Location: LCCOMB_X17_Y9_N22
\tec|Add1~22\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Add1~22_combout\ = (\tec|sm_counter\(11) & (!\tec|Add1~21\)) # (!\tec|sm_counter\(11) & ((\tec|Add1~21\) # (GND)))
-- \tec|Add1~23\ = CARRY((!\tec|Add1~21\) # (!\tec|sm_counter\(11)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(11),
	datad => VCC,
	cin => \tec|Add1~21\,
	combout => \tec|Add1~22_combout\,
	cout => \tec|Add1~23\);

-- Location: FF_X17_Y9_N23
\tec|sm_counter[11]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \tec|Add1~22_combout\,
	ena => \dc|ce~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \tec|sm_counter\(11));

-- Location: LCCOMB_X17_Y9_N24
\tec|Add1~24\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Add1~24_combout\ = (\tec|sm_counter\(12) & (\tec|Add1~23\ $ (GND))) # (!\tec|sm_counter\(12) & (!\tec|Add1~23\ & VCC))
-- \tec|Add1~25\ = CARRY((\tec|sm_counter\(12) & !\tec|Add1~23\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \tec|sm_counter\(12),
	datad => VCC,
	cin => \tec|Add1~23\,
	combout => \tec|Add1~24_combout\,
	cout => \tec|Add1~25\);

-- Location: FF_X17_Y9_N25
\tec|sm_counter[12]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \tec|Add1~24_combout\,
	ena => \dc|ce~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \tec|sm_counter\(12));

-- Location: LCCOMB_X17_Y9_N26
\tec|Add1~26\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Add1~26_combout\ = (\tec|sm_counter\(13) & (!\tec|Add1~25\)) # (!\tec|sm_counter\(13) & ((\tec|Add1~25\) # (GND)))
-- \tec|Add1~27\ = CARRY((!\tec|Add1~25\) # (!\tec|sm_counter\(13)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(13),
	datad => VCC,
	cin => \tec|Add1~25\,
	combout => \tec|Add1~26_combout\,
	cout => \tec|Add1~27\);

-- Location: LCCOMB_X16_Y9_N16
\tec|sm_counter~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|sm_counter~0_combout\ = (\tec|Add1~26_combout\ & (((!\tec|Equal19~0_combout\) # (!\tec|Equal0~3_combout\)) # (!\tec|Equal142~8_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Equal142~8_combout\,
	datab => \tec|Add1~26_combout\,
	datac => \tec|Equal0~3_combout\,
	datad => \tec|Equal19~0_combout\,
	combout => \tec|sm_counter~0_combout\);

-- Location: FF_X16_Y9_N17
\tec|sm_counter[13]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \tec|sm_counter~0_combout\,
	ena => \dc|ce~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \tec|sm_counter\(13));

-- Location: LCCOMB_X16_Y9_N30
\tec|Equal142~6\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal142~6_combout\ = (!\tec|sm_counter\(5) & (\tec|sm_counter\(13) & (!\tec|sm_counter\(6) & \tec|sm_counter\(10))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000010000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(5),
	datab => \tec|sm_counter\(13),
	datac => \tec|sm_counter\(6),
	datad => \tec|sm_counter\(10),
	combout => \tec|Equal142~6_combout\);

-- Location: LCCOMB_X16_Y9_N24
\tec|Equal142~7\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal142~7_combout\ = (\tec|sm_counter\(9) & (!\tec|sm_counter\(7) & \tec|sm_counter\(8)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000101000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(9),
	datac => \tec|sm_counter\(7),
	datad => \tec|sm_counter\(8),
	combout => \tec|Equal142~7_combout\);

-- Location: LCCOMB_X17_Y9_N28
\tec|Add1~28\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Add1~28_combout\ = (\tec|sm_counter\(14) & (\tec|Add1~27\ $ (GND))) # (!\tec|sm_counter\(14) & (!\tec|Add1~27\ & VCC))
-- \tec|Add1~29\ = CARRY((\tec|sm_counter\(14) & !\tec|Add1~27\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \tec|sm_counter\(14),
	datad => VCC,
	cin => \tec|Add1~27\,
	combout => \tec|Add1~28_combout\,
	cout => \tec|Add1~29\);

-- Location: FF_X17_Y9_N29
\tec|sm_counter[14]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \tec|Add1~28_combout\,
	ena => \dc|ce~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \tec|sm_counter\(14));

-- Location: LCCOMB_X17_Y9_N30
\tec|Add1~30\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Add1~30_combout\ = (\tec|sm_counter\(15) & (!\tec|Add1~29\)) # (!\tec|sm_counter\(15) & ((\tec|Add1~29\) # (GND)))
-- \tec|Add1~31\ = CARRY((!\tec|Add1~29\) # (!\tec|sm_counter\(15)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(15),
	datad => VCC,
	cin => \tec|Add1~29\,
	combout => \tec|Add1~30_combout\,
	cout => \tec|Add1~31\);

-- Location: FF_X17_Y9_N31
\tec|sm_counter[15]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \tec|Add1~30_combout\,
	ena => \dc|ce~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \tec|sm_counter\(15));

-- Location: LCCOMB_X17_Y8_N0
\tec|Add1~32\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Add1~32_combout\ = (\tec|sm_counter\(16) & (\tec|Add1~31\ $ (GND))) # (!\tec|sm_counter\(16) & (!\tec|Add1~31\ & VCC))
-- \tec|Add1~33\ = CARRY((\tec|sm_counter\(16) & !\tec|Add1~31\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \tec|sm_counter\(16),
	datad => VCC,
	cin => \tec|Add1~31\,
	combout => \tec|Add1~32_combout\,
	cout => \tec|Add1~33\);

-- Location: FF_X17_Y8_N1
\tec|sm_counter[16]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \tec|Add1~32_combout\,
	ena => \dc|ce~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \tec|sm_counter\(16));

-- Location: LCCOMB_X17_Y8_N2
\tec|Add1~34\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Add1~34_combout\ = (\tec|sm_counter\(17) & (!\tec|Add1~33\)) # (!\tec|sm_counter\(17) & ((\tec|Add1~33\) # (GND)))
-- \tec|Add1~35\ = CARRY((!\tec|Add1~33\) # (!\tec|sm_counter\(17)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \tec|sm_counter\(17),
	datad => VCC,
	cin => \tec|Add1~33\,
	combout => \tec|Add1~34_combout\,
	cout => \tec|Add1~35\);

-- Location: FF_X17_Y8_N3
\tec|sm_counter[17]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \tec|Add1~34_combout\,
	ena => \dc|ce~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \tec|sm_counter\(17));

-- Location: LCCOMB_X17_Y8_N4
\tec|Add1~36\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Add1~36_combout\ = (\tec|sm_counter\(18) & (\tec|Add1~35\ $ (GND))) # (!\tec|sm_counter\(18) & (!\tec|Add1~35\ & VCC))
-- \tec|Add1~37\ = CARRY((\tec|sm_counter\(18) & !\tec|Add1~35\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \tec|sm_counter\(18),
	datad => VCC,
	cin => \tec|Add1~35\,
	combout => \tec|Add1~36_combout\,
	cout => \tec|Add1~37\);

-- Location: FF_X17_Y8_N5
\tec|sm_counter[18]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \tec|Add1~36_combout\,
	ena => \dc|ce~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \tec|sm_counter\(18));

-- Location: LCCOMB_X17_Y8_N6
\tec|Add1~38\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Add1~38_combout\ = (\tec|sm_counter\(19) & (!\tec|Add1~37\)) # (!\tec|sm_counter\(19) & ((\tec|Add1~37\) # (GND)))
-- \tec|Add1~39\ = CARRY((!\tec|Add1~37\) # (!\tec|sm_counter\(19)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(19),
	datad => VCC,
	cin => \tec|Add1~37\,
	combout => \tec|Add1~38_combout\,
	cout => \tec|Add1~39\);

-- Location: FF_X17_Y8_N7
\tec|sm_counter[19]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \tec|Add1~38_combout\,
	ena => \dc|ce~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \tec|sm_counter\(19));

-- Location: LCCOMB_X17_Y8_N8
\tec|Add1~40\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Add1~40_combout\ = (\tec|sm_counter\(20) & (\tec|Add1~39\ $ (GND))) # (!\tec|sm_counter\(20) & (!\tec|Add1~39\ & VCC))
-- \tec|Add1~41\ = CARRY((\tec|sm_counter\(20) & !\tec|Add1~39\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \tec|sm_counter\(20),
	datad => VCC,
	cin => \tec|Add1~39\,
	combout => \tec|Add1~40_combout\,
	cout => \tec|Add1~41\);

-- Location: FF_X17_Y8_N9
\tec|sm_counter[20]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \tec|Add1~40_combout\,
	ena => \dc|ce~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \tec|sm_counter\(20));

-- Location: LCCOMB_X17_Y8_N10
\tec|Add1~42\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Add1~42_combout\ = (\tec|sm_counter\(21) & (!\tec|Add1~41\)) # (!\tec|sm_counter\(21) & ((\tec|Add1~41\) # (GND)))
-- \tec|Add1~43\ = CARRY((!\tec|Add1~41\) # (!\tec|sm_counter\(21)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(21),
	datad => VCC,
	cin => \tec|Add1~41\,
	combout => \tec|Add1~42_combout\,
	cout => \tec|Add1~43\);

-- Location: FF_X17_Y8_N11
\tec|sm_counter[21]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \tec|Add1~42_combout\,
	ena => \dc|ce~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \tec|sm_counter\(21));

-- Location: LCCOMB_X17_Y8_N12
\tec|Add1~44\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Add1~44_combout\ = (\tec|sm_counter\(22) & (\tec|Add1~43\ $ (GND))) # (!\tec|sm_counter\(22) & (!\tec|Add1~43\ & VCC))
-- \tec|Add1~45\ = CARRY((\tec|sm_counter\(22) & !\tec|Add1~43\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(22),
	datad => VCC,
	cin => \tec|Add1~43\,
	combout => \tec|Add1~44_combout\,
	cout => \tec|Add1~45\);

-- Location: FF_X17_Y8_N13
\tec|sm_counter[22]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \tec|Add1~44_combout\,
	ena => \dc|ce~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \tec|sm_counter\(22));

-- Location: LCCOMB_X17_Y8_N14
\tec|Add1~46\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Add1~46_combout\ = (\tec|sm_counter\(23) & (!\tec|Add1~45\)) # (!\tec|sm_counter\(23) & ((\tec|Add1~45\) # (GND)))
-- \tec|Add1~47\ = CARRY((!\tec|Add1~45\) # (!\tec|sm_counter\(23)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \tec|sm_counter\(23),
	datad => VCC,
	cin => \tec|Add1~45\,
	combout => \tec|Add1~46_combout\,
	cout => \tec|Add1~47\);

-- Location: FF_X17_Y8_N15
\tec|sm_counter[23]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \tec|Add1~46_combout\,
	ena => \dc|ce~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \tec|sm_counter\(23));

-- Location: LCCOMB_X21_Y9_N12
\tec|Equal142~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal142~3_combout\ = (!\tec|sm_counter\(23) & (!\tec|sm_counter\(20) & (!\tec|sm_counter\(21) & !\tec|sm_counter\(22))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(23),
	datab => \tec|sm_counter\(20),
	datac => \tec|sm_counter\(21),
	datad => \tec|sm_counter\(22),
	combout => \tec|Equal142~3_combout\);

-- Location: LCCOMB_X21_Y8_N0
\tec|Equal142~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal142~4_combout\ = (!\tec|sm_counter\(17) & (!\tec|sm_counter\(16) & (!\tec|sm_counter\(18) & !\tec|sm_counter\(19))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(17),
	datab => \tec|sm_counter\(16),
	datac => \tec|sm_counter\(18),
	datad => \tec|sm_counter\(19),
	combout => \tec|Equal142~4_combout\);

-- Location: LCCOMB_X17_Y8_N16
\tec|Add1~48\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Add1~48_combout\ = (\tec|sm_counter\(24) & (\tec|Add1~47\ $ (GND))) # (!\tec|sm_counter\(24) & (!\tec|Add1~47\ & VCC))
-- \tec|Add1~49\ = CARRY((\tec|sm_counter\(24) & !\tec|Add1~47\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \tec|sm_counter\(24),
	datad => VCC,
	cin => \tec|Add1~47\,
	combout => \tec|Add1~48_combout\,
	cout => \tec|Add1~49\);

-- Location: FF_X17_Y8_N17
\tec|sm_counter[24]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \tec|Add1~48_combout\,
	ena => \dc|ce~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \tec|sm_counter\(24));

-- Location: LCCOMB_X17_Y8_N18
\tec|Add1~50\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Add1~50_combout\ = (\tec|sm_counter\(25) & (!\tec|Add1~49\)) # (!\tec|sm_counter\(25) & ((\tec|Add1~49\) # (GND)))
-- \tec|Add1~51\ = CARRY((!\tec|Add1~49\) # (!\tec|sm_counter\(25)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \tec|sm_counter\(25),
	datad => VCC,
	cin => \tec|Add1~49\,
	combout => \tec|Add1~50_combout\,
	cout => \tec|Add1~51\);

-- Location: FF_X17_Y8_N19
\tec|sm_counter[25]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \tec|Add1~50_combout\,
	ena => \dc|ce~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \tec|sm_counter\(25));

-- Location: LCCOMB_X17_Y8_N20
\tec|Add1~52\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Add1~52_combout\ = (\tec|sm_counter\(26) & (\tec|Add1~51\ $ (GND))) # (!\tec|sm_counter\(26) & (!\tec|Add1~51\ & VCC))
-- \tec|Add1~53\ = CARRY((\tec|sm_counter\(26) & !\tec|Add1~51\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \tec|sm_counter\(26),
	datad => VCC,
	cin => \tec|Add1~51\,
	combout => \tec|Add1~52_combout\,
	cout => \tec|Add1~53\);

-- Location: FF_X17_Y8_N21
\tec|sm_counter[26]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \tec|Add1~52_combout\,
	ena => \dc|ce~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \tec|sm_counter\(26));

-- Location: LCCOMB_X17_Y8_N22
\tec|Add1~54\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Add1~54_combout\ = (\tec|sm_counter\(27) & (!\tec|Add1~53\)) # (!\tec|sm_counter\(27) & ((\tec|Add1~53\) # (GND)))
-- \tec|Add1~55\ = CARRY((!\tec|Add1~53\) # (!\tec|sm_counter\(27)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(27),
	datad => VCC,
	cin => \tec|Add1~53\,
	combout => \tec|Add1~54_combout\,
	cout => \tec|Add1~55\);

-- Location: FF_X17_Y8_N23
\tec|sm_counter[27]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \tec|Add1~54_combout\,
	ena => \dc|ce~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \tec|sm_counter\(27));

-- Location: LCCOMB_X17_Y8_N24
\tec|Add1~56\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Add1~56_combout\ = (\tec|sm_counter\(28) & (\tec|Add1~55\ $ (GND))) # (!\tec|sm_counter\(28) & (!\tec|Add1~55\ & VCC))
-- \tec|Add1~57\ = CARRY((\tec|sm_counter\(28) & !\tec|Add1~55\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \tec|sm_counter\(28),
	datad => VCC,
	cin => \tec|Add1~55\,
	combout => \tec|Add1~56_combout\,
	cout => \tec|Add1~57\);

-- Location: FF_X17_Y8_N25
\tec|sm_counter[28]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \tec|Add1~56_combout\,
	ena => \dc|ce~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \tec|sm_counter\(28));

-- Location: LCCOMB_X17_Y8_N26
\tec|Add1~58\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Add1~58_combout\ = (\tec|sm_counter\(29) & (!\tec|Add1~57\)) # (!\tec|sm_counter\(29) & ((\tec|Add1~57\) # (GND)))
-- \tec|Add1~59\ = CARRY((!\tec|Add1~57\) # (!\tec|sm_counter\(29)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(29),
	datad => VCC,
	cin => \tec|Add1~57\,
	combout => \tec|Add1~58_combout\,
	cout => \tec|Add1~59\);

-- Location: FF_X17_Y8_N27
\tec|sm_counter[29]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \tec|Add1~58_combout\,
	ena => \dc|ce~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \tec|sm_counter\(29));

-- Location: LCCOMB_X17_Y8_N28
\tec|Add1~60\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Add1~60_combout\ = (\tec|sm_counter\(30) & (\tec|Add1~59\ $ (GND))) # (!\tec|sm_counter\(30) & (!\tec|Add1~59\ & VCC))
-- \tec|Add1~61\ = CARRY((\tec|sm_counter\(30) & !\tec|Add1~59\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \tec|sm_counter\(30),
	datad => VCC,
	cin => \tec|Add1~59\,
	combout => \tec|Add1~60_combout\,
	cout => \tec|Add1~61\);

-- Location: FF_X17_Y8_N29
\tec|sm_counter[30]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \tec|Add1~60_combout\,
	ena => \dc|ce~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \tec|sm_counter\(30));

-- Location: LCCOMB_X17_Y8_N30
\tec|Add1~62\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Add1~62_combout\ = \tec|sm_counter\(31) $ (\tec|Add1~61\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(31),
	cin => \tec|Add1~61\,
	combout => \tec|Add1~62_combout\);

-- Location: FF_X17_Y8_N31
\tec|sm_counter[31]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \tec|Add1~62_combout\,
	ena => \dc|ce~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \tec|sm_counter\(31));

-- Location: LCCOMB_X18_Y8_N0
\tec|Equal142~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal142~1_combout\ = (!\tec|sm_counter\(28) & (!\tec|sm_counter\(30) & (!\tec|sm_counter\(29) & !\tec|sm_counter\(31))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(28),
	datab => \tec|sm_counter\(30),
	datac => \tec|sm_counter\(29),
	datad => \tec|sm_counter\(31),
	combout => \tec|Equal142~1_combout\);

-- Location: LCCOMB_X21_Y9_N10
\tec|Equal142~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal142~2_combout\ = (!\tec|sm_counter\(26) & (!\tec|sm_counter\(24) & (!\tec|sm_counter\(25) & !\tec|sm_counter\(27))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(26),
	datab => \tec|sm_counter\(24),
	datac => \tec|sm_counter\(25),
	datad => \tec|sm_counter\(27),
	combout => \tec|Equal142~2_combout\);

-- Location: LCCOMB_X21_Y9_N6
\tec|Equal142~5\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal142~5_combout\ = (\tec|Equal142~3_combout\ & (\tec|Equal142~4_combout\ & (\tec|Equal142~1_combout\ & \tec|Equal142~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Equal142~3_combout\,
	datab => \tec|Equal142~4_combout\,
	datac => \tec|Equal142~1_combout\,
	datad => \tec|Equal142~2_combout\,
	combout => \tec|Equal142~5_combout\);

-- Location: LCCOMB_X21_Y9_N0
\tec|Equal142~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal142~0_combout\ = (!\tec|sm_counter\(14) & (!\tec|sm_counter\(11) & (!\tec|sm_counter\(15) & !\tec|sm_counter\(12))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(14),
	datab => \tec|sm_counter\(11),
	datac => \tec|sm_counter\(15),
	datad => \tec|sm_counter\(12),
	combout => \tec|Equal142~0_combout\);

-- Location: LCCOMB_X16_Y9_N26
\tec|Equal142~8\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal142~8_combout\ = (\tec|Equal142~6_combout\ & (\tec|Equal142~7_combout\ & (\tec|Equal142~5_combout\ & \tec|Equal142~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Equal142~6_combout\,
	datab => \tec|Equal142~7_combout\,
	datac => \tec|Equal142~5_combout\,
	datad => \tec|Equal142~0_combout\,
	combout => \tec|Equal142~8_combout\);

-- Location: LCCOMB_X16_Y9_N28
\tec|sm_counter~5\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|sm_counter~5_combout\ = (\tec|Add1~0_combout\ & (((!\tec|Equal19~0_combout\) # (!\tec|Equal0~3_combout\)) # (!\tec|Equal142~8_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Equal142~8_combout\,
	datab => \tec|Add1~0_combout\,
	datac => \tec|Equal0~3_combout\,
	datad => \tec|Equal19~0_combout\,
	combout => \tec|sm_counter~5_combout\);

-- Location: FF_X16_Y9_N29
\tec|sm_counter[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \tec|sm_counter~5_combout\,
	ena => \dc|ce~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \tec|sm_counter\(0));

-- Location: LCCOMB_X16_Y15_N16
\tec|Equal7~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal7~0_combout\ = (\tec|sm_counter\(0) & \tec|sm_counter\(1))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \tec|sm_counter\(0),
	datad => \tec|sm_counter\(1),
	combout => \tec|Equal7~0_combout\);

-- Location: LCCOMB_X17_Y10_N0
\tec|Equal64~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal64~1_combout\ = (\tec|sm_counter\(6) & !\tec|sm_counter\(3))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(6),
	datad => \tec|sm_counter\(3),
	combout => \tec|Equal64~1_combout\);

-- Location: LCCOMB_X16_Y9_N0
\tec|Equal24~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal24~2_combout\ = (!\tec|sm_counter\(8) & (!\tec|sm_counter\(10) & (!\tec|sm_counter\(9) & !\tec|sm_counter\(13))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(8),
	datab => \tec|sm_counter\(10),
	datac => \tec|sm_counter\(9),
	datad => \tec|sm_counter\(13),
	combout => \tec|Equal24~2_combout\);

-- Location: LCCOMB_X21_Y9_N28
\tec|Equal64~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal64~0_combout\ = (\tec|Equal142~5_combout\ & (!\tec|sm_counter\(7) & (\tec|Equal24~2_combout\ & \tec|Equal142~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Equal142~5_combout\,
	datab => \tec|sm_counter\(7),
	datac => \tec|Equal24~2_combout\,
	datad => \tec|Equal142~0_combout\,
	combout => \tec|Equal64~0_combout\);

-- Location: LCCOMB_X17_Y10_N12
\tec|Equal80~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal80~0_combout\ = (!\tec|sm_counter\(5) & (\tec|Equal64~1_combout\ & (\tec|sm_counter\(4) & \tec|Equal64~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(5),
	datab => \tec|Equal64~1_combout\,
	datac => \tec|sm_counter\(4),
	datad => \tec|Equal64~0_combout\,
	combout => \tec|Equal80~0_combout\);

-- Location: LCCOMB_X18_Y13_N26
\dc|d1Next[0]~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \dc|d1Next[0]~2_combout\ = !\dc|d1Curr\(0)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \dc|d1Curr\(0),
	combout => \dc|d1Next[0]~2_combout\);

-- Location: FF_X18_Y13_N27
\dc|d1Next[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \dc|d1Next[0]~2_combout\,
	ena => \dc|ce~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \dc|d1Next\(0));

-- Location: FF_X18_Y13_N1
\dc|d1Curr[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	asdata => \dc|d1Next\(0),
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \dc|d1Curr\(0));

-- Location: LCCOMB_X18_Y13_N2
\dc|d1Next~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \dc|d1Next~1_combout\ = (\dc|d1Curr\(2) & (\dc|d1Curr\(3) $ (((\dc|d1Curr\(0) & \dc|d1Curr\(1)))))) # (!\dc|d1Curr\(2) & (\dc|d1Curr\(3) & ((\dc|d1Curr\(1)) # (!\dc|d1Curr\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111100010110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \dc|d1Curr\(2),
	datab => \dc|d1Curr\(0),
	datac => \dc|d1Curr\(3),
	datad => \dc|d1Curr\(1),
	combout => \dc|d1Next~1_combout\);

-- Location: FF_X18_Y13_N3
\dc|d1Next[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \dc|d1Next~1_combout\,
	ena => \dc|ce~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \dc|d1Next\(3));

-- Location: LCCOMB_X18_Y13_N6
\dc|d1Curr[3]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \dc|d1Curr[3]~feeder_combout\ = \dc|d1Next\(3)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \dc|d1Next\(3),
	combout => \dc|d1Curr[3]~feeder_combout\);

-- Location: FF_X18_Y13_N7
\dc|d1Curr[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \dc|d1Curr[3]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \dc|d1Curr\(3));

-- Location: LCCOMB_X18_Y13_N18
\dc|d1Next~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \dc|d1Next~0_combout\ = (\dc|d1Curr\(0) & (!\dc|d1Curr\(1) & ((\dc|d1Curr\(2)) # (!\dc|d1Curr\(3))))) # (!\dc|d1Curr\(0) & (((\dc|d1Curr\(1)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001110001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \dc|d1Curr\(2),
	datab => \dc|d1Curr\(0),
	datac => \dc|d1Curr\(3),
	datad => \dc|d1Curr\(1),
	combout => \dc|d1Next~0_combout\);

-- Location: FF_X18_Y13_N19
\dc|d1Next[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \dc|d1Next~0_combout\,
	ena => \dc|ce~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \dc|d1Next\(1));

-- Location: LCCOMB_X18_Y13_N28
\dc|d1Curr[1]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \dc|d1Curr[1]~feeder_combout\ = \dc|d1Next\(1)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \dc|d1Next\(1),
	combout => \dc|d1Curr[1]~feeder_combout\);

-- Location: FF_X18_Y13_N29
\dc|d1Curr[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \dc|d1Curr[1]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \dc|d1Curr\(1));

-- Location: LCCOMB_X18_Y13_N8
\dc|Add4~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \dc|Add4~0_combout\ = \dc|d1Curr\(2) $ (((\dc|d1Curr\(1) & \dc|d1Curr\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \dc|d1Curr\(1),
	datac => \dc|d1Curr\(2),
	datad => \dc|d1Curr\(0),
	combout => \dc|Add4~0_combout\);

-- Location: FF_X18_Y13_N9
\dc|d1Next[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \dc|Add4~0_combout\,
	ena => \dc|ce~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \dc|d1Next\(2));

-- Location: FF_X18_Y13_N5
\dc|d1Curr[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	asdata => \dc|d1Next\(2),
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \dc|d1Curr\(2));

-- Location: LCCOMB_X18_Y13_N0
\dc|Equal3~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \dc|Equal3~0_combout\ = (!\dc|d1Curr\(2) & (\dc|d1Curr\(3) & (\dc|d1Curr\(0) & !\dc|d1Curr\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \dc|d1Curr\(2),
	datab => \dc|d1Curr\(3),
	datac => \dc|d1Curr\(0),
	datad => \dc|d1Curr\(1),
	combout => \dc|Equal3~0_combout\);

-- Location: LCCOMB_X18_Y13_N14
\dc|d10Next~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \dc|d10Next~0_combout\ = \dc|d10Curr\(0) $ (\dc|Equal3~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \dc|d10Curr\(0),
	datac => \dc|Equal3~0_combout\,
	combout => \dc|d10Next~0_combout\);

-- Location: FF_X18_Y13_N15
\dc|d10Next[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \dc|d10Next~0_combout\,
	ena => \dc|ce~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \dc|d10Next\(0));

-- Location: FF_X18_Y13_N21
\dc|d10Curr[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	asdata => \dc|d10Next\(0),
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \dc|d10Curr\(0));

-- Location: LCCOMB_X18_Y13_N10
\dc|Add3~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \dc|Add3~0_combout\ = \dc|d10Curr\(3) $ (((\dc|d10Curr\(0) & (\dc|d10Curr\(1) & \dc|d10Curr\(2)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111100011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \dc|d10Curr\(0),
	datab => \dc|d10Curr\(1),
	datac => \dc|d10Curr\(3),
	datad => \dc|d10Curr\(2),
	combout => \dc|Add3~0_combout\);

-- Location: LCCOMB_X18_Y13_N30
\dc|d10Next~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \dc|d10Next~3_combout\ = (\dc|Equal3~0_combout\ & (\dc|Add3~0_combout\ & ((!\dc|Equal2~0_combout\)))) # (!\dc|Equal3~0_combout\ & (((\dc|d10Curr\(3)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000110010101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \dc|Add3~0_combout\,
	datab => \dc|d10Curr\(3),
	datac => \dc|Equal3~0_combout\,
	datad => \dc|Equal2~0_combout\,
	combout => \dc|d10Next~3_combout\);

-- Location: FF_X18_Y13_N31
\dc|d10Next[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \dc|d10Next~3_combout\,
	ena => \dc|ce~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \dc|d10Next\(3));

-- Location: FF_X18_Y13_N11
\dc|d10Curr[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	asdata => \dc|d10Next\(3),
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \dc|d10Curr\(3));

-- Location: LCCOMB_X18_Y13_N20
\dc|Equal2~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \dc|Equal2~0_combout\ = (!\dc|d10Curr\(1) & (\dc|d10Curr\(3) & (\dc|d10Curr\(0) & !\dc|d10Curr\(2))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \dc|d10Curr\(1),
	datab => \dc|d10Curr\(3),
	datac => \dc|d10Curr\(0),
	datad => \dc|d10Curr\(2),
	combout => \dc|Equal2~0_combout\);

-- Location: LCCOMB_X18_Y13_N24
\dc|d10Next~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \dc|d10Next~1_combout\ = (\dc|Equal3~0_combout\ & (!\dc|Equal2~0_combout\ & (\dc|d10Curr\(0) $ (\dc|d10Curr\(1))))) # (!\dc|Equal3~0_combout\ & (((\dc|d10Curr\(1)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000110001101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \dc|d10Curr\(0),
	datab => \dc|d10Curr\(1),
	datac => \dc|Equal3~0_combout\,
	datad => \dc|Equal2~0_combout\,
	combout => \dc|d10Next~1_combout\);

-- Location: FF_X18_Y13_N25
\dc|d10Next[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \dc|d10Next~1_combout\,
	ena => \dc|ce~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \dc|d10Next\(1));

-- Location: LCCOMB_X18_Y13_N22
\dc|d10Curr[1]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \dc|d10Curr[1]~feeder_combout\ = \dc|d10Next\(1)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \dc|d10Next\(1),
	combout => \dc|d10Curr[1]~feeder_combout\);

-- Location: FF_X18_Y13_N23
\dc|d10Curr[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \dc|d10Curr[1]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \dc|d10Curr\(1));

-- Location: LCCOMB_X18_Y13_N12
\dc|d10Next~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \dc|d10Next~2_combout\ = \dc|d10Curr\(2) $ (((\dc|d10Curr\(0) & (\dc|d10Curr\(1) & \dc|Equal3~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111111110000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \dc|d10Curr\(0),
	datab => \dc|d10Curr\(1),
	datac => \dc|Equal3~0_combout\,
	datad => \dc|d10Curr\(2),
	combout => \dc|d10Next~2_combout\);

-- Location: FF_X18_Y13_N13
\dc|d10Next[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \dc|d10Next~2_combout\,
	ena => \dc|ce~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \dc|d10Next\(2));

-- Location: LCCOMB_X18_Y13_N16
\dc|d10Curr[2]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \dc|d10Curr[2]~feeder_combout\ = \dc|d10Next\(2)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \dc|d10Next\(2),
	combout => \dc|d10Curr[2]~feeder_combout\);

-- Location: FF_X18_Y13_N17
\dc|d10Curr[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \dc|d10Curr[2]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \dc|d10Curr\(2));

-- Location: LCCOMB_X18_Y14_N16
\tec|Equal71~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal71~0_combout\ = (\tec|sm_counter\(0) & (\tec|sm_counter\(2) & \tec|sm_counter\(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(0),
	datac => \tec|sm_counter\(2),
	datad => \tec|sm_counter\(1),
	combout => \tec|Equal71~0_combout\);

-- Location: LCCOMB_X17_Y16_N18
\tec|Equal143~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal143~2_combout\ = (\tec|Equal142~8_combout\ & (!\tec|sm_counter\(4) & (\tec|sm_counter\(3) & \tec|Equal71~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Equal142~8_combout\,
	datab => \tec|sm_counter\(4),
	datac => \tec|sm_counter\(3),
	datad => \tec|Equal71~0_combout\,
	combout => \tec|Equal143~2_combout\);

-- Location: FF_X17_Y16_N19
\tec|rdy\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \tec|Equal143~2_combout\,
	ena => \dc|ce~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \tec|rdy~q\);

-- Location: LCCOMB_X17_Y16_N4
\tec|reg_digit0[3]~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|reg_digit0[3]~0_combout\ = (\tec|rdy~q\ & \dc|ce~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|rdy~q\,
	datac => \dc|ce~q\,
	combout => \tec|reg_digit0[3]~0_combout\);

-- Location: FF_X17_Y16_N1
\tec|reg_digit2[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	asdata => \dc|d10Curr\(2),
	sload => VCC,
	ena => \tec|reg_digit0[3]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \tec|reg_digit2\(2));

-- Location: FF_X17_Y16_N27
\tec|reg_digit2[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	asdata => \dc|d10Curr\(3),
	sload => VCC,
	ena => \tec|reg_digit0[3]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \tec|reg_digit2\(3));

-- Location: LCCOMB_X17_Y16_N22
\tec|reg_digit2[1]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|reg_digit2[1]~feeder_combout\ = \dc|d10Curr\(1)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \dc|d10Curr\(1),
	combout => \tec|reg_digit2[1]~feeder_combout\);

-- Location: FF_X17_Y16_N23
\tec|reg_digit2[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \tec|reg_digit2[1]~feeder_combout\,
	ena => \tec|reg_digit0[3]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \tec|reg_digit2\(1));

-- Location: FF_X17_Y16_N29
\tec|reg_digit2[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	asdata => \dc|d10Curr\(0),
	sload => VCC,
	ena => \tec|reg_digit0[3]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \tec|reg_digit2\(0));

-- Location: LCCOMB_X17_Y16_N20
\tec|Mux16~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Mux16~0_combout\ = (\tec|reg_digit2\(2) & (\tec|reg_digit2\(3) & ((\tec|reg_digit2\(1)) # (!\tec|reg_digit2\(0))))) # (!\tec|reg_digit2\(2) & (!\tec|reg_digit2\(3) & (\tec|reg_digit2\(1) & !\tec|reg_digit2\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000010011000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|reg_digit2\(2),
	datab => \tec|reg_digit2\(3),
	datac => \tec|reg_digit2\(1),
	datad => \tec|reg_digit2\(0),
	combout => \tec|Mux16~0_combout\);

-- Location: LCCOMB_X18_Y14_N30
\tec|Selector1~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Selector1~4_combout\ = (\tec|Equal7~0_combout\ & (!\tec|sm_counter\(2) & (\tec|Equal80~0_combout\ & !\tec|Mux16~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Equal7~0_combout\,
	datab => \tec|sm_counter\(2),
	datac => \tec|Equal80~0_combout\,
	datad => \tec|Mux16~0_combout\,
	combout => \tec|Selector1~4_combout\);

-- Location: LCCOMB_X19_Y12_N24
\tec|Equal8~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal8~0_combout\ = (!\tec|sm_counter\(2) & \tec|sm_counter\(3))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011000000110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \tec|sm_counter\(2),
	datac => \tec|sm_counter\(3),
	combout => \tec|Equal8~0_combout\);

-- Location: LCCOMB_X19_Y12_N10
\tec|Equal8~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal8~1_combout\ = (\tec|Equal64~0_combout\ & (!\tec|sm_counter\(1) & (!\tec|sm_counter\(4) & \tec|Equal8~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Equal64~0_combout\,
	datab => \tec|sm_counter\(1),
	datac => \tec|sm_counter\(4),
	datad => \tec|Equal8~0_combout\,
	combout => \tec|Equal8~1_combout\);

-- Location: LCCOMB_X17_Y15_N24
\dc|d100Next~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \dc|d100Next~0_combout\ = \dc|d100Curr\(0) $ (((\dc|Equal3~0_combout\ & \dc|Equal2~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110011011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \dc|Equal3~0_combout\,
	datab => \dc|d100Curr\(0),
	datad => \dc|Equal2~0_combout\,
	combout => \dc|d100Next~0_combout\);

-- Location: FF_X17_Y15_N25
\dc|d100Next[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \dc|d100Next~0_combout\,
	ena => \dc|ce~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \dc|d100Next\(0));

-- Location: LCCOMB_X17_Y15_N22
\dc|d100Curr[0]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \dc|d100Curr[0]~feeder_combout\ = \dc|d100Next\(0)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \dc|d100Next\(0),
	combout => \dc|d100Curr[0]~feeder_combout\);

-- Location: FF_X17_Y15_N23
\dc|d100Curr[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \dc|d100Curr[0]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \dc|d100Curr\(0));

-- Location: FF_X16_Y14_N25
\tec|reg_digit1[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	asdata => \dc|d100Curr\(0),
	sload => VCC,
	ena => \tec|reg_digit0[3]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \tec|reg_digit1\(0));

-- Location: LCCOMB_X17_Y15_N16
\dc|process_1~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \dc|process_1~0_combout\ = (\dc|Equal3~0_combout\ & \dc|Equal2~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \dc|Equal3~0_combout\,
	datad => \dc|Equal2~0_combout\,
	combout => \dc|process_1~0_combout\);

-- Location: LCCOMB_X17_Y15_N18
\dc|Add2~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \dc|Add2~0_combout\ = \dc|d100Curr\(3) $ (((\dc|d100Curr\(2) & (\dc|d100Curr\(1) & \dc|d100Curr\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111100011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \dc|d100Curr\(2),
	datab => \dc|d100Curr\(1),
	datac => \dc|d100Curr\(3),
	datad => \dc|d100Curr\(0),
	combout => \dc|Add2~0_combout\);

-- Location: LCCOMB_X17_Y15_N14
\dc|d100Next~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \dc|d100Next~3_combout\ = (!\dc|process_1~2_combout\ & ((\dc|process_1~0_combout\ & (\dc|Add2~0_combout\)) # (!\dc|process_1~0_combout\ & ((\dc|d100Curr\(3))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000101100001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \dc|Add2~0_combout\,
	datab => \dc|process_1~0_combout\,
	datac => \dc|process_1~2_combout\,
	datad => \dc|d100Curr\(3),
	combout => \dc|d100Next~3_combout\);

-- Location: FF_X17_Y15_N15
\dc|d100Next[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \dc|d100Next~3_combout\,
	ena => \dc|ce~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \dc|d100Next\(3));

-- Location: FF_X17_Y15_N19
\dc|d100Curr[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	asdata => \dc|d100Next\(3),
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \dc|d100Curr\(3));

-- Location: LCCOMB_X17_Y15_N28
\dc|process_1~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \dc|process_1~1_combout\ = (!\dc|d100Curr\(2) & (\dc|d100Curr\(0) & (!\dc|d100Curr\(1) & \dc|d100Curr\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000010000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \dc|d100Curr\(2),
	datab => \dc|d100Curr\(0),
	datac => \dc|d100Curr\(1),
	datad => \dc|d100Curr\(3),
	combout => \dc|process_1~1_combout\);

-- Location: LCCOMB_X17_Y15_N26
\dc|process_1~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \dc|process_1~2_combout\ = (\dc|Equal3~0_combout\ & (\dc|process_1~1_combout\ & \dc|Equal2~0_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \dc|Equal3~0_combout\,
	datab => \dc|process_1~1_combout\,
	datad => \dc|Equal2~0_combout\,
	combout => \dc|process_1~2_combout\);

-- Location: LCCOMB_X17_Y15_N8
\dc|d100Next~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \dc|d100Next~1_combout\ = (!\dc|process_1~2_combout\ & (\dc|d100Curr\(1) $ (((\dc|process_1~0_combout\ & \dc|d100Curr\(0))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001010001010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \dc|process_1~2_combout\,
	datab => \dc|process_1~0_combout\,
	datac => \dc|d100Curr\(1),
	datad => \dc|d100Curr\(0),
	combout => \dc|d100Next~1_combout\);

-- Location: FF_X17_Y15_N9
\dc|d100Next[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \dc|d100Next~1_combout\,
	ena => \dc|ce~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \dc|d100Next\(1));

-- Location: LCCOMB_X17_Y15_N10
\dc|d100Curr[1]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \dc|d100Curr[1]~feeder_combout\ = \dc|d100Next\(1)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \dc|d100Next\(1),
	combout => \dc|d100Curr[1]~feeder_combout\);

-- Location: FF_X17_Y15_N11
\dc|d100Curr[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \dc|d100Curr[1]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \dc|d100Curr\(1));

-- Location: LCCOMB_X17_Y15_N20
\dc|d100Next~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \dc|d100Next~2_combout\ = \dc|d100Curr\(2) $ (((\dc|process_1~0_combout\ & (\dc|d100Curr\(1) & \dc|d100Curr\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110101010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \dc|d100Curr\(2),
	datab => \dc|process_1~0_combout\,
	datac => \dc|d100Curr\(1),
	datad => \dc|d100Curr\(0),
	combout => \dc|d100Next~2_combout\);

-- Location: FF_X17_Y15_N21
\dc|d100Next[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \dc|d100Next~2_combout\,
	ena => \dc|ce~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \dc|d100Next\(2));

-- Location: LCCOMB_X17_Y15_N0
\dc|d100Curr[2]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \dc|d100Curr[2]~feeder_combout\ = \dc|d100Next\(2)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \dc|d100Next\(2),
	combout => \dc|d100Curr[2]~feeder_combout\);

-- Location: FF_X17_Y15_N1
\dc|d100Curr[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \dc|d100Curr[2]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \dc|d100Curr\(2));

-- Location: FF_X16_Y15_N17
\tec|reg_digit1[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	asdata => \dc|d100Curr\(2),
	sload => VCC,
	ena => \tec|reg_digit0[3]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \tec|reg_digit1\(2));

-- Location: FF_X16_Y15_N1
\tec|reg_digit1[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	asdata => \dc|d100Curr\(1),
	sload => VCC,
	ena => \tec|reg_digit0[3]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \tec|reg_digit1\(1));

-- Location: FF_X16_Y14_N19
\tec|reg_digit1[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	asdata => \dc|d100Curr\(3),
	sload => VCC,
	ena => \tec|reg_digit0[3]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \tec|reg_digit1\(3));

-- Location: LCCOMB_X16_Y14_N28
\tec|Mux13~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Mux13~0_combout\ = (\tec|reg_digit1\(0) & ((\tec|reg_digit1\(3)) # (\tec|reg_digit1\(2) $ (\tec|reg_digit1\(1))))) # (!\tec|reg_digit1\(0) & ((\tec|reg_digit1\(1)) # (\tec|reg_digit1\(2) $ (\tec|reg_digit1\(3)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101101111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|reg_digit1\(0),
	datab => \tec|reg_digit1\(2),
	datac => \tec|reg_digit1\(1),
	datad => \tec|reg_digit1\(3),
	combout => \tec|Mux13~0_combout\);

-- Location: LCCOMB_X18_Y14_N18
\tec|Equal9~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal9~1_combout\ = (!\tec|sm_counter\(5) & \tec|sm_counter\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011000000110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \tec|sm_counter\(5),
	datac => \tec|sm_counter\(0),
	combout => \tec|Equal9~1_combout\);

-- Location: LCCOMB_X18_Y14_N28
\tec|Selector1~6\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Selector1~6_combout\ = (\tec|Equal8~1_combout\ & (\tec|Mux13~0_combout\ & (\tec|sm_counter\(6) & \tec|Equal9~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Equal8~1_combout\,
	datab => \tec|Mux13~0_combout\,
	datac => \tec|sm_counter\(6),
	datad => \tec|Equal9~1_combout\,
	combout => \tec|Selector1~6_combout\);

-- Location: LCCOMB_X17_Y16_N6
\tec|Mux15~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Mux15~0_combout\ = (\tec|reg_digit2\(3) & ((\tec|reg_digit2\(0) & ((\tec|reg_digit2\(1)))) # (!\tec|reg_digit2\(0) & (\tec|reg_digit2\(2))))) # (!\tec|reg_digit2\(3) & (\tec|reg_digit2\(2) & (\tec|reg_digit2\(1) $ (\tec|reg_digit2\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001010101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|reg_digit2\(2),
	datab => \tec|reg_digit2\(3),
	datac => \tec|reg_digit2\(1),
	datad => \tec|reg_digit2\(0),
	combout => \tec|Mux15~0_combout\);

-- Location: LCCOMB_X18_Y14_N20
\tec|Equal1~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal1~2_combout\ = (\tec|sm_counter\(0) & !\tec|sm_counter\(1))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(0),
	datad => \tec|sm_counter\(1),
	combout => \tec|Equal1~2_combout\);

-- Location: LCCOMB_X18_Y14_N24
\tec|Selector1~5\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Selector1~5_combout\ = (!\tec|sm_counter\(2) & (!\tec|Mux15~0_combout\ & (\tec|Equal80~0_combout\ & \tec|Equal1~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(2),
	datab => \tec|Mux15~0_combout\,
	datac => \tec|Equal80~0_combout\,
	datad => \tec|Equal1~2_combout\,
	combout => \tec|Selector1~5_combout\);

-- Location: LCCOMB_X18_Y17_N16
\tec|Equal37~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal37~0_combout\ = (\tec|sm_counter\(5) & \tec|sm_counter\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \tec|sm_counter\(5),
	datac => \tec|sm_counter\(0),
	combout => \tec|Equal37~0_combout\);

-- Location: FF_X17_Y14_N31
\tec|reg_digit3[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	asdata => \dc|d1Curr\(1),
	sload => VCC,
	ena => \tec|reg_digit0[3]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \tec|reg_digit3\(1));

-- Location: FF_X17_Y14_N21
\tec|reg_digit3[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	asdata => \dc|d1Curr\(0),
	sload => VCC,
	ena => \tec|reg_digit0[3]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \tec|reg_digit3\(0));

-- Location: FF_X17_Y14_N19
\tec|reg_digit3[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	asdata => \dc|d1Curr\(3),
	sload => VCC,
	ena => \tec|reg_digit0[3]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \tec|reg_digit3\(3));

-- Location: FF_X17_Y14_N17
\tec|reg_digit3[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	asdata => \dc|d1Curr\(2),
	sload => VCC,
	ena => \tec|reg_digit0[3]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \tec|reg_digit3\(2));

-- Location: LCCOMB_X17_Y14_N28
\tec|Mux25~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Mux25~0_combout\ = (\tec|reg_digit3\(1) & (\tec|reg_digit3\(0) & (!\tec|reg_digit3\(3)))) # (!\tec|reg_digit3\(1) & ((\tec|reg_digit3\(2) & ((!\tec|reg_digit3\(3)))) # (!\tec|reg_digit3\(2) & (\tec|reg_digit3\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000110101001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|reg_digit3\(1),
	datab => \tec|reg_digit3\(0),
	datac => \tec|reg_digit3\(3),
	datad => \tec|reg_digit3\(2),
	combout => \tec|Mux25~0_combout\);

-- Location: LCCOMB_X18_Y14_N12
\tec|Selector1~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Selector1~3_combout\ = (\tec|Equal37~0_combout\ & (!\tec|Mux25~0_combout\ & (\tec|sm_counter\(6) & \tec|Equal8~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Equal37~0_combout\,
	datab => \tec|Mux25~0_combout\,
	datac => \tec|sm_counter\(6),
	datad => \tec|Equal8~1_combout\,
	combout => \tec|Selector1~3_combout\);

-- Location: LCCOMB_X18_Y14_N6
\tec|Selector1~7\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Selector1~7_combout\ = (\tec|Selector1~4_combout\) # ((\tec|Selector1~6_combout\) # ((\tec|Selector1~5_combout\) # (\tec|Selector1~3_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Selector1~4_combout\,
	datab => \tec|Selector1~6_combout\,
	datac => \tec|Selector1~5_combout\,
	datad => \tec|Selector1~3_combout\,
	combout => \tec|Selector1~7_combout\);

-- Location: LCCOMB_X16_Y14_N26
\tec|Mux9~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Mux9~0_combout\ = (\tec|reg_digit1\(2) & (\tec|reg_digit1\(3) & ((\tec|reg_digit1\(1)) # (!\tec|reg_digit1\(0))))) # (!\tec|reg_digit1\(2) & (!\tec|reg_digit1\(0) & (\tec|reg_digit1\(1) & !\tec|reg_digit1\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100010000010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|reg_digit1\(0),
	datab => \tec|reg_digit1\(2),
	datac => \tec|reg_digit1\(1),
	datad => \tec|reg_digit1\(3),
	combout => \tec|Mux9~0_combout\);

-- Location: LCCOMB_X17_Y10_N22
\tec|Equal64~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal64~2_combout\ = (!\tec|sm_counter\(7) & (!\tec|sm_counter\(4) & (\tec|Equal24~2_combout\ & !\tec|sm_counter\(5))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(7),
	datab => \tec|sm_counter\(4),
	datac => \tec|Equal24~2_combout\,
	datad => \tec|sm_counter\(5),
	combout => \tec|Equal64~2_combout\);

-- Location: LCCOMB_X17_Y10_N16
\tec|Equal64~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal64~3_combout\ = (\tec|Equal64~2_combout\ & (\tec|Equal64~1_combout\ & (\tec|Equal142~5_combout\ & \tec|Equal142~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Equal64~2_combout\,
	datab => \tec|Equal64~1_combout\,
	datac => \tec|Equal142~5_combout\,
	datad => \tec|Equal142~0_combout\,
	combout => \tec|Equal64~3_combout\);

-- Location: LCCOMB_X16_Y14_N12
\tec|Selector1~9\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Selector1~9_combout\ = (!\tec|Mux9~0_combout\ & (\tec|Equal64~3_combout\ & (!\tec|sm_counter\(2) & \tec|Equal1~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000010000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Mux9~0_combout\,
	datab => \tec|Equal64~3_combout\,
	datac => \tec|sm_counter\(2),
	datad => \tec|Equal1~2_combout\,
	combout => \tec|Selector1~9_combout\);

-- Location: LCCOMB_X16_Y14_N30
\tec|Mux10~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Mux10~0_combout\ = (\tec|reg_digit1\(1) & ((\tec|reg_digit1\(0) & (\tec|reg_digit1\(2))) # (!\tec|reg_digit1\(0) & (!\tec|reg_digit1\(2) & \tec|reg_digit1\(3))))) # (!\tec|reg_digit1\(1) & (!\tec|reg_digit1\(3) & (\tec|reg_digit1\(0) $ 
-- (\tec|reg_digit1\(2)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001000010000110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|reg_digit1\(0),
	datab => \tec|reg_digit1\(2),
	datac => \tec|reg_digit1\(1),
	datad => \tec|reg_digit1\(3),
	combout => \tec|Mux10~0_combout\);

-- Location: LCCOMB_X16_Y14_N16
\tec|Selector1~8\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Selector1~8_combout\ = (!\tec|Mux10~0_combout\ & (\tec|Equal64~3_combout\ & (!\tec|sm_counter\(2) & \tec|Equal7~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000010000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Mux10~0_combout\,
	datab => \tec|Equal64~3_combout\,
	datac => \tec|sm_counter\(2),
	datad => \tec|Equal7~0_combout\,
	combout => \tec|Selector1~8_combout\);

-- Location: LCCOMB_X17_Y15_N30
\dc|d1000Next~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \dc|d1000Next~0_combout\ = \dc|d1000Curr\(0) $ (((\dc|process_1~1_combout\ & (\dc|Equal3~0_combout\ & \dc|Equal2~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110101010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \dc|d1000Curr\(0),
	datab => \dc|process_1~1_combout\,
	datac => \dc|Equal3~0_combout\,
	datad => \dc|Equal2~0_combout\,
	combout => \dc|d1000Next~0_combout\);

-- Location: FF_X17_Y15_N31
\dc|d1000Next[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \dc|d1000Next~0_combout\,
	ena => \dc|ce~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \dc|d1000Next\(0));

-- Location: FF_X17_Y15_N7
\dc|d1000Curr[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	asdata => \dc|d1000Next\(0),
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \dc|d1000Curr\(0));

-- Location: LCCOMB_X18_Y15_N16
\dc|Add1~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \dc|Add1~0_combout\ = \dc|d1000Curr\(3) $ (((\dc|d1000Curr\(1) & (\dc|d1000Curr\(0) & \dc|d1000Curr\(2)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111111110000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \dc|d1000Curr\(1),
	datab => \dc|d1000Curr\(0),
	datac => \dc|d1000Curr\(2),
	datad => \dc|d1000Curr\(3),
	combout => \dc|Add1~0_combout\);

-- Location: LCCOMB_X17_Y15_N12
\dc|d1000Next~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \dc|d1000Next~3_combout\ = (\dc|process_1~2_combout\ & (\dc|Add1~0_combout\ & (!\dc|process_1~3_combout\))) # (!\dc|process_1~2_combout\ & (((\dc|d1000Curr\(3)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010111100100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \dc|Add1~0_combout\,
	datab => \dc|process_1~3_combout\,
	datac => \dc|process_1~2_combout\,
	datad => \dc|d1000Curr\(3),
	combout => \dc|d1000Next~3_combout\);

-- Location: FF_X17_Y15_N13
\dc|d1000Next[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \dc|d1000Next~3_combout\,
	ena => \dc|ce~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \dc|d1000Next\(3));

-- Location: LCCOMB_X18_Y15_N22
\dc|d1000Curr[3]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \dc|d1000Curr[3]~feeder_combout\ = \dc|d1000Next\(3)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \dc|d1000Next\(3),
	combout => \dc|d1000Curr[3]~feeder_combout\);

-- Location: FF_X18_Y15_N23
\dc|d1000Curr[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \dc|d1000Curr[3]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \dc|d1000Curr\(3));

-- Location: LCCOMB_X17_Y15_N6
\dc|process_1~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \dc|process_1~3_combout\ = (!\dc|d1000Curr\(1) & (!\dc|d1000Curr\(2) & (\dc|d1000Curr\(0) & \dc|d1000Curr\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \dc|d1000Curr\(1),
	datab => \dc|d1000Curr\(2),
	datac => \dc|d1000Curr\(0),
	datad => \dc|d1000Curr\(3),
	combout => \dc|process_1~3_combout\);

-- Location: LCCOMB_X17_Y15_N2
\dc|d1000Next~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \dc|d1000Next~1_combout\ = (\dc|process_1~2_combout\ & (!\dc|process_1~3_combout\ & (\dc|d1000Curr\(1) $ (\dc|d1000Curr\(0))))) # (!\dc|process_1~2_combout\ & (((\dc|d1000Curr\(1)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101001001110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \dc|process_1~2_combout\,
	datab => \dc|process_1~3_combout\,
	datac => \dc|d1000Curr\(1),
	datad => \dc|d1000Curr\(0),
	combout => \dc|d1000Next~1_combout\);

-- Location: FF_X17_Y15_N3
\dc|d1000Next[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \dc|d1000Next~1_combout\,
	ena => \dc|ce~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \dc|d1000Next\(1));

-- Location: FF_X17_Y15_N17
\dc|d1000Curr[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	asdata => \dc|d1000Next\(1),
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \dc|d1000Curr\(1));

-- Location: LCCOMB_X17_Y15_N4
\dc|d1000Next~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \dc|d1000Next~2_combout\ = \dc|d1000Curr\(2) $ (((\dc|d1000Curr\(1) & (\dc|process_1~2_combout\ & \dc|d1000Curr\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \dc|d1000Curr\(1),
	datab => \dc|d1000Curr\(2),
	datac => \dc|process_1~2_combout\,
	datad => \dc|d1000Curr\(0),
	combout => \dc|d1000Next~2_combout\);

-- Location: FF_X17_Y15_N5
\dc|d1000Next[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \dc|d1000Next~2_combout\,
	ena => \dc|ce~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \dc|d1000Next\(2));

-- Location: FF_X17_Y15_N27
\dc|d1000Curr[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	asdata => \dc|d1000Next\(2),
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \dc|d1000Curr\(2));

-- Location: FF_X18_Y15_N13
\tec|reg_digit0[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	asdata => \dc|d1000Curr\(2),
	sload => VCC,
	ena => \tec|reg_digit0[3]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \tec|reg_digit0\(2));

-- Location: FF_X18_Y15_N9
\tec|reg_digit0[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	asdata => \dc|d1000Curr\(0),
	sload => VCC,
	ena => \tec|reg_digit0[3]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \tec|reg_digit0\(0));

-- Location: LCCOMB_X18_Y15_N30
\tec|reg_digit0[3]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|reg_digit0[3]~feeder_combout\ = \dc|d1000Curr\(3)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \dc|d1000Curr\(3),
	combout => \tec|reg_digit0[3]~feeder_combout\);

-- Location: FF_X18_Y15_N31
\tec|reg_digit0[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \tec|reg_digit0[3]~feeder_combout\,
	ena => \tec|reg_digit0[3]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \tec|reg_digit0\(3));

-- Location: FF_X18_Y15_N11
\tec|reg_digit0[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	asdata => \dc|d1000Curr\(1),
	sload => VCC,
	ena => \tec|reg_digit0[3]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \tec|reg_digit0\(1));

-- Location: LCCOMB_X18_Y15_N24
\tec|Mux2~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Mux2~0_combout\ = (\tec|reg_digit0\(2) & (\tec|reg_digit0\(3) & ((\tec|reg_digit0\(1)) # (!\tec|reg_digit0\(0))))) # (!\tec|reg_digit0\(2) & (!\tec|reg_digit0\(0) & (!\tec|reg_digit0\(3) & \tec|reg_digit0\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000100100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|reg_digit0\(2),
	datab => \tec|reg_digit0\(0),
	datac => \tec|reg_digit0\(3),
	datad => \tec|reg_digit0\(1),
	combout => \tec|Mux2~0_combout\);

-- Location: LCCOMB_X16_Y15_N18
\tec|Equal47~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal47~0_combout\ = (\tec|sm_counter\(5) & (\tec|sm_counter\(0) & \tec|sm_counter\(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(5),
	datab => \tec|sm_counter\(0),
	datad => \tec|sm_counter\(1),
	combout => \tec|Equal47~0_combout\);

-- Location: LCCOMB_X19_Y17_N6
\tec|Equal7~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal7~1_combout\ = (!\tec|sm_counter\(4) & (\tec|sm_counter\(2) & (\tec|Equal64~0_combout\ & !\tec|sm_counter\(6))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(4),
	datab => \tec|sm_counter\(2),
	datac => \tec|Equal64~0_combout\,
	datad => \tec|sm_counter\(6),
	combout => \tec|Equal7~1_combout\);

-- Location: LCCOMB_X16_Y15_N4
\tec|Selector1~10\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Selector1~10_combout\ = (!\tec|Mux2~0_combout\ & (\tec|Equal47~0_combout\ & (\tec|sm_counter\(3) & \tec|Equal7~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Mux2~0_combout\,
	datab => \tec|Equal47~0_combout\,
	datac => \tec|sm_counter\(3),
	datad => \tec|Equal7~1_combout\,
	combout => \tec|Selector1~10_combout\);

-- Location: LCCOMB_X18_Y15_N2
\tec|Mux1~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Mux1~0_combout\ = (\tec|reg_digit0\(3) & ((\tec|reg_digit0\(0) & ((\tec|reg_digit0\(1)))) # (!\tec|reg_digit0\(0) & (\tec|reg_digit0\(2))))) # (!\tec|reg_digit0\(3) & (\tec|reg_digit0\(2) & (\tec|reg_digit0\(0) $ (\tec|reg_digit0\(1)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110001000101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|reg_digit0\(2),
	datab => \tec|reg_digit0\(0),
	datac => \tec|reg_digit0\(3),
	datad => \tec|reg_digit0\(1),
	combout => \tec|Mux1~0_combout\);

-- Location: LCCOMB_X16_Y15_N24
\tec|Equal37~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal37~1_combout\ = (\tec|sm_counter\(5) & (\tec|sm_counter\(0) & !\tec|sm_counter\(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(5),
	datab => \tec|sm_counter\(0),
	datad => \tec|sm_counter\(1),
	combout => \tec|Equal37~1_combout\);

-- Location: LCCOMB_X16_Y15_N14
\tec|Selector1~11\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Selector1~11_combout\ = (!\tec|Mux1~0_combout\ & (\tec|Equal37~1_combout\ & (\tec|sm_counter\(3) & \tec|Equal7~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Mux1~0_combout\,
	datab => \tec|Equal37~1_combout\,
	datac => \tec|sm_counter\(3),
	datad => \tec|Equal7~1_combout\,
	combout => \tec|Selector1~11_combout\);

-- Location: LCCOMB_X16_Y14_N6
\tec|Selector1~12\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Selector1~12_combout\ = (\tec|Selector1~9_combout\) # ((\tec|Selector1~8_combout\) # ((\tec|Selector1~10_combout\) # (\tec|Selector1~11_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Selector1~9_combout\,
	datab => \tec|Selector1~8_combout\,
	datac => \tec|Selector1~10_combout\,
	datad => \tec|Selector1~11_combout\,
	combout => \tec|Selector1~12_combout\);

-- Location: LCCOMB_X16_Y15_N12
\tec|Equal77~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal77~0_combout\ = (!\tec|sm_counter\(5) & (\tec|sm_counter\(0) & !\tec|sm_counter\(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(5),
	datab => \tec|sm_counter\(0),
	datad => \tec|sm_counter\(1),
	combout => \tec|Equal77~0_combout\);

-- Location: LCCOMB_X17_Y16_N26
\tec|Mux20~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Mux20~0_combout\ = (\tec|reg_digit2\(0) & ((\tec|reg_digit2\(3)) # (\tec|reg_digit2\(2) $ (\tec|reg_digit2\(1))))) # (!\tec|reg_digit2\(0) & ((\tec|reg_digit2\(1)) # (\tec|reg_digit2\(2) $ (\tec|reg_digit2\(3)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111011111011010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|reg_digit2\(2),
	datab => \tec|reg_digit2\(0),
	datac => \tec|reg_digit2\(3),
	datad => \tec|reg_digit2\(1),
	combout => \tec|Mux20~0_combout\);

-- Location: LCCOMB_X17_Y16_N2
\tec|Equal27~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal27~0_combout\ = (\tec|sm_counter\(4) & \tec|sm_counter\(3))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \tec|sm_counter\(4),
	datac => \tec|sm_counter\(3),
	combout => \tec|Equal27~0_combout\);

-- Location: LCCOMB_X17_Y19_N6
\tec|Equal89~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal89~0_combout\ = (\tec|sm_counter\(6) & (!\tec|sm_counter\(2) & (\tec|Equal64~0_combout\ & \tec|Equal27~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(6),
	datab => \tec|sm_counter\(2),
	datac => \tec|Equal64~0_combout\,
	datad => \tec|Equal27~0_combout\,
	combout => \tec|Equal89~0_combout\);

-- Location: LCCOMB_X16_Y15_N8
\tec|Selector1~25\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Selector1~25_combout\ = (\tec|Mux20~0_combout\ & (\tec|Equal7~0_combout\ & (!\tec|sm_counter\(5) & \tec|Equal89~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Mux20~0_combout\,
	datab => \tec|Equal7~0_combout\,
	datac => \tec|sm_counter\(5),
	datad => \tec|Equal89~0_combout\,
	combout => \tec|Selector1~25_combout\);

-- Location: LCCOMB_X17_Y16_N24
\tec|Mux19~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Mux19~0_combout\ = (\tec|reg_digit2\(2) & (\tec|reg_digit2\(0) & (\tec|reg_digit2\(3) $ (\tec|reg_digit2\(1))))) # (!\tec|reg_digit2\(2) & (!\tec|reg_digit2\(3) & ((\tec|reg_digit2\(1)) # (\tec|reg_digit2\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011100100010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|reg_digit2\(2),
	datab => \tec|reg_digit2\(3),
	datac => \tec|reg_digit2\(1),
	datad => \tec|reg_digit2\(0),
	combout => \tec|Mux19~0_combout\);

-- Location: LCCOMB_X16_Y15_N10
\tec|Selector1~26\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Selector1~26_combout\ = (\tec|Selector1~25_combout\) # ((\tec|Equal77~0_combout\ & (!\tec|Mux19~0_combout\ & \tec|Equal89~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Equal77~0_combout\,
	datab => \tec|Selector1~25_combout\,
	datac => \tec|Mux19~0_combout\,
	datad => \tec|Equal89~0_combout\,
	combout => \tec|Selector1~26_combout\);

-- Location: LCCOMB_X17_Y16_N12
\tec|Mux17~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Mux17~0_combout\ = (\tec|reg_digit2\(1) & ((\tec|reg_digit2\(2) & ((\tec|reg_digit2\(0)))) # (!\tec|reg_digit2\(2) & (\tec|reg_digit2\(3) & !\tec|reg_digit2\(0))))) # (!\tec|reg_digit2\(1) & (!\tec|reg_digit2\(3) & (\tec|reg_digit2\(2) $ 
-- (\tec|reg_digit2\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000101000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|reg_digit2\(2),
	datab => \tec|reg_digit2\(3),
	datac => \tec|reg_digit2\(1),
	datad => \tec|reg_digit2\(0),
	combout => \tec|Mux17~0_combout\);

-- Location: LCCOMB_X16_Y17_N28
\tec|Equal69~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal69~0_combout\ = (!\tec|sm_counter\(1) & (\tec|sm_counter\(0) & \tec|sm_counter\(2)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \tec|sm_counter\(1),
	datac => \tec|sm_counter\(0),
	datad => \tec|sm_counter\(2),
	combout => \tec|Equal69~0_combout\);

-- Location: LCCOMB_X17_Y16_N0
\tec|Mux18~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Mux18~0_combout\ = (\tec|reg_digit2\(1) & (\tec|reg_digit2\(0) & ((!\tec|reg_digit2\(3))))) # (!\tec|reg_digit2\(1) & ((\tec|reg_digit2\(2) & ((!\tec|reg_digit2\(3)))) # (!\tec|reg_digit2\(2) & (\tec|reg_digit2\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000010011011100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|reg_digit2\(1),
	datab => \tec|reg_digit2\(0),
	datac => \tec|reg_digit2\(2),
	datad => \tec|reg_digit2\(3),
	combout => \tec|Mux18~0_combout\);

-- Location: LCCOMB_X17_Y16_N10
\tec|Selector1~27\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Selector1~27_combout\ = (!\tec|Mux18~0_combout\ & (\tec|Equal80~0_combout\ & \tec|Equal71~0_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \tec|Mux18~0_combout\,
	datac => \tec|Equal80~0_combout\,
	datad => \tec|Equal71~0_combout\,
	combout => \tec|Selector1~27_combout\);

-- Location: LCCOMB_X17_Y16_N14
\tec|Selector1~28\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Selector1~28_combout\ = (\tec|Selector1~27_combout\) # ((!\tec|Mux17~0_combout\ & (\tec|Equal80~0_combout\ & \tec|Equal69~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111101000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Mux17~0_combout\,
	datab => \tec|Equal80~0_combout\,
	datac => \tec|Equal69~0_combout\,
	datad => \tec|Selector1~27_combout\,
	combout => \tec|Selector1~28_combout\);

-- Location: LCCOMB_X16_Y14_N0
\tec|Mux11~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Mux11~0_combout\ = (\tec|reg_digit1\(1) & (\tec|reg_digit1\(0) & ((!\tec|reg_digit1\(3))))) # (!\tec|reg_digit1\(1) & ((\tec|reg_digit1\(2) & ((!\tec|reg_digit1\(3)))) # (!\tec|reg_digit1\(2) & (\tec|reg_digit1\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001010101110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|reg_digit1\(0),
	datab => \tec|reg_digit1\(2),
	datac => \tec|reg_digit1\(1),
	datad => \tec|reg_digit1\(3),
	combout => \tec|Mux11~0_combout\);

-- Location: LCCOMB_X18_Y15_N4
\tec|Mux4~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Mux4~0_combout\ = (\tec|reg_digit0\(1) & (((\tec|reg_digit0\(0) & !\tec|reg_digit0\(3))))) # (!\tec|reg_digit0\(1) & ((\tec|reg_digit0\(2) & ((!\tec|reg_digit0\(3)))) # (!\tec|reg_digit0\(2) & (\tec|reg_digit0\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000110001001110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|reg_digit0\(2),
	datab => \tec|reg_digit0\(0),
	datac => \tec|reg_digit0\(3),
	datad => \tec|reg_digit0\(1),
	combout => \tec|Mux4~0_combout\);

-- Location: LCCOMB_X21_Y9_N30
\tec|Equal18~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal18~0_combout\ = (!\tec|sm_counter\(7) & (\tec|Equal24~2_combout\ & (\tec|sm_counter\(1) & !\tec|sm_counter\(6))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(7),
	datab => \tec|Equal24~2_combout\,
	datac => \tec|sm_counter\(1),
	datad => \tec|sm_counter\(6),
	combout => \tec|Equal18~0_combout\);

-- Location: LCCOMB_X21_Y9_N24
\tec|Equal18~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal18~1_combout\ = (\tec|Equal19~0_combout\ & (\tec|Equal142~0_combout\ & (\tec|Equal18~0_combout\ & \tec|Equal142~5_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Equal19~0_combout\,
	datab => \tec|Equal142~0_combout\,
	datac => \tec|Equal18~0_combout\,
	datad => \tec|Equal142~5_combout\,
	combout => \tec|Equal18~1_combout\);

-- Location: LCCOMB_X16_Y14_N22
\tec|Selector1~31\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Selector1~31_combout\ = (\tec|Equal37~0_combout\ & (!\tec|sm_counter\(2) & (!\tec|Mux4~0_combout\ & \tec|Equal18~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Equal37~0_combout\,
	datab => \tec|sm_counter\(2),
	datac => \tec|Mux4~0_combout\,
	datad => \tec|Equal18~1_combout\,
	combout => \tec|Selector1~31_combout\);

-- Location: LCCOMB_X16_Y14_N10
\tec|Selector1~32\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Selector1~32_combout\ = (\tec|Selector1~31_combout\) # ((!\tec|Mux11~0_combout\ & (\tec|Equal69~0_combout\ & \tec|Equal64~3_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Mux11~0_combout\,
	datab => \tec|Equal69~0_combout\,
	datac => \tec|Selector1~31_combout\,
	datad => \tec|Equal64~3_combout\,
	combout => \tec|Selector1~32_combout\);

-- Location: LCCOMB_X16_Y14_N2
\tec|Mux12~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Mux12~0_combout\ = (\tec|reg_digit1\(0) & (\tec|reg_digit1\(3) $ (((\tec|reg_digit1\(1)) # (!\tec|reg_digit1\(2)))))) # (!\tec|reg_digit1\(0) & (!\tec|reg_digit1\(2) & (\tec|reg_digit1\(1) & !\tec|reg_digit1\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100010110010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|reg_digit1\(0),
	datab => \tec|reg_digit1\(2),
	datac => \tec|reg_digit1\(1),
	datad => \tec|reg_digit1\(3),
	combout => \tec|Mux12~0_combout\);

-- Location: LCCOMB_X16_Y14_N20
\tec|Selector1~30\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Selector1~30_combout\ = (\tec|Equal7~0_combout\ & (!\tec|Mux12~0_combout\ & (\tec|sm_counter\(2) & \tec|Equal64~3_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Equal7~0_combout\,
	datab => \tec|Mux12~0_combout\,
	datac => \tec|sm_counter\(2),
	datad => \tec|Equal64~3_combout\,
	combout => \tec|Selector1~30_combout\);

-- Location: LCCOMB_X16_Y15_N26
\tec|Equal7~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal7~2_combout\ = (!\tec|sm_counter\(5) & (\tec|sm_counter\(0) & \tec|sm_counter\(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100010000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(5),
	datab => \tec|sm_counter\(0),
	datad => \tec|sm_counter\(1),
	combout => \tec|Equal7~2_combout\);

-- Location: LCCOMB_X17_Y13_N8
\tec|Equal76~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal76~0_combout\ = (\tec|sm_counter\(3) & \tec|sm_counter\(6))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \tec|sm_counter\(3),
	datad => \tec|sm_counter\(6),
	combout => \tec|Equal76~0_combout\);

-- Location: LCCOMB_X17_Y13_N10
\tec|Equal76~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal76~1_combout\ = (\tec|sm_counter\(2) & (!\tec|sm_counter\(4) & (\tec|Equal76~0_combout\ & \tec|Equal64~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(2),
	datab => \tec|sm_counter\(4),
	datac => \tec|Equal76~0_combout\,
	datad => \tec|Equal64~0_combout\,
	combout => \tec|Equal76~1_combout\);

-- Location: LCCOMB_X17_Y16_N8
\tec|Mux14~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Mux14~0_combout\ = (\tec|reg_digit2\(2) & (!\tec|reg_digit2\(1) & (\tec|reg_digit2\(3) $ (!\tec|reg_digit2\(0))))) # (!\tec|reg_digit2\(2) & (\tec|reg_digit2\(0) & (\tec|reg_digit2\(3) $ (!\tec|reg_digit2\(1)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100100100000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|reg_digit2\(2),
	datab => \tec|reg_digit2\(3),
	datac => \tec|reg_digit2\(1),
	datad => \tec|reg_digit2\(0),
	combout => \tec|Mux14~0_combout\);

-- Location: LCCOMB_X16_Y15_N0
\tec|Selector1~29\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Selector1~29_combout\ = (\tec|Equal7~2_combout\ & (\tec|Equal76~1_combout\ & !\tec|Mux14~0_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Equal7~2_combout\,
	datab => \tec|Equal76~1_combout\,
	datad => \tec|Mux14~0_combout\,
	combout => \tec|Selector1~29_combout\);

-- Location: LCCOMB_X16_Y15_N28
\tec|Selector1~33\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Selector1~33_combout\ = (\tec|Selector1~28_combout\) # ((\tec|Selector1~32_combout\) # ((\tec|Selector1~30_combout\) # (\tec|Selector1~29_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Selector1~28_combout\,
	datab => \tec|Selector1~32_combout\,
	datac => \tec|Selector1~30_combout\,
	datad => \tec|Selector1~29_combout\,
	combout => \tec|Selector1~33_combout\);

-- Location: LCCOMB_X17_Y11_N0
\tec|Equal96~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal96~0_combout\ = (\tec|Equal64~0_combout\ & (!\tec|sm_counter\(4) & (\tec|sm_counter\(5) & \tec|Equal64~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Equal64~0_combout\,
	datab => \tec|sm_counter\(4),
	datac => \tec|sm_counter\(5),
	datad => \tec|Equal64~1_combout\,
	combout => \tec|Equal96~0_combout\);

-- Location: LCCOMB_X17_Y14_N10
\tec|Equal97~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal97~2_combout\ = (\tec|sm_counter\(0) & (\tec|Equal96~0_combout\ & (!\tec|sm_counter\(1) & !\tec|sm_counter\(2))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(0),
	datab => \tec|Equal96~0_combout\,
	datac => \tec|sm_counter\(1),
	datad => \tec|sm_counter\(2),
	combout => \tec|Equal97~2_combout\);

-- Location: LCCOMB_X18_Y15_N26
\tec|Mux0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Mux0~0_combout\ = (\tec|reg_digit0\(2) & (!\tec|reg_digit0\(1) & (\tec|reg_digit0\(0) $ (!\tec|reg_digit0\(3))))) # (!\tec|reg_digit0\(2) & (\tec|reg_digit0\(0) & (\tec|reg_digit0\(3) $ (!\tec|reg_digit0\(1)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000010000110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|reg_digit0\(2),
	datab => \tec|reg_digit0\(0),
	datac => \tec|reg_digit0\(3),
	datad => \tec|reg_digit0\(1),
	combout => \tec|Mux0~0_combout\);

-- Location: LCCOMB_X17_Y14_N2
\tec|Mux21~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Mux21~0_combout\ = (\tec|reg_digit3\(3) & (\tec|reg_digit3\(0) & (\tec|reg_digit3\(1) $ (\tec|reg_digit3\(2))))) # (!\tec|reg_digit3\(3) & (!\tec|reg_digit3\(1) & (\tec|reg_digit3\(0) $ (\tec|reg_digit3\(2)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000110000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|reg_digit3\(1),
	datab => \tec|reg_digit3\(0),
	datac => \tec|reg_digit3\(3),
	datad => \tec|reg_digit3\(2),
	combout => \tec|Mux21~0_combout\);

-- Location: LCCOMB_X21_Y9_N20
\tec|Equal2~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal2~3_combout\ = (!\tec|sm_counter\(7) & (\tec|sm_counter\(1) & !\tec|sm_counter\(6)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \tec|sm_counter\(7),
	datac => \tec|sm_counter\(1),
	datad => \tec|sm_counter\(6),
	combout => \tec|Equal2~3_combout\);

-- Location: LCCOMB_X21_Y9_N22
\tec|Equal2~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal2~4_combout\ = (\tec|Equal142~5_combout\ & (\tec|Equal2~3_combout\ & (\tec|Equal24~2_combout\ & \tec|Equal142~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Equal142~5_combout\,
	datab => \tec|Equal2~3_combout\,
	datac => \tec|Equal24~2_combout\,
	datad => \tec|Equal142~0_combout\,
	combout => \tec|Equal2~4_combout\);

-- Location: LCCOMB_X19_Y12_N28
\tec|Equal10~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal10~0_combout\ = (!\tec|sm_counter\(4) & \tec|sm_counter\(3))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101000001010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(4),
	datac => \tec|sm_counter\(3),
	combout => \tec|Equal10~0_combout\);

-- Location: LCCOMB_X21_Y16_N4
\tec|Equal43~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal43~0_combout\ = (\tec|Equal2~4_combout\ & (!\tec|sm_counter\(2) & (\tec|Equal37~0_combout\ & \tec|Equal10~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Equal2~4_combout\,
	datab => \tec|sm_counter\(2),
	datac => \tec|Equal37~0_combout\,
	datad => \tec|Equal10~0_combout\,
	combout => \tec|Equal43~0_combout\);

-- Location: LCCOMB_X17_Y14_N12
\tec|Selector1~23\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Selector1~23_combout\ = (\tec|Equal97~2_combout\ & (((!\tec|Mux0~0_combout\ & \tec|Equal43~0_combout\)) # (!\tec|Mux21~0_combout\))) # (!\tec|Equal97~2_combout\ & (!\tec|Mux0~0_combout\ & ((\tec|Equal43~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011101100001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Equal97~2_combout\,
	datab => \tec|Mux0~0_combout\,
	datac => \tec|Mux21~0_combout\,
	datad => \tec|Equal43~0_combout\,
	combout => \tec|Selector1~23_combout\);

-- Location: LCCOMB_X17_Y14_N4
\tec|Equal99~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal99~2_combout\ = (\tec|sm_counter\(0) & (\tec|Equal96~0_combout\ & (\tec|sm_counter\(1) & !\tec|sm_counter\(2))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(0),
	datab => \tec|Equal96~0_combout\,
	datac => \tec|sm_counter\(1),
	datad => \tec|sm_counter\(2),
	combout => \tec|Equal99~2_combout\);

-- Location: LCCOMB_X17_Y14_N14
\tec|Mux22~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Mux22~0_combout\ = (\tec|reg_digit3\(1) & ((\tec|reg_digit3\(0) & (\tec|reg_digit3\(3))) # (!\tec|reg_digit3\(0) & ((\tec|reg_digit3\(2)))))) # (!\tec|reg_digit3\(1) & (\tec|reg_digit3\(2) & (\tec|reg_digit3\(0) $ (\tec|reg_digit3\(3)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011011010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|reg_digit3\(1),
	datab => \tec|reg_digit3\(0),
	datac => \tec|reg_digit3\(3),
	datad => \tec|reg_digit3\(2),
	combout => \tec|Mux22~0_combout\);

-- Location: LCCOMB_X18_Y15_N0
\tec|Mux3~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Mux3~0_combout\ = (\tec|reg_digit0\(1) & ((\tec|reg_digit0\(2) & (\tec|reg_digit0\(0))) # (!\tec|reg_digit0\(2) & (!\tec|reg_digit0\(0) & \tec|reg_digit0\(3))))) # (!\tec|reg_digit0\(1) & (!\tec|reg_digit0\(3) & (\tec|reg_digit0\(2) $ 
-- (\tec|reg_digit0\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001100000000110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|reg_digit0\(2),
	datab => \tec|reg_digit0\(0),
	datac => \tec|reg_digit0\(3),
	datad => \tec|reg_digit0\(1),
	combout => \tec|Mux3~0_combout\);

-- Location: LCCOMB_X21_Y16_N14
\tec|Equal16~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal16~1_combout\ = (!\tec|sm_counter\(6) & (\tec|Equal19~0_combout\ & (!\tec|sm_counter\(1) & \tec|Equal64~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000010000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(6),
	datab => \tec|Equal19~0_combout\,
	datac => \tec|sm_counter\(1),
	datad => \tec|Equal64~0_combout\,
	combout => \tec|Equal16~1_combout\);

-- Location: LCCOMB_X18_Y16_N20
\tec|Selector1~22\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Selector1~22_combout\ = (!\tec|sm_counter\(2) & (!\tec|Mux3~0_combout\ & (\tec|Equal37~0_combout\ & \tec|Equal16~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(2),
	datab => \tec|Mux3~0_combout\,
	datac => \tec|Equal37~0_combout\,
	datad => \tec|Equal16~1_combout\,
	combout => \tec|Selector1~22_combout\);

-- Location: LCCOMB_X17_Y14_N0
\tec|Selector1~24\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Selector1~24_combout\ = (\tec|Selector1~23_combout\) # ((\tec|Selector1~22_combout\) # ((\tec|Equal99~2_combout\ & !\tec|Mux22~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111110101110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Selector1~23_combout\,
	datab => \tec|Equal99~2_combout\,
	datac => \tec|Mux22~0_combout\,
	datad => \tec|Selector1~22_combout\,
	combout => \tec|Selector1~24_combout\);

-- Location: LCCOMB_X16_Y14_N18
\tec|Mux7~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Mux7~0_combout\ = (\tec|reg_digit1\(2) & (!\tec|reg_digit1\(1) & (\tec|reg_digit1\(3) $ (!\tec|reg_digit1\(0))))) # (!\tec|reg_digit1\(2) & (\tec|reg_digit1\(0) & (\tec|reg_digit1\(1) $ (!\tec|reg_digit1\(3)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110000100000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|reg_digit1\(1),
	datab => \tec|reg_digit1\(2),
	datac => \tec|reg_digit1\(3),
	datad => \tec|reg_digit1\(0),
	combout => \tec|Mux7~0_combout\);

-- Location: LCCOMB_X16_Y9_N22
\tec|Equal56~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal56~2_combout\ = (\tec|sm_counter\(5) & (!\tec|sm_counter\(7) & (!\tec|sm_counter\(6) & !\tec|sm_counter\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(5),
	datab => \tec|sm_counter\(7),
	datac => \tec|sm_counter\(6),
	datad => \tec|sm_counter\(1),
	combout => \tec|Equal56~2_combout\);

-- Location: LCCOMB_X16_Y9_N20
\tec|Equal56~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal56~4_combout\ = (\tec|sm_counter\(3) & (\tec|Equal24~2_combout\ & \tec|sm_counter\(4)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(3),
	datab => \tec|Equal24~2_combout\,
	datad => \tec|sm_counter\(4),
	combout => \tec|Equal56~4_combout\);

-- Location: LCCOMB_X16_Y9_N8
\tec|Equal56~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal56~3_combout\ = (\tec|Equal56~2_combout\ & (\tec|Equal56~4_combout\ & (\tec|Equal142~5_combout\ & \tec|Equal142~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Equal56~2_combout\,
	datab => \tec|Equal56~4_combout\,
	datac => \tec|Equal142~5_combout\,
	datad => \tec|Equal142~0_combout\,
	combout => \tec|Equal56~3_combout\);

-- Location: LCCOMB_X17_Y13_N14
\tec|Selector1~15\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Selector1~15_combout\ = (!\tec|Mux7~0_combout\ & (\tec|sm_counter\(0) & (\tec|Equal56~3_combout\ & \tec|sm_counter\(2))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Mux7~0_combout\,
	datab => \tec|sm_counter\(0),
	datac => \tec|Equal56~3_combout\,
	datad => \tec|sm_counter\(2),
	combout => \tec|Selector1~15_combout\);

-- Location: LCCOMB_X18_Y15_N14
\tec|Mux5~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Mux5~0_combout\ = (\tec|reg_digit0\(2) & (\tec|reg_digit0\(0) & (\tec|reg_digit0\(3) $ (\tec|reg_digit0\(1))))) # (!\tec|reg_digit0\(2) & (!\tec|reg_digit0\(3) & ((\tec|reg_digit0\(0)) # (\tec|reg_digit0\(1)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000110110000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|reg_digit0\(2),
	datab => \tec|reg_digit0\(0),
	datac => \tec|reg_digit0\(3),
	datad => \tec|reg_digit0\(1),
	combout => \tec|Mux5~0_combout\);

-- Location: LCCOMB_X18_Y17_N26
\tec|Equal53~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal53~0_combout\ = (\tec|sm_counter\(2) & (\tec|sm_counter\(5) & \tec|sm_counter\(0)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(2),
	datab => \tec|sm_counter\(5),
	datac => \tec|sm_counter\(0),
	combout => \tec|Equal53~0_combout\);

-- Location: LCCOMB_X19_Y12_N8
\tec|Equal16~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal16~0_combout\ = (\tec|sm_counter\(4) & (!\tec|sm_counter\(1) & (!\tec|sm_counter\(3) & !\tec|sm_counter\(6))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(4),
	datab => \tec|sm_counter\(1),
	datac => \tec|sm_counter\(3),
	datad => \tec|sm_counter\(6),
	combout => \tec|Equal16~0_combout\);

-- Location: LCCOMB_X17_Y13_N20
\tec|Selector1~18\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Selector1~18_combout\ = (!\tec|Mux5~0_combout\ & (\tec|Equal53~0_combout\ & (\tec|Equal16~0_combout\ & \tec|Equal64~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Mux5~0_combout\,
	datab => \tec|Equal53~0_combout\,
	datac => \tec|Equal16~0_combout\,
	datad => \tec|Equal64~0_combout\,
	combout => \tec|Selector1~18_combout\);

-- Location: LCCOMB_X17_Y14_N16
\tec|Mux26~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Mux26~0_combout\ = (\tec|reg_digit3\(1) & (!\tec|reg_digit3\(3) & ((\tec|reg_digit3\(0)) # (!\tec|reg_digit3\(2))))) # (!\tec|reg_digit3\(1) & (\tec|reg_digit3\(0) & (\tec|reg_digit3\(2) $ (!\tec|reg_digit3\(3)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000010001110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|reg_digit3\(1),
	datab => \tec|reg_digit3\(0),
	datac => \tec|reg_digit3\(2),
	datad => \tec|reg_digit3\(3),
	combout => \tec|Mux26~0_combout\);

-- Location: LCCOMB_X19_Y12_N4
\tec|Equal74~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal74~0_combout\ = (\tec|sm_counter\(1) & \tec|sm_counter\(6))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \tec|sm_counter\(1),
	datad => \tec|sm_counter\(6),
	combout => \tec|Equal74~0_combout\);

-- Location: LCCOMB_X19_Y12_N6
\tec|Equal74~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal74~1_combout\ = (\tec|Equal64~0_combout\ & (\tec|Equal74~0_combout\ & (!\tec|sm_counter\(4) & \tec|Equal8~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Equal64~0_combout\,
	datab => \tec|Equal74~0_combout\,
	datac => \tec|sm_counter\(4),
	datad => \tec|Equal8~0_combout\,
	combout => \tec|Equal74~1_combout\);

-- Location: LCCOMB_X17_Y13_N6
\tec|Selector1~19\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Selector1~19_combout\ = (\tec|Selector1~18_combout\) # ((\tec|Equal37~0_combout\ & (!\tec|Mux26~0_combout\ & \tec|Equal74~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010111010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Selector1~18_combout\,
	datab => \tec|Equal37~0_combout\,
	datac => \tec|Mux26~0_combout\,
	datad => \tec|Equal74~1_combout\,
	combout => \tec|Selector1~19_combout\);

-- Location: LCCOMB_X17_Y13_N24
\tec|Equal63~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal63~0_combout\ = (\tec|sm_counter\(4) & (\tec|Equal53~0_combout\ & (\tec|sm_counter\(3) & \tec|Equal2~4_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(4),
	datab => \tec|Equal53~0_combout\,
	datac => \tec|sm_counter\(3),
	datad => \tec|Equal2~4_combout\,
	combout => \tec|Equal63~0_combout\);

-- Location: LCCOMB_X16_Y14_N8
\tec|Mux8~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Mux8~0_combout\ = (\tec|reg_digit1\(1) & ((\tec|reg_digit1\(0) & ((\tec|reg_digit1\(3)))) # (!\tec|reg_digit1\(0) & (\tec|reg_digit1\(2))))) # (!\tec|reg_digit1\(1) & (\tec|reg_digit1\(2) & (\tec|reg_digit1\(0) $ (\tec|reg_digit1\(3)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110010001001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|reg_digit1\(0),
	datab => \tec|reg_digit1\(2),
	datac => \tec|reg_digit1\(1),
	datad => \tec|reg_digit1\(3),
	combout => \tec|Mux8~0_combout\);

-- Location: LCCOMB_X17_Y14_N18
\tec|Mux27~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Mux27~0_combout\ = (\tec|reg_digit3\(0) & ((\tec|reg_digit3\(3)) # (\tec|reg_digit3\(1) $ (\tec|reg_digit3\(2))))) # (!\tec|reg_digit3\(0) & ((\tec|reg_digit3\(1)) # (\tec|reg_digit3\(3) $ (\tec|reg_digit3\(2)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110011111111010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|reg_digit3\(1),
	datab => \tec|reg_digit3\(0),
	datac => \tec|reg_digit3\(3),
	datad => \tec|reg_digit3\(2),
	combout => \tec|Mux27~0_combout\);

-- Location: LCCOMB_X17_Y13_N18
\tec|Selector1~17\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Selector1~17_combout\ = (\tec|Equal37~1_combout\ & (\tec|Mux27~0_combout\ & \tec|Equal76~1_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \tec|Equal37~1_combout\,
	datac => \tec|Mux27~0_combout\,
	datad => \tec|Equal76~1_combout\,
	combout => \tec|Selector1~17_combout\);

-- Location: LCCOMB_X17_Y13_N0
\tec|Selector1~20\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Selector1~20_combout\ = (\tec|Selector1~19_combout\) # ((\tec|Selector1~17_combout\) # ((\tec|Equal63~0_combout\ & !\tec|Mux8~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111110101110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Selector1~19_combout\,
	datab => \tec|Equal63~0_combout\,
	datac => \tec|Mux8~0_combout\,
	datad => \tec|Selector1~17_combout\,
	combout => \tec|Selector1~20_combout\);

-- Location: LCCOMB_X17_Y14_N30
\tec|Mux24~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Mux24~0_combout\ = (\tec|reg_digit3\(1) & ((\tec|reg_digit3\(0) & ((\tec|reg_digit3\(2)))) # (!\tec|reg_digit3\(0) & (\tec|reg_digit3\(3) & !\tec|reg_digit3\(2))))) # (!\tec|reg_digit3\(1) & (!\tec|reg_digit3\(3) & (\tec|reg_digit3\(0) $ 
-- (\tec|reg_digit3\(2)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000100100100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|reg_digit3\(3),
	datab => \tec|reg_digit3\(0),
	datac => \tec|reg_digit3\(1),
	datad => \tec|reg_digit3\(2),
	combout => \tec|Mux24~0_combout\);

-- Location: LCCOMB_X17_Y14_N6
\tec|Selector1~13\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Selector1~13_combout\ = (!\tec|Mux24~0_combout\ & (\tec|Equal96~0_combout\ & \tec|Equal71~0_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \tec|Mux24~0_combout\,
	datac => \tec|Equal96~0_combout\,
	datad => \tec|Equal71~0_combout\,
	combout => \tec|Selector1~13_combout\);

-- Location: LCCOMB_X17_Y14_N20
\tec|Mux23~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Mux23~0_combout\ = (\tec|reg_digit3\(2) & (\tec|reg_digit3\(3) & ((\tec|reg_digit3\(1)) # (!\tec|reg_digit3\(0))))) # (!\tec|reg_digit3\(2) & (\tec|reg_digit3\(1) & (!\tec|reg_digit3\(0) & !\tec|reg_digit3\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000110000000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|reg_digit3\(1),
	datab => \tec|reg_digit3\(2),
	datac => \tec|reg_digit3\(0),
	datad => \tec|reg_digit3\(3),
	combout => \tec|Mux23~0_combout\);

-- Location: LCCOMB_X17_Y14_N24
\tec|Selector1~14\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Selector1~14_combout\ = (\tec|Selector1~13_combout\) # ((\tec|Equal69~0_combout\ & (\tec|Equal96~0_combout\ & !\tec|Mux23~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101011101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Selector1~13_combout\,
	datab => \tec|Equal69~0_combout\,
	datac => \tec|Equal96~0_combout\,
	datad => \tec|Mux23~0_combout\,
	combout => \tec|Selector1~14_combout\);

-- Location: LCCOMB_X18_Y15_N20
\tec|Mux6~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Mux6~0_combout\ = (\tec|reg_digit0\(0) & ((\tec|reg_digit0\(3)) # (\tec|reg_digit0\(2) $ (\tec|reg_digit0\(1))))) # (!\tec|reg_digit0\(0) & ((\tec|reg_digit0\(1)) # (\tec|reg_digit0\(2) $ (\tec|reg_digit0\(3)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111011111011010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|reg_digit0\(2),
	datab => \tec|reg_digit0\(0),
	datac => \tec|reg_digit0\(3),
	datad => \tec|reg_digit0\(1),
	combout => \tec|Mux6~0_combout\);

-- Location: LCCOMB_X17_Y13_N16
\tec|Selector1~16\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Selector1~16_combout\ = (\tec|Equal53~0_combout\ & (\tec|Mux6~0_combout\ & \tec|Equal18~1_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \tec|Equal53~0_combout\,
	datac => \tec|Mux6~0_combout\,
	datad => \tec|Equal18~1_combout\,
	combout => \tec|Selector1~16_combout\);

-- Location: LCCOMB_X17_Y13_N2
\tec|Selector1~21\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Selector1~21_combout\ = (\tec|Selector1~15_combout\) # ((\tec|Selector1~20_combout\) # ((\tec|Selector1~14_combout\) # (\tec|Selector1~16_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Selector1~15_combout\,
	datab => \tec|Selector1~20_combout\,
	datac => \tec|Selector1~14_combout\,
	datad => \tec|Selector1~16_combout\,
	combout => \tec|Selector1~21_combout\);

-- Location: LCCOMB_X16_Y15_N22
\tec|Selector1~34\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Selector1~34_combout\ = (\tec|Selector1~26_combout\) # ((\tec|Selector1~33_combout\) # ((\tec|Selector1~24_combout\) # (\tec|Selector1~21_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Selector1~26_combout\,
	datab => \tec|Selector1~33_combout\,
	datac => \tec|Selector1~24_combout\,
	datad => \tec|Selector1~21_combout\,
	combout => \tec|Selector1~34_combout\);

-- Location: LCCOMB_X16_Y15_N6
\tec|Selector1~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Selector1~0_combout\ = ((\tec|sm_counter\(3) & (!\tec|Equal7~2_combout\)) # (!\tec|sm_counter\(3) & ((!\tec|Equal37~1_combout\)))) # (!\tec|Equal7~1_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101001111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Equal7~2_combout\,
	datab => \tec|Equal37~1_combout\,
	datac => \tec|sm_counter\(3),
	datad => \tec|Equal7~1_combout\,
	combout => \tec|Selector1~0_combout\);

-- Location: LCCOMB_X17_Y19_N16
\tec|Equal40~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal40~0_combout\ = (!\tec|sm_counter\(0) & \tec|sm_counter\(5))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(0),
	datad => \tec|sm_counter\(5),
	combout => \tec|Equal40~0_combout\);

-- Location: LCCOMB_X17_Y19_N20
\tec|Equal113~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal113~3_combout\ = (\tec|sm_counter\(6) & (\tec|sm_counter\(4) & (\tec|Equal64~0_combout\ & !\tec|sm_counter\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(6),
	datab => \tec|sm_counter\(4),
	datac => \tec|Equal64~0_combout\,
	datad => \tec|sm_counter\(3),
	combout => \tec|Equal113~3_combout\);

-- Location: LCCOMB_X17_Y19_N26
\tec|Equal117~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal117~0_combout\ = (\tec|sm_counter\(0) & (\tec|sm_counter\(2) & (!\tec|sm_counter\(1) & \tec|sm_counter\(5))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(0),
	datab => \tec|sm_counter\(2),
	datac => \tec|sm_counter\(1),
	datad => \tec|sm_counter\(5),
	combout => \tec|Equal117~0_combout\);

-- Location: LCCOMB_X18_Y14_N0
\tec|Equal8~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal8~2_combout\ = (!\tec|sm_counter\(6) & \tec|Equal8~1_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \tec|sm_counter\(6),
	datad => \tec|Equal8~1_combout\,
	combout => \tec|Equal8~2_combout\);

-- Location: LCCOMB_X17_Y19_N4
\tec|Selector3~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Selector3~1_combout\ = (\tec|Equal40~0_combout\ & (!\tec|Equal8~2_combout\ & ((!\tec|Equal117~0_combout\) # (!\tec|Equal113~3_combout\)))) # (!\tec|Equal40~0_combout\ & (((!\tec|Equal117~0_combout\)) # (!\tec|Equal113~3_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001010100111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Equal40~0_combout\,
	datab => \tec|Equal113~3_combout\,
	datac => \tec|Equal117~0_combout\,
	datad => \tec|Equal8~2_combout\,
	combout => \tec|Selector3~1_combout\);

-- Location: LCCOMB_X21_Y9_N16
\tec|Equal128~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal128~0_combout\ = (!\tec|sm_counter\(6) & (\tec|sm_counter\(7) & (!\tec|sm_counter\(4) & !\tec|sm_counter\(5))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(6),
	datab => \tec|sm_counter\(7),
	datac => \tec|sm_counter\(4),
	datad => \tec|sm_counter\(5),
	combout => \tec|Equal128~0_combout\);

-- Location: LCCOMB_X21_Y9_N18
\tec|Equal128~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal128~1_combout\ = (\tec|Equal142~5_combout\ & (\tec|Equal128~0_combout\ & (\tec|Equal24~2_combout\ & \tec|Equal142~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Equal142~5_combout\,
	datab => \tec|Equal128~0_combout\,
	datac => \tec|Equal24~2_combout\,
	datad => \tec|Equal142~0_combout\,
	combout => \tec|Equal128~1_combout\);

-- Location: LCCOMB_X18_Y17_N20
\tec|Equal140~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal140~0_combout\ = (\tec|sm_counter\(3) & \tec|Equal128~1_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(3),
	datad => \tec|Equal128~1_combout\,
	combout => \tec|Equal140~0_combout\);

-- Location: LCCOMB_X17_Y19_N24
\tec|Equal1~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal1~0_combout\ = (!\tec|sm_counter\(2) & !\tec|sm_counter\(5))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \tec|sm_counter\(2),
	datad => \tec|sm_counter\(5),
	combout => \tec|Equal1~0_combout\);

-- Location: LCCOMB_X17_Y19_N30
\tec|Equal0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal0~0_combout\ = (!\tec|sm_counter\(6) & (!\tec|sm_counter\(4) & (\tec|Equal64~0_combout\ & !\tec|sm_counter\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(6),
	datab => \tec|sm_counter\(4),
	datac => \tec|Equal64~0_combout\,
	datad => \tec|sm_counter\(3),
	combout => \tec|Equal0~0_combout\);

-- Location: LCCOMB_X16_Y17_N6
\tec|Equal1~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal1~1_combout\ = (\tec|Equal1~0_combout\ & (!\tec|sm_counter\(1) & (\tec|sm_counter\(0) & \tec|Equal0~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Equal1~0_combout\,
	datab => \tec|sm_counter\(1),
	datac => \tec|sm_counter\(0),
	datad => \tec|Equal0~0_combout\,
	combout => \tec|Equal1~1_combout\);

-- Location: LCCOMB_X18_Y17_N18
\tec|Equal68~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal68~0_combout\ = (\tec|sm_counter\(2) & (!\tec|sm_counter\(1) & !\tec|sm_counter\(0)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001000000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(2),
	datab => \tec|sm_counter\(1),
	datac => \tec|sm_counter\(0),
	combout => \tec|Equal68~0_combout\);

-- Location: LCCOMB_X17_Y17_N0
\tec|Selector3~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Selector3~3_combout\ = (!\tec|Equal1~1_combout\ & (((!\tec|Equal69~0_combout\ & !\tec|Equal68~0_combout\)) # (!\tec|Equal140~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000010100000111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Equal140~0_combout\,
	datab => \tec|Equal69~0_combout\,
	datac => \tec|Equal1~1_combout\,
	datad => \tec|Equal68~0_combout\,
	combout => \tec|Selector3~3_combout\);

-- Location: LCCOMB_X19_Y17_N28
\tec|Equal136~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal136~1_combout\ = (\tec|sm_counter\(3) & (!\tec|sm_counter\(2) & \tec|Equal128~1_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000101000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(3),
	datac => \tec|sm_counter\(2),
	datad => \tec|Equal128~1_combout\,
	combout => \tec|Equal136~1_combout\);

-- Location: LCCOMB_X16_Y17_N0
\tec|Equal0~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal0~1_combout\ = (!\tec|sm_counter\(0) & (!\tec|sm_counter\(1) & (!\tec|sm_counter\(5) & !\tec|sm_counter\(2))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(0),
	datab => \tec|sm_counter\(1),
	datac => \tec|sm_counter\(5),
	datad => \tec|sm_counter\(2),
	combout => \tec|Equal0~1_combout\);

-- Location: LCCOMB_X16_Y17_N26
\tec|Selector3~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Selector3~2_combout\ = (\tec|Equal136~1_combout\ & (!\tec|Equal7~0_combout\ & ((!\tec|Equal0~0_combout\) # (!\tec|Equal0~1_combout\)))) # (!\tec|Equal136~1_combout\ & (((!\tec|Equal0~0_combout\)) # (!\tec|Equal0~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001001101011111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Equal136~1_combout\,
	datab => \tec|Equal0~1_combout\,
	datac => \tec|Equal7~0_combout\,
	datad => \tec|Equal0~0_combout\,
	combout => \tec|Selector3~2_combout\);

-- Location: LCCOMB_X16_Y17_N16
\tec|Equal4~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal4~0_combout\ = (!\tec|sm_counter\(0) & \tec|Equal7~1_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \tec|sm_counter\(0),
	datad => \tec|Equal7~1_combout\,
	combout => \tec|Equal4~0_combout\);

-- Location: LCCOMB_X16_Y17_N18
\tec|Equal38~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal38~0_combout\ = (!\tec|sm_counter\(3) & (\tec|Equal4~0_combout\ & (\tec|sm_counter\(5) & \tec|sm_counter\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(3),
	datab => \tec|Equal4~0_combout\,
	datac => \tec|sm_counter\(5),
	datad => \tec|sm_counter\(1),
	combout => \tec|Equal38~0_combout\);

-- Location: LCCOMB_X16_Y17_N4
\tec|Selector3~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Selector3~4_combout\ = (\tec|Selector3~1_combout\ & (\tec|Selector3~3_combout\ & (\tec|Selector3~2_combout\ & !\tec|Equal38~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Selector3~1_combout\,
	datab => \tec|Selector3~3_combout\,
	datac => \tec|Selector3~2_combout\,
	datad => \tec|Equal38~0_combout\,
	combout => \tec|Selector3~4_combout\);

-- Location: LCCOMB_X17_Y10_N20
\tec|Equal63~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal63~1_combout\ = (\tec|sm_counter\(2) & (\tec|sm_counter\(4) & (\tec|sm_counter\(0) & \tec|sm_counter\(5))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(2),
	datab => \tec|sm_counter\(4),
	datac => \tec|sm_counter\(0),
	datad => \tec|sm_counter\(5),
	combout => \tec|Equal63~1_combout\);

-- Location: LCCOMB_X17_Y11_N10
\tec|Equal119~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal119~0_combout\ = (\tec|sm_counter\(1) & (\tec|Equal64~1_combout\ & (\tec|Equal64~0_combout\ & \tec|Equal63~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(1),
	datab => \tec|Equal64~1_combout\,
	datac => \tec|Equal64~0_combout\,
	datad => \tec|Equal63~1_combout\,
	combout => \tec|Equal119~0_combout\);

-- Location: LCCOMB_X19_Y17_N10
\tec|Equal23~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal23~0_combout\ = (\tec|Equal18~1_combout\ & (\tec|sm_counter\(2) & (!\tec|sm_counter\(5) & \tec|sm_counter\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Equal18~1_combout\,
	datab => \tec|sm_counter\(2),
	datac => \tec|sm_counter\(5),
	datad => \tec|sm_counter\(0),
	combout => \tec|Equal23~0_combout\);

-- Location: LCCOMB_X19_Y17_N0
\tec|Equal133~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal133~0_combout\ = (!\tec|sm_counter\(3) & (\tec|Equal1~2_combout\ & (\tec|sm_counter\(2) & \tec|Equal128~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(3),
	datab => \tec|Equal1~2_combout\,
	datac => \tec|sm_counter\(2),
	datad => \tec|Equal128~1_combout\,
	combout => \tec|Equal133~0_combout\);

-- Location: LCCOMB_X19_Y17_N30
\tec|Equal39~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal39~0_combout\ = (\tec|sm_counter\(1) & (\tec|sm_counter\(0) & (\tec|sm_counter\(5) & !\tec|sm_counter\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(1),
	datab => \tec|sm_counter\(0),
	datac => \tec|sm_counter\(5),
	datad => \tec|sm_counter\(3),
	combout => \tec|Equal39~0_combout\);

-- Location: LCCOMB_X19_Y17_N18
\tec|Selector1~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Selector1~1_combout\ = (!\tec|Equal23~0_combout\ & (!\tec|Equal133~0_combout\ & ((!\tec|Equal7~1_combout\) # (!\tec|Equal39~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000100010001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Equal23~0_combout\,
	datab => \tec|Equal133~0_combout\,
	datac => \tec|Equal39~0_combout\,
	datad => \tec|Equal7~1_combout\,
	combout => \tec|Selector1~1_combout\);

-- Location: LCCOMB_X18_Y16_N24
\tec|Selector1~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Selector1~2_combout\ = (\tec|Selector1~0_combout\ & (\tec|Selector3~4_combout\ & (!\tec|Equal119~0_combout\ & \tec|Selector1~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Selector1~0_combout\,
	datab => \tec|Selector3~4_combout\,
	datac => \tec|Equal119~0_combout\,
	datad => \tec|Selector1~1_combout\,
	combout => \tec|Selector1~2_combout\);

-- Location: LCCOMB_X16_Y16_N0
\tec|Selector1~35\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Selector1~35_combout\ = (\tec|Selector1~7_combout\) # ((\tec|Selector1~12_combout\) # ((\tec|Selector1~34_combout\) # (!\tec|Selector1~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Selector1~7_combout\,
	datab => \tec|Selector1~12_combout\,
	datac => \tec|Selector1~34_combout\,
	datad => \tec|Selector1~2_combout\,
	combout => \tec|Selector1~35_combout\);

-- Location: LCCOMB_X17_Y19_N12
\tec|Equal2~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal2~1_combout\ = (!\tec|sm_counter\(4) & !\tec|sm_counter\(3))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000110011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \tec|sm_counter\(4),
	datad => \tec|sm_counter\(3),
	combout => \tec|Equal2~1_combout\);

-- Location: LCCOMB_X17_Y19_N2
\tec|Equal32~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal32~0_combout\ = (!\tec|sm_counter\(0) & (!\tec|sm_counter\(2) & (!\tec|sm_counter\(1) & \tec|sm_counter\(5))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(0),
	datab => \tec|sm_counter\(2),
	datac => \tec|sm_counter\(1),
	datad => \tec|sm_counter\(5),
	combout => \tec|Equal32~0_combout\);

-- Location: LCCOMB_X21_Y12_N2
\tec|Equal0~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal0~2_combout\ = (!\tec|sm_counter\(2) & !\tec|sm_counter\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \tec|sm_counter\(2),
	datad => \tec|sm_counter\(0),
	combout => \tec|Equal0~2_combout\);

-- Location: LCCOMB_X17_Y19_N10
\tec|Equal2~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal2~0_combout\ = (\tec|sm_counter\(1) & !\tec|sm_counter\(6))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \tec|sm_counter\(1),
	datad => \tec|sm_counter\(6),
	combout => \tec|Equal2~0_combout\);

-- Location: LCCOMB_X21_Y16_N18
\tec|Equal34~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal34~0_combout\ = (\tec|sm_counter\(5) & (\tec|Equal0~2_combout\ & (\tec|Equal2~0_combout\ & \tec|Equal64~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(5),
	datab => \tec|Equal0~2_combout\,
	datac => \tec|Equal2~0_combout\,
	datad => \tec|Equal64~0_combout\,
	combout => \tec|Equal34~0_combout\);

-- Location: LCCOMB_X17_Y19_N28
\tec|Selector3~6\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Selector3~6_combout\ = (\tec|Equal2~1_combout\ & (!\tec|Equal34~0_combout\ & ((!\tec|Equal0~0_combout\) # (!\tec|Equal32~0_combout\)))) # (!\tec|Equal2~1_combout\ & (((!\tec|Equal0~0_combout\)) # (!\tec|Equal32~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001010100111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Equal2~1_combout\,
	datab => \tec|Equal32~0_combout\,
	datac => \tec|Equal0~0_combout\,
	datad => \tec|Equal34~0_combout\,
	combout => \tec|Selector3~6_combout\);

-- Location: LCCOMB_X16_Y17_N24
\tec|Equal36~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal36~0_combout\ = (!\tec|sm_counter\(3) & (\tec|Equal4~0_combout\ & (\tec|sm_counter\(5) & !\tec|sm_counter\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(3),
	datab => \tec|Equal4~0_combout\,
	datac => \tec|sm_counter\(5),
	datad => \tec|sm_counter\(1),
	combout => \tec|Equal36~0_combout\);

-- Location: LCCOMB_X18_Y17_N6
\tec|Equal70~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal70~0_combout\ = (\tec|sm_counter\(2) & (\tec|sm_counter\(1) & !\tec|sm_counter\(0)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100000001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(2),
	datab => \tec|sm_counter\(1),
	datac => \tec|sm_counter\(0),
	combout => \tec|Equal70~0_combout\);

-- Location: LCCOMB_X17_Y10_N10
\tec|Equal112~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal112~0_combout\ = (\tec|sm_counter\(5) & (\tec|Equal64~1_combout\ & (\tec|sm_counter\(4) & \tec|Equal64~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(5),
	datab => \tec|Equal64~1_combout\,
	datac => \tec|sm_counter\(4),
	datad => \tec|Equal64~0_combout\,
	combout => \tec|Equal112~0_combout\);

-- Location: LCCOMB_X21_Y12_N0
\tec|Equal22~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal22~0_combout\ = (\tec|sm_counter\(2) & !\tec|sm_counter\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \tec|sm_counter\(2),
	datad => \tec|sm_counter\(0),
	combout => \tec|Equal22~0_combout\);

-- Location: LCCOMB_X21_Y16_N8
\tec|Equal30~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal30~0_combout\ = (\tec|Equal64~0_combout\ & (\tec|Equal27~0_combout\ & (\tec|Equal2~0_combout\ & \tec|Equal22~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Equal64~0_combout\,
	datab => \tec|Equal27~0_combout\,
	datac => \tec|Equal2~0_combout\,
	datad => \tec|Equal22~0_combout\,
	combout => \tec|Equal30~0_combout\);

-- Location: LCCOMB_X16_Y17_N22
\tec|Selector3~5\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Selector3~5_combout\ = (\tec|Equal70~0_combout\ & (!\tec|Equal112~0_combout\ & ((\tec|sm_counter\(5)) # (!\tec|Equal30~0_combout\)))) # (!\tec|Equal70~0_combout\ & ((\tec|sm_counter\(5)) # ((!\tec|Equal30~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100110001011111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Equal70~0_combout\,
	datab => \tec|sm_counter\(5),
	datac => \tec|Equal112~0_combout\,
	datad => \tec|Equal30~0_combout\,
	combout => \tec|Selector3~5_combout\);

-- Location: LCCOMB_X19_Y17_N12
\tec|Equal24~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal24~4_combout\ = (\tec|sm_counter\(4) & (!\tec|sm_counter\(0) & (\tec|Equal64~0_combout\ & \tec|sm_counter\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(4),
	datab => \tec|sm_counter\(0),
	datac => \tec|Equal64~0_combout\,
	datad => \tec|sm_counter\(3),
	combout => \tec|Equal24~4_combout\);

-- Location: LCCOMB_X19_Y17_N24
\tec|Equal138~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal138~0_combout\ = (!\tec|sm_counter\(0) & \tec|sm_counter\(1))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \tec|sm_counter\(0),
	datad => \tec|sm_counter\(1),
	combout => \tec|Equal138~0_combout\);

-- Location: LCCOMB_X19_Y17_N26
\tec|Equal24~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal24~3_combout\ = (!\tec|sm_counter\(1) & (!\tec|sm_counter\(2) & (!\tec|sm_counter\(5) & !\tec|sm_counter\(6))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(1),
	datab => \tec|sm_counter\(2),
	datac => \tec|sm_counter\(5),
	datad => \tec|sm_counter\(6),
	combout => \tec|Equal24~3_combout\);

-- Location: LCCOMB_X19_Y17_N20
\tec|Selector3~7\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Selector3~7_combout\ = (\tec|Equal24~4_combout\ & (!\tec|Equal24~3_combout\ & ((!\tec|Equal136~1_combout\) # (!\tec|Equal138~0_combout\)))) # (!\tec|Equal24~4_combout\ & (((!\tec|Equal136~1_combout\)) # (!\tec|Equal138~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001001101011111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Equal24~4_combout\,
	datab => \tec|Equal138~0_combout\,
	datac => \tec|Equal24~3_combout\,
	datad => \tec|Equal136~1_combout\,
	combout => \tec|Selector3~7_combout\);

-- Location: LCCOMB_X16_Y17_N10
\tec|Selector3~8\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Selector3~8_combout\ = (\tec|Selector3~6_combout\ & (!\tec|Equal36~0_combout\ & (\tec|Selector3~5_combout\ & \tec|Selector3~7_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Selector3~6_combout\,
	datab => \tec|Equal36~0_combout\,
	datac => \tec|Selector3~5_combout\,
	datad => \tec|Selector3~7_combout\,
	combout => \tec|Selector3~8_combout\);

-- Location: LCCOMB_X18_Y17_N14
\tec|Equal59~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal59~0_combout\ = (\tec|Equal2~4_combout\ & (\tec|Equal27~0_combout\ & (!\tec|sm_counter\(2) & \tec|Equal37~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Equal2~4_combout\,
	datab => \tec|Equal27~0_combout\,
	datac => \tec|sm_counter\(2),
	datad => \tec|Equal37~0_combout\,
	combout => \tec|Equal59~0_combout\);

-- Location: LCCOMB_X18_Y17_N28
\tec|Equal128~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal128~3_combout\ = (!\tec|sm_counter\(3) & \tec|Equal128~1_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(3),
	datad => \tec|Equal128~1_combout\,
	combout => \tec|Equal128~3_combout\);

-- Location: LCCOMB_X18_Y17_N24
\tec|WideOr6~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|WideOr6~2_combout\ = (!\tec|Equal59~0_combout\ & (((!\tec|Equal128~3_combout\) # (!\tec|Equal7~0_combout\)) # (!\tec|sm_counter\(2))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001001100110011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(2),
	datab => \tec|Equal59~0_combout\,
	datac => \tec|Equal7~0_combout\,
	datad => \tec|Equal128~3_combout\,
	combout => \tec|WideOr6~2_combout\);

-- Location: LCCOMB_X17_Y19_N8
\tec|Equal3~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal3~0_combout\ = (\tec|sm_counter\(0) & (\tec|Equal1~0_combout\ & (\tec|Equal64~0_combout\ & \tec|Equal2~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(0),
	datab => \tec|Equal1~0_combout\,
	datac => \tec|Equal64~0_combout\,
	datad => \tec|Equal2~0_combout\,
	combout => \tec|Equal3~0_combout\);

-- Location: LCCOMB_X18_Y16_N8
\tec|WideOr6~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|WideOr6~1_combout\ = (\tec|Equal19~0_combout\ & (!\tec|Equal3~0_combout\ & ((!\tec|Equal8~2_combout\) # (!\tec|Equal37~0_combout\)))) # (!\tec|Equal19~0_combout\ & (((!\tec|Equal8~2_combout\) # (!\tec|Equal37~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000011101110111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Equal19~0_combout\,
	datab => \tec|Equal3~0_combout\,
	datac => \tec|Equal37~0_combout\,
	datad => \tec|Equal8~2_combout\,
	combout => \tec|WideOr6~1_combout\);

-- Location: LCCOMB_X16_Y9_N10
\tec|Equal88~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal88~2_combout\ = (!\tec|sm_counter\(5) & (!\tec|sm_counter\(7) & (\tec|sm_counter\(6) & \tec|Equal24~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(5),
	datab => \tec|sm_counter\(7),
	datac => \tec|sm_counter\(6),
	datad => \tec|Equal24~2_combout\,
	combout => \tec|Equal88~2_combout\);

-- Location: LCCOMB_X16_Y9_N4
\tec|Equal88~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal88~3_combout\ = (\tec|Equal27~0_combout\ & (\tec|Equal88~2_combout\ & (\tec|Equal142~5_combout\ & \tec|Equal142~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Equal27~0_combout\,
	datab => \tec|Equal88~2_combout\,
	datac => \tec|Equal142~5_combout\,
	datad => \tec|Equal142~0_combout\,
	combout => \tec|Equal88~3_combout\);

-- Location: LCCOMB_X16_Y15_N2
\tec|WideOr6~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|WideOr6~0_combout\ = (\tec|Equal77~0_combout\ & (!\tec|Equal76~1_combout\ & ((!\tec|Equal71~0_combout\) # (!\tec|Equal88~3_combout\)))) # (!\tec|Equal77~0_combout\ & (((!\tec|Equal71~0_combout\) # (!\tec|Equal88~3_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000011101110111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Equal77~0_combout\,
	datab => \tec|Equal76~1_combout\,
	datac => \tec|Equal88~3_combout\,
	datad => \tec|Equal71~0_combout\,
	combout => \tec|WideOr6~0_combout\);

-- Location: LCCOMB_X18_Y17_N10
\tec|Equal113~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal113~2_combout\ = (!\tec|sm_counter\(2) & (\tec|sm_counter\(5) & (\tec|sm_counter\(0) & !\tec|sm_counter\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(2),
	datab => \tec|sm_counter\(5),
	datac => \tec|sm_counter\(0),
	datad => \tec|sm_counter\(1),
	combout => \tec|Equal113~2_combout\);

-- Location: LCCOMB_X18_Y17_N8
\tec|Equal128~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal128~2_combout\ = (!\tec|sm_counter\(1) & !\tec|sm_counter\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001100000011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \tec|sm_counter\(1),
	datac => \tec|sm_counter\(0),
	combout => \tec|Equal128~2_combout\);

-- Location: LCCOMB_X18_Y17_N12
\tec|WideOr6~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|WideOr6~3_combout\ = (\tec|Equal113~2_combout\ & (!\tec|Equal113~3_combout\ & ((!\tec|Equal136~1_combout\) # (!\tec|Equal128~2_combout\)))) # (!\tec|Equal113~2_combout\ & (((!\tec|Equal136~1_combout\)) # (!\tec|Equal128~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001001101011111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Equal113~2_combout\,
	datab => \tec|Equal128~2_combout\,
	datac => \tec|Equal113~3_combout\,
	datad => \tec|Equal136~1_combout\,
	combout => \tec|WideOr6~3_combout\);

-- Location: LCCOMB_X18_Y16_N2
\tec|WideOr6~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|WideOr6~4_combout\ = (\tec|WideOr6~2_combout\ & (\tec|WideOr6~1_combout\ & (\tec|WideOr6~0_combout\ & \tec|WideOr6~3_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|WideOr6~2_combout\,
	datab => \tec|WideOr6~1_combout\,
	datac => \tec|WideOr6~0_combout\,
	datad => \tec|WideOr6~3_combout\,
	combout => \tec|WideOr6~4_combout\);

-- Location: LCCOMB_X18_Y16_N22
\tec|WideNor0~28\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|WideNor0~28_combout\ = (\tec|Equal64~3_combout\ & (!\tec|sm_counter\(2) & ((\tec|Equal7~0_combout\) # (\tec|Equal1~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Equal64~3_combout\,
	datab => \tec|Equal7~0_combout\,
	datac => \tec|Equal1~2_combout\,
	datad => \tec|sm_counter\(2),
	combout => \tec|WideNor0~28_combout\);

-- Location: LCCOMB_X16_Y17_N2
\tec|WideNor0~34\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|WideNor0~34_combout\ = (\tec|sm_counter\(0) & (\tec|sm_counter\(3) & (\tec|sm_counter\(5) & \tec|Equal7~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(0),
	datab => \tec|sm_counter\(3),
	datac => \tec|sm_counter\(5),
	datad => \tec|Equal7~1_combout\,
	combout => \tec|WideNor0~34_combout\);

-- Location: LCCOMB_X18_Y16_N12
\tec|WideNor0~29\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|WideNor0~29_combout\ = (((\tec|WideNor0~28_combout\) # (\tec|WideNor0~34_combout\)) # (!\tec|WideOr6~4_combout\)) # (!\tec|Selector3~8_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111110111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Selector3~8_combout\,
	datab => \tec|WideOr6~4_combout\,
	datac => \tec|WideNor0~28_combout\,
	datad => \tec|WideNor0~34_combout\,
	combout => \tec|WideNor0~29_combout\);

-- Location: LCCOMB_X19_Y12_N2
\tec|WideNor0~17\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|WideNor0~17_combout\ = (\tec|sm_counter\(1) & (!\tec|sm_counter\(7) & \tec|sm_counter\(6))) # (!\tec|sm_counter\(1) & (\tec|sm_counter\(7) & !\tec|sm_counter\(6)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000110000110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \tec|sm_counter\(1),
	datac => \tec|sm_counter\(7),
	datad => \tec|sm_counter\(6),
	combout => \tec|WideNor0~17_combout\);

-- Location: LCCOMB_X19_Y12_N30
\tec|WideNor0~18\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|WideNor0~18_combout\ = (!\tec|sm_counter\(5) & (\tec|WideNor0~17_combout\ & (!\tec|sm_counter\(2) & \tec|Equal10~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000010000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(5),
	datab => \tec|WideNor0~17_combout\,
	datac => \tec|sm_counter\(2),
	datad => \tec|Equal10~0_combout\,
	combout => \tec|WideNor0~18_combout\);

-- Location: LCCOMB_X19_Y12_N12
\tec|WideNor0~21\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|WideNor0~21_combout\ = (\tec|sm_counter\(4) & (((!\tec|sm_counter\(2) & \tec|sm_counter\(3))) # (!\tec|sm_counter\(5)))) # (!\tec|sm_counter\(4) & (\tec|sm_counter\(2) & (!\tec|sm_counter\(3) & !\tec|sm_counter\(5))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000010101110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(4),
	datab => \tec|sm_counter\(2),
	datac => \tec|sm_counter\(3),
	datad => \tec|sm_counter\(5),
	combout => \tec|WideNor0~21_combout\);

-- Location: LCCOMB_X19_Y12_N14
\tec|WideNor0~22\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|WideNor0~22_combout\ = (!\tec|sm_counter\(1) & \tec|WideNor0~21_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \tec|sm_counter\(1),
	datad => \tec|WideNor0~21_combout\,
	combout => \tec|WideNor0~22_combout\);

-- Location: LCCOMB_X19_Y12_N18
\tec|WideNor0~20\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|WideNor0~20_combout\ = (\tec|sm_counter\(4) & (\tec|sm_counter\(2) & (\tec|sm_counter\(3) & !\tec|sm_counter\(5)))) # (!\tec|sm_counter\(4) & (!\tec|sm_counter\(2) & (!\tec|sm_counter\(3) & \tec|sm_counter\(5))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000110000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(4),
	datab => \tec|sm_counter\(2),
	datac => \tec|sm_counter\(3),
	datad => \tec|sm_counter\(5),
	combout => \tec|WideNor0~20_combout\);

-- Location: LCCOMB_X19_Y12_N16
\tec|WideNor0~23\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|WideNor0~23_combout\ = (!\tec|sm_counter\(7) & ((\tec|sm_counter\(6) & (\tec|WideNor0~22_combout\ & \tec|WideNor0~20_combout\)) # (!\tec|sm_counter\(6) & ((\tec|WideNor0~22_combout\) # (\tec|WideNor0~20_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000110100000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(6),
	datab => \tec|WideNor0~22_combout\,
	datac => \tec|sm_counter\(7),
	datad => \tec|WideNor0~20_combout\,
	combout => \tec|WideNor0~23_combout\);

-- Location: LCCOMB_X19_Y12_N0
\tec|WideNor0~19\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|WideNor0~19_combout\ = (\tec|sm_counter\(5) & ((\tec|sm_counter\(2) & ((\tec|sm_counter\(3)))) # (!\tec|sm_counter\(2) & (\tec|sm_counter\(4) & !\tec|sm_counter\(3)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(4),
	datab => \tec|sm_counter\(2),
	datac => \tec|sm_counter\(3),
	datad => \tec|sm_counter\(5),
	combout => \tec|WideNor0~19_combout\);

-- Location: LCCOMB_X19_Y12_N20
\tec|WideNor0~33\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|WideNor0~33_combout\ = (\tec|sm_counter\(6) & (\tec|sm_counter\(1) & (!\tec|sm_counter\(7) & \tec|WideNor0~19_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(6),
	datab => \tec|sm_counter\(1),
	datac => \tec|sm_counter\(7),
	datad => \tec|WideNor0~19_combout\,
	combout => \tec|WideNor0~33_combout\);

-- Location: LCCOMB_X19_Y12_N26
\tec|WideNor0~24\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|WideNor0~24_combout\ = (\tec|sm_counter\(0) & ((\tec|WideNor0~18_combout\) # ((\tec|WideNor0~23_combout\) # (\tec|WideNor0~33_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|WideNor0~18_combout\,
	datab => \tec|WideNor0~23_combout\,
	datac => \tec|sm_counter\(0),
	datad => \tec|WideNor0~33_combout\,
	combout => \tec|WideNor0~24_combout\);

-- Location: LCCOMB_X21_Y9_N2
\tec|WideNor0~25\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|WideNor0~25_combout\ = (\tec|WideNor0~24_combout\ & (\tec|Equal142~0_combout\ & (\tec|Equal24~2_combout\ & \tec|Equal142~5_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|WideNor0~24_combout\,
	datab => \tec|Equal142~0_combout\,
	datac => \tec|Equal24~2_combout\,
	datad => \tec|Equal142~5_combout\,
	combout => \tec|WideNor0~25_combout\);

-- Location: LCCOMB_X17_Y13_N28
\tec|WideNor0~32\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|WideNor0~32_combout\ = (\tec|sm_counter\(5) & (\tec|sm_counter\(0) & (\tec|Equal16~0_combout\ & \tec|Equal64~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(5),
	datab => \tec|sm_counter\(0),
	datac => \tec|Equal16~0_combout\,
	datad => \tec|Equal64~0_combout\,
	combout => \tec|WideNor0~32_combout\);

-- Location: LCCOMB_X17_Y13_N22
\tec|WideNor0~16\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|WideNor0~16_combout\ = (\tec|WideNor0~32_combout\) # ((\tec|sm_counter\(2) & (\tec|sm_counter\(0) & \tec|Equal56~3_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111110000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(2),
	datab => \tec|sm_counter\(0),
	datac => \tec|Equal56~3_combout\,
	datad => \tec|WideNor0~32_combout\,
	combout => \tec|WideNor0~16_combout\);

-- Location: LCCOMB_X17_Y13_N26
\tec|WideNor0~26\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|WideNor0~26_combout\ = (\tec|WideNor0~25_combout\) # ((\tec|Equal63~0_combout\) # ((\tec|WideNor0~16_combout\) # (\tec|Equal43~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|WideNor0~25_combout\,
	datab => \tec|Equal63~0_combout\,
	datac => \tec|WideNor0~16_combout\,
	datad => \tec|Equal43~0_combout\,
	combout => \tec|WideNor0~26_combout\);

-- Location: LCCOMB_X16_Y15_N30
\tec|WideNor0~11\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|WideNor0~11_combout\ = (\tec|Equal7~2_combout\ & ((\tec|Equal76~1_combout\) # ((\tec|Equal89~0_combout\)))) # (!\tec|Equal7~2_combout\ & (((\tec|Equal77~0_combout\ & \tec|Equal89~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Equal7~2_combout\,
	datab => \tec|Equal76~1_combout\,
	datac => \tec|Equal77~0_combout\,
	datad => \tec|Equal89~0_combout\,
	combout => \tec|WideNor0~11_combout\);

-- Location: LCCOMB_X18_Y14_N2
\tec|WideNor0~10\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|WideNor0~10_combout\ = (\tec|Equal64~3_combout\ & (((\tec|Equal69~0_combout\) # (\tec|Equal71~0_combout\)))) # (!\tec|Equal64~3_combout\ & (\tec|Equal80~0_combout\ & ((\tec|Equal69~0_combout\) # (\tec|Equal71~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111011100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Equal64~3_combout\,
	datab => \tec|Equal80~0_combout\,
	datac => \tec|Equal69~0_combout\,
	datad => \tec|Equal71~0_combout\,
	combout => \tec|WideNor0~10_combout\);

-- Location: LCCOMB_X18_Y14_N14
\tec|WideNor0~9\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|WideNor0~9_combout\ = (!\tec|sm_counter\(2) & (\tec|Equal80~0_combout\ & ((\tec|Equal7~0_combout\) # (\tec|Equal1~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011000000100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Equal7~0_combout\,
	datab => \tec|sm_counter\(2),
	datac => \tec|Equal80~0_combout\,
	datad => \tec|Equal1~2_combout\,
	combout => \tec|WideNor0~9_combout\);

-- Location: LCCOMB_X18_Y14_N10
\tec|WideNor0~8\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|WideNor0~8_combout\ = (\tec|sm_counter\(6) & (\tec|sm_counter\(0) & \tec|Equal8~1_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \tec|sm_counter\(6),
	datac => \tec|sm_counter\(0),
	datad => \tec|Equal8~1_combout\,
	combout => \tec|WideNor0~8_combout\);

-- Location: LCCOMB_X18_Y14_N4
\tec|WideNor0~12\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|WideNor0~12_combout\ = (\tec|WideNor0~11_combout\) # ((\tec|WideNor0~10_combout\) # ((\tec|WideNor0~9_combout\) # (\tec|WideNor0~8_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|WideNor0~11_combout\,
	datab => \tec|WideNor0~10_combout\,
	datac => \tec|WideNor0~9_combout\,
	datad => \tec|WideNor0~8_combout\,
	combout => \tec|WideNor0~12_combout\);

-- Location: LCCOMB_X16_Y14_N24
\tec|WideNor0~31\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|WideNor0~31_combout\ = (\tec|sm_counter\(0) & (\tec|sm_counter\(5) & \tec|Equal18~1_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(0),
	datab => \tec|sm_counter\(5),
	datad => \tec|Equal18~1_combout\,
	combout => \tec|WideNor0~31_combout\);

-- Location: LCCOMB_X17_Y14_N26
\tec|WideNor0~15\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|WideNor0~15_combout\ = (\tec|WideNor0~31_combout\) # ((\tec|Equal96~0_combout\ & ((\tec|Equal69~0_combout\) # (\tec|Equal71~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101011101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|WideNor0~31_combout\,
	datab => \tec|Equal69~0_combout\,
	datac => \tec|Equal96~0_combout\,
	datad => \tec|Equal71~0_combout\,
	combout => \tec|WideNor0~15_combout\);

-- Location: LCCOMB_X17_Y13_N12
\tec|WideNor0~13\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|WideNor0~13_combout\ = (\tec|Equal76~1_combout\ & ((\tec|Equal37~1_combout\) # ((\tec|Equal37~0_combout\ & \tec|Equal74~1_combout\)))) # (!\tec|Equal76~1_combout\ & (\tec|Equal37~0_combout\ & ((\tec|Equal74~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Equal76~1_combout\,
	datab => \tec|Equal37~0_combout\,
	datac => \tec|Equal37~1_combout\,
	datad => \tec|Equal74~1_combout\,
	combout => \tec|WideNor0~13_combout\);

-- Location: LCCOMB_X17_Y19_N0
\tec|Equal26~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal26~0_combout\ = (!\tec|sm_counter\(0) & (!\tec|sm_counter\(2) & !\tec|sm_counter\(5)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(0),
	datac => \tec|sm_counter\(2),
	datad => \tec|sm_counter\(5),
	combout => \tec|Equal26~0_combout\);

-- Location: LCCOMB_X17_Y19_N14
\tec|Equal2~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal2~2_combout\ = (\tec|Equal2~0_combout\ & (\tec|Equal26~0_combout\ & (\tec|Equal64~0_combout\ & \tec|Equal2~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Equal2~0_combout\,
	datab => \tec|Equal26~0_combout\,
	datac => \tec|Equal64~0_combout\,
	datad => \tec|Equal2~1_combout\,
	combout => \tec|Equal2~2_combout\);

-- Location: LCCOMB_X17_Y14_N8
\tec|WideNor0~14\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|WideNor0~14_combout\ = (\tec|WideNor0~13_combout\) # ((\tec|Equal2~2_combout\) # ((\tec|Equal99~2_combout\) # (\tec|Equal97~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|WideNor0~13_combout\,
	datab => \tec|Equal2~2_combout\,
	datac => \tec|Equal99~2_combout\,
	datad => \tec|Equal97~2_combout\,
	combout => \tec|WideNor0~14_combout\);

-- Location: LCCOMB_X18_Y14_N22
\tec|WideNor0~27\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|WideNor0~27_combout\ = (\tec|WideNor0~26_combout\) # ((\tec|WideNor0~12_combout\) # ((\tec|WideNor0~15_combout\) # (\tec|WideNor0~14_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|WideNor0~26_combout\,
	datab => \tec|WideNor0~12_combout\,
	datac => \tec|WideNor0~15_combout\,
	datad => \tec|WideNor0~14_combout\,
	combout => \tec|WideNor0~27_combout\);

-- Location: LCCOMB_X18_Y16_N26
\tec|dio~41\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|dio~41_combout\ = (\tec|Equal89~0_combout\ & (!\tec|Equal37~0_combout\ & ((!\tec|Equal10~0_combout\) # (!\tec|Equal3~0_combout\)))) # (!\tec|Equal89~0_combout\ & (((!\tec|Equal10~0_combout\)) # (!\tec|Equal3~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001001101011111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Equal89~0_combout\,
	datab => \tec|Equal3~0_combout\,
	datac => \tec|Equal37~0_combout\,
	datad => \tec|Equal10~0_combout\,
	combout => \tec|dio~41_combout\);

-- Location: LCCOMB_X16_Y15_N20
\tec|dio~39\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|dio~39_combout\ = ((\tec|sm_counter\(3) & (!\tec|Equal77~0_combout\)) # (!\tec|sm_counter\(3) & ((!\tec|Equal7~2_combout\)))) # (!\tec|Equal7~1_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100011111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Equal77~0_combout\,
	datab => \tec|sm_counter\(3),
	datac => \tec|Equal7~2_combout\,
	datad => \tec|Equal7~1_combout\,
	combout => \tec|dio~39_combout\);

-- Location: LCCOMB_X18_Y14_N26
\tec|Equal9~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal9~0_combout\ = (\tec|sm_counter\(0) & (!\tec|sm_counter\(6) & (!\tec|sm_counter\(5) & \tec|Equal8~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(0),
	datab => \tec|sm_counter\(6),
	datac => \tec|sm_counter\(5),
	datad => \tec|Equal8~1_combout\,
	combout => \tec|Equal9~0_combout\);

-- Location: LCCOMB_X18_Y16_N16
\tec|dio~40\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|dio~40_combout\ = (\tec|dio~39_combout\ & (!\tec|Equal9~0_combout\ & ((!\tec|Equal2~1_combout\) # (!\tec|Equal3~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|dio~39_combout\,
	datab => \tec|Equal3~0_combout\,
	datac => \tec|Equal9~0_combout\,
	datad => \tec|Equal2~1_combout\,
	combout => \tec|dio~40_combout\);

-- Location: LCCOMB_X17_Y19_N22
\tec|Equal88~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal88~4_combout\ = (\tec|sm_counter\(6) & (\tec|sm_counter\(4) & (\tec|Equal64~0_combout\ & \tec|sm_counter\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(6),
	datab => \tec|sm_counter\(4),
	datac => \tec|Equal64~0_combout\,
	datad => \tec|sm_counter\(3),
	combout => \tec|Equal88~4_combout\);

-- Location: LCCOMB_X17_Y19_N18
\tec|dio~42\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|dio~42_combout\ = (\tec|Equal117~0_combout\ & (!\tec|Equal88~4_combout\ & ((!\tec|Equal27~0_combout\) # (!\tec|Equal3~0_combout\)))) # (!\tec|Equal117~0_combout\ & (((!\tec|Equal27~0_combout\)) # (!\tec|Equal3~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001001101011111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Equal117~0_combout\,
	datab => \tec|Equal3~0_combout\,
	datac => \tec|Equal88~4_combout\,
	datad => \tec|Equal27~0_combout\,
	combout => \tec|dio~42_combout\);

-- Location: LCCOMB_X19_Y17_N22
\tec|Equal128~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal128~4_combout\ = (!\tec|sm_counter\(3) & (!\tec|sm_counter\(2) & \tec|Equal128~1_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000010100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(3),
	datac => \tec|sm_counter\(2),
	datad => \tec|Equal128~1_combout\,
	combout => \tec|Equal128~4_combout\);

-- Location: LCCOMB_X18_Y16_N4
\tec|dio~43\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|dio~43_combout\ = (\tec|dio~42_combout\ & (((!\tec|Equal7~0_combout\ & !\tec|Equal1~2_combout\)) # (!\tec|Equal128~4_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|dio~42_combout\,
	datab => \tec|Equal7~0_combout\,
	datac => \tec|Equal1~2_combout\,
	datad => \tec|Equal128~4_combout\,
	combout => \tec|dio~43_combout\);

-- Location: LCCOMB_X16_Y17_N12
\tec|dio~46\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|dio~46_combout\ = (\tec|sm_counter\(0) & ((!\tec|sm_counter\(5)))) # (!\tec|sm_counter\(0) & (\tec|sm_counter\(6) & \tec|sm_counter\(5)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100101001001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(0),
	datab => \tec|sm_counter\(6),
	datac => \tec|sm_counter\(5),
	combout => \tec|dio~46_combout\);

-- Location: LCCOMB_X16_Y17_N20
\tec|dio~16\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|dio~16_combout\ = (\tec|Equal0~3_combout\ & (!\tec|Equal64~3_combout\ & ((!\tec|Equal30~0_combout\) # (!\tec|sm_counter\(5))))) # (!\tec|Equal0~3_combout\ & (((!\tec|Equal30~0_combout\) # (!\tec|sm_counter\(5)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000011101110111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Equal0~3_combout\,
	datab => \tec|Equal64~3_combout\,
	datac => \tec|sm_counter\(5),
	datad => \tec|Equal30~0_combout\,
	combout => \tec|dio~16_combout\);

-- Location: LCCOMB_X16_Y17_N30
\tec|dio~17\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|dio~17_combout\ = (\tec|dio~16_combout\ & ((\tec|dio~46_combout\ $ (\tec|sm_counter\(5))) # (!\tec|Equal8~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|dio~46_combout\,
	datab => \tec|sm_counter\(5),
	datac => \tec|Equal8~1_combout\,
	datad => \tec|dio~16_combout\,
	combout => \tec|dio~17_combout\);

-- Location: LCCOMB_X16_Y17_N8
\tec|dio~18\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|dio~18_combout\ = (\tec|dio~17_combout\ & (((!\tec|sm_counter\(3) & \tec|sm_counter\(5))) # (!\tec|Equal4~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111001100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(3),
	datab => \tec|Equal4~0_combout\,
	datac => \tec|sm_counter\(5),
	datad => \tec|dio~17_combout\,
	combout => \tec|dio~18_combout\);

-- Location: LCCOMB_X18_Y14_N8
\tec|Equal66~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal66~0_combout\ = (!\tec|sm_counter\(0) & (!\tec|sm_counter\(2) & \tec|sm_counter\(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000010100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(0),
	datac => \tec|sm_counter\(2),
	datad => \tec|sm_counter\(1),
	combout => \tec|Equal66~0_combout\);

-- Location: LCCOMB_X17_Y10_N6
\tec|dio~21\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|dio~21_combout\ = ((!\tec|Equal66~0_combout\ & (!\tec|Equal68~0_combout\ & !\tec|Equal0~3_combout\))) # (!\tec|Equal80~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010101010111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Equal80~0_combout\,
	datab => \tec|Equal66~0_combout\,
	datac => \tec|Equal68~0_combout\,
	datad => \tec|Equal0~3_combout\,
	combout => \tec|dio~21_combout\);

-- Location: LCCOMB_X17_Y10_N18
\tec|dio~19\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|dio~19_combout\ = (\tec|sm_counter\(5)) # ((\tec|sm_counter\(0)) # ((!\tec|Equal76~1_combout\ & !\tec|Equal74~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101011111011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(5),
	datab => \tec|Equal76~1_combout\,
	datac => \tec|sm_counter\(0),
	datad => \tec|Equal74~1_combout\,
	combout => \tec|dio~19_combout\);

-- Location: LCCOMB_X17_Y10_N8
\tec|dio~22\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|dio~22_combout\ = (\tec|Equal88~3_combout\ & (((!\tec|Equal0~3_combout\ & !\tec|Equal70~0_combout\)))) # (!\tec|Equal88~3_combout\ & (((!\tec|Equal70~0_combout\)) # (!\tec|Equal80~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000010100111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Equal80~0_combout\,
	datab => \tec|Equal0~3_combout\,
	datac => \tec|Equal88~3_combout\,
	datad => \tec|Equal70~0_combout\,
	combout => \tec|dio~22_combout\);

-- Location: LCCOMB_X17_Y10_N28
\tec|dio~20\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|dio~20_combout\ = ((!\tec|Equal70~0_combout\ & (!\tec|Equal66~0_combout\ & !\tec|Equal68~0_combout\))) # (!\tec|Equal64~3_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Equal70~0_combout\,
	datab => \tec|Equal66~0_combout\,
	datac => \tec|Equal68~0_combout\,
	datad => \tec|Equal64~3_combout\,
	combout => \tec|dio~20_combout\);

-- Location: LCCOMB_X17_Y10_N26
\tec|dio~23\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|dio~23_combout\ = (\tec|dio~21_combout\ & (\tec|dio~19_combout\ & (\tec|dio~22_combout\ & \tec|dio~20_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|dio~21_combout\,
	datab => \tec|dio~19_combout\,
	datac => \tec|dio~22_combout\,
	datad => \tec|dio~20_combout\,
	combout => \tec|dio~23_combout\);

-- Location: LCCOMB_X17_Y10_N30
\tec|Equal122~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal122~0_combout\ = (\tec|sm_counter\(5) & (\tec|Equal27~0_combout\ & (\tec|Equal64~0_combout\ & \tec|sm_counter\(6))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(5),
	datab => \tec|Equal27~0_combout\,
	datac => \tec|Equal64~0_combout\,
	datad => \tec|sm_counter\(6),
	combout => \tec|Equal122~0_combout\);

-- Location: LCCOMB_X17_Y10_N24
\tec|dio~26\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|dio~26_combout\ = ((!\tec|Equal66~0_combout\ & (!\tec|Equal68~0_combout\ & !\tec|Equal70~0_combout\))) # (!\tec|Equal122~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010101010111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Equal122~0_combout\,
	datab => \tec|Equal66~0_combout\,
	datac => \tec|Equal68~0_combout\,
	datad => \tec|Equal70~0_combout\,
	combout => \tec|dio~26_combout\);

-- Location: LCCOMB_X17_Y14_N22
\tec|dio~47\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|dio~47_combout\ = (!\tec|sm_counter\(0) & (\tec|sm_counter\(1) $ (\tec|sm_counter\(2))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000010101010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(0),
	datac => \tec|sm_counter\(1),
	datad => \tec|sm_counter\(2),
	combout => \tec|dio~47_combout\);

-- Location: LCCOMB_X17_Y10_N4
\tec|dio~24\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|dio~24_combout\ = (\tec|Equal112~0_combout\ & ((\tec|dio~47_combout\) # ((\tec|Equal0~3_combout\)))) # (!\tec|Equal112~0_combout\ & (\tec|dio~47_combout\ & (\tec|Equal88~3_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101011001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Equal112~0_combout\,
	datab => \tec|dio~47_combout\,
	datac => \tec|Equal88~3_combout\,
	datad => \tec|Equal0~3_combout\,
	combout => \tec|dio~24_combout\);

-- Location: LCCOMB_X17_Y10_N14
\tec|dio~48\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|dio~48_combout\ = (!\tec|dio~24_combout\ & (((\tec|sm_counter\(0)) # (!\tec|Equal74~1_combout\)) # (!\tec|sm_counter\(5))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011000100110011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(5),
	datab => \tec|dio~24_combout\,
	datac => \tec|sm_counter\(0),
	datad => \tec|Equal74~1_combout\,
	combout => \tec|dio~48_combout\);

-- Location: LCCOMB_X21_Y16_N22
\tec|Equal18~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal18~2_combout\ = (!\tec|sm_counter\(5) & (\tec|Equal19~0_combout\ & (\tec|Equal2~0_combout\ & \tec|Equal64~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(5),
	datab => \tec|Equal19~0_combout\,
	datac => \tec|Equal2~0_combout\,
	datad => \tec|Equal64~0_combout\,
	combout => \tec|Equal18~2_combout\);

-- Location: LCCOMB_X21_Y16_N0
\tec|Equal10~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal10~1_combout\ = (\tec|Equal2~0_combout\ & (\tec|Equal10~0_combout\ & (\tec|Equal26~0_combout\ & \tec|Equal64~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Equal2~0_combout\,
	datab => \tec|Equal10~0_combout\,
	datac => \tec|Equal26~0_combout\,
	datad => \tec|Equal64~0_combout\,
	combout => \tec|Equal10~1_combout\);

-- Location: LCCOMB_X21_Y16_N26
\tec|dio~25\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|dio~25_combout\ = (!\tec|Equal10~1_combout\ & (((!\tec|Equal22~0_combout\ & !\tec|Equal0~2_combout\)) # (!\tec|Equal18~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000011111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Equal22~0_combout\,
	datab => \tec|Equal0~2_combout\,
	datac => \tec|Equal18~2_combout\,
	datad => \tec|Equal10~1_combout\,
	combout => \tec|dio~25_combout\);

-- Location: LCCOMB_X17_Y10_N2
\tec|dio~27\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|dio~27_combout\ = (\tec|dio~23_combout\ & (\tec|dio~26_combout\ & (\tec|dio~48_combout\ & \tec|dio~25_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|dio~23_combout\,
	datab => \tec|dio~26_combout\,
	datac => \tec|dio~48_combout\,
	datad => \tec|dio~25_combout\,
	combout => \tec|dio~27_combout\);

-- Location: LCCOMB_X18_Y17_N4
\tec|Equal54~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal54~2_combout\ = (\tec|sm_counter\(2) & (\tec|sm_counter\(5) & (!\tec|sm_counter\(0) & \tec|Equal18~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(2),
	datab => \tec|sm_counter\(5),
	datac => \tec|sm_counter\(0),
	datad => \tec|Equal18~1_combout\,
	combout => \tec|Equal54~2_combout\);

-- Location: LCCOMB_X18_Y17_N2
\tec|dio~36\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|dio~36_combout\ = (!\tec|Equal54~2_combout\ & (((!\tec|Equal70~0_combout\ & !\tec|Equal68~0_combout\)) # (!\tec|Equal128~3_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000100001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Equal70~0_combout\,
	datab => \tec|Equal68~0_combout\,
	datac => \tec|Equal54~2_combout\,
	datad => \tec|Equal128~3_combout\,
	combout => \tec|dio~36_combout\);

-- Location: LCCOMB_X19_Y17_N8
\tec|Equal28~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal28~0_combout\ = (!\tec|sm_counter\(1) & (\tec|sm_counter\(2) & (!\tec|sm_counter\(5) & !\tec|sm_counter\(6))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(1),
	datab => \tec|sm_counter\(2),
	datac => \tec|sm_counter\(5),
	datad => \tec|sm_counter\(6),
	combout => \tec|Equal28~0_combout\);

-- Location: LCCOMB_X19_Y17_N2
\tec|dio~35\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|dio~35_combout\ = (\tec|Equal24~4_combout\ & (!\tec|Equal28~0_combout\ & ((!\tec|Equal128~4_combout\) # (!\tec|Equal138~0_combout\)))) # (!\tec|Equal24~4_combout\ & (((!\tec|Equal128~4_combout\)) # (!\tec|Equal138~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001001101011111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Equal24~4_combout\,
	datab => \tec|Equal138~0_combout\,
	datac => \tec|Equal28~0_combout\,
	datad => \tec|Equal128~4_combout\,
	combout => \tec|dio~35_combout\);

-- Location: LCCOMB_X18_Y17_N0
\tec|dio~34\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|dio~34_combout\ = (\tec|Equal88~4_combout\ & (!\tec|Equal32~0_combout\ & ((!\tec|Equal128~4_combout\) # (!\tec|Equal128~2_combout\)))) # (!\tec|Equal88~4_combout\ & (((!\tec|Equal128~4_combout\) # (!\tec|Equal128~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000011101110111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Equal88~4_combout\,
	datab => \tec|Equal32~0_combout\,
	datac => \tec|Equal128~2_combout\,
	datad => \tec|Equal128~4_combout\,
	combout => \tec|dio~34_combout\);

-- Location: LCCOMB_X21_Y16_N2
\tec|Equal52~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal52~0_combout\ = (\tec|sm_counter\(5) & (!\tec|sm_counter\(0) & (\tec|sm_counter\(2) & \tec|Equal16~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(5),
	datab => \tec|sm_counter\(0),
	datac => \tec|sm_counter\(2),
	datad => \tec|Equal16~1_combout\,
	combout => \tec|Equal52~0_combout\);

-- Location: LCCOMB_X19_Y17_N4
\tec|dio~37\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|dio~37_combout\ = (\tec|dio~36_combout\ & (\tec|dio~35_combout\ & (\tec|dio~34_combout\ & !\tec|Equal52~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|dio~36_combout\,
	datab => \tec|dio~35_combout\,
	datac => \tec|dio~34_combout\,
	datad => \tec|Equal52~0_combout\,
	combout => \tec|dio~37_combout\);

-- Location: LCCOMB_X21_Y16_N20
\tec|dio~31\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|dio~31_combout\ = (\tec|sm_counter\(5) & ((\tec|Equal18~1_combout\) # ((\tec|Equal27~0_combout\ & \tec|Equal2~4_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Equal18~1_combout\,
	datab => \tec|Equal27~0_combout\,
	datac => \tec|Equal2~4_combout\,
	datad => \tec|sm_counter\(5),
	combout => \tec|dio~31_combout\);

-- Location: LCCOMB_X21_Y16_N30
\tec|dio~32\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|dio~32_combout\ = (\tec|Equal0~2_combout\ & (((!\tec|Equal56~3_combout\ & !\tec|dio~31_combout\)))) # (!\tec|Equal0~2_combout\ & (((!\tec|Equal56~3_combout\)) # (!\tec|Equal22~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001001100011111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Equal22~0_combout\,
	datab => \tec|Equal0~2_combout\,
	datac => \tec|Equal56~3_combout\,
	datad => \tec|dio~31_combout\,
	combout => \tec|dio~32_combout\);

-- Location: LCCOMB_X21_Y16_N28
\tec|dio~50\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|dio~50_combout\ = (\tec|sm_counter\(0)) # (!\tec|Equal96~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111111001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \tec|sm_counter\(0),
	datac => \tec|Equal96~0_combout\,
	combout => \tec|dio~50_combout\);

-- Location: LCCOMB_X17_Y13_N30
\tec|dio~49\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|dio~49_combout\ = (!\tec|sm_counter\(2) & (!\tec|sm_counter\(5) & (\tec|Equal16~0_combout\ & \tec|Equal64~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(2),
	datab => \tec|sm_counter\(5),
	datac => \tec|Equal16~0_combout\,
	datad => \tec|Equal64~0_combout\,
	combout => \tec|dio~49_combout\);

-- Location: LCCOMB_X17_Y13_N4
\tec|dio~28\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|dio~28_combout\ = (\tec|sm_counter\(0)) # ((!\tec|dio~49_combout\ & ((!\tec|Equal76~1_combout\) # (!\tec|sm_counter\(5)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110111011101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|dio~49_combout\,
	datab => \tec|sm_counter\(0),
	datac => \tec|sm_counter\(5),
	datad => \tec|Equal76~1_combout\,
	combout => \tec|dio~28_combout\);

-- Location: LCCOMB_X21_Y9_N8
\tec|Equal20~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal20~0_combout\ = (\tec|sm_counter\(2) & (!\tec|sm_counter\(0) & (!\tec|sm_counter\(7) & !\tec|sm_counter\(5))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(2),
	datab => \tec|sm_counter\(0),
	datac => \tec|sm_counter\(7),
	datad => \tec|sm_counter\(5),
	combout => \tec|Equal20~0_combout\);

-- Location: LCCOMB_X21_Y9_N26
\tec|Equal20~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal20~1_combout\ = (\tec|Equal24~2_combout\ & \tec|Equal16~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \tec|Equal24~2_combout\,
	datad => \tec|Equal16~0_combout\,
	combout => \tec|Equal20~1_combout\);

-- Location: LCCOMB_X21_Y9_N4
\tec|Equal20~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal20~2_combout\ = (\tec|Equal142~5_combout\ & (\tec|Equal20~0_combout\ & (\tec|Equal20~1_combout\ & \tec|Equal142~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Equal142~5_combout\,
	datab => \tec|Equal20~0_combout\,
	datac => \tec|Equal20~1_combout\,
	datad => \tec|Equal142~0_combout\,
	combout => \tec|Equal20~2_combout\);

-- Location: LCCOMB_X21_Y16_N12
\tec|dio~29\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|dio~29_combout\ = (!\tec|Equal20~2_combout\ & (((!\tec|Equal27~0_combout\) # (!\tec|Equal26~0_combout\)) # (!\tec|Equal2~4_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Equal2~4_combout\,
	datab => \tec|Equal26~0_combout\,
	datac => \tec|Equal27~0_combout\,
	datad => \tec|Equal20~2_combout\,
	combout => \tec|dio~29_combout\);

-- Location: LCCOMB_X21_Y16_N24
\tec|Equal48~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal48~0_combout\ = (\tec|sm_counter\(5) & (!\tec|sm_counter\(0) & (!\tec|sm_counter\(2) & \tec|Equal16~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|sm_counter\(5),
	datab => \tec|sm_counter\(0),
	datac => \tec|sm_counter\(2),
	datad => \tec|Equal16~1_combout\,
	combout => \tec|Equal48~0_combout\);

-- Location: LCCOMB_X21_Y16_N10
\tec|dio~30\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|dio~30_combout\ = (\tec|dio~29_combout\ & (!\tec|Equal48~0_combout\ & ((!\tec|Equal10~0_combout\) # (!\tec|Equal34~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001000100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|dio~29_combout\,
	datab => \tec|Equal48~0_combout\,
	datac => \tec|Equal34~0_combout\,
	datad => \tec|Equal10~0_combout\,
	combout => \tec|dio~30_combout\);

-- Location: LCCOMB_X21_Y16_N16
\tec|dio~33\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|dio~33_combout\ = (\tec|dio~32_combout\ & (\tec|dio~50_combout\ & (\tec|dio~28_combout\ & \tec|dio~30_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|dio~32_combout\,
	datab => \tec|dio~50_combout\,
	datac => \tec|dio~28_combout\,
	datad => \tec|dio~30_combout\,
	combout => \tec|dio~33_combout\);

-- Location: LCCOMB_X18_Y16_N6
\tec|dio~38\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|dio~38_combout\ = (\tec|dio~18_combout\ & (\tec|dio~27_combout\ & (\tec|dio~37_combout\ & \tec|dio~33_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|dio~18_combout\,
	datab => \tec|dio~27_combout\,
	datac => \tec|dio~37_combout\,
	datad => \tec|dio~33_combout\,
	combout => \tec|dio~38_combout\);

-- Location: LCCOMB_X18_Y16_N30
\tec|dio~44\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|dio~44_combout\ = (\tec|dio~41_combout\ & (\tec|dio~40_combout\ & (\tec|dio~43_combout\ & \tec|dio~38_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|dio~41_combout\,
	datab => \tec|dio~40_combout\,
	datac => \tec|dio~43_combout\,
	datad => \tec|dio~38_combout\,
	combout => \tec|dio~44_combout\);

-- Location: LCCOMB_X18_Y16_N10
\tec|WideNor0~30\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|WideNor0~30_combout\ = (\tec|WideNor0~29_combout\) # ((\tec|WideNor0~27_combout\) # ((!\tec|Selector1~2_combout\) # (!\tec|dio~44_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|WideNor0~29_combout\,
	datab => \tec|WideNor0~27_combout\,
	datac => \tec|dio~44_combout\,
	datad => \tec|Selector1~2_combout\,
	combout => \tec|WideNor0~30_combout\);

-- Location: LCCOMB_X18_Y16_N14
\tec|dio~45\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|dio~45_combout\ = (\tec|WideNor0~30_combout\ & (\tec|dio~44_combout\ & \dc|ce~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|WideNor0~30_combout\,
	datac => \tec|dio~44_combout\,
	datad => \dc|ce~q\,
	combout => \tec|dio~45_combout\);

-- Location: FF_X16_Y16_N1
\tec|dio~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \tec|Selector1~35_combout\,
	ena => \tec|dio~45_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \tec|dio~reg0_q\);

-- Location: FF_X18_Y16_N3
\tec|dio~en\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \tec|WideOr6~4_combout\,
	ena => \tec|dio~45_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \tec|dio~en_q\);

-- Location: LCCOMB_X19_Y17_N16
\tec|Equal136~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Equal136~0_combout\ = (\tec|Equal128~2_combout\ & (\tec|sm_counter\(3) & (!\tec|sm_counter\(2) & \tec|Equal128~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Equal128~2_combout\,
	datab => \tec|sm_counter\(3),
	datac => \tec|sm_counter\(2),
	datad => \tec|Equal128~1_combout\,
	combout => \tec|Equal136~0_combout\);

-- Location: LCCOMB_X18_Y16_N18
\tec|Selector3~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Selector3~0_combout\ = (\tec|Equal136~0_combout\) # ((\tec|clk~q\ & ((\tec|Equal2~2_combout\) # (\tec|Equal23~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111011101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|Equal136~0_combout\,
	datab => \tec|clk~q\,
	datac => \tec|Equal2~2_combout\,
	datad => \tec|Equal23~0_combout\,
	combout => \tec|Selector3~0_combout\);

-- Location: LCCOMB_X18_Y16_N28
\tec|Selector3~9\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Selector3~9_combout\ = ((\tec|Selector3~0_combout\) # (!\tec|Selector3~8_combout\)) # (!\tec|Selector3~4_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \tec|Selector3~4_combout\,
	datac => \tec|Selector3~8_combout\,
	datad => \tec|Selector3~0_combout\,
	combout => \tec|Selector3~9_combout\);

-- Location: LCCOMB_X18_Y16_N0
\tec|Selector3~10\ : cycloneive_lcell_comb
-- Equation(s):
-- \tec|Selector3~10_combout\ = (\tec|Selector3~9_combout\) # (((!\tec|WideNor0~30_combout\ & \tec|clk~q\)) # (!\tec|dio~38_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tec|WideNor0~30_combout\,
	datab => \tec|Selector3~9_combout\,
	datac => \tec|clk~q\,
	datad => \tec|dio~38_combout\,
	combout => \tec|Selector3~10_combout\);

-- Location: FF_X18_Y16_N1
\tec|clk\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk25~inputclkctrl_outclk\,
	d => \tec|Selector3~10_combout\,
	ena => \dc|ce~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \tec|clk~q\);

ww_clk <= \clk~output_o\;

ww_dio <= \dio~output_o\;
END structure;


