library ieee;
use ieee.std_logic_1164.all;

entity scan_column is 
	port (
		s0, s1 :in std_logic;
		c0, c1, c2, c3 :out std_logic
	);
end entity;

architecture behave of scan_column is 
	signal num :std_logic_vector(0 to 1);
	
begin
	num <= s1 & s0;
	process(num)
	begin
		c0 <= '1'; 
		c1 <= '1'; 
		c2 <= '1'; 
		c3 <= '1';
		case num is
			when "00" => c0 <= '0';
			when "01" => c1 <= '0';
			when "10" => c2 <= '0';
			when "11" => c3 <= '0';
			when others => null;
		end case;
	end process;
end behave;
		