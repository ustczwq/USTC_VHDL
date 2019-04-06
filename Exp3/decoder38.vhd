library ieee;
use ieee.std_logic_1164.all;

entity decoder38 is
	port(
		x2, x1, x0 :in std_logic;
		y7, y6, y5, y4, y3, y2, y1, y0 :out std_logic
	);
end entity;

architecture output of decoder38 is
	signal num :std_logic_vector(2 downto 0);
begin
	num <= x2 & x1 & x0;
	process(num)
	begin 
		y7 <= '0';
		y6 <= '0';
		y5 <= '0';
		y4 <= '0';
		y3 <= '0';
		y2 <= '0';
		y1 <= '0';
		y0 <= '0';
		case num is
			when "000" => y0 <= '1';
			when "001" => y1 <= '1';
			when "010" => y2 <= '1';
			when "011" => y3 <= '1';
			when "100" => y4 <= '1';
			when "101" => y5 <= '1';
			when "110" => y6 <= '1';
			when "111" => y7 <= '1';
			when others => null;
		end case;
	end process;
end output;