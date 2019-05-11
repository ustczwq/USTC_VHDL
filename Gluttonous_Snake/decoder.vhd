library ieee;
use ieee.std_logic_1164.all;

entity decoder is
	port(
		s3, s2, s1, s0 :in std_logic;
		y15, y14, y13, y12, y11, y10, y9, y8 :out std_logic;
		y7, y6, y5, y4, y3, y2, y1, y0 :out std_logic
	);
end entity;

architecture output of decoder is
	signal num :std_logic_vector(3 downto 0);
begin
	num <= s3 & s2 & s1 & s0;
	process(num)
	begin
		y15 <= '1';
		y14 <= '1';
		y13 <= '1';
		y12 <= '1';
		y11 <= '1';
		y10 <= '1';
		y9  <= '1';
		y8  <= '1';
		y7 <= '1';
		y6 <= '1';
		y5 <= '1';
		y4 <= '1';
		y3 <= '1';
		y2 <= '1';
		y1 <= '1';
		y0 <= '1';
		case num is
			when "0000" => y0 <= '0';
			when "0001" => y1 <= '0';
			when "0010" => y2 <= '0';
			when "0011" => y3 <= '0';
			when "0100" => y4 <= '0';
			when "0101" => y5 <= '0';
			when "0110" => y6 <= '0';
			when "0111" => y7 <= '0';
			when "1000" => y8  <= '0';
			when "1001" => y9  <= '0';
			when "1010" => y10 <= '0';
			when "1011" => y11 <= '0';
			when "1100" => y12 <= '0';
			when "1101" => y13 <= '0';
			when "1110" => y14 <= '0';
			when "1111" => y15 <= '0';
			when others => null;
		end case;
	end process;
end output;