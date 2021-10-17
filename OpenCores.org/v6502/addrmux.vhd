library IEEE;
use IEEE.std_logic_1164.all;  -- defines std_logic types
use IEEE.STD_LOGIC_unsigned.all;
use IEEE.STD_LOGIC_arith.all;

-- 16 bit two-way multiplexer
entity addrmux is
  port(  sel:  in STD_LOGIC_VECTOR(1 downto 0);
           a:  in STD_LOGIC_VECTOR(15 downto 0);
           b:  in STD_LOGIC_VECTOR(15 downto 0);
           s:  in STD_LOGIC_VECTOR(15 downto 0);
           y: out STD_LOGIC_VECTOR(15 downto 0)
      );
end addrmux;

architecture comb of addrmux is
constant ADPC: STD_LOGIC_VECTOR(1 downto 0) := "00";  -- select PC
constant ADMP: STD_LOGIC_VECTOR(1 downto 0) := "01";  -- select MP
constant ADSP: STD_LOGIC_VECTOR(1 downto 0) := "10";  -- select SP
constant ADNP: STD_LOGIC_VECTOR(1 downto 0) := "00";  -- no operation
begin
  process(sel,a,b,s)
  begin
    case sel is
      when ADPC   => y <= a;
      when ADMP   => y <= b;
      when ADSP   => y <= s;
      when others => y <= a;
    end case;
  end process;    
end comb;


