-------------------------------------------------------------------------------
--
-- Copyright 2020
-- ASTRON (Netherlands Institute for Radio Astronomy) <http://www.astron.nl/>
-- P.O.Box 2, 7990 AA Dwingeloo, The Netherlands
-- 
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
-- 
--     http://www.apache.org/licenses/LICENSE-2.0
-- 
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
--
-------------------------------------------------------------------------------

-- Purpose: Multi page memory
-- Description:
--   When next_page_* pulses then the next access will occur in the next page.
-- Remarks:
-- . See common_paged_ram_crw_crw for details.

LIBRARY IEEE; --, technology_lib;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
LIBRARY common_pkg_lib;
USE common_pkg_lib.common_pkg.ALL;
--USE technology_lib.technology_select_pkg.ALL;

ENTITY common_paged_ram_r_w IS
  GENERIC (
    g_technology      : NATURAL := 0;
    g_str             : STRING := "use_adr";
    g_data_w          : NATURAL;
    g_nof_pages       : NATURAL := 2;  -- >= 2
    g_page_sz         : NATURAL;
    g_wr_start_page   : NATURAL := 0;
    g_rd_start_page   : NATURAL := 0;
    g_rd_latency      : NATURAL := 1
  );
  PORT (
    rst          : IN  STD_LOGIC;
    clk          : IN  STD_LOGIC;
    clken        : IN  STD_LOGIC := '1';
    wr_next_page : IN  STD_LOGIC;
    wr_adr       : IN  STD_LOGIC_VECTOR(ceil_log2(g_page_sz)-1 DOWNTO 0) := (OTHERS=>'0');
    wr_en        : IN  STD_LOGIC := '0';
    wr_dat       : IN  STD_LOGIC_VECTOR(g_data_w-1 DOWNTO 0) := (OTHERS=>'0');
    rd_next_page : IN  STD_LOGIC;
    rd_adr       : IN  STD_LOGIC_VECTOR(ceil_log2(g_page_sz)-1 DOWNTO 0) := (OTHERS=>'0');
    rd_en        : IN  STD_LOGIC := '1';
    rd_dat       : OUT STD_LOGIC_VECTOR(g_data_w-1 DOWNTO 0);
    rd_val       : OUT STD_LOGIC
  );
END common_paged_ram_r_w;


ARCHITECTURE str OF common_paged_ram_r_w IS

BEGIN

  u_rw_rw : ENTITY work.common_paged_ram_rw_rw
  GENERIC MAP (
    g_technology     => g_technology,
    g_str            => g_str,
    g_data_w         => g_data_w,
    g_nof_pages      => g_nof_pages,
    g_page_sz        => g_page_sz,
    g_start_page_a   => g_wr_start_page,
    g_start_page_b   => g_rd_start_page,
    g_rd_latency     => g_rd_latency,
    g_true_dual_port => FALSE
  )
  PORT MAP (
    rst         => rst,
    clk         => clk,
    clken       => clken,
    next_page_a => wr_next_page,
    adr_a       => wr_adr,
    wr_en_a     => wr_en,
    wr_dat_a    => wr_dat,
    rd_en_a     => '0',
    rd_dat_a    => OPEN,
    rd_val_a    => OPEN,
    next_page_b => rd_next_page,
    adr_b       => rd_adr,
    wr_en_b     => '0',
    wr_dat_b    => (OTHERS=>'0'),
    rd_en_b     => rd_en,
    rd_dat_b    => rd_dat,
    rd_val_b    => rd_val
  );

END str;
