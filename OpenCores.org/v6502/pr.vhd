library IEEE;
use IEEE.std_logic_1164.all;  -- defines std_logic types
use IEEE.STD_LOGIC_unsigned.all;
use IEEE.STD_LOGIC_arith.all;

-- 8 bit processor status register P
-- NV1BDIZC    
-- 76543210
-- ||||||||
-- ||||||||--- C = carry/borrow flag
-- |||||||---- Z = zero flag
-- ||||||----- I = interrupt mask
-- |||||------ D = decimal/binary alu mode
-- ||||------- B = break opcode flag
-- |||-------- 1 = always "1'
-- ||--------- V = overflow flag
-- |---------- N = negative flag
entity pr is
  port(      clk:  in STD_LOGIC;                        -- clock
             clr:  in STD_LOGIC;                        -- clear
           fwait:  in STD_LOGIC; 
               n:  in STD_LOGIC;                        -- N input
               v:  in STD_LOGIC;                        -- V input
               z:  in STD_LOGIC;                        -- Z input
               c:  in STD_LOGIC;                        -- C input
               b:  in STD_LOGIC;                        -- B input
              sv:  in STD_LOGIC;                        -- set overflow (by external pin SO) 
          acr_in:  in STD_LOGIC;                        -- auxiliary carry in   
              fc:  in STD_LOGIC_VECTOR(3 downto 0);     -- function code 
             din:  in STD_LOGIC_VECTOR(7 downto 0);     -- input
            dout: out STD_LOGIC_VECTOR(7 downto 0);     -- output
         acr_out: out STD_LOGIC                         -- auxiliary carry out   
      );        
end pr;

architecture rtl of pr is
constant NOP_P: STD_LOGIC_VECTOR(3 downto 0) := "0000"; -- PR no operation
constant PLD_P: STD_LOGIC_VECTOR(3 downto 0) := "0001"; -- PR load
constant FLD_P: STD_LOGIC_VECTOR(3 downto 0) := "0010"; -- NZ load
constant FLC_P: STD_LOGIC_VECTOR(3 downto 0) := "0011"; -- NZC load
constant FLV_P: STD_LOGIC_VECTOR(3 downto 0) := "0100"; -- NVZC load
constant SEC_P: STD_LOGIC_VECTOR(3 downto 0) := "0101"; -- 1 => C 
constant CLC_P: STD_LOGIC_VECTOR(3 downto 0) := "0110"; -- 0 => C 
constant SEI_P: STD_LOGIC_VECTOR(3 downto 0) := "0111"; -- 1 => I 
constant CLI_P: STD_LOGIC_VECTOR(3 downto 0) := "1000"; -- 0 => I 
constant SED_P: STD_LOGIC_VECTOR(3 downto 0) := "1001"; -- 1 => D 
constant CLD_P: STD_LOGIC_VECTOR(3 downto 0) := "1010"; -- 0 => D 
constant CLV_P: STD_LOGIC_VECTOR(3 downto 0) := "1011"; -- 0 => V 
constant AUC_P: STD_LOGIC_VECTOR(3 downto 0) := "1100"; -- auc => ACR 
constant HAC_P: STD_LOGIC_VECTOR(3 downto 0) := "1101"; -- hold ACR 
constant SID_P: STD_LOGIC_VECTOR(3 downto 0) := "1110"; -- 1 => I/D 
constant LDZ_P: STD_LOGIC_VECTOR(3 downto 0) := "1111"; -- Z load

signal  reg: STD_LOGIC_VECTOR(7 downto 0);
signal  acr: STD_LOGIC;                                                   -- carry/borrow used for effectve address calculation 
signal i_so: STD_LOGIC;

begin
  i_so <= reg(6) when sv = '1' else '1';                                  -- logic for external pin SO
  process(clk)
    begin
      if (clk'event and clk = '1') then
        if fwait = '1' then
          reg <= reg;
        else
          if clr = '1' then
            reg <= "00100100";
            acr <= '0';
          else
            case fc is
              when PLD_P  => reg(7 downto 6) <= din(7 downto 6);                      -- load NV1BDIZC 
                             reg(5)          <= '1';
                             reg(4 downto 0) <= din(4 downto 0);
                             acr <= '0';   
              when FLD_P  => reg <= n & reg(6) & '1' & reg(4 downto 2) & z & reg(0);  -- load NZ
                             acr <= '0';   
              when FLC_P  => reg <= n & reg(6) & '1' & reg(4 downto 2) & z & c;       -- load NZC
                             acr <= '0';   
              when FLV_P  => reg <= n & v & '1' & reg(4 downto 2) & z & c;            -- load NZCV
                             acr <= '0';   
              when SEC_P  => reg <= reg or  "00000001";                               -- 1 => C
                             acr <= acr;   
              when CLC_P  => reg <= reg and "11111110";                               -- 0 => C
                             acr <= acr;   
              when CLI_P  => reg <= reg and "11111011";                               -- 0 => I
                             acr <= acr;   
              when SED_P  => reg <= reg or  "00001000";                               -- 1 => D
                             acr <= acr;   
              when CLD_P  => reg <= reg and "11110111";                               -- 0 => D
                             acr <= acr;   
				  when LDZ_P  => reg(1) <= z;                                             -- z => Z
                             reg(7 downto 2) <= reg(7 downto 2);
			                    reg(0) <= reg(0);						  
              when SEI_P  => reg(7 downto 5) <= reg(7 downto 5); 
                             reg(4) <= reg(4);
                             reg(3) <= reg(3);
                             reg(2) <= '1';                                           -- 1 => I
                             reg(1 downto 0) <= reg(1 downto 0);           
                             acr <= acr;   
              when SID_P  => reg(7 downto 5) <= reg(7 downto 5);                      -- set I and clear D decimal flag (used by interrupt sequence)
                             reg(4) <= b;                                             -- 1 => B (if BRK)
                             reg(3) <= '0';                                           -- 0 -> D                                 
                             reg(2) <= '1';                                           -- 1 => I
                             reg(1 downto 0) <= reg(1 downto 0);           
                             acr <= acr;   
              when CLV_P  => reg <= reg and "10111111";                               -- 0 => V
                             acr <= acr;   
              when AUC_P  => acr    <= acr_in;                                        -- store auxiliary carry (ACR)
                             reg    <= reg;               
              when HAC_P  => acr    <= acr;                                           -- holds auxiliary carry (ACR)
                             reg    <= reg;               
              when others => reg(7) <= reg(7);                             
                             reg(6) <= i_so;                                          -- set overflow by pin SO
                             reg(5 downto 0) <= reg(5 downto 0);  
                             acr    <= '0';
            end case;
          end if;    
        end if;
      end if;  
  end process;
  dout <= reg;
  acr_out <= acr;
end rtl;


