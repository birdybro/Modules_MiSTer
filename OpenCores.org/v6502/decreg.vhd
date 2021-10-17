library IEEE;
use IEEE.std_logic_1164.all;  -- defines std_logic types
use IEEE.STD_LOGIC_unsigned.all;
use IEEE.STD_LOGIC_arith.all;

-- register operation decode
entity decreg is
  port(   r:  in STD_LOGIC_VECTOR(3 downto 0);
          y: out STD_LOGIC_VECTOR(8 downto 0)
      );
end decreg;

architecture comb of decreg is
constant NOP_R: STD_LOGIC_VECTOR(3 downto 0) := "0000";  -- no operation
constant ALD_R: STD_LOGIC_VECTOR(3 downto 0) := "0001";  -- register A load
constant XLD_R: STD_LOGIC_VECTOR(3 downto 0) := "0010";  -- register X load
constant YLD_R: STD_LOGIC_VECTOR(3 downto 0) := "0011";  -- register Y load
constant ZLD_R: STD_LOGIC_VECTOR(3 downto 0) := "0100";  -- register Z load
constant OLD_R: STD_LOGIC_VECTOR(3 downto 0) := "0101";  -- register O load
constant SLD_R: STD_LOGIC_VECTOR(3 downto 0) := "0110";  -- register S load lsb
constant SLM_R: STD_LOGIC_VECTOR(3 downto 0) := "0111";  -- register S load msb
constant SUP_R: STD_LOGIC_VECTOR(3 downto 0) := "1000";  -- register S increment by 1
constant SDW_R: STD_LOGIC_VECTOR(3 downto 0) := "1001";  -- register S decrement by 1
constant SAU_R: STD_LOGIC_VECTOR(3 downto 0) := "1010";  -- register A load/register S increment by 1
constant SXU_R: STD_LOGIC_VECTOR(3 downto 0) := "1011";  -- register X load/register S increment by 1
constant SYU_R: STD_LOGIC_VECTOR(3 downto 0) := "1100";  -- register Y load/register S increment by 1
constant SZU_R: STD_LOGIC_VECTOR(3 downto 0) := "1101";  -- register Z load/register S increment by 1

begin
  process(r)
  begin
    case r is
      when  NOP_R => y <= "000000000";
      when  ALD_R => y <= "000000001";
      when  XLD_R => y <= "000000010";
      when  YLD_R => y <= "000000100";
      when  ZLD_R => y <= "000001000";
      when  OLD_R => y <= "000010000";
      when  SLD_R => y <= "000100000";
      when  SLM_R => y <= "001000000";
      when  SUP_R => y <= "010000000";
      when  SDW_R => y <= "100000000";
      when  SAU_R => y <= "010000001";
      when  SXU_R => y <= "010000010";
      when  SYU_R => y <= "010000100";
      when  SZU_R => y <= "010001000";
      when others => y <= "000000000";
    end case;
  end process;
end comb;


