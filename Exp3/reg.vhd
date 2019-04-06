library ieee;
use ieee.std_logic_1164.all;

entity reg is 
	port(
		clk, en, reset :in std_logic;
		s0, s1, s2     :in std_logic;
		d0, d1, d2, d3 :in std_logic;
		sout0, sout1, sout2        :out std_logic;
		dout0, dout1, dout2, dout3 :out std_logic 
	);
end reg;

architecture behave of reg is
	type slct is array (2 downto 0) of std_logic;
	type data is array (3 downto 0) of std_logic;
	type slct_reg is array (0 to 7) of slct;
	type data_reg is array (0 to 7) of data;
	signal counter :integer range 0 to 7;
	constant sreg :slct_reg := ("000",  "001",  "010",  "011",  "100",  "101",  "110",  "111");
	signal dreg :data_reg := ("0000", "0001", "0010", "0011", "0100", "0101", "0110", "0111");
	
begin	
   process(clk, en, reset, s0, s1, s2, d0, d1, d2, d3)
		variable num :integer range 0 to 7;
	begin 
		if reset = '1' then 
			dreg <= ("0000", "0000", "0000", "0000", "0000", "0000", "0000", "0000");	
		elsif clk'event and clk = '1' then
			--data register 
			if en = '1' then 
				num := 0;
				if s2 = '1' then
					num := num + 4;
				end if;
				if s1 = '1' then
					num := num + 2;
				end if;
				if s0 = '1' then
					num := num + 1;
				end if;
				dreg(num)(0) <= d0;
				dreg(num)(1) <= d1;
				dreg(num)(2) <= d2;
				dreg(num)(3) <= d3;
			end if;	
			
			--out put
			counter <= (counter + 1) rem 8;	
			sout0 <= sreg(counter)(0);
			sout1 <= sreg(counter)(1);
			sout2 <= sreg(counter)(2);
			dout0 <= dreg(counter)(0);
			dout1 <= dreg(counter)(1);
			dout2 <= dreg(counter)(2);
			dout3 <= dreg(counter)(3);
		end if;
	end process;
end behave;
