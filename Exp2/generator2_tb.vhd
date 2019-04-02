library ieee;
use ieee.std_logic_1164.all;

entity generator2_tb is
end generator2_tb;

architecture arch_tb of generator2_tb is
	component generator2 is
   port(
		clk, reset :in std_logic;
		gout       :out std_logic
	);
   end component;

   signal clk   : std_logic;
	signal reset : std_logic;
	signal gout  : std_logic;

begin
   u1 :generator2 port map(
		clk, reset,
      gout);
		  
	reset <= '0';
	process
	begin
		clk <= '0';
		wait for 10 ns;
		clk <= '1';
		wait for 10 ns;
	end process;
end arch_tb;