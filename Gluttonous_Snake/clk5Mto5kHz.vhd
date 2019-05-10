library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity clk5Mto5kHz is
	port(
		clk, clr :in std_logic;
		clk5kHz :out std_logic
	);
end entity;

architecture division of clk5Mto5kHz is
	signal counter :integer range 0 to 9999;
	signal tmp_clk :std_logic := '0';
begin
	process
	begin
		wait until rising_edge(clk);
		if clr = '1' then
			counter <= 0;
			tmp_clk <= '0';
		elsif counter = 9999 then
			counter <= 0;
			tmp_clk <= not tmp_clk;
		else 
			counter <= counter + 1;
		end if;
	end process;
	clk5kHz <= tmp_clk;
end division;