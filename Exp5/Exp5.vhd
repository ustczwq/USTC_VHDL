library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity Exp5 is 
	port (
		clk   :in std_logic;
		reset :in std_logic;
		q     :out std_logic_vector (7 downto 0)
	);
end Exp5;

architecture behave of Exp5 is 

component mystorage is 
	port(
		address		: in std_logic_vector (9 downto	0);
		clock		: in std_logic  := '1';
		q		: out std_logic_vector	(7 downto 0)
	);
end component;

	signal i :integer range 0 to 1024;
	signal addr :std_logic_vector (9 downto 0);
begin
	ms: mystorage port map (addr, clk, q);
	process
	begin
		wait until rising_edge(clk);
		if reset = '1' then i <= 0;
		elsif i = 1024 then i <= 0;
		else i <= i + 1;
		end if;
	end process;
	addr <= conv_std_logic_vector(i, 10);
end behave;