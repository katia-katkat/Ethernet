----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:16:33 01/05/2023 
-- Design Name: 
-- Module Name:    packet_generator - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: sending a fixed ethernet packet(no fifo), using the autonegotiation mode (no MDIO)
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity packet is
PORT(clock : in std_logic;
	  reset : in std_logic;
	  data_i : in std_logic_vector( 7 downto 0);
	  crs_i : in std_logic_vector( 7 downto 0);
	  tx : out std_logic_vector( 1 downto 0);
	  tx_en : out std_logic;
	  fifo_read_en :out std_logic 
	  
	  );
end packet;

architecture Behavioral of packet is
-- time required for each state constants 
constant HEADER_t : integer:= 4; -- 20*8/2 =180  
constant DATA_t : integer:= 4; --46*8/2 = 184  
constant CRS_t : integer:= 4; --4*8/2 = 16
type state is (IDLE,HEADER, DATA, CRS);
signal packet : state := IDLE;
signal counter : integer range 0 to 190 := 0;
signal HEADER_d : std_logic_vector( 7 downto 0):= "10101010";
begin

-- state transition
process(clock)
begin 
	if(rising_edge(clock)) then
		if(reset = '0') then
		else
		   txen <= '1';
			case packet is 
				when IDLE => 
						packet <= HEADER;
				when HEADER => 
					if counter = HEADER_t-1 then 
						counter <= 0;
						packet  <= DATA;
					else 
						counter <= counter + 1;
					end if;
				when DATA =>
					if counter = DATA_t-1 then 
						counter <= 0;
						packet  <= CRS;
					else 
						counter <= counter + 1;
					end if;
				when CRS => 
					if counter = CRS_t-1 then 
						counter <= 0;
						packet  <= HEADER;
						fifo_read_en <= '1';

					else 
						counter <= counter + 1;
					end if;
						
			end case;
end process;

process(packet, counter) 
begin
case packet is 
when IDLE =>   tx <= HEADER_d(2*counter + 1 downto 2*counter) ;
when HEADER => tx <= HEADER_d(2*counter + 1 downto 2*counter) ;
when DATA   => tx <= DATA_i  (2*counter + 1 downto 2*counter) ;
when CRS    => tx <= crs_i   (2*counter + 1 downto 2*counter);
when OTHERS => tx <= "00" ;
end case;
end process;


end Behavioral;

