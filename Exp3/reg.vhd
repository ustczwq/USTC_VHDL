library ieee;
use ieee.std_logic_1164.all;

entity reg is 
	port(
		clk, en, reset, a, b, c :in std_logic;
		s0, s1, s2     :in std_logic;
		d0, d1, d2, d3 :in std_logic;
		dout0, dout1, dout2, dout3 :out std_logic 
	);
end reg;

architecture behave of reg is
	signal counter :integer range 0 to 7;
	type data is array (3 downto 0) of std_logic;
	type data_reg is array (0 to 7) of data;
	signal dreg :data_reg := ("0000", "0001", "0010", "0011", "0100", "0101", "0110", "0111");
	
begin	
	reg: process(reset, a, b, c, d0, d1, d2, d3)
		variable num :integer range 0 to 15;
	begin
		if reset = '1' then
			dreg <= ("0000", "0001", "0010", "0011", "0100", "0101", "0110", "0111");
		elsif en = '1' then
			num := 0;
			if a = '1' then
				num := num + 4;
			end if;
			if b = '1' then
				num := num + 2;
			end if;
			if c = '1' then
				num := num + 1;
			end if;
			dreg(num)(0) <= d0;
			dreg(num)(1) <= d1;
			dreg(num)(2) <= d2;
			dreg(num)(3) <= d3;
		end if;
	end process reg;
	
	output: process(clk, s0, s1, s2)
		variable slct :integer range 0 to 7;
	begin
		slct := 0;
		if s2 = '1' then
			slct := slct + 4;
		end if;
		if s1 = '1' then
			slct := slct + 2;
		end if;
		if s0 = '1' then
			slct := slct + 1;
		end if;
		dout0 <= dreg(slct)(0);
		dout1 <= dreg(slct)(1);
		dout2 <= dreg(slct)(2);
		dout3 <= dreg(slct)(3);
	end process output;
end behave;
