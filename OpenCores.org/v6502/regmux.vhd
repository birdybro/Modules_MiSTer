library IEEE;
use IEEE.std_logic_1164.all;  -- defines std_logic types
use IEEE.STD_LOGIC_unsigned.all;
use IEEE.STD_LOGIC_arith.all;

-- 8 bit seven-way multiplexer
entity regmux is
  port(  sel:  in STD_LOGIC_VECTOR(3 downto 0);
           a:  in STD_LOGIC_VECTOR(7 downto 0);
           b:  in STD_LOGIC_VECTOR(7 downto 0);
           c:  in STD_LOGIC_VECTOR(7 downto 0);
           d:  in STD_LOGIC_VECTOR(7 downto 0);
           e:  in STD_LOGIC_VECTOR(7 downto 0);
           f:  in STD_LOGIC_VECTOR(7 downto 0);
           g:  in STD_LOGIC_VECTOR(7 downto 0);
           h:  in STD_LOGIC_VECTOR(7 downto 0);
           i:  in STD_LOGIC_VECTOR(7 downto 0);
           j:  in STD_LOGIC_VECTOR(7 downto 0);
           k:  in STD_LOGIC_VECTOR(7 downto 0);
           y: out STD_LOGIC_VECTOR(7 downto 0)
      );
end regmux;

architecture comb of regmux is
constant EXT_O: STD_LOGIC_VECTOR(3 downto 0) := "0000";  -- external data bus
constant ARD_O: STD_LOGIC_VECTOR(3 downto 0) := "0001";  -- register A select
constant XRD_O: STD_LOGIC_VECTOR(3 downto 0) := "0010";  -- register X select
constant YRD_O: STD_LOGIC_VECTOR(3 downto 0) := "0011";  -- register Y select
constant SRD_O: STD_LOGIC_VECTOR(3 downto 0) := "0100";  -- register S lsb select
constant SRM_O: STD_LOGIC_VECTOR(3 downto 0) := "0101";  -- register S msb select
constant PRD_O: STD_LOGIC_VECTOR(3 downto 0) := "0110";  -- register P select
constant PLR_O: STD_LOGIC_VECTOR(3 downto 0) := "0111";  -- register PCL select
constant PHR_O: STD_LOGIC_VECTOR(3 downto 0) := "1000";  -- register PCH select
constant ORD_O: STD_LOGIC_VECTOR(3 downto 0) := "1001";  -- register O select
constant Z00_O: STD_LOGIC_VECTOR(3 downto 0) := "1010";  -- select (all zero output)
constant ZRD_O: STD_LOGIC_VECTOR(3 downto 0) := "1011";  -- register Z select (all zero output)

begin
  process(sel,a,b,c,d,e,f,g,h,i,j,k)
  begin 
    case sel is
      when EXT_O  => y <= a;
      when ARD_O  => y <= b;
      when XRD_O  => y <= c;
      when YRD_O  => y <= d;
      when SRD_O  => y <= e;
      when SRM_O  => y <= f;
      
      when PRD_O  => y <= g;
      when PLR_O  => y <= h;
      when PHR_O  => y <= i;
      when ORD_O  => y <= j;
      when Z00_O  => y <= (others => '0');
      when ZRD_O  => y <= k;
      when others => y <= a;
    end case;
  end process;  
end comb;


