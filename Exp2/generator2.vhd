library ieee;
use ieee.std_logic_1164.all;

entity generator2 is 
	port (
		clk, reset :in std_logic;
		gout :out std_logic
	);
end generator2;

architecture serial of generator2 is 
	type State is (s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15);
	signal current_state : State;
	
begin 
	process(clk, reset)
	begin 
		if reset = '1' then 
			current_state <= s0;
			gout <= '0';
		elsif clk'event and clk = '1' then 
			case current_state is
				when s0  => current_state <= s1;  gout <= '0';
				when s1  => current_state <= s2;  gout <= '0';
				when s2  => current_state <= s3;  gout <= '1';	--
				when s3  => current_state <= s4;  gout <= '1';
				when s4  => current_state <= s5;  gout <= '1';
				when s5  => current_state <= s6;  gout <= '0';
				when s6  => current_state <= s7;  gout <= '1';
				when s7  => current_state <= s8;  gout <= '0';
				when s8  => current_state <= s9;  gout <= '1';
				when s9  => current_state <= s10; gout <= '1';
				when s10 => current_state <= s11; gout <= '1';	--
				when s11 => current_state <= s12; gout <= '0';
				when s12 => current_state <= s13; gout <= '0';
				when s13 => current_state <= s14; gout <= '0';
				when s14 => current_state <= s15; gout <= '0';
				when s15 => current_state <= s0;  gout <= '0';
			end case;
		end if;
	end process;
end serial;
				