library ieee;
use ieee.std_logic_1164.all;

entity selector_tb is
end selector_tb;

architecture arch_tb of selector_tb is
	component selector is
		port(
			clk :in std_logic;
			s0, s1, s2 :out std_logic
		);
	end component;
	signal clk :std_logic;
	signal s0, s1, s2 :std_logic;
begin 
	u1: selector port map (
		clk, 
		s0, s1, s2
	);
	process
	begin
		clk <= '0';
		wait for 10ns;
		clk <= '1';
		wait for 10ns;
	end process;
end arch_tb;
		
		
	