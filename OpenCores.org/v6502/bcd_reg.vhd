library IEEE;
use IEEE.std_logic_1164.all;  -- defines std_logic types
use IEEE.STD_LOGIC_unsigned.all;
use IEEE.STD_LOGIC_arith.all;

-- BCD register
entity bcd_reg is
  port(    clk:  in STD_LOGIC;
           clr:  in STD_LOGIC;
         fwait:  in STD_LOGIC;   
            en:  in STD_LOGIC;
        bcd_sl:  in STD_LOGIC;
        bcd_sh:  in STD_LOGIC;
        dout: out STD_LOGIC_VECTOR(7 downto 0)
      );
end bcd_reg;

architecture rtl of bcd_reg is
signal reg: STD_LOGIC_VECTOR(7 downto 0);
begin
  process(clk)
    begin
      if (clk'event and clk = '1') then
        if fwait = '1' then
          reg <= reg;
        else  
          if clr = '1' or en = '0' then
            reg <= (others => '0');
          else
            if bcd_sl = '1' then
              reg(3 downto 0) <= "0110";  -- loads 0x6 to lsb
            else
              reg(3 downto 0) <= reg(3 downto 0);
            end if;     
            if bcd_sh = '1' then
              reg(7 downto 4) <= "0110";  -- loads 0x6 to msb
            else
              reg(7 downto 4) <= reg(7 downto 4);
            end if;
          end if;       
        end if;            
      end if;  
  end process;
  dout <= reg;
end rtl;


