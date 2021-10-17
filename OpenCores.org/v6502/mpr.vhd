library IEEE;
use IEEE.std_logic_1164.all;  -- defines std_logic types
use IEEE.STD_LOGIC_unsigned.all;
use IEEE.STD_LOGIC_arith.all;

-- 16 bit memory pointer address register 
entity mpr is
  port(   clk:  in STD_LOGIC;
        fwait:  in STD_LOGIC;
            c:  in STD_LOGIC;                           -- carry input
           fc:  in STD_LOGIC_VECTOR(3 downto 0);
        din_l:  in STD_LOGIC_VECTOR(7 downto 0);  
        din_h:  in STD_LOGIC_VECTOR(7 downto 0);  
           zp:  in STD_LOGIC_VECTOR(7 downto 0);  
            v:  in STD_LOGIC_VECTOR(2 downto 0);
         dout: out STD_LOGIC_VECTOR(15 downto 0)
      );
end mpr;

architecture rtl of mpr is
constant NOP_M: STD_LOGIC_VECTOR(3 downto 0) := "0000"; -- no operation
constant LSB_M: STD_LOGIC_VECTOR(3 downto 0) := "0001"; -- load lsb
constant MSB_M: STD_LOGIC_VECTOR(3 downto 0) := "0010"; -- load msb
constant INC_M: STD_LOGIC_VECTOR(3 downto 0) := "0011"; -- increment LSB
constant VEC_M: STD_LOGIC_VECTOR(3 downto 0) := "0100"; -- load vector
constant ZPL_M: STD_LOGIC_VECTOR(3 downto 0) := "0101"; -- load ZEROPAGE
constant ALL_M: STD_LOGIC_VECTOR(3 downto 0) := "0110"; -- load all 16 bit register
constant ICC_M: STD_LOGIC_VECTOR(3 downto 0) := "0111"; -- increment MSB with carry
constant INM_M: STD_LOGIC_VECTOR(3 downto 0) := "1000"; -- increment MSB/LSB

signal reg: STD_LOGIC_VECTOR(15 downto 0);
begin
  process(clk)
  begin
    if (clk'event and clk = '1') then
      if fwait = '1' then
        reg <= reg;
      else  
        case fc is
          when LSB_M  => reg(7 downto 0) <= din_l; reg(15 downto 8) <= reg(15 downto 8);
          when MSB_M  => reg(15 downto 8) <= din_h; reg(7 downto 0) <= reg(7 downto 0);
          when ALL_M  => reg(15 downto 8) <= din_h; reg(7 downto 0) <= din_l;
          when INC_M  => reg(7 downto 0) <= reg(7 downto 0) +1;
          when VEC_M  => reg(15 downto 3) <= "1111111111111"; reg(2 downto 0) <= v;          -- 0xFFFX load vector
          when ZPL_M  => reg(15 downto 8) <= zp; reg(7 downto 0) <= din_l;                   -- 0xXXXX zeropage operation
          when ICC_M  => reg(15 downto 8) <= reg(15 downto 8) + c;                           -- increment MSB for indexed addressing mode
          when INM_M  => reg <= reg +1;
          when others => reg <= reg;
        end case;
      end if;  
    end if;  
  end process;
  dout <= reg;
end rtl;


