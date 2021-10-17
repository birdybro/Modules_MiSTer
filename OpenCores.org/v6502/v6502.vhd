----------------------------------------------------------------------
-- 8 bit microprocessor (65C02) with some enhances VHDL project     -- 
-- Full RTL synchronous pipelined architecture                      --
-- Project by Valerio Venturi (Italy)                               -- 
-- Date: 14/04/2011                                                 --
-- Last revision: 19/04/2020                                        --
----------------------------------------------------------------------

-- NOTE:
-- in this version I made some changes on the pr.vhd and mcpla.vhd files because some instructions changed the V flag by mistake


library IEEE;
use IEEE.std_logic_1164.all;                             -- defines std_logic types
use IEEE.STD_LOGIC_unsigned.all;
use IEEE.STD_LOGIC_arith.all;

-- global architecture 
entity v6502 is
  port(     clk0:    in STD_LOGIC;                       -- PHASE0 clock input
             res:    in STD_LOGIC;                       -- reset input
             irq:    in STD_LOGIC;                       -- interrupt request input
             nmi:    in STD_LOGIC;                       -- not maskable interrupt input
             rdy:    in STD_LOGIC;                       -- wait state input (read/write)
              so:    in STD_LOGIC;                       -- set overflow V input
              rw:   out STD_LOGIC;                       -- read/write out
            sync:   out STD_LOGIC;                       -- opcode fetch out
              vp:   out STD_LOGIC;                       -- vector pull
             ope:   out STD_LOGIC;                       -- microcode end 
            addr:   out STD_LOGIC_VECTOR(15 downto 0);   -- 16 bit address bus out
         data_in:    in STD_LOGIC_VECTOR(7 downto 0);    -- 8 bit input data bus
        data_out:   out STD_LOGIC_VECTOR(7 downto 0)     -- 8 bit output data bus
      );   
end v6502;

architecture struct of v6502 is
  signal      i_res: STD_LOGIC;                      -- internal global reset RES
  signal      i_irq: STD_LOGIC;                      -- internal interrupt request IRQ
  signal      i_nmi: STD_LOGIC;                      -- internal interrupt request NMI
  signal      i_rdy: STD_LOGIC;                      -- internal wait request RDY
  signal       i_so: STD_LOGIC;                      -- internal set overflow SO
  signal       i_vp: STD_LOGIC;                      -- internal VP (vector pull)
  signal        int: STD_LOGIC;                      -- internal global interrupt (instruction boundary synchronized)
  signal         we: STD_LOGIC;                      -- write enable (combinatorial from PLA)
  signal       we_r: STD_LOGIC;                      -- write enable (registered)
  signal        ien: STD_LOGIC;                      -- interrupt IRQ enable

  -- microcode signals (register control)
  signal      regop: STD_LOGIC_VECTOR(3 downto 0);   -- register operation microcode
  signal       rsel: STD_LOGIC_VECTOR(3 downto 0);   -- register select microcode
  signal        a_l: STD_LOGIC;                      -- A load
  signal        x_l: STD_LOGIC;                      -- X load
  signal        y_l: STD_LOGIC;                      -- Y load
  signal        z_l: STD_LOGIC;                      -- Y load
  signal        p_l: STD_LOGIC;                      -- P load
  signal        o_l: STD_LOGIC;                      -- OPE load
  signal      sp_ll: STD_LOGIC;                      -- SP load lsb
  signal      sp_lh: STD_LOGIC;                      -- SP load msb
  signal       sp_u: STD_LOGIC;                      -- SP increment
  signal       sp_d: STD_LOGIC;                      -- SP decrement
  signal   dmux_sel: STD_LOGIC_VECTOR(1 downto 0);   -- ALU operand #2 data multiplexer

  -- microcode signals (ALU control)
  signal      aluop: STD_LOGIC_VECTOR(4 downto 0);   -- ALU operation code    

  -- microcode signals CPU control logic
  signal    opfetch: STD_LOGIC;                      -- opcode fetch 
  signal     i_sync: STD_LOGIC;                      -- internal SYNC not latched
  signal     m_sync: STD_LOGIC;                      -- internal SYNC latched
  signal      opdec: STD_LOGIC;                      -- opcode decode
  signal       pcmp: STD_LOGIC_VECTOR(1 downto 0);   -- PC/MP out control effective
  signal    pcmp_mc: STD_LOGIC_VECTOR(1 downto 0);   -- PC/MP out control microcode
  signal      pcinc: STD_LOGIC;                      -- PC increment
  signal      e_eop: STD_LOGIC;                      -- early microcode sequence end (for some opcodes)
  signal     mc_eop: STD_LOGIC;                      -- microcode sequence end (for some opcodes)
  signal        eop: STD_LOGIC;                      -- microcode sequence end (effective)
  signal      we_mc: STD_LOGIC;                      -- microcode write enable
  signal    we_mc_l: STD_LOGIC;                      -- microcode write enable to latch
  signal       fbrk: STD_LOGIC;                      -- force BRK opcode (used by hardware interrupts) 
  signal      opbrk: STD_LOGIC;                      -- BRK opcode (used for distinguish between hardware/software interrupts) 
  signal        bcf: STD_LOGIC;                      -- branch condition resolved
  signal        pcc: STD_LOGIC;                      -- PC carry
  signal       clri: STD_LOGIC;                      -- clear interrupt request pending microcode
  signal        vso: STD_LOGIC;                      -- SO input high to low edge flag
  signal  mc_branch: STD_LOGIC;                      -- branch (relative) opcode 
  signal adc_sbc_mc: STD_LOGIC;                      -- ADC/SBC opcode (used for decimal adjustment)
  signal      ai_op: STD_LOGIC;                      -- opcode with absolute indexed addressing mode
  signal    daa_req: STD_LOGIC;                      -- DAA required
  signal       mcad: STD_LOGIC_VECTOR(10 downto 0);  -- microcode address
  signal     mcscan: STD_LOGIC_VECTOR(2 downto 0);   -- microcode pointer control
  signal       p_op: STD_LOGIC_VECTOR(3 downto 0);   -- microcode control bits register P
  signal     pcr_fc: STD_LOGIC_VECTOR(2 downto 0);   -- microcode control PC 
  signal     mpr_fc: STD_LOGIC_VECTOR(3 downto 0);   -- microcode control MP 
  signal      mcbit: STD_LOGIC_VECTOR(34 downto 0);  -- microcode control bits
  signal     regbit: STD_LOGIC_VECTOR(8 downto 0);   -- microcode control bits
  signal     ivoffs: STD_LOGIC_VECTOR(2 downto 0);   -- microcode interrupt vector offset encoding
  signal        mcn: STD_LOGIC;                      -- microcode does NOPs
  signal add_sub_op: STD_LOGIC;                      -- ADC/SBC opcode

  -- ALU signals 
  signal        bcd: STD_LOGIC;                      -- ALU binary/bcd mode
  signal      c_flg: STD_LOGIC;                      -- ALU carry flag
  signal      z_flg: STD_LOGIC;                      -- ALU zero flag  
  signal      v_flg: STD_LOGIC;                      -- ALU overflow flag  
  signal      n_flg: STD_LOGIC;                      -- ALU negative flag  
  signal   pc_c_alu_flg: STD_LOGIC;                  -- ALU PC carry flag  
  signal    acr_reg: STD_LOGIC;                      -- ALU auxiliary carry (registered)
  signal    bcd_lsb: STD_LOGIC;                      -- bcd lsb overflow flag
  signal    bcd_msb: STD_LOGIC;                      -- bcd msb overflow flag
  signal branch_neg: STD_LOGIC;                      -- branch negative offset flag          

  -- bus
  signal       dbin: STD_LOGIC_VECTOR(7 downto 0);   -- input data bus D0..D7 
  signal      dbout: STD_LOGIC_VECTOR(7 downto 0);   -- output data bus D0..D7
  signal      a_bus: STD_LOGIC_VECTOR(7 downto 0);   -- accumulator register A bus
  signal      x_bus: STD_LOGIC_VECTOR(7 downto 0);   -- index register X bus
  signal      y_bus: STD_LOGIC_VECTOR(7 downto 0);   -- index register Y bus
  signal      z_bus: STD_LOGIC_VECTOR(7 downto 0);   -- index register Z bus
  signal     sp_bus: STD_LOGIC_VECTOR(15 downto 0);  -- stack pointer register S bus
  signal      p_bus: STD_LOGIC_VECTOR(7 downto 0);   -- status register P bus
  signal     op_bus: STD_LOGIC_VECTOR(7 downto 0);   -- opcode register bus
  signal      o_bus: STD_LOGIC_VECTOR(7 downto 0);   -- operand register bus
  signal    bcd_bus: STD_LOGIC_VECTOR(7 downto 0);   -- bcd constants bus (used for decimal adjustement)
  signal   oper_bus: STD_LOGIC_VECTOR(7 downto 0);   -- operand bus (ALU operand #2 bus)
  signal      r_bus: STD_LOGIC_VECTOR(7 downto 0);   -- general register bus (ALU operand #2 bus)
  signal    alu_bus: STD_LOGIC_VECTOR(7 downto 0);   -- ALU output bus
  signal     pc_bus: STD_LOGIC_VECTOR(15 downto 0);  -- program counter register PC bus
  signal     mp_bus: STD_LOGIC_VECTOR(15 downto 0);  -- memory pointer register PC bus
  signal     ad_bus: STD_LOGIC_VECTOR(15 downto 0);  -- address bus

  -- 16 bit program counter register (PC)
  component pcr
    port(   clk:  in STD_LOGIC;                        -- clock
              i:  in STD_LOGIC;                        -- increment 
          fwait:  in STD_LOGIC;                        -- wait
             fc:  in STD_LOGIC_VECTOR(3 downto 0);     -- function code
           din1:  in STD_LOGIC_VECTOR(7 downto 0);     -- input
           din2:  in STD_LOGIC_VECTOR(7 downto 0);     -- input
           dout: out STD_LOGIC_VECTOR(15 downto 0)     -- output
        );
  end component;        

  -- 16 bit memory pointer register (MP)
  component mpr
    port(   clk:  in STD_LOGIC;                       -- clock
          fwait:  in STD_LOGIC;                       -- wait
              c:  in STD_LOGIC;                       -- carry input
             fc:  in STD_LOGIC_VECTOR(3 downto 0);    -- function code
          din_l:  in STD_LOGIC_VECTOR(7 downto 0);    -- input LSB
          din_h:  in STD_LOGIC_VECTOR(7 downto 0);    -- input MSB
             zp:  in STD_LOGIC_VECTOR(7 downto 0);    -- input zero bage register Z 
              v:  in STD_LOGIC_VECTOR(2 downto 0);    -- vector offset input
           dout: out STD_LOGIC_VECTOR(15 downto 0)    -- output
        );
  end component;        

  -- 8 bit opcode register opr (pipeline opcode prefetch register)
  component opr
    port(   clk:  in STD_LOGIC;                        -- clock
            clr:  in STD_LOGIC;                        -- force BRK opcode
          fwait:  in STD_LOGIC;                        -- wait
             ld:  in STD_LOGIC;                        -- load
            din:  in STD_LOGIC_VECTOR(7 downto 0);     -- input 
              b: out STD_LOGIC;                        -- BRK opcode          
           dout: out STD_LOGIC_VECTOR(7 downto 0)      -- output
        );        
  end component;

  -- 8 bit operand hold register oper
  component oper
    port(   clk:  in STD_LOGIC;                        -- clock
          fwait:  in STD_LOGIC;                        -- wait
             ld:  in STD_LOGIC;                        -- load
            din:  in STD_LOGIC_VECTOR(7 downto 0);     -- input 
           dout: out STD_LOGIC_VECTOR(7 downto 0)      -- output
        );        
  end component;

  -- 8 bit accumulator register A
  component ar
    port(   clk:  in STD_LOGIC;                        -- clock                      
          fwait:  in STD_LOGIC; 
             ld:  in STD_LOGIC;                        -- load
            din:  in STD_LOGIC_VECTOR(7 downto 0);     -- input
           dout: out STD_LOGIC_VECTOR(7 downto 0)      -- output
        );        
  end component;

  -- 8 bit index register X 
  component xr
    port(   clk:  in STD_LOGIC;                        -- clock                         
          fwait:  in STD_LOGIC; 
             ld:  in STD_LOGIC;                        -- load
            din:  in STD_LOGIC_VECTOR(7 downto 0);     -- input 
           dout: out STD_LOGIC_VECTOR(7 downto 0)      -- output
        );        
  end component;

  -- 8 bit index register Y 
  component yr
    port(   clk:  in STD_LOGIC;                        -- clock
          fwait:  in STD_LOGIC; 
             ld:  in STD_LOGIC;                        -- load
            din:  in STD_LOGIC_VECTOR(7 downto 0);     -- input 
           dout: out STD_LOGIC_VECTOR(7 downto 0)      -- output
        );        
  end component;

  -- 8 bit zero page register Z 
  -- cleared by any interrupts
  component zr
    port(   clk:  in STD_LOGIC;                        -- clock
            clr:  in STD_LOGIC;                        -- reset
          fwait:  in STD_LOGIC; 
             ld:  in STD_LOGIC;                        -- load
            din:  in STD_LOGIC_VECTOR(7 downto 0);     -- input 
           dout: out STD_LOGIC_VECTOR(7 downto 0)      -- output
        );        
  end component;

  -- 16 bit stack pointer SP 
  component spr
    port(   clk:  in STD_LOGIC;                        -- clock
          fwait:  in STD_LOGIC;                        -- wait
            clr:  in STD_LOGIC;                        -- load init value
           ld_l:  in STD_LOGIC;                        -- load lsb
           ld_h:  in STD_LOGIC;                        -- load msb
              u:  in STD_LOGIC;                        -- increment
              d:  in STD_LOGIC;                        -- decrement
            din:  in STD_LOGIC_VECTOR(7 downto 0);     -- input
           dout: out STD_LOGIC_VECTOR(15 downto 0)     -- output
      );
  end component;

  -- 8 bit processor status register P
  --  NV1BDIZC    
  --  76543210
  --  ||||||||
  --  ||||||||---    C = carry/borrow flag
  --  |||||||----    Z = zero flag
  --  ||||||-----    I = interrupt mask
  --  |||||------    D = decimal/binary alu mode
  --  ||||-------    B = break opcode flag
  --  |||--------    1 = always "1'
  --  ||---------    V = overflow flag
  --  |----------    N = negative flag
  -- The P register also contains an additional carry/borrow flag (ACR) used for effective address calculation but
  -- it is not visible at program level
  component pr
    port(      clk:  in STD_LOGIC;                        -- clock
               clr:  in STD_LOGIC;                        -- clear
             fwait:  in STD_LOGIC;                        -- wait
                 n:  in STD_LOGIC;                        -- N input
                 v:  in STD_LOGIC;                        -- V input
                 z:  in STD_LOGIC;                        -- Z input
                 c:  in STD_LOGIC;                        -- C input
                 b:  in STD_LOGIC;                        -- B input
                sv:  in STD_LOGIC;                        -- set overflow  
            acr_in:  in STD_LOGIC;                        -- auxiliary carry in   
                fc:  in STD_LOGIC_VECTOR(3 downto 0);     -- function code 
               din:  in STD_LOGIC_VECTOR(7 downto 0);     -- input
              dout: out STD_LOGIC_VECTOR(7 downto 0);     -- output
           acr_out: out STD_LOGIC                         -- auxiliary carry out   
        );        
  end component;

  -- BCD register (used for decimal adjustement)
  component bcd_reg is
    port(    clk:  in STD_LOGIC;
             clr:  in STD_LOGIC;
           fwait:  in STD_LOGIC;   
              en:  in STD_LOGIC;
          bcd_sl:  in STD_LOGIC;                          -- loads "6" to lsb
          bcd_sh:  in STD_LOGIC;                          -- loads "6" to msb
            dout: out STD_LOGIC_VECTOR(7 downto 0)
        );
  end component;

  -- 8 bit (binary/bcd) two-way through pass ALU   
  -- operation:
  -- aluop = "0000" => dout <= op1 (pass/test)
  -- aluop = "0001" => dout <= op1 + op2 + carry 
  -- aluop = "0010" => dout <= op1 - op2 - carry 
  -- aluop = "0011" => dout <= op1 and op2       
  -- aluop = "0100" => dout <= op1  or op2       
  -- aluop = "0101" => dout <= op1 xor op2       
  -- aluop = "0110" => dout <= op1 + 1           
  -- aluop = "0111" => dout <= op1 - 1
  -- aluop = "1000" => dout <= op1 << 1 (ASL)
  -- aluop = "1001" => dout <= op1 >> 1 (LSR)
  -- aluop = "1010" => dout <= op1 << 1 (ROL)
  -- aluop = "1011" => dout <= op1 >> 1 (ROR)
  component alu_bin
    port( alu_byp:  in STD_LOGIC;                      -- ALU bypass (no operation)    
              cin:  in STD_LOGIC;                      -- carry/borrow in
              vin:  in STD_LOGIC;                      -- overflow in
              op1:  in STD_LOGIC_VECTOR(7 downto 0);   -- 8 bit operand #1
              op2:  in STD_LOGIC_VECTOR(7 downto 0);   -- 8 bit operand #2
               fc:  in STD_LOGIC_VECTOR(5 downto 0);   -- function code
               cf: out STD_LOGIC;                      -- carry/borrow (byte) out 
               zf: out STD_LOGIC;                      -- zero flag out
               nf: out STD_LOGIC;                      -- negative flag out
               vf: out STD_LOGIC;                      -- overflow flag out
            pc_cf: out STD_LOGIC;                      -- carry/borrow out for PC operation 
           bcd_ol: out STD_LOGIC;                      -- bcd lsb overflow  
           bcd_oh: out STD_LOGIC;                      -- bcd msb overflow  
             dout: out STD_LOGIC_VECTOR(7 downto 0)    -- 8 bit result out
        );  
  end component;           

  -- PC/MP address multiplexer
  component addrmux
    port(  sel:  in STD_LOGIC_VECTOR(1 downto 0);
             a:  in STD_LOGIC_VECTOR(15 downto 0);
             b:  in STD_LOGIC_VECTOR(15 downto 0);
             s:  in STD_LOGIC_VECTOR(15 downto 0);
             y: out STD_LOGIC_VECTOR(15 downto 0)
        );
  end component;            

  -- register multiplexer
  component regmux
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
  end component;           

  -- data multiplexer (register "O" bypass)
  component dmux is
    port(  sel:  in STD_LOGIC_VECTOR(1 downto 0);
             a:  in STD_LOGIC_VECTOR(7 downto 0);
             b:  in STD_LOGIC_VECTOR(7 downto 0);
             c:  in STD_LOGIC_VECTOR(7 downto 0);
             y: out STD_LOGIC_VECTOR(7 downto 0)
        );
  end component dmux;

  -- microcode sequencer logic
  component mcseq
    port(    clk:  in STD_LOGIC; 
             clr:  in STD_LOGIC;
          mc_nop:  in STD_LOGIC;
           fwait:  in STD_LOGIC;
               q: out STD_LOGIC_VECTOR(2 downto 0)
        );
  end component;          

  -- micropla logic
  -- output fields format:
  component mcpla
    port(    a:  in STD_LOGIC_VECTOR(10 downto 0);
             q: out STD_LOGIC_VECTOR(34 downto 0)
        );
  end component;          

  -- register operation decoding logic
  component decreg
    port(    r:  in STD_LOGIC_VECTOR(3 downto 0);
             y: out STD_LOGIC_VECTOR(8 downto 0)
        );
  end component;                   

  -- cpu main state machine
  component cpufsm
    port(     clk:  in STD_LOGIC;
              clr:  in STD_LOGIC;
            fwait:  in STD_LOGIC;
             ireq:  in STD_LOGIC;
           branch:  in STD_LOGIC;
            bflag:  in STD_LOGIC;
              aim:  in STD_LOGIC;
           bcarry:  in STD_LOGIC;  
           icarry:  in STD_LOGIC;  
               p1:  in STD_LOGIC_VECTOR(1 downto 0); 
             e_ei:  in STD_LOGIC; 
            mc_ei:  in STD_LOGIC; 
           addsub:  in STD_LOGIC;   
         dec_mode:  in STD_LOGIC;   
            fetch: out STD_LOGIC;
          op_sync: out STD_LOGIC;  
              pci: out STD_LOGIC;
               pq: out STD_LOGIC_VECTOR(1 downto 0);
               fb: out STD_LOGIC; 
               od: out STD_LOGIC;
           mc_nop: out STD_LOGIC  
        );     
  end component;
  
  -- interrupt logic
  component intlog
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
  end component;                            

  -- branch logic
  component branch
    port(    op:  in STD_LOGIC_VECTOR(3 downto 0);
              n:  in STD_LOGIC;                        
              v:  in STD_LOGIC;                        
              z:  in STD_LOGIC;                        
              c:  in STD_LOGIC;                        
           bres: out STD_LOGIC
        );      
  end component;                            
  
  -- opcode decimal instructions and prefetch prediction logic
  component pre_dec
    port(    op:  in STD_LOGIC_VECTOR(7 downto 0);
          fetch:  in STD_LOGIC; 
             ei: out STD_LOGIC;
            dec: out STD_LOGIC 
        );      
  end component;                            

  begin  
    u1:pcr      port map(clk=>clk0,
                         i=>pcinc,
                         fwait=>i_rdy,
                         fc(3 downto 1)=>pcr_fc,
                         fc(0)=>o_bus(7),
                         din1=>alu_bus,
                         din2=>o_bus,
                         dout=>pc_bus
                        );

    u2:mpr      port map(clk=>clk0,
                         fwait=>i_rdy,
                         c=>acr_reg,
                         fc=>mpr_fc,
                         din_l=>alu_bus,
                         din_h=>dbin,
                         zp=>z_bus,
                         v=>ivoffs,
                         dout=>mp_bus
                        );

    u3:ar       port map(clk=>clk0,
                         fwait=>i_rdy,
                         ld=>a_l,
                         din=>alu_bus,
                         dout=>a_bus
                        );

    u4:xr       port map(clk=>clk0,
                         fwait=>i_rdy,
                         ld=>x_l,
                         din=>alu_bus,
                         dout=>x_bus
                        );

    u5:yr       port map(clk=>clk0,
                         fwait=>i_rdy,
                         ld=>y_l,
                         din=>alu_bus,
                         dout=>y_bus
                        );

    u6:zr       port map(clk=>clk0,
                         clr=>clri,
                         fwait=>i_rdy,
                         ld=>z_l,
                         din=>alu_bus,
                         dout=>z_bus
                        );

    u7:spr      port map(clk=>clk0,
                         clr=>i_res,
                         fwait=>i_rdy,
                         ld_l=>sp_ll,
                         ld_h=>sp_lh,
                         u=>sp_u,
                         d=>sp_d,
                         din=>alu_bus,
                         dout=>sp_bus
                        );

    u8:pr       port map(clk=>clk0,
                         clr=>i_res,
                         fwait=>i_rdy,
                         n=>n_flg,
                         v=>v_flg,
                         z=>z_flg,
                         c=>c_flg,
                         b=>opbrk,
                         sv=>vso,
                         acr_in=>pc_c_alu_flg,
                         fc=>p_op,
                         din=>dbin,
                         dout=>p_bus,
                         acr_out=>acr_reg
                        ); 
                                             
    u9:opr      port map(clk=>clk0,
                         clr=>fbrk,
                         fwait=>i_rdy,
                         ld=>opfetch,
                         din=>dbin,
                         b=>opbrk,
                         dout=>op_bus
                        );

    u10:oper    port map(clk=>clk0,
                         fwait=>i_rdy,
                         ld=>o_l,
                         din=>alu_bus,
                         dout=>o_bus
                        );

    u11:bcd_reg port map(clk=>clk0,
                         clr=>opfetch,
                         fwait=>i_rdy,
                         en=>bcd,
                         bcd_sl=>bcd_lsb,
                         bcd_sh=>bcd_msb,
                         dout=>bcd_bus
                        );

    u12:alu_bin port map(alu_byp=>acr_reg,
                         cin=>p_bus(0),
                         vin=>p_bus(6),
                         op1=>r_bus,
                         op2=>oper_bus,
                         fc(5 downto 1)=>aluop,                         
                         fc(0)=>branch_neg,
                         cf=>c_flg,
                         zf=>z_flg,
                         nf=>n_flg,
                         vf=>v_flg,
                         pc_cf=>pc_c_alu_flg,
                         bcd_ol=>bcd_lsb,
                         bcd_oh=>bcd_msb,
                         dout=>alu_bus
                        );                                                   

    u13:addrmux port map(sel=>pcmp,
                         a=>pc_bus,
                         b=>mp_bus,
                         s=>sp_bus,
                         y=>addr
                        );
                        
    u14:regmux  port map(sel=>rsel,
                         a=>dbin,
                         b=>a_bus,
                         c=>x_bus,
                         d=>y_bus,
                         e=>sp_bus(7 downto 0),
                         f=>sp_bus(15 downto 8),                    
                         g=>p_bus,
                         h=>pc_bus(7 downto 0),
                         i=>pc_bus(15 downto 8),
                         j=>o_bus,
                         k=>z_bus,
                         y=>r_bus
                        );

    u15:dmux    port map(sel=>dmux_sel,
                         a=>o_bus,
                         b=>dbin,
                         c=>bcd_bus,
                         y=>oper_bus
                        ); 

    u16:mcseq   port map(clk=>clk0,
                         clr=>opdec,
                         mc_nop=>mcn,
                         fwait=>i_rdy,
                         q=>mcscan
                        ); 
                        
    u17:mcpla   port map(a=>mcad,
                         q=>mcbit
                        ); 
                        
    u18:decreg  port map(r=>regop,
                         y=>regbit
                        ); 
                        
    u19:cpufsm  port map(clk=>clk0,
                         clr=>i_res,
                         fwait=>i_rdy,
                         ireq=>int,
                         branch=>mc_branch,
                         bflag=>bcf,
                         aim=>ai_op,
                         bcarry=>pcc,
                         icarry=>acr_reg,
                         p1=>pcmp_mc,
                         e_ei=>e_eop,
                         mc_ei=>mc_eop,
                         addsub=>add_sub_op,
                         dec_mode=>p_bus(3),
                         fetch=>opfetch,
                         op_sync=>i_sync,
                         pci=>pcinc,
                         pq=>pcmp,
                         fb=>fbrk,
                         od=>opdec,
                         mc_nop=>mcn
                        ); 

    u20:intlog  port map(clk=>clk0,
                         iack=>clri,
                         r=>i_res,
                         n=>i_nmi,
                         i=>i_irq,
                         b=>opbrk,
                         s=>i_so,
                         imask=>ien,
                         ioffs=>mp_bus(2 downto 1),
                         ireq=>int,
                         vset=>vso,
                         voffs=>ivoffs
                        );       
                        
    u21:branch  port map(op=>op_bus(7 downto 4),
                         n=>p_bus(7),                                      
                         v=>p_bus(6),
                         z=>p_bus(1),
                         c=>p_bus(0),
                         bres=>bcf
                        ); 

    u22:pre_dec port map(op=>dbin,
                         fetch=>opfetch,
                         ei=>e_eop,
                         dec=>add_sub_op
                        );

    -- asynchronous CPU link section 
    ien        <= p_bus(2);                                -- P(I) flag 
    bcd        <= p_bus(3);                                -- P(D) flag
    i_res      <= not res;                                 -- internal reset
    i_nmi      <= not nmi;                                 -- internal NMI
    i_irq      <= not irq;                                 -- internal IRQ
    i_rdy      <= not rdy;                                 -- internal RDY
    i_so       <= not so;                                  -- internal SO
    mcad       <= op_bus & mcscan;                         -- microcode address
    rsel       <= mcbit(3 downto 0);                       -- registers read microcode
    regop      <= mcbit(7 downto 4);                       -- registers operation microcode
    aluop      <= mcbit(12 downto 8);                      -- ALU microcode
    p_op       <= mcbit(16 downto 13);                     -- register P microcode 
    mpr_fc     <= mcbit(20 downto 17);                     -- MPR microcode
    pcr_fc     <= mcbit(23 downto 21);                     -- PCR microcode
    pcmp_mc    <= mcbit(25 downto 24);                     -- PCR/MPR multiplexer microcode
    clri       <= mcbit(26);                               -- clear interrupt request (also serves as register Z clear)
    we_mc      <= mcbit(27);                               -- write enable (combinatorial) microcode
    we_mc_l    <= mcbit(28);                               -- write enable (latched) microcode
    mc_eop     <= mcbit(29);                               -- end of instruction reached                             
    mc_branch  <= mcbit(30);                               -- branch opcode
    i_vp       <= mcbit(31);                               -- vector pull 
    ai_op      <= mcbit(32);                               -- opcode with addressing indexed microcode
    dmux_sel   <= mcbit(34 downto 33);                     -- data multiplexer microcode
    ope        <= eop;
    eop <= '1' when mc_eop = '1' or e_eop = '1' else '0';
    branch_neg <= '0' when mc_branch = '0' else o_bus(7);  -- flag for branch negative offset is valid only with branches opcode 
    vp <= not i_vp;

    -- register operations
    a_l        <= regbit(0);                               -- A load
    x_l        <= regbit(1);                               -- X load
    y_l        <= regbit(2);                               -- Y load
    z_l        <= regbit(3);                               -- Z load
    o_l        <= regbit(4);                               -- O load
    sp_ll      <= regbit(5);                               -- S load lsb
    sp_lh      <= regbit(6);                               -- S load msb
    sp_u       <= regbit(7);                               -- S += 1
    sp_d       <= regbit(8);                               -- S -= 1
    we         <= we_mc or opfetch;                        -- write enable
    sync       <= m_sync;

    -- SYNC latched
    process(clk0)
    begin
      if (clk0'event and clk0 = '1') then
        if i_rdy = '0' then
          m_sync <= i_sync;
        else
          m_sync <= m_sync;   
        end if;  
      end if;
    end process;  

    -- PC carry logic
    process(o_bus,pc_c_alu_flg)
    begin
      if o_bus(7) = '0' then              -- check for positive/negative branch offset (bit 7)
        pcc <= pc_c_alu_flg;
      else
        pcc <= not pc_c_alu_flg;
      end if;            
    end process;              

    -- write enable registered
    process(clk0)
    begin
      if (clk0'event and clk0 = '1') then
        if i_res = '1' then
          we_r <= '1';
        else   
          if i_rdy = '0' then
            we_r <= we_mc_l;
          else
            we_r <= we_r;
          end if;    
        end if;  
      end if;      
    end process;              
 
    rw <= we and we_r;

    -- data bus tristate (buffer ring gated) control logic
    --process(clk0,we,we_r,alu_bus)
    --begin
    --  if clock = '0' and (we = '0' or we_r = '0') then
    --    data <= alu_bus;
    --  else
    --    data <= "ZZZZZZZZ";
    --  end if;
    --end process;
    data_out <= alu_bus;            
    dbin <= data_in or "00000000";

end struct;    
  


