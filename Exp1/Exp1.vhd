library ieee;
use ieee.std_logic_1164.all;

entity Exp1 is
    port(
        y0_n, y1_n, y2_n, y3_n, y4_n, y5_n, y6_n, y7_n :out std_logic;
        a, b, c :in std_logic
    );
end Exp1;

architecture behave of Exp1 is
    signal abc :std_logic_vector(2 downto 0);
begin
    abc <= a & b & c;
    process(abc) 
    begin
        y0_n <= '1';
        y1_n <= '1';
        y2_n <= '1';
        y3_n <= '1';
        y4_n <= '1';
        y5_n <= '1';
        y6_n <= '1';
        y7_n <= '1';
		 case abc is 
			  when "000" =>
					y0_n <= '0';
			  when "001" =>
					y1_n <= '0';
			  when "010" =>
					y2_n <= '0';
			  when "011" =>
					y3_n <= '0';
			  when "100" =>
					y4_n <= '0';
			  when "101" =>
					y5_n <= '0';
			  when "110" =>
					y6_n <= '0';
			  when "111" =>
					y7_n <= '0';
			  when others =>
					null;
		 end case;
	end process;
end behave;