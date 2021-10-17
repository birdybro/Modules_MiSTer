library IEEE;
use IEEE.std_logic_1164.all;  -- defines std_logic types
use IEEE.STD_LOGIC_unsigned.all;
use IEEE.STD_LOGIC_arith.all;

-- interrupt request logic
entity intlog is
  port(    clk:  in STD_LOGIC;
          iack:  in STD_LOGIC;                    -- interrupt acknowledge by microcode 
             r:  in STD_LOGIC;                    -- RESET request
             n:  in STD_LOGIC;                    -- NMI request
             i:  in STD_LOGIC;                    -- IRQ request
             b:  in STD_LOGIC;                    -- BRK opcode
             s:  in STD_LOGIC;                    -- SO
         imask:  in STD_LOGIC;                    -- interrupt mask (valid only for IRQ)
         ioffs:  in STD_LOGIC_VECTOR(1 downto 0); -- interrupt servicing offset
          ireq: out STD_LOGIC;                    -- global interrupt requestb (IRQ/NMI)
          vset: out STD_LOGIC;                    -- SO output
         voffs: out STD_LOGIC_VECTOR(2 downto 0)  -- interrupt vector offset 
        );
end intlog;

architecture rtl of intlog is
signal irq_sync: STD_LOGIC_VECTOR(1 downto 0);
signal nmi_sync: STD_LOGIC_VECTOR(1 downto 0);
signal res_sync: STD_LOGIC_VECTOR(1 downto 0);
signal irq_req:  STD_LOGIC;
signal nmi_req:  STD_LOGIC;
signal res_req:  STD_LOGIC;
signal nmi_clr:  STD_LOGIC;
signal res_clr:  STD_LOGIC;
signal irq_brk:  STD_LOGIC;
signal so_sync:  STD_LOGIC_VECTOR(1 downto 0);

begin
  process(clk)                                                           -- IRQ/NMI synchronization
  begin
    if(clk'event and clk = '1')then
      res_sync <= res_sync(res_sync'left-1 downto res_sync'right) & r;   -- RES sampling
      nmi_sync <= nmi_sync(nmi_sync'left-1 downto nmi_sync'right) & n;   -- NMI sampling
      irq_sync <= irq_sync(irq_sync'left-1 downto irq_sync'right) & i;   -- IRQ sampling
      if res_clr = '1' then                                              -- RES ack
        res_req <= '0';
      else
        if res_sync = "11" then                                          -- level detection for RES
          res_req <= '1';
        else
          res_req <= res_req;
        end if;
      end if;                    
      if nmi_clr = '1' then                                              -- NMI ack
        nmi_req <= '0';
      else
        if nmi_sync = "01" then                                          -- edge detection for NMI
          nmi_req <= '1';
        else
          nmi_req <= nmi_req;
        end if;
      end if;                    
    end if;  
  end process;
  
  process(imask, irq_sync)
  begin
    if imask = '0' then
      if irq_sync = "11" then
        irq_req <= '1';
      else   
        irq_req <= '0';
      end if;  
    else
      irq_req <= '0';
    end if;
  end process;
    
  irq_brk <= irq_req or b;                                               -- IRQ | BRK (opcode)
  
  -- priority encoder and vector offset generation (vector bits 2..0)
  voffs <= "100" when res_req = '1' else                                 -- RESET VECTOR:    0xFFFC - 0xFFFD   
           "010" when nmi_req = '1' else                                 -- NMI VECTOR:      0xFFFA - 0xFFFB
           "110" when irq_brk = '1' else "XXX";                          -- IRQ/BRK VECTOR:  0xFFFE - 0xFFFF

  process(iack,ioffs)                                                    -- interrupt acknowledge and flags clear
  begin
    if iack = '1' then
      case ioffs is
        when "10"   => res_clr <= '1';                                   -- RESET acknowledge
                       nmi_clr <= '1';                                   -- also NMI acknowledge
        when "01"   => nmi_clr <= '1';                                   -- NMI acknowledge
                       res_clr <= '0';
        when others => res_clr <= '0';             
                       nmi_clr <= '0';
      end case;
    else  
      res_clr <= '0';
      nmi_clr <= '0';
    end if;  
  end process;

  process(clk)                                                           -- SO synchronization
  begin
    if(clk'event and clk = '1')then
      so_sync <= so_sync(so_sync'left-1 downto so_sync'right) & s;       -- SO sampling (edge detection)
    end if;
  end process;  
  
  ireq <= res_req or nmi_req or irq_req;
  vset <= '0' when so_sync = "10" else '1';
end rtl;


