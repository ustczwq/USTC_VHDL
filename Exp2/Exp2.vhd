library ieee;
use ieee.std_logic_1164.all;

entity Exp2 is
	port( 
		clk, reset :in  std_logic;
		which :in  std_logic;
		dout  :out std_logic
	);
end Exp2;

architecture whole of Exp2 is
	component clk50Mto1 is
		port(
			clk    :in std_logic;
			reset  :in std_logic;
			clk1Hz :out std_logic 
		);
	end component;

	component generator1 is
		port(
			clk, reset :in  std_logic;
			gout       :out std_logic
		);
   end component;
	
	component generator2 is
		port(
			clk, reset :in  std_logic;
			gout       :out std_logic
		);
   end component;
	
	component selector is
		port(
			sin0 :in std_logic;
			sin1 :in std_logic;
			which :in std_logic;
			sout :out std_logic
		);
   end component;
	
	component detector is
		port(
			clk, reset :in std_logic;
			din  :in  std_logic;
			dout :out std_logic
		);
   end component;
	
	signal clk1Hz : std_logic;
	signal din    : std_logic;
	signal sin0   : std_logic;
	signal sin1   : std_logic;
	
begin
	c1: clk50Mto1 port map(
		clk => clk,
		reset  => reset,
		clk1Hz => clk1Hz
	);
	
	g1 :generator1 port map(
		clk => clk1Hz, reset => reset,
      gout => sin0
	);
		
	g2 :generator2 port map(
		clk => clk1Hz, reset => reset,
      gout => sin1
	);
		
	s1 :selector port map(
		sin0 => sin0,
		sin1 => sin1,
		which => which,
		sout  => din
	);
	
	d1 :detector port map(
		clk => clk1Hz, reset => reset,
		din  => din,
		dout => dout
	);
end whole;

	