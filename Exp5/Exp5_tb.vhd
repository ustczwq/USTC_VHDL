library ieee;
use ieee.std_logic_1164.all;

entity Exp5_tb is 
end Exp5_tb;

architecture tb of Exp5_tb is
	component Exp5 is
		port (
			clk   :in std_logic;
			reset :in std_logic;
			q     :out std_logic_vector (7 downto 0)
		);
	end component;
	
	signal clk, reset: std_logic;
	signal q: std_logic_vector (7 downto 0);
begin 
	u1: Exp5 port map (clk, reset, q);
	process
	begin
		clk <= '1';
		wait for 10 ns;
		clk <= '0';
		wait for 10 ns;
	end process;
   
	init: process
	begin
		reset <= '0';
		wait for 20 ns;
	end process init;
end tb;