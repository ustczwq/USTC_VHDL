library ieee;
use ieee.std_logic_1164.all;

entity Gluttonous_Snake is
	port (
		clk, clr :in std_logic;
		sw0, sw1, sw2, sw3 :in std_logic;
		x15, x14, x13, x12, x11, x10, x9, x8 :out std_logic;
		x7, x6, x5, x4, x3, x2, x1, x0 :out std_logic;
		y15, y14, y13, y12, y11, y10, y9, y8 :out std_logic;
		y7, y6, y5, y4, y3, y2, y1, y0 :out std_logic
	);
end entity;

architecture behave of Gluttonous_Snake is
	component direction is 
		port (
			clk, clr :in std_logic;
			sw0, sw1, sw2, sw3 :in std_logic;
			k1, k0 :out std_logic
		);
	end component;

	component count is
		port (
			clk: in std_logic;
			c3, c2, c1, c0 :out std_logic := '0'
		);
	end component;
	
	component clk5Mto5kHz is
		port(
			clk, clr :in std_logic;
			clk5kHz :out std_logic
		);
	end component;
	
	component clk5Mto1Hz is
		port(
			clk, clr :in std_logic;
			clk1Hz :out std_logic
		);
	end component;
	
	component reg is 
		port (
			clk, clk_seed, clr :in std_logic;
			k1, k0 :in std_logic;
			c3, c2, c1, c0 :in std_logic;
			a, b, c, d, e, f, g, h :out std_logic
		);
	end component;
	
	component decoder is
		port(
			s3, s2, s1, s0 :in std_logic;
			y15, y14, y13, y12, y11, y10, y9, y8 :out std_logic;
			y7, y6, y5, y4, y3, y2, y1, y0 :out std_logic
		);
	end component;
	
	signal clk5kHz :std_logic;
	signal clk1Hz  :std_logic;
	signal k1, k0  :std_logic;
	signal c3, c2, c1, c0 :std_logic;
	signal a, b, c, d, e, f, g, h :std_logic;
	
begin
	key: direction port map (
		clk5kHz, clr,
		sw0, sw1, sw2, sw3,
		k1, k0
	);
	
	clk5k: clk5Mto5kHz port map (
		clk, clr, clk5kHz
	);
	
	clk1: clk5Mto1Hz port map (
		clk, clr, clk1Hz
	);
	
	co: count port map (
		clk5kHz, 
		c3, c2, c1, c0
	);
	
	re: reg port map (
		clk1Hz, clk5kHz, clr,
		k1, k0,
		c3, c2, c1, c0,
		a, b, c, d, e, f, g, h
	);
	
	de: decoder port map (
		c3, c2, c1, c0,
		y15, y14, y13, y12, y11, y10, y9, y8,
		y7, y6, y5, y4, y3, y2, y1, y0
	);
	
	x0 <= a;
	x1 <= b;
	x2 <= c;
	x3 <= d;
	x4 <= e;
	x5 <= f;
	x6 <= g;
	x7 <= h;
	x8  <= a;
	x9  <= b;
	x10 <= c;
	x11 <= d;
	x12 <= e;
	x13 <= f;
	x14 <= g;
	x15 <= h;
	
end behave;