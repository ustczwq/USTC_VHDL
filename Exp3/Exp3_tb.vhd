library ieee;
use ieee.std_logic_1164.all;

entity Exp3_tb is
end Exp3_tb;

architecture arch_tb of Exp3_tb is
	component Exp3 is
		port(
			clk, en, reset :in std_logic;
			s0, s1, s2     :in std_logic;
			d0, d1, d2, d3 :in std_logic;
			a, b, c, d, e, f, g :out std_logic;
			y7, y6, y5, y4, y3, y2, y1, y0 :out std_logic
		);
	end component;
	
	signal clk, en, reset : std_logic;
	signal s0, s1, s2     : std_logic;
	signal d0, d1, d2, d3 : std_logic;
	signal a, b, c, d, e, f, g : std_logic;
	signal y7, y6, y5, y4, y3, y2, y1, y0 : std_logic;
	
begin 
	u1: Exp3 port map (
		clk, en, reset,
		s0, s1, s2,
		d0, d1, d2, d3,
		a, b, c, d, e, f, g,
		y7, y6, y5, y4, y3, y2, y1, y0
	);
   reset <= '0';
	en <= '1';
	s0 <= '1';
	s1 <= '0';
	s2 <= '1';
	d0 <= '0';
	d1 <= '0';
	d2 <= '0';
	d3 <= '1';
	process
	begin
		clk <= '0';
		wait for 10ns;
		clk <= '1';
		wait for 10ns;
	end process;
end arch_tb;
		
		
	