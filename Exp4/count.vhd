library ieee;
use ieee.std_logic_1164.all;

entity count is
	port (
		clk: in std_logic;
		s1, s0 :out std_logic := '0'
	);
end entity;

architecture behave of count is
	signal counter :integer range 0 to 3 := 0;
	
begin 
	process(clk)
	begin
		if clk'event and clk = '1' then				
			counter <= (counter + 1) rem 4;
			case counter is
				when 0 => s1 <= '0'; s0 <= '0';
				when 1 => s1 <= '0'; s0 <= '1';
				when 2 => s1 <= '1'; s0 <= '0';
				when 3 => s1 <= '1'; s0 <= '1';
				when others => null;
			end case;
		end if;
	end process;
end behave;