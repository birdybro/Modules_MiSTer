-- VHDL Entity r6502_tc.r6502_tc.symbol
--
-- Created:
--          by - eda.UNKNOWN (ENTW-7HPZ200)
--          at - 10:34:09 11.09.2018
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2016.2 (Build 5)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

entity r6502_tc is
   port( 
      clk_clk_i   : in     std_logic;
      d_i         : in     std_logic_vector (7 downto 0);
      irq_n_i     : in     std_logic;
      nmi_n_i     : in     std_logic;
      rdy_i       : in     std_logic;
      rst_rst_n_i : in     std_logic;
      so_n_i      : in     std_logic;
      a_o         : out    std_logic_vector (15 downto 0);
      d_o         : out    std_logic_vector (7 downto 0);
      rd_o        : out    std_logic;
      sync_o      : out    std_logic;
      wr_n_o      : out    std_logic;
      wr_o        : out    std_logic
   );

-- Declarations

end r6502_tc ;

-- (C) 2008 - 2018 Jens Gutschmidt
-- (email: opencores@vivare-services.com)
-- 
-- Versions:
-- Revision 1.4  2018/09/15 22:07:00  jens
-- - RESET generates SYNC now, 1 dead cycle
--   delayed
-- - ADC / SBC flags and A like R6502 now
-- - Bug Fix ADC and SBC in decimal mode
--   (all op codes - "Overflow" flag was computed
--   wrong)
-- - Interrupt priority order is now: BRK - NMI -
--   IRQ
-- - Performance improvements on-going
--   (Mealy -> Moore)
-- - Bug Fixes All Branch Instructions 
--   (BCC, BCS, BEQ, BNE, BPL, BMI, BVC,
--   BVS)
--   3 cycles now if branch forward occur and
--   the branch instruction lies on a xxFEh
--   location.
-- - Bug Fix Hardware Interrupts NMI & IRQ -
--   "SYNC" now
-- 
-- Revision 1.4  BETA 2013/07/24 11:11:00  jens
-- - Changing the title block and internal revision history
-- - Bug Fix ADC and SBC (all sub codes - "Overflow" flag was computed wrong)
-- 
-- Revision 1.3  2009/01/04 10:20:50  eda
-- Changes for cosmetic issues only
-- 
-- Revision 1.2  2009/01/04 09:23:12  eda
-- - Delete unused nets and blocks
-- - Rename blocks
-- - Re-arrage FSM symbols in block FSM_Execution_Unit
-- 
-- Revision 1.1  2009/01/03 16:36:48  eda
-- Production version
--  
-- 
--
-- VHDL Architecture r6502_tc.r6502_tc.struct
--
-- Created:
--          by - eda.UNKNOWN (ENTW-7HPZ200)
--          at - 22:34:11 15.09.2018
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2016.2 (Build 5)
--
-- COPYRIGHT (C) 2008 - 2018 by Jens Gutschmidt
-- 
-- This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or any later version.
-- 
-- This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
-- 
-- You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.
-- 
-- 
LIBRARY ieee;
USE ieee.std_logic_1164.all;

library r6502_tc;

architecture struct of r6502_tc is

   -- Architecture declarations

   -- Internal signal declarations


   -- Component Declarations
   component core
   port (
      clk_clk_i   : in     std_logic ;
      d_i         : in     std_logic_vector (7 downto 0);
      irq_n_i     : in     std_logic ;
      nmi_n_i     : in     std_logic ;
      rdy_i       : in     std_logic ;
      rst_rst_n_i : in     std_logic ;
      so_n_i      : in     std_logic ;
      a_o         : out    std_logic_vector (15 downto 0);
      d_o         : out    std_logic_vector (7 downto 0);
      rd_o        : out    std_logic ;
      sync_o      : out    std_logic ;
      wr_n_o      : out    std_logic ;
      wr_o        : out    std_logic 
   );
   end component;

   -- Optional embedded configurations
   -- pragma synthesis_off
   for all : core use entity r6502_tc.core;
   -- pragma synthesis_on


begin

   -- Instance port mappings.
   U_0 : core
      port map (
         clk_clk_i   => clk_clk_i,
         d_i         => d_i,
         irq_n_i     => irq_n_i,
         nmi_n_i     => nmi_n_i,
         rdy_i       => rdy_i,
         rst_rst_n_i => rst_rst_n_i,
         so_n_i      => so_n_i,
         a_o         => a_o,
         d_o         => d_o,
         rd_o        => rd_o,
         sync_o      => sync_o,
         wr_n_o      => wr_n_o,
         wr_o        => wr_o
      );

end struct;