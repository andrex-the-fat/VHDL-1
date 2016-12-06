----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:26:36 07/24/2016 
-- Design Name: 
-- Module Name:    MEMORY_M_512x16 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MEMORY_M_512x16 is
PORT(
	data_in, address_in : in std_logic_vector(15 downto 0);
	mw, mr, clk : in std_logic;
	data_out : out std_logic_vector(15 downto 0));
	
end MEMORY_M_512x16;

architecture Behavioral of MEMORY_M_512x16 is
	type mem_array is array (511 downto 0) of std_logic_vector(15 downto 0);
	signal access_enable : std_logic;
begin
	process(data_in, address_in, access_enable)
	variable data_mem : mem_array := (
	X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000",	
	X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000",	
	X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000",	
	X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000",	
	X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000",	
	X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000",	
	X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000",	
	X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"9080", 			X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"F000",			 X"0000", X"0000",X"0000", X"0000", X"0000", X"0000",X"0000", X"8100", X"0094", X"6C01",X"4066", X"B00B", X"6100", X"FACE",X"6180", X"0000");	-- write FACE to R6, B00B to R4, AND BOOB with FACE and write to R1, store R1 in address 0x94 (148), jump to 0x20 where branch carry clear instruction brances to 0x10
																																																																																																																																																							--	X"8000", X"8000", X"FFFF",X"6180", X"0000");	-- write FACE to R6, B00B to R4, ADD BOOB to FACE and write to R1																																																
	variable addr : integer;																																																																																																																																																																																																
	
	begin		
	
		if (access_enable = '1') then
			addr := conv_integer(address_in(8 downto 0));
			if (mw = '1') then data_mem(addr) := data_in;
			elsif (mr = '1') then data_out <= data_mem(addr);
			end if;		
		end if;
	end process;	
	
	process(clk)
	begin
		if (rising_edge(clk)) then
		access_enable <= '1';
		elsif (falling_edge(clk)) then
		access_enable <= '0';
		end if;
	end process;
	
end Behavioral;
