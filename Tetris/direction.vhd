library ieee;
use ieee.std_logic_1164.all;

entity direction is 
	port (
		clk, clr :in std_logic;
		sw0, sw1, sw2, sw3 :in std_logic;
		k2 :out std_logic := '0';
		k1 :out std_logic := '0';
		k0 :out std_logic := '0'
	);
end entity;

architecture behave of direction is 
begin
	process(clk, clr, sw0, sw1, sw2, sw3)
	begin
		if clr = '0' then 
			k2 <= '0';
			k1 <= '0';
			k0 <= '0';
		elsif clk'event and clk = '1' then
			if sw0 = '0' then 
				k2 <= '1'; k1 <= '0'; k0 <= '0';
			elsif sw1 = '0' then 
				k2 <= '0'; k1 <= '0'; k0 <= '1';
			elsif sw2 = '0' then
				k2 <= '0'; k1 <= '1'; k0 <= '0';
			elsif sw3 = '0' then
				k2 <= '1'; k1 <= '1'; k0 <= '1';
			else 
				k2 <= '0'; k1 <= '0'; k0 <= '0';
			end if;
		end if;
	end process;
end behave;
