library ieee;
use ieee.std_logic_1164.all;

entity reg is 
	port (
		clk, clr :in std_logic;
		k1, k0 :in std_logic;
		c3, c2, c1, c0 :in std_logic;
		a, b, c, d, e, f, g, h :out std_logic
	);
end entity;

architecture behave of reg is
	type t_column is array (0 to 7) of std_logic;
	type t_grid   is array (0 to 15) of t_column;
	
	type t_position is array (0 to 1) of integer;
	type t_snake    is array (0 to 127) of t_position;
	
	signal grid  :t_grid;
	signal food  :t_position;
	signal snake :t_snake;
	signal alive :std_logic := '1';
	signal head  :integer range 0 to 127 := 1;
	signal tail  :integer range 0 to 127 := 0;
	signal len   :integer range 0 to 127 := 2;
	signal key   :std_logic_vector (0 to 1);
	
	signal counter_x   :integer range 0 to 15 :=0;
	signal counter_y   :integer range 0 to 7  :=0;
	signal random_food :t_position;
	
begin
	key <= k1 & k0;
	move: process(clk, key)
		variable x, y :integer;
		variable eat  :std_logic := '0';
		variable move :std_logic := '0';
	begin
		if clk'event and clk = '1' then
			x := snake(head)(0);
			y := snake(head)(1);
			case key is                  -- get new head
				when "00" => y := y - 1;  -- up		
				when "01" => x := x + 1;  -- right			
				when "10" => x := x - 1;  -- left			
				when "11" => y := y + 1;  -- down			
				when others => null;
			end case;
			if x < 0 or x > 15 or y < 0 or y > 7 then alive <= '0';	    -- crashed into walls
			elsif x = food(0) and y = food(1)    then eat   := '1';      -- got food
			elsif grid(x)(y) = '1'               then alive <= '0';      -- crashed into itself
			else                                      move  := '1';      -- just move
			end if;
			if move = '1' or eat = '1' then
				grid(x)(y) <= '1';
				grid(snake(tail)(0))(snake(tail)(1)) <= '0';
				snake((head + 1) rem 128)(0) <= x;
				snake((head + 1) rem 128)(1) <= y;
				head <= (head + 1) rem 128;
				tail <= (tail + 1) rem 128;
			end if;
			if eat = '1' then
				food(0) <= random_food(0);
				food(1) <= random_food(1);
			end if;
		end if;
	end process move;
	
	feed: process(clk)
	begin 
		counter_x <= (counter_x + 5) rem 16;
		counter_y <= (counter_y + 3) rem 16;
		if grid(counter_x)(counter_y) = '0' then
			random_food(0) <= counter_x;
			random_food(1) <= counter_y;
		end if;
	end process feed;
	
	show: process(c3, c2, c1, c0)
		variable column :integer range 0 to 15;
	begin
		column := 0;
		if c3 = '1' then column := column + 8;
		end if;
		if c2 = '1' then column := column + 4;
		end if;
		if c1 = '1' then column := column + 2;
		end if;
		if c0 = '1' then column := column + 1;
		end if;
		a <= grid(column)(0);
		b <= grid(column)(1);
		c <= grid(column)(2);
		d <= grid(column)(3);
		e <= grid(column)(4);
		f <= grid(column)(5);
		g <= grid(column)(6);
		h <= grid(column)(7);
	end process show;
end behave;