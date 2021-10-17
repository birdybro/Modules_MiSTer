-- https://staging.doulos.com/knowhow/vhdl/vhdl-2008-easier-to-use/
-- https://community.intel.com/t5/Programmable-Devices/VHDL-2008-DSP-Builder-and-Quartus-10/td-p/16379

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tm1637_toplevel is
    Port (    clk25 	: in  std_logic;
			     clk    : out std_logic;
			     dio    : out std_logic
          );
end tm1637_toplevel;

architecture Behavioral of tm1637_toplevel is

-----------------------------------------------------------------------------
--
-- Important!!! Change this to fit to hw oscillator frequency.
-- The divider must be set so that the result is a frequency of 10-20 kHz
--
   constant divider  : integer := 2500; -- 25000000/2500 => 10000 -> 1 sec -> +1
-- 
-----------------------------------------------------------------------------


component tm1637_decimal_count IS
  generic (divider : integer);
  PORT (clk25, en : IN std_logic; 
        out3, out2, out1, out0: OUT std_logic_vector(3 DOWNTO 0));
end component;

component tm1637_external_connect is
	Generic (divider  : integer);
   Port (clk25 	 : in std_logic;
		   data 	 : in std_logic_vector(15 downto 0);
			clk      : out std_logic;
			dio      : out std_logic;
			en : in std_logic
         );
end component;

signal output0: std_logic_vector(3 DOWNTO 0);--:= "0001";
signal output1: std_logic_vector(3 DOWNTO 0);--:= "0010";
signal output2: std_logic_vector(3 DOWNTO 0);--:= "0011";
signal output3: std_logic_vector(3 DOWNTO 0); --:= "0000";
signal bigdata: std_logic_vector(15 downto 0); -- := "0000000000000000";

begin

-- https://stackoverflow.com/questions/32927663/how-to-make-startup-process-in-vhdl  
-- https://www.mikrocontroller.net/topic/477730

bigdata(3  downto  0) <= output0;
bigdata(7  downto  4) <= output1;
bigdata(11 downto  8) <= output2;
bigdata(15 downto 12) <= output3;

dc: tm1637_decimal_count 
  generic map (divider => divider)
  port map (
	clk25 => clk25, 
	en => '1',
	out3 => output3,
	out2 => output2,
	out1 => output1,
	out0 => output0
);	

tec: tm1637_external_connect 
   generic map (divider => divider)
   port map (
   clk25 => clk25,
   en => '1',
	data => bigdata,
	clk => clk,
	dio => dio
);

end Behavioral;