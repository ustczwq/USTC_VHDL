library ieee;
use ieee.std_logic_1164.all;

entity out_decode is
	port (
		s3, s2, s1, s0 :in std_logic;
		a, b, c, d, e, f, g :out std_logic
	);
end entity;

architecture behave of out_decode is
	type num  is array (0 to 6) of std_logic;
	type nums is array (0 to 15) of num;
	constant data :nums := (
		"1001111", --'1'
		"1001100", --'4'
		"0001111", --'7'
		"1111110", --'*'
		"0010010",   --'2'
		"0100100",   --'5'
		"0000000",   --'8'
		"0000001",   --'0'
		"0000110",     --'3'
		"0100000",     --'6'
		"0000100",     --'9'
		"1001000",     --'#'
		"0001000",       --'A'
		"1100000",       --'B'
		"0110001",       --'C'
		"1000010"        --'D'
	);
begin
	process(s3, s2, s1, s0)
		variable index :integer range 0 to 15;
	begin
	   index := 0;
		if s3 = '1' then index := index + 8;
		end if;
		if s2 = '1' then index := index + 4;
		end if;
		if s1 = '1' then index := index + 2;
		end if;
		if s0 = '1' then index := index + 1;
		end if;
	   
		a <= data(index)(0);
		b <= data(index)(1);
		c <= data(index)(2);
		d <= data(index)(3);
		e <= data(index)(4);
		f <= data(index)(5);
		g <= data(index)(6);
	end process;
end behave;