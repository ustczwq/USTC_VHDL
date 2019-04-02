library ieee;
use ieee.std_logic_1164.all;

entity selector is 
	port(
		sin0 :in std_logic;
		sin1 :in std_logic;
		which :in std_logic;
		sout :out std_logic
	);
end selector;

architecture result of selector is
begin
	process(sin0, sin1, which)
	begin
		if which = '0' then
			sout <= sin0;
		else
			sout <= sin1;
		end if;
	end process;
end result;

