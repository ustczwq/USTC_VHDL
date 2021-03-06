library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity clk_division is
	port(
		clk    :in std_logic;
		reset  :in std_logic;
		clk1Hz :out std_logic
	);
end entity;

architecture division of clk_division is
	signal counter :integer range 0 to 1;
	signal tmp_clk :std_logic := '0';
begin
	process
	begin
		wait until rising_edge(clk);
		if reset = '1' then
			counter <= 0;
			tmp_clk <= '0';
		elsif counter = 1 then
			counter <= 0;
			tmp_clk <= not tmp_clk;
		else 
			counter <= counter + 1;
		end if;
	end process;
	clk1Hz <= tmp_clk;
end division;