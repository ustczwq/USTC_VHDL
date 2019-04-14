library ieee;
use ieee.std_logic_1164.all;

entity Exp3 is
	port(
		clk, en, reset :in std_logic;
		s0, s1, s2     :in std_logic;
		d0, d1, d2, d3 :in std_logic;
		a, b, c, d, e, f, g :out std_logic;
		y7, y6, y5, y4, y3, y2, y1, y0 :out std_logic
	);
end Exp3;

architecture behave of Exp3 is
	component clk_division is
		port(
			clk    :in std_logic;
			reset  :in std_logic;
			clk1Hz :out std_logic
		);
	end component;
	
	component selector is
		port(
			clk :in std_logic;
			s0, s1, s2 :out std_logic := '0'
		);
	end component;
	
	component reg is 
		port(
			clk, en, reset, a, b, c:in std_logic;
			s0, s1, s2     :in std_logic;
			d0, d1, d2, d3 :in std_logic;
			dout0, dout1, dout2, dout3 :out std_logic
		);
	end component;
	
	component decoder38 is
		port(
			x2, x1, x0 :in std_logic;
		   y7, y6, y5, y4, y3, y2, y1, y0 :out std_logic
		);
	end component;
	
	component decoder47 is
		port(
			x3, x2, x1, x0 :in std_logic;
		   a, b, c, d, e, f, g :out std_logic
		);
	end component;
	
	signal clk1Hz :std_logic;
	signal sout0, sout1, sout2 :std_logic;
	signal d47in0, d47in1, d47in2, d47in3 : std_logic;
	
begin
	c1: clk_division port map(
		clk, reset, clk1Hz
	);
	
	se1: selector port map(
		clk1Hz,
		sout0, sout1, sout2
	);
	
	r1: reg port map(
		clk1Hz, en, reset, s2, s1, s0,
		sout0, sout1, sout2,     
		d0, d1, d2, d3,
		d47in0, d47in1, d47in2, d47in3
	);
	
	d38: decoder38 port map(
		x2 => sout2, x1 => sout1, x0 => sout0,
		y7 => y7, y6 => y6, y5 => y5, y4 => y4, y3 => y3, y2 => y2, y1 => y1, y0 => y0
	);
	
	d47: decoder47 port map(
		x3 => d47in3, x2 => d47in2, x1 => d47in1, x0 => d47in0,
		a => a, b => b, c => c, d => d, e => e, f => f, g => g
	);
end behave;