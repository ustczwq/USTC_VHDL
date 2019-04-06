library ieee;
use ieee.std_logic_1164.all;

entity decoder47 is
	port(
		x3, x2, x1, x0 :in std_logic;
		a, b, c, d, e, f, g :out std_logic
	);
end decoder47;

architecture output of decoder47 is
	type num  is array (6 downto 0) of std_logic;
	type nums is array (0 to 9) of num;
	
begin
	process(x3, x2, x1, x0)
		constant data :nums := (
			"0000001",
			"1001111",
			"0010010",
			"0000110",
			"1001100",
			"0100100",
			"0100000",
			"0001111",
			"0000000",
			"0001000"
		);
		variable tmp_num :integer range 0 to 15;
	begin
		tmp_num := 0;
		if x3 = '1' then
			tmp_num := tmp_num + 8;
		end if;
		if x2 = '1' then
			tmp_num := tmp_num + 4;
		end if;
		if x1 = '1' then
			tmp_num := tmp_num + 2;
		end if;
		if x0 = '1' then
			tmp_num := tmp_num + 1;
		end if;
		a <= data(tmp_num)(0);
		b <= data(tmp_num)(1);
		c <= data(tmp_num)(2);
		d <= data(tmp_num)(3);
		e <= data(tmp_num)(4);
		f <= data(tmp_num)(5);
		g <= data(tmp_num)(6);
	end process;
end output;