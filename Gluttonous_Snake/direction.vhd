library ieee;
use ieee.std_logic_1164.all;

entity direction is 
	port (
		sw0, sw1, sw2, sw3 :in std_logic;
		k1, k0 :out std_logic
	);
end entity;

architecture behave of direction is 
begin
	process(sw0, sw1, sw2, sw3)
	begin
		if sw0 = '0' then 
			k1 <= '0'; k0 <= '0';
		elsif sw1 = '0' then 
			k1 <= '1'; k0 <= '1';
		elsif sw2 = '0' then
			k1 <= '1'; k0 <= '0';
		elsif sw3 = '0' then 
			k1 <= '0'; k0 <= '1';
		end if;
	end process;
end behave;
