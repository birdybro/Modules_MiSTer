library IEEE;
use IEEE.std_logic_1164.all;  -- defines std_logic types
use IEEE.STD_LOGIC_unsigned.all;
use IEEE.STD_LOGIC_arith.all;

-- 16 bit program counter register "PC"
entity pcr is
  port(   clk:  in STD_LOGIC;
            i:  in STD_LOGIC;
        fwait:  in STD_LOGIC;   
           fc:  in STD_LOGIC_VECTOR(3 downto 0);
         din1:  in STD_LOGIC_VECTOR(7 downto 0);
         din2:  in STD_LOGIC_VECTOR(7 downto 0);
         dout: out STD_LOGIC_VECTOR(15 downto 0)
      );
end pcr;

architecture rtl of pcr is
constant NOP_P: STD_LOGIC_VECTOR(3 downto 0) := "0000"; -- PC no operation
constant LSB_P: STD_LOGIC_VECTOR(3 downto 0) := "0010"; -- PC load lsb
constant MSB_P: STD_LOGIC_VECTOR(3 downto 0) := "0100"; -- PC load msb
constant INC_P: STD_LOGIC_VECTOR(3 downto 0) := "0110"; -- PC increment by 1
constant LOD_P: STD_LOGIC_VECTOR(3 downto 0) := "1000"; -- PC load lsb\msb
constant ADJ_P: STD_LOGIC_VECTOR(3 downto 0) := "1010"; -- PC msb increment by 1
constant ADJ_N: STD_LOGIC_VECTOR(3 downto 0) := "1011"; -- PC msb decrement by 1
signal op:  STD_LOGIC_VECTOR(3 downto 0);
signal reg: STD_LOGIC_VECTOR(15 downto 0);

begin
  process(fc)
  begin
    case fc is
      when ADJ_P  => op             <= ADJ_P;
      when ADJ_N  => op             <= ADJ_N;
      when others => op(3 downto 1) <= fc(3 downto 1);
                     op(0)          <= '0';
    end case;
  end process;                  

  process(clk)
    begin
      if (clk'event and clk = '1') then
        if fwait = '1' then
          reg <= reg;
        else  
          if i = '1' then
            reg <= reg +1;
          else
            case op is
              when LSB_P  => reg(7 downto 0) <= din1; reg(15 downto 8) <= reg(15 downto 8);
              when MSB_P  => reg(15 downto 8) <= din1; reg(7 downto 0) <= reg(7 downto 0);
              when INC_P  => reg <= reg +1;
              when LOD_P  => reg(15 downto 8) <= din1; reg(7 downto 0) <= din2;
              when ADJ_P  => reg(15 downto 8) <= reg(15 downto 8) + ("00000001"); reg(7 downto 0) <= reg(7 downto 0);
              when ADJ_N  => reg(15 downto 8) <= reg(15 downto 8) - ("00000001"); reg(7 downto 0) <= reg(7 downto 0);
              when NOP_P  => reg <= reg;
              when others => reg <= reg;
            end case;
          end if;  
        end if;
      end if;    
  end process;
  dout <= reg;
end rtl;


