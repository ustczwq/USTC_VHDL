library ieee;
use ieee.std_logic_1164.all;

entity out_encode is
	port (
		r0, r1, r2, r3 :in std_logic;
		c0, c1 :in std_logic;
		s0, s1, s2, s3 :out std_logic
	);
end entity;

architecture behave of out_encode is
	signal column :std_logic_vector (0 to 1);
begin
	process(c0, c1, r0, r1, r2, r3)
	begin
		if    r0 = '0' then s3 <= c1; s2 <= c0; s1 <= '0'; s0 <= '0';
		elsif r1 = '0' then s3 <= c1; s2 <= c0; s1 <= '0'; s0 <= '1';
		elsif r2 = '0' then s3 <= c1; s2 <= c0; s1 <= '1'; s0 <= '0';
		elsif r3 = '0' then s3 <= c1; s2 <= c0; s1 <= '1'; s0 <= '1';
		end if;
	end process;
end behave;
		
		
		
		
		