library ieee;
use ieee.std_logic_1164.all;

entity selector is 
	port(
		clk :in std_logic;
		s0, s1, s2 :out std_logic := '0'
	);
end selector;

architecture behave of selector is
	type slct is array (2 downto 0) of std_logic;
	type slct_reg is array (0 to 7) of slct;
	signal counter :integer range 0 to 7 := 0;
	constant sreg :slct_reg := ("000",  "001",  "010",  "011",  "100",  "101",  "110",  "111");
	
begin	
   process(clk)
	begin  
		if clk'event and clk = '1' then				
			counter <= (counter + 1) rem 8;	
			s0 <= sreg(counter)(0);
			s1 <= sreg(counter)(1);
			s2 <= sreg(counter)(2);
		end if;
	end process;
end behave;
