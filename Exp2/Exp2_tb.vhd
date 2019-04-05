library ieee;
use ieee.std_logic_1164.all;

entity Exp2_tb is
end Exp2_tb;

architecture arch_tb of Exp2_tb is
	component Exp2 is
   port(
		clk, reset :in  std_logic;
		which :in  std_logic;
		dout  :out std_logic
	);
   end component;

   signal clk, reset : std_logic;
	signal which : std_logic;
	signal dout  : std_logic;

begin
   u1 :Exp2 port map(
		clk, reset,
		which,
      dout);
		  
	reset <= '0';
	which <= '0';
	
	process
	begin
		clk <= '0';
		wait for 10 ns;
		clk <= '1';
		wait for 10 ns;
	end process;
end arch_tb;