library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity clk5Mto1Hz is
	port(
		clk, clr :in std_logic;
		clk1Hz :out std_logic
	);
end entity;

architecture division of clk5Mto1Hz is
	signal counter :integer range 0 to 19999999;
	signal tmp_clk :std_logic := '0';
begin
	process
	begin
		wait until rising_edge(clk);
		if clr = '0' then
			counter <= 0;
			tmp_clk <= '0';
		elsif counter = 19999999 then
			counter <= 0;
			tmp_clk <= not tmp_clk;
		else 
			counter <= counter + 1;
		end if;
	end process;
	clk1Hz <= tmp_clk;
end division;