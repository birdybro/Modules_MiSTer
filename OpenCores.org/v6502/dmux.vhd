library IEEE;
use IEEE.std_logic_1164.all;  -- defines std_logic types
use IEEE.STD_LOGIC_unsigned.all;
use IEEE.STD_LOGIC_arith.all;

-- 8 bit three-way multiplexer
entity dmux is
  port(  sel:  in STD_LOGIC_VECTOR(1 downto 0);
           a:  in STD_LOGIC_VECTOR(7 downto 0);
           b:  in STD_LOGIC_VECTOR(7 downto 0);
           c:  in STD_LOGIC_VECTOR(7 downto 0);
           y: out STD_LOGIC_VECTOR(7 downto 0)
      );
end dmux;

architecture comb of dmux is
constant NOP_D: STD_LOGIC_VECTOR(1 downto 0) := "00";
constant ORD_D: STD_LOGIC_VECTOR(1 downto 0) := "01";
constant EXT_D: STD_LOGIC_VECTOR(1 downto 0) := "10";
constant BCD_D: STD_LOGIC_VECTOR(1 downto 0) := "11";
begin
  process(sel,a,b,c)
  begin 
    case sel is
      when ORD_D    => y <= a;
      when EXT_D    => y <= b;
      when BCD_D    => y <= c;
      when others   => y <= "00000000";
    end case;
  end process;  
end comb;


