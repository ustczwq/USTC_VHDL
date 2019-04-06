library ieee;
use ieee.std_logic_1164.all;

entity reg_tb is
end reg_tb;

architecture arch_reg_tb of reg_tb is
	component reg is
		port(
			clk, en, reset :in std_logic;
			s0, s1, s2     :in std_logic;
			d0, d1, d2, d3 :in std_logic;
			sout0, sout1, sout2        :out std_logic;
			dout0, dout1, dout2, dout3 :out std_logic 
		);
	end component;
	signal clk, en, reset : std_logic;
	signal s0, s1, s2     : std_logic;
	signal d0, d1, d2, d3 : std_logic;
	signal sout0, sout1, sout2        : std_logic;
	signal dout0, dout1, dout2, dout3 : std_logic;
	
begin 
	u1: reg port map (
		clk, en, reset,
		s0, s1, s2,
		d0, d1, d2, d3,
		sout0, sout1, sout2,
		dout0, dout1, dout2, dout3
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
end arch_reg_tb;
		
		
	