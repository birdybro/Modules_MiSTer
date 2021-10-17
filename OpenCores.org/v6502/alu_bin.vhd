library IEEE;
use IEEE.std_logic_1164.all;  -- defines std_logic types
use IEEE.STD_LOGIC_unsigned.all;
use IEEE.STD_LOGIC_arith.all;

-- 8 bit binary alu
-- Written by Valerio Venturi
entity alu_bin is
  port( alu_byp:  in STD_LOGIC;                      -- ALU bypass (no operation)   
            cin:  in STD_LOGIC;                      -- carry/borrow in
            vin:  in STD_LOGIC;                      -- overflow in
            op1:  in STD_LOGIC_VECTOR(7 downto 0);   -- 8 bit operand #1
            op2:  in STD_LOGIC_VECTOR(7 downto 0);   -- 8 bit operand #2
             fc:  in STD_LOGIC_VECTOR(5 downto 0);   -- function code (bit #0 serves as flag to signal an branch negative offset) 
             cf: out STD_LOGIC;                      -- carry/borrow out 
             zf: out STD_LOGIC;                      -- zero flag out
             nf: out STD_LOGIC;                      -- negative flag out
             vf: out STD_LOGIC;                      -- overflow flag out
          pc_cf: out STD_LOGIC;                      -- carry/borrow out for PC operation 
         bcd_ol: out STD_LOGIC;                      -- bcd lsb overflow  
         bcd_oh: out STD_LOGIC;                      -- bcd msb overflow  
           dout: out STD_LOGIC_VECTOR(7 downto 0)    -- 8 bit result out
      );  
end alu_bin;

architecture comb of alu_bin is
-- ALU function codes
constant NOP_A: STD_LOGIC_VECTOR(5 downto 0) := "000000";    -- no operation
constant SUM_A: STD_LOGIC_VECTOR(5 downto 0) := "000010";    -- sum with carry
constant SUB_A: STD_LOGIC_VECTOR(5 downto 0) := "000100";    -- subtract with borrow
constant AND_A: STD_LOGIC_VECTOR(5 downto 0) := "000110";    -- and
constant  OR_A: STD_LOGIC_VECTOR(5 downto 0) := "001000";    -- or
constant XOR_A: STD_LOGIC_VECTOR(5 downto 0) := "001010";    -- xor
constant INC_A: STD_LOGIC_VECTOR(5 downto 0) := "001100";    -- increment by 1
constant DEC_A: STD_LOGIC_VECTOR(5 downto 0) := "001110";    -- decrement by 1
constant SHL_A: STD_LOGIC_VECTOR(5 downto 0) := "010000";    -- shift left
constant SHR_A: STD_LOGIC_VECTOR(5 downto 0) := "010010";    -- shift right
constant ROL_A: STD_LOGIC_VECTOR(5 downto 0) := "010100";    -- rotation left
constant ROR_A: STD_LOGIC_VECTOR(5 downto 0) := "010110";    -- rotation right
constant SWC_A: STD_LOGIC_VECTOR(5 downto 0) := "011000";    -- sum without carry (used for indexing and branches)
constant SWC_N: STD_LOGIC_VECTOR(5 downto 0) := "011001";    -- subtract without borrow (used only by branches with negative offset)
constant BIT_A: STD_LOGIC_VECTOR(5 downto 0) := "011010";    -- bit test (used by BIT opcode)
constant DAA_A: STD_LOGIC_VECTOR(5 downto 0) := "011100";    -- decimal adjustement for BCD sum
constant DAS_A: STD_LOGIC_VECTOR(5 downto 0) := "011110";    -- decimal adjustement for BCD subtract
constant CMP_A: STD_LOGIC_VECTOR(5 downto 0) := "100000";    -- compare
constant TSB_A: STD_LOGIC_VECTOR(5 downto 0) := "100010";    -- test and set bit
constant TRB_A: STD_LOGIC_VECTOR(5 downto 0) := "100100";    -- test and reset bit
signal      op: STD_LOGIC_VECTOR(5 downto 0);
signal       c: STD_LOGIC;
signal    pc_c: STD_LOGIC;
signal   v_add: STD_LOGIC;
signal   v_sub: STD_LOGIC;
signal   bcd_l: STD_LOGIC;
signal   bcd_h: STD_LOGIC;
signal  bcd_lh: STD_LOGIC;
signal   n_op2: STD_LOGIC_VECTOR(7 downto 0);
signal       y: STD_LOGIC_VECTOR(8 downto 0);

begin
  process(fc)
  begin
    case fc is
      when SWC_A  => op             <= SWC_A;
      when SWC_N  => op             <= SWC_N;
      when others => op(5 downto 1) <= fc(5 downto 1);
                     op(0)          <= '0';
    end case;
  end process;                  
    
  n_op2 <= (not op2);  
  process(alu_byp,op,op1,op2,n_op2,cin)
  begin
    if alu_byp = '1' then
      y(y'left) <= '0';
      y(y'left-1 downto y'right) <= op1;
    else   
      case op is
        when SUM_A  => y <= ('0' & op1) + ('0' & op2) + ("00000000" & cin);     -- ADC with carry in
        when SUB_A  => y <= ('0' & op1) + ('0' & n_op2) + ("00000000" & cin);   -- SBC with borrow in
        when BIT_A  => y <= ('0' & op1) and ('0' & op2);                        -- BIT test
        when AND_A  => y <= ('0' & op1) and ('0' & op2);                        -- AND
        when OR_A   => y <= ('0' & op1)  or ('0' & op2);                        -- OR
        when XOR_A  => y <= ('0' & op1) xor ('0' & op2);                        -- XOR
        when INC_A  => y <= op1 + "000000001";                                  -- INC
        when DEC_A  => y <= op1 - "000000001";                                  -- DEC
        when SHL_A  => y(8 downto 1) <= op1; y(0) <= '0';                       -- ASL
        when SHR_A  => y <= "00" & op1(op1'left downto op1'right+1);            -- LSR
        when ROL_A  => y(8 downto 1) <= op1; y(0) <= cin;                       -- ROL
        when ROR_A  => y <= '0' & cin & op1(op1'left downto op1'right+1);       -- ROR
        when SWC_A  => y <= ('0' & op1) + ('0' & op2);                          -- ADD without carry in
        when SWC_N  => y <= ('0' & op1) - ('0' & (0 - op2));                    -- SUB two complement without borrow in
        when DAA_A  => y <= ('0' & op1) + ('0' & op2);                          -- ADD without carry in (used for DAA decimal adjustement)
        when DAS_A  => y <= ('0' & op1) - ('0' & op2);                          -- SUB without borrow in (used for DAS decimal adjustement)
        when CMP_A  => y <= ('1' & op1) - ('0' & op2);                          -- SBC without borrow in (used for compare)
        when TSB_A  => y <= ('0' & op1) or ('0' & op2);                         -- TSB
        when TRB_A  => y <= ('0' & not op1) and ('0' & op2);                    -- TRB
        when others => y(y'left) <= '0'; y(y'left-1 downto y'right) <= op1;     -- NOP
      end case;
    end if;   
  end process;


  -- flag "C" carry/borrow logic
  process(op,op1,y,cin)
  begin
    case op is
      when SUM_A  => c    <= y(y'left);
                     pc_c <= '0';
      when SUB_A  => c    <= y(y'left);
                     pc_c <= '0';
      when SWC_A  => pc_c <= y(y'left);
                     c    <= cin;
      when SWC_N  => pc_c <= not y(y'left);
                     c    <= cin;
      when SHL_A  => c    <= y(y'left);
                     pc_c <= '0';
      when SHR_A  => c    <= op1(op1'right);
                     pc_c <= '0';
      when ROL_A  => c    <= y(y'left);
                     pc_c <= '0';
      when ROR_A  => c    <= op1(op1'right);
                     pc_c <= '0';
      when DAA_A  => c    <= y(y'left);
                     pc_c <= '0';
      when DAS_A  => c    <= cin;
                     pc_c <= '0';
      when BIT_A  => c    <= cin;
                     pc_c <= '0';
      when CMP_A  => c    <= y(y'left);
                     pc_c <= '0';
      when others => c    <= cin;
                     pc_c <= '0';
    end case;
  end process;  

  -- flag "V" overflow logic
  v_add <= (y(7) xor op1(7)) and not (op1(7) xor op2(7));
  v_sub <= (y(7) xor op1(7)) and (op1(7) xor op2(7));
  process(op,op2,v_add,v_sub,vin)
  begin
    case op is
      when SUM_A  => vf <= v_add;
      when SUB_A  => vf <= v_sub;
      when BIT_A  => vf <= op2(op2'left-1);
      when others => vf <= vin;
    end case;
  end process;  

  -- flag "N" negative result logic
  process(op,op2,y)
  begin
    case op is
      when BIT_A  => nf <= op2(op2'left);
      when others => nf <= y(y'left-1);
    end case;
  end process;  

  -- flag "Z" zero result logic (always set with zero results)
  zf <= '1' when y(y'left-1 downto y'right) = "00000000" else '0';

  -- bcd adjustement detection
  process(y)
  begin
    case y(3 downto 0) is
      when "1010" => bcd_l <= '1';  -- 0xA
      when "1011" => bcd_l <= '1';  -- 0xB
      when "1100" => bcd_l <= '1';  -- 0xC
      when "1101" => bcd_l <= '1';  -- 0xD 
      when "1110" => bcd_l <= '1';  -- 0xE
      when "1111" => bcd_l <= '1';  -- 0xF
      when others => bcd_l <= '0';
    end case;
    case y(7 downto 4) is
      when "1010" => bcd_h <= '1';  -- 0xA
      when "1011" => bcd_h <= '1';  -- 0xB
      when "1100" => bcd_h <= '1';  -- 0xC
      when "1101" => bcd_h <= '1';  -- 0xD 
      when "1110" => bcd_h <= '1';  -- 0xE
      when "1111" => bcd_h <= '1';  -- 0xF
      when others => bcd_h <= '0';
    end case;
  end process;  
  process(y)
  begin
    case y(7 downto 0) is
      when "10011010" => bcd_lh <= '1';  -- 0x9A
      when "10011011" => bcd_lh <= '1';  -- 0x9B
      when "10011100" => bcd_lh <= '1';  -- 0x9C
      when "10011101" => bcd_lh <= '1';  -- 0x9D 
      when "10011110" => bcd_lh <= '1';  -- 0x9E
      when "10011111" => bcd_lh <= '1';  -- 0x9F
      when others     => bcd_lh <= '0';
    end case;
  end process;  

  bcd_ol <= bcd_l or bcd_lh;
  bcd_oh <= bcd_h or bcd_lh;
  cf <= c;  
  pc_cf <= pc_c;
  dout <= y(y'left-1 downto y'right);    
end comb;


