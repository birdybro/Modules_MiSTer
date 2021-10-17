--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   00:00:04 08/14/2009
-- Design Name:   
-- Module Name:   /home/yann/fpga/work/pdp1-3/testtop.vhd
-- Project Name:  pdp1-3
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: top
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

USE std.textio.ALL;
 
ENTITY testtop IS
END testtop;
 
ARCHITECTURE behavior OF testtop IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT top
    PORT(
         CLK_50M : IN  std_logic;
         CLK_AUX : IN  std_logic;
         LED : OUT  std_logic_vector(7 downto 0);
         SW : IN  std_logic_vector(3 downto 0);
         AWAKE : OUT  std_logic;
         SPI_MOSI : OUT  std_logic;
         DAC_CS : OUT  std_logic;
         SPI_SCK : OUT  std_logic;
         DAC_CLR : OUT  std_logic;
         DAC_OUT : IN  std_logic;
			RS232_DCE_RXD : IN std_logic;
			RS232_DCE_TXD : OUT std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK_50M : std_logic := '0';
   signal CLK_AUX : std_logic := '0';
   signal SW : std_logic_vector(3 downto 0) := (others => '0');
   signal DAC_OUT : std_logic := '0';

 	--Outputs
   signal LED : std_logic_vector(7 downto 0);
   signal AWAKE : std_logic;
   signal SPI_MOSI : std_logic;
   signal DAC_CS : std_logic;
   signal SPI_SCK : std_logic;
   signal DAC_CLR : std_logic;
	signal TXD, RXD : std_logic;

	-- UART interface
	COMPONENT Minimal_UART_CORE
	PORT(
		CLOCK : IN std_logic;
		RXD : IN std_logic;
		INP : IN std_logic_vector(7 downto 0);
		WR : IN std_logic;    
		OUTP : INOUT std_logic_vector(7 downto 0);      
		EOC : OUT std_logic;
		TXD : OUT std_logic;
		EOT : OUT std_logic;
		READY : OUT std_logic
		);
	END COMPONENT;
	signal received_byte, old_received_byte, tx_ready, wrote, byte_request,
		eot : std_logic := '0';
	signal read_byte, write_byte: std_logic_vector(7 downto 0);


   constant CLK_50M_period : time := 20ns;
   constant CLK_AUX_period : time := 7.5ns;

	constant bittime : time := 8.680555us; --1s/115200;
	constant waittime : time := 20*bittime;

   procedure send_byte (bytetosend : in std_logic_vector(7 downto 0);
								signal tx_ready : in std_logic;
								signal eot : in std_logic;
								signal write_byte : out std_logic_vector(7 downto 0);
								signal wrote : out std_logic)
	is
      -- subprogram_declarative_items (constant declarations, variable declarations, etc.)
   begin
--		wait for 100ns;
		wait until rising_edge(CLK_50M) and tx_ready = '1' and eot='0';
		write_byte <= bytetosend;
		wrote <= '1';
		wait until rising_edge(CLK_50M);
		wrote <= '0';
--		wait until eot='0' and tx_ready='1';

		-- Without UART, it was something like:
--		RXD <= '0'; wait for bittime;
--		RXD <= bytetosend(0); wait for bittime;
--		RXD <= bytetosend(1); wait for bittime;
--		RXD <= bytetosend(2); wait for bittime;
--		RXD <= bytetosend(3); wait for bittime;
--		RXD <= bytetosend(4); wait for bittime;
--		RXD <= bytetosend(5); wait for bittime;
--		RXD <= bytetosend(6); wait for bittime;
--		RXD <= bytetosend(7); wait for bittime;
--		RXD <= '1'; wait for bittime;		-- first sixbit 000101
--		wait for waittime;
   end send_byte;

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: top PORT MAP (
          CLK_50M => CLK_50M,
			 CLK_AUX => CLK_AUX,
          LED => LED,
          SW => SW,
          AWAKE => AWAKE,
          SPI_MOSI => SPI_MOSI,
          DAC_CS => DAC_CS,
          SPI_SCK => SPI_SCK,
          DAC_CLR => DAC_CLR,
          DAC_OUT => DAC_OUT,
			RS232_DCE_RXD => RXD,
			RS232_DCE_TXD => TXD
        );
 
   -- No clocks detected in port list. Replace CLK_50M below with 
   -- appropriate port name 
 
   CLK_50M_process :process
   begin
		CLK_50M <= '0';
		wait for CLK_50M_period/2;
		CLK_50M <= '1';
		wait for CLK_50M_period/2;
   end process;
 
   CLK_AUX_process :process
   begin
		CLK_AUX <= '0';
		wait for CLK_AUX_period/2;
		CLK_AUX <= '1';
		wait for CLK_AUX_period/2;
   end process;
	
	-- UART for talking to UUT
	Inst_Minimal_UART_CORE: Minimal_UART_CORE PORT MAP(
		CLOCK => CLK_50M,
		
		EOC => received_byte,	-- end of character; rising edge indicates valid data in OUTP
		OUTP => read_byte,
		
		RXD => TXD,
		TXD => RXD,

		EOT => eot,	-- end of transmit; indicates a character has been sent
		INP => write_byte,
		READY => tx_ready,	-- indicates that we may write
		WR => wrote
	);
 
	
   -- Stimulus process
   stim_proc: process
		type bytefile is file of integer;  -- TODO: assert 32-bit?
		file rimfile : bytefile;
		variable tapefileword : integer;
		variable tapebytes : signed(31 downto 0);
   begin
		file_open(rimfile, "tapefile.rim", READ_MODE);
		while not endfile(rimfile) loop
			--wait for bittime*12;
			wait until received_byte='1';
			-- I seem to be getting 32-bit signed little endian numbers.
			-- Which naturally don't fit in a byte. 
			read (rimfile, tapefileword);
			tapebytes := to_signed(tapefileword, 32);
			--report "Read a word, value: " & integer'image(tapefileword);

			send_byte(std_logic_vector(tapebytes(7 downto 0)), tx_ready, eot, write_byte, wrote);
			wait until received_byte='1';
			send_byte(std_logic_vector(tapebytes(15 downto 8)), tx_ready, eot, write_byte, wrote);
			wait until received_byte='1';
			send_byte(std_logic_vector(tapebytes(23 downto 16)), tx_ready, eot, write_byte, wrote);
			wait until received_byte='1';
			send_byte(std_logic_vector(tapebytes(31 downto 24)), tx_ready, eot, write_byte, wrote);
			
--			send_byte(conv(tapebyte), tx_ready, eot, write_byte, wrote);
--			send_byte(std_logic_vector(to_signed(integer(tapebyte(0)),8)), tx_ready, eot, write_byte, wrote);
--			send_byte("10000101", tx_ready, eot, write_byte, wrote);
--			send_byte("00111111", tx_ready, eot, write_byte, wrote);  -- ignored, as bit 7 is not set
--			send_byte("10000110", tx_ready, eot, write_byte, wrote);
--			send_byte("10111000", tx_ready, eot, write_byte, wrote);  -- Together 050670
		-- TODO: show reply data
		end loop;
		file_close(rimfile);
		report "Reached end of RIM (paper tape) file";

      wait for CLK_50M_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
