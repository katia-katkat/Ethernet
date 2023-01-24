--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:38:28 01/06/2023
-- Design Name:   
-- Module Name:   C:/Users/katia/Desktop/Digital design/SPI-ADXL345 project/ethernet/packet_tb.vhd
-- Project Name:  ethernet
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: packet_generator
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
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY packet_tb IS
END packet_tb;
 
ARCHITECTURE behavior OF packet_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT packet
    PORT(
         clock : IN  std_logic;
         reset : IN  std_logic;
         data_i : IN  std_logic_vector(7 downto 0);
         crs_i : IN  std_logic_vector(7 downto 0);
         tx : OUT  std_logic_vector(1 downto 0);
         fifo_read_en : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clock : std_logic := '0';
   signal reset : std_logic := '0';
   signal data_i : std_logic_vector(7 downto 0) ;--:= (others => '0');
   signal crs_i : std_logic_vector(7 downto 0);-- := (others => '0');

 	--Outputs
   signal tx : std_logic_vector(1 downto 0);
   signal fifo_read_en : std_logic;

   -- Clock period definitions
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: packet PORT MAP (
          clock => clock,
          reset => reset,
          data_i => data_i,
          crs_i => crs_i,
          tx => tx,
          fifo_read_en => fifo_read_en
        );

   -- Clock process definitions
   clock_process :process
   begin
		clock <= '0';
		wait for clock_period/2;
		clock <= '1';
		wait for clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      --wait for 100 ns;	

      --wait for clock_period*10;
		data_i <= "10011100";
		crs_i <= "11001100";
      -- insert stimulus here 

      wait;
   end process;

END;
