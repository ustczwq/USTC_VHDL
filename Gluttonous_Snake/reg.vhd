library ieee;
use ieee.std_logic_1164.all;

entity reg is 
	port (
		clk, clk_seed, clr :in std_logic;
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
	signal head  :integer range 0 to 127;
	signal tail  :integer range 0 to 127;
	signal key   :std_logic_vector (0 to 1);
	
	signal rx, ry      :integer;
	signal random_food :t_position := (0, 0);
	
begin
	move: process(clk, clr, k1, k0, alive, grid)
		variable x, y :integer;
		variable i :integer;
	begin
		key <= k1 & k0;
		if clr = '0' then
			for i in 0 to 15 loop   -- clear grid show
				grid(i) <= "00000000";
			end loop;
			key <= "01";
			head <= 1;
			tail <= 0;
			snake(0) <= (0, 4);   -- initial tail
			snake(1) <= (1, 4);   -- initial head
			food <= (8, 3);       -- initial food
			grid(0)(4) <= '1';
			grid(1)(4) <= '1';
			grid(8)(3) <= '1';
			alive <= '1';
		elsif clk'event and clk = '1' and alive = '1' then
			x := snake(head)(0);
			y := snake(head)(1);	
			case key is                  -- get temp new head
				when "00" => y := y - 1;  -- up		
				when "01" => x := x + 1;  -- right			
				when "10" => x := x - 1;  -- left			
				when "11" => y := y + 1;  -- down			
				when others => null;
			end case;
			if x < 0 or x > 15 or y < 0 or y > 7 then alive <= '0';  -- crashed into walls
			elsif x = food(0) and y = food(1) then                   -- got food
				snake((head + 1) rem 128) <= (x, y);
				head <= (head + 1) rem 128;	
				food <= random_food;
				grid(food(0))(food(1)) <= '1';
			elsif grid(x)(y) = '1' then alive <= '0';               -- crashed into itself
			else                                                    -- just move
				grid(x)(y) <= '1';
				grid(snake(tail)(0))(snake(tail)(1)) <= '0';
				snake((head + 1) rem 128) <= (x, y);
				head <= (head + 1) rem 128;
				tail <= (tail + 1) rem 128;
			end if;
		end if;
	end process move;
	
	feed: process(clk_seed)
	begin
		if clk_seed'event and clk_seed = '1' then
			rx <= (5*rx + 3) rem 16;
			ry <= (3*ry + 1) rem 8;
			if grid(rx)(ry) = '0' then random_food <= (rx, ry);
			end if;
		end if;
	end process feed;
	
	show: process(c3, c2, c1, c0, grid)
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