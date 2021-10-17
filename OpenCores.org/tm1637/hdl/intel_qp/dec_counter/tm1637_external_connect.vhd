-- synthesis VHDL_INPUT_VERSION VHDL_2008
-- ^^ keep this to avoid "Error (10887): VHDL error at tm1637_external_connect.vhd(112): simplified sensitivity list is not supported in VHDL_1993, and is only supported for VHDL 2008"
-- https://staging.doulos.com/knowhow/vhdl/vhdl-2008-easier-to-use/
-- https://community.intel.com/t5/Programmable-Devices/VHDL-2008-DSP-Builder-and-Quartus-10/td-p/16379

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tm1637_external_connect is
    generic (divider  : integer); 
    Port (   clk25 	 : in  std_logic;
				 data 	 : in std_logic_vector(15 downto 0);
			    clk      : out std_logic;
			    dio      : out std_logic;
				 En       : in std_logic
          );
			 
end tm1637_external_connect;

architecture Behavioral of tm1637_external_connect is

impure function int_to_seg7(zahl : in integer; stelle : in integer; nrbit : in integer; in_digit0 : in std_logic_vector(3 downto 0);  in_digit1 : in std_logic_vector(3 downto 0);  in_digit2 : in std_logic_vector(3 downto 0);  in_digit3 : in std_logic_vector(3 downto 0)) return std_logic is

variable counter : integer := 0;
variable bcd : integer := 0;
variable seg7 : std_logic_vector(7 downto 0);
variable dig : std_logic_vector(3 downto 0);

-- Werte hier !!! umziehen nach display aufdröselei

variable digit0 : std_logic_vector(3 downto 0) := "0001"; 
variable digit1 : std_logic_vector(3 downto 0) := "0001"; 
variable digit2 : std_logic_vector(3 downto 0) := "0001"; 
variable digit3 : std_logic_vector(3 downto 0) := "0001"; 

begin

  digit0 :=  in_digit0;
  digit1 :=  in_digit1;
  digit2 :=  in_digit2;
  digit3 :=  in_digit3;

 case stelle is
  when 1 => dig := digit0; 
  when 2 => dig := digit1; 
  when 3 => dig := digit2; 
  when 4 => dig := digit3; 
  when others => null;
 end case;
 
 
 case dig is 
  when "0000"=> seg7 :=  "00111111";    -- 0
  when "0001"=> seg7 :=  "00000110";    -- 1
  when "0010"=> seg7 :=  "01011011";    -- 2
  when "0011"=> seg7 :=  "01001111";    -- 3
  when "0100"=> seg7 :=  "01100110";    -- 4
  when "0101"=> seg7 :=  "01101101";    -- 5
  when "0110"=> seg7 :=  "01111101";    -- 6
  when "0111"=> seg7 :=  "00000111";    -- 7
  when "1000"=> seg7 :=  "01111111";    -- 8
  when "1001"=> seg7 :=  "01101111";    -- 9
  when "1010"=> seg7 :=  "01110111";    -- A
  when "1011"=> seg7 :=  "01111100";    -- b
  when "1100"=> seg7 :=  "00111001";    -- C
  when "1101"=> seg7 :=  "01011110";    -- d
  when "1110"=> seg7 :=  "01111001";    -- E
  when "1111"=> seg7 :=  "01110001";    -- F
  when others=> seg7 :=  "00000000";    -- 8:
 end case;
 if En='0' then 
  seg7 :=  "00000000";   -- empty:
 end if;
 return seg7(nrbit);

end int_to_seg7;

------------------------------------------------------------------------------------------------------------------------------------

signal clkdiv : integer range 0 to divider-1 := 0;
signal ce: std_logic := '0';
signal sm_counter : integer := 0;
signal clk_250k : std_logic := '0';
signal rdy : std_logic := '0';

signal reg_digit0 : std_logic_vector(3 downto 0) := "0000";
signal reg_digit1 : std_logic_vector(3 downto 0) := "0000";
signal reg_digit2 : std_logic_vector(3 downto 0) := "0000";
signal reg_digit3 : std_logic_vector(3 downto 0) := "0000";

signal cnt_rdy :  std_logic_vector(1 downto 0);	
signal display : integer := 0;

begin

display <= 0;
 
process (clk25) begin
 if rising_edge(clk25) then
  if (clkdiv < divider-1) then   
    clkdiv <= clkdiv + 1;
    ce <= '0';
   else
    clkdiv <= 0;
    ce <= '1';
   end if;
  end if;
 end process;

 process(clk25)
  begin

  if rising_edge(clk25) then
   if (ce='1') then 
	case sm_counter is
     when 0 => clk <= '1'; dio <= '1';
     when 1 => clk <= '1'; dio <= '1'; 
	  when 2 =>             dio <= '0';
	  when 3 => clk <= '0'; 
	  when 4 => clk <= '1';
	  when 5 => clk <= '0'; dio <= '0';
	  when 6 => clk <= '1'; 
	  when 7 => clk <= '0'; 
	  when 8 => clk <= '1';
	  when 9 => clk <= '0'; 
	  when 10 => clk <= '1'; 
	  when 11 => clk <= '0'; 
	  when 12 => clk <= '1'; 
	  when 13 => clk <= '0'; 
	  when 14 => clk <= '1'; 
	  when 15 => clk <= '0';  dio <= '1';
	  when 16 => clk <= '1'; 
	  when 17 => clk <= '0';  dio <= '0';
	  when 18 => clk <= '1'; 
	  when 19 => clk <= '0'; dio <= 'Z';
	  when 20 => clk <= '1';
	  when 21 => clk <= '0'; dio <= '0'; 
	  when 22 => clk <= '1';
     when 23 =>             dio <= '1'; 
 	  when 24 => clk <= '1'; dio <= '0'; 
	  when 25 => clk <= '0'; dio <= '0';
	  when 26 => clk <= '1'; 
	  when 27 => clk <= '0'; 
	  when 28 => clk <= '1'; 
	  when 29 => clk <= '0'; dio <= '0';
	  when 30 => clk <= '1'; dio <= '0';
	  when 31 => clk <= '0'; dio <= '0';
	  when 32 => clk <= '1'; dio <= '0';
	  when 33 => clk <= '0'; dio <= '0'; 
	  when 34 => clk <= '1'; dio <= '0';
	  when 35 => clk <= '0'; dio <= '0';
	  when 36 => clk <= '1'; dio <= '0';
	  when 37 => clk <= '0'; dio <= '1';
	  when 38 => clk <= '1'; dio <= '1';
	  when 39 => clk <= '0'; dio <= '1';
	  when 40 => clk <= '1'; dio <= '1';
	  when 41 => clk <= '0'; dio <= 'Z'; 
	  when 42 => clk <= '1'; 
	  when 43 => clk <= '0'; dio <= int_to_seg7(display, 1, 0, reg_digit0, reg_digit1, reg_digit2, reg_digit3); 
	  when 44 => clk <= '1'; 
	  when 45 => clk <= '0'; dio <= int_to_seg7(display, 1, 1, reg_digit0, reg_digit1, reg_digit2, reg_digit3); 
	  when 46 => clk <= '1'; 
	  when 47 => clk <= '0'; dio <= int_to_seg7(display, 1, 2, reg_digit0, reg_digit1, reg_digit2, reg_digit3); 
	  when 48 => clk <= '1';
	  when 49 => clk <= '0'; dio <= int_to_seg7(display, 1, 3, reg_digit0, reg_digit1, reg_digit2, reg_digit3); 
	  when 50 => clk <= '1'; 
	  when 51 => clk <= '0'; dio <= int_to_seg7(display, 1, 4, reg_digit0, reg_digit1, reg_digit2, reg_digit3); 
	  when 52 => clk <= '1'; 
	  when 53 => clk <= '0'; dio <= int_to_seg7(display, 1, 5, reg_digit0, reg_digit1, reg_digit2, reg_digit3); 
	  when 54 => clk <= '1';
	  when 55 => clk <= '0'; dio <= int_to_seg7(display, 1, 6, reg_digit0, reg_digit1, reg_digit2, reg_digit3); 
	  when 56 => clk <= '1';
	  when 57 => clk <= '0'; dio <= int_to_seg7(display, 1, 7, reg_digit0, reg_digit1, reg_digit2, reg_digit3); 
	  when 58 => clk <= '1'; 
	  when 59 => clk <= '0'; dio <= 'Z';
	  when 60 => clk <= '1';  
	  when 61 => clk <= '0'; dio <= int_to_seg7(display, 2, 0, reg_digit0, reg_digit1, reg_digit2, reg_digit3); 
	  when 62 => clk <= '1'; 
	  when 63 => clk <= '0'; dio <= int_to_seg7(display, 2, 1, reg_digit0, reg_digit1, reg_digit2, reg_digit3); 
	  when 64 => clk <= '1';
	  when 65 => clk <= '0'; dio <= int_to_seg7(display, 2, 2, reg_digit0, reg_digit1, reg_digit2, reg_digit3); 
	  when 66 => clk <= '1';
	  when 67 => clk <= '0'; dio <= int_to_seg7(display, 2, 3, reg_digit0, reg_digit1, reg_digit2, reg_digit3); 
	  when 68 => clk <= '1';
	  when 69 => clk <= '0'; dio <= int_to_seg7(display, 2, 4, reg_digit0, reg_digit1, reg_digit2, reg_digit3); 
	  when 70 => clk <= '1';
	  when 71 => clk <= '0'; dio <= int_to_seg7(display, 2, 5, reg_digit0, reg_digit1, reg_digit2, reg_digit3);  
	  when 72 => clk <= '1';
	  when 73 => clk <= '0'; dio <= int_to_seg7(display, 2, 6, reg_digit0, reg_digit1, reg_digit2, reg_digit3); 
	  when 74 => clk <= '1';
	  when 75 => clk <= '0'; dio <= int_to_seg7(display, 2, 7, reg_digit0, reg_digit1, reg_digit2, reg_digit3); 
	  when 76 => clk <= '1';
	  when 77 => clk <= '0'; dio <= 'Z';
	  when 78 => clk <= '1'; 
	  when 79 => clk <= '0'; dio <= int_to_seg7(display, 3, 0, reg_digit0, reg_digit1, reg_digit2, reg_digit3); 
	  when 80 => clk <= '1';
	  when 81 => clk <= '0'; dio <= int_to_seg7(display, 3, 1, reg_digit0, reg_digit1, reg_digit2, reg_digit3); 
	  when 82 => clk <= '1'; 
	  when 83 => clk <= '0'; dio <= int_to_seg7(display, 3, 2, reg_digit0, reg_digit1, reg_digit2, reg_digit3); 
	  when 84 => clk <= '1';
	  when 85 => clk <= '0'; dio <= int_to_seg7(display, 3, 3, reg_digit0, reg_digit1, reg_digit2, reg_digit3); 
	  when 86 => clk <= '1';
	  when 87 => clk <= '0'; dio <= int_to_seg7(display, 3, 4, reg_digit0, reg_digit1, reg_digit2, reg_digit3); 
	  when 88 => clk <= '1';
	  when 89 => clk <= '0'; dio <= int_to_seg7(display, 3, 5, reg_digit0, reg_digit1, reg_digit2, reg_digit3); 
	  when 90 => clk <= '1';
	  when 91 => clk <= '0'; dio <= int_to_seg7(display, 3, 6, reg_digit0, reg_digit1, reg_digit2, reg_digit3); 
	  when 92 => clk <= '1';
	  when 93 => clk <= '0'; dio <= int_to_seg7(display, 3, 7, reg_digit0, reg_digit1, reg_digit2, reg_digit3); 
	  when 94 => clk <= '1';
	  when 95 => clk <= '0'; dio <= 'Z'; 
	  when 96 => clk <= '1';
	  when 97 => clk <= '0'; dio <= int_to_seg7(display, 4, 0, reg_digit0, reg_digit1, reg_digit2, reg_digit3);
	  when 98 => clk <= '1';
	  when 99 => clk <= '0'; dio <= int_to_seg7(display, 4, 1, reg_digit0, reg_digit1, reg_digit2, reg_digit3);
	  when 100 => clk <= '1';  
	  when 101 => clk <= '0'; dio <= int_to_seg7(display, 4, 2, reg_digit0, reg_digit1, reg_digit2, reg_digit3);
	  when 102 => clk <= '1';
	  when 103 => clk <= '0'; dio <= int_to_seg7(display, 4, 3, reg_digit0, reg_digit1, reg_digit2, reg_digit3);
	  when 104 => clk <= '1';
	  when 105 => clk <= '0'; dio <= int_to_seg7(display, 4, 4, reg_digit0, reg_digit1, reg_digit2, reg_digit3);
	  when 106 => clk <= '1';
	  when 107 => clk <= '0'; dio <= int_to_seg7(display, 4, 5, reg_digit0, reg_digit1, reg_digit2, reg_digit3);
	  when 108 => clk <= '1';
	  when 109 => clk <= '0'; dio <= int_to_seg7(display, 4, 6, reg_digit0, reg_digit1, reg_digit2, reg_digit3);
	  when 110 => clk <= '1';
	  when 111 => clk <= '0'; dio <= int_to_seg7(display, 4, 7, reg_digit0, reg_digit1, reg_digit2, reg_digit3);
	  when 112 => clk <= '1';
	  when 113 => clk <= '0'; dio <= 'Z'; 
	  when 114 => clk <= '1'; 
	  when 115 => clk <= '0'; dio <= '0'; 
	  when 116 => clk <= '1';
	  when 117 => clk <= '1'; dio <= '1';
	  when 118 => clk <= '1'; dio <= '0'; 
	  when 119 => clk <= '0'; dio <= '1'; 
	  when 120 => clk <= '1'; 
	  when 121 => clk <= '0'; 
	  when 122 => clk <= '1'; 
	  when 123 => clk <= '0'; 
	  when 124 => clk <= '1'; 
	  when 125 => clk <= '0'; 
	  when 126 => clk <= '1'; 
	  when 127 => clk <= '0'; dio <= '0'; 
	  when 128 => clk <= '1'; 
	  when 129 => clk <= '0'; 
	  when 130 => clk <= '1'; 
	  when 131 => clk <= '0'; 
	  when 132 => clk <= '1'; 
	  when 133 => clk <= '0'; dio <= '1'; 
	  when 134 => clk <= '1'; 
	  when 135 => clk <= '0'; dio <= 'Z'; 
	  when 136 => clk <= '1'; dio <= 'Z';
	  when 137 => clk <= '0'; dio <= '0';
	  when 138 => clk <= '1'; dio <= '0';
	  when 139 => clk <= '1'; dio <= '1';
	  when 140 => clk <= '1'; dio <= '1';
	  when 141 => clk <= '1'; dio <= '1';
	  when others => null;
   end case;
	
	if sm_counter = 10000 then 
		sm_counter <= 0;
	else
		sm_counter <= sm_counter + 1;
	end if;	
	
	if sm_counter = 9999 then
		rdy <= '1';
	else
		rdy <= '0';
	end if;	
   
  end if;
  end if;	
 end process;
 
 process(clk25)
  begin
  if rising_edge(clk25) then
	if rdy = '1' then
	 if (ce ='1') then
		reg_digit0 <= data(3 downto 0);
		reg_digit1 <= data(7 downto 4);
		reg_digit2 <= data(11 downto 8);
		reg_digit3 <= data(15 downto 12);
	end if;
  end if;
  end if;
  end process;
 
end Behavioral;