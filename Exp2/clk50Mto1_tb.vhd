library ieee;
use ieee.std_logic_1164.all;

entity clk50Mto1_tb is
end clk50Mto1_tb;

architecture arch_tb of clk50Mto1_tb is
	component clk50Mto1 is
   port(
		clk    :in std_logic;
		reset  :in std_logic;
		clk1Hz :out std_logic
	);
   end component;

   signal clk, reset : std_logic;
	signal clk1Hz : std_logic;

begin
   u1 :clk50Mto1 port map(
		clk, reset,
		clk1Hz);
		  
	reset <= '0';
	
	process
	begin
		clk <= '0';
		wait for 10 ns;
		clk <= '1';
		wait for 10 ns;
	end process;
end arch_tb;