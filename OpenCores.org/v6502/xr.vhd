library IEEE;
use IEEE.std_logic_1164.all;  -- defines std_logic types
use IEEE.STD_LOGIC_unsigned.all;
use IEEE.STD_LOGIC_arith.all;

-- 8 bit index register "X"
entity xr is
  port(   clk:  in STD_LOGIC;
        fwait:  in STD_LOGIC; 
           ld:  in STD_LOGIC;
          din:  in STD_LOGIC_VECTOR(7 downto 0);
         dout: out STD_LOGIC_VECTOR(7 downto 0)
      );
end xr;

architecture rtl of xr is
signal reg: STD_LOGIC_VECTOR(7 downto 0);
begin
  process(clk)
    begin
      if (clk'event and clk = '1') then
        if fwait = '1' then
          reg <= reg;
        else  
          if ld = '1' then
            reg <= din;
          else
            reg <= reg;
          end if;
        end if;      
      end if;  
  end process;
  dout <= reg;
end rtl;


