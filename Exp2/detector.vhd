library ieee;
use ieee.std_logic_1164.all;

entity detector is
	port(
		clk, reset :in std_logic;
		din  :in std_logic;
		dout :out std_logic := '0'
	);
end detector;

architecture result of detector is
	type State is (s0, s1, s2, s3, s4, s5, s6, s7, s8, s9);
	signal current_state: State;
	
begin
	process(clk, reset, din)
	begin
	   if reset = '1' then 
			current_state <= s0;
			dout <= '0';
		elsif clk'event and clk = '1' then 
			case current_state is 
				when s0 => dout <= '0'; 
					if din = '0' then
						current_state <= s0;
					else 
						current_state <= s1;
					end if;					
				when s1 => dout <= '0';
					if din = '0' then
						current_state <= s0;
					else 
						current_state <= s2;
					end if;
				when s2 => dout <= '0';
					if din = '0' then
						current_state <= s0;
					else 
						current_state <= s3;
					end if;
				when s3 => dout <= '0';
					if din = '0' then
						current_state <= s4;
					else 
						current_state <= s3;
					end if;
				when s4 => dout <= '0';
					if din = '0' then
						current_state <= s0;
					else 
						current_state <= s5;
					end if;
				when s5 => dout <= '0';
					if din = '0' then
						current_state <= s6;
					else 
						current_state <= s1;
					end if;
				when s6 => dout <= '0';
					if din = '0' then
						current_state <= s7;
					else 
						current_state <= s1;
					end if;
				when s7 => dout <= '0';
					if din = '0' then
						current_state <= s0;
					else 
						current_state <= s8;
					end if;
				when s8 => dout <= '0';
					if din = '0' then
						current_state <= s0;
					else 
						current_state <= s9;
					end if;
				when s9 => dout <= '1';
					if din = '0' then
						current_state <= s0;
					else 
						current_state <= s1;
					end if;
			end case;
		end if;
	end process;
end result;  
