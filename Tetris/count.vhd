library ieee;
use ieee.std_logic_1164.all;

entity count is
	port (
		clk: in std_logic;
		c3, c2, c1, c0 :out std_logic := '0'
	);
end entity;

architecture behave of count is
	type t_column  is array (0 to 3) of std_logic;
	type t_columns is array (0 to 15) of t_column;
	signal counter :integer range 0 to 15 := 0;
	constant columns :t_columns := ("0000", "0001", "0010", "0011", 
											  "0100", "0101", "0110", "0111",
											  "1000", "1001", "1010", "1011",
											  "1100", "1101", "1110", "1111"
											  );

begin 
	process(clk)
	begin
		if clk'event and clk = '1' then				
			counter <= (counter + 1) rem 16;
			c3 <= columns(counter)(0);
			c2 <= columns(counter)(1);
			c1 <= columns(counter)(2);
			c0 <= columns(counter)(3);
		end if;
	end process;
end behave;