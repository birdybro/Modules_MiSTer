-- https://www.engineersgarage.com/vhdl/decimal-counter-in-vhdl/
-- https://www.edaboard.com/threads/counting-pulses-in-one-second-with-vhdl.341476/

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

entity tm1637_decimal_count is
  generic (divider : integer); 
  port (clk25, en: IN std_logic; 
        out3, out2, out1, out0: OUT std_logic_vector(3 DOWNTO 0));
end tm1637_decimal_count;

architecture behavioral OF tm1637_decimal_count IS
  signal d1000Curr, d100Curr, d1000Next, d100Next, d10Curr, d10Next, d1Curr, d1Next: unsigned(3 DOWNTO 0) := (OTHERS =>'0');
  signal clkdiv : integer range 0 to divider-1 := 0;
  signal ce: std_logic := '0';
begin

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
 if (rising_edge(clk25)) then
  if (ce='1') then 
   if (d1000Curr=9 AND d100Curr=9 AND d10Curr=9 AND d1Curr=9) then
    d1000Next <= "0000";
   elsif (d100Curr=9 AND d10Curr=9 AND d1Curr=9) then
    d1000Next <= d1000Curr+1;
   else
    d1000Next <= d1000Curr;
   end if;
   if (d100Curr=9 AND d10Curr=9 AND d1Curr=9) then
    d100Next <= "0000";
   elsif (d10Curr=9 AND d1Curr=9) then
    d100Next <= d100Curr+1;
   else
    d100Next <= d100Curr;
   end if;  
   if (d10Curr=9 AND d1Curr=9) then
    d10Next  <= "0000";
   elsif (d1Curr=9) then
    d10Next <= d10Curr+1;
   else
    d10Next <= d10Curr; 
  end if;
  if (d1Curr=9) then
   d1Next   <= "0000";
  else
   d1Next <= d1Curr+1;
  end if;		  

  end if;
 d1000Curr <= d1000Next;
 d100Curr <= d100Next;
 d10Curr  <= d10Next;
 d1Curr   <= d1Next;
end if;
end process;

 out0 <= std_logic_vector(d1000Curr);
 out1 <= std_logic_vector(d100Curr); 
 out2 <= std_logic_vector(d10Curr);  
 out3 <= std_logic_vector(d1Curr);
  
end behavioral;
