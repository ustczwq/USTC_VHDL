library ieee;
use ieee.std_logic_1164.all;

entity Exp4 is
	port (
		clk   :in std_logic;
		reset :in std_logic;
		r0, r1, r2, r3 :in std_logic;
		c0, c1, c2, c3 :out std_logic;
		en :out std_logic := '1';
		a, b, c, d, e, f, g :out std_logic
	);
end Exp4;

architecture behave of Exp4 is
	component clk_division is 
		port(
			clk    :in std_logic;
			reset  :in std_logic;
			clk1Hz :out std_logic
		);
	end component;
	
	component count is
		port (
			clk: in std_logic;
			s1, s0 :out std_logic := '0'
		);
	end component;
	
	component scan_column is
		port (
		s0, s1 :in std_logic;
		c0, c1, c2, c3 :out std_logic
		);
	end component;
	
	component out_encode is
		port (
		   clk :in std_logic;
			r0, r1, r2, r3 :in std_logic;
			c0, c1 :in std_logic;
			s0, s1, s2, s3 :out std_logic
		);
	end component;
	
	component out_decode is 
		port (
			s3, s2, s1, s0 :in std_logic;
			a, b, c, d, e, f, g :out std_logic
		);
	end component;
	
	signal clk5kHz :std_logic;
	signal cou0, cou1 :std_logic;
	signal s0, s1, s2, s3 :std_logic;
begin 
	cl: clk_division port map(
		clk, reset, clk5kHz
	);
	
	co: count port map(
		clk5kHz, cou1, cou0
	);
	
	sc: scan_column port map(
		cou0, cou1,
		c0, c1, c2, c3
	);
	
	oe: out_encode port map(
		clk5kHz,
		r0, r1, r2, r3,
		cou0, cou1,
		s0, s1, s2, s3
	);
	
	od: out_decode port map(
		s3, s2, s1, s0,
		a, b, c, d, e, f, g
	);
	
end behave;