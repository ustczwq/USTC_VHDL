library ieee;
use ieee.std_logic_1164.all;

entity reg is 
	port (
		clk, clk_seed, clr     :in std_logic;
		k1, k0                 :in std_logic;
		c3, c2, c1, c0         :in std_logic;
		a, b, c, d, e, f, g, h :out std_logic
	);
end entity;

architecture behave of reg is
	type t_column is array (0 to 7)  of std_logic;   -- grid: (width, height) = (16, 8)
	type t_grid   is array (0 to 15) of t_column;
	signal grid   :t_grid;
	
	type t_position is array (0 to 1)  of integer;   -- position: (x, y), range (0, 0) to (15, 7)
	type t_shape    is array (0 to 3)  of t_position;
	type t_shapes   is array (0 to 27) of t_shape;
	constant shapes :t_shapes := (
		((0, 0), (0, 1), (1, 0), (1, 1)), 	-- 7 basic shapes   
	   ((0, 0), (1, 0), (2, 0), (3, 0)),	 
		((0, 0), (0, 1), (1, 1), (2, 1)), 
		((1, 0), (0, 1), (1, 1), (2, 1)),
		((2, 0), (0, 1), (1, 1), (2, 1)),
		((0, 0), (1, 0), (1, 1), (2, 1)),
		((1, 0), (2, 0), (0, 1), (1, 1)),
		
		((0, 0), (0, 1), (1, 0), (1, 1)),	-- rotate 90  deg   
		((0, 0), (0, 1), (0, 2), (0, 3)), 
		((1, 0), (0, 0), (0, 1), (0, 2)), 
		((1, 1), (0, 0), (0, 1), (0, 2)), 
		((1, 2), (0, 0), (0, 1), (0, 2)), 
		((0, 1), (0, 2), (1, 0), (1, 1)),
		((0, 0), (0, 1), (1, 1), (1, 2)),
		
		((0, 0), (0, 1), (1, 0), (1, 1)), 	-- rotate 180 deg  
	   ((0, 0), (1, 0), (2, 0), (3, 0)),
		((0, 0), (1, 0), (2, 0), (2, 1)),
		((0, 0), (1, 0), (2, 0), (1, 1)),
		((0, 0), (1, 0), (2, 0), (0, 1)),
		((0, 0), (1, 0), (1, 1), (2, 1)),
		((1, 0), (2, 0), (0, 1), (1, 1)),
		
		((0, 0), (0, 1), (1, 0), (1, 1)),	-- rotate 270  deg   
		((0, 0), (0, 1), (0, 2), (0, 3)), 
		((0, 2), (1, 0), (1, 1), (1, 2)),
		((0, 1), (1, 0), (1, 1), (1, 2)),
		((0, 0), (1, 0), (1, 1), (1, 2)),
		((0, 1), (0, 2), (1, 0), (1, 1)),
		((0, 0), (0, 1), (1, 1), (1, 2))
	);
	
	signal current :integer range 0 to 27 := 0;
	signal random  :integer range 0 to 27 := 0;
	
	signal dx    :integer range 0 to 7  := 0;
	signal dy    :integer range 0 to 15 := 0; 
	signal alive :std_logic := '1';
	signal key   :std_logic_vector (0 to 1);
	
begin
	key <= k1 & k0;
	move: process(clk, clr, key, alive, dx, dy)
		variable x, y   :integer;
		variable tmp_dx :integer;
		variable tmp_dy :integer;
		variable err    :std_logic;
		variable fix    :std_logic;
		variable full   :std_logic;
	begin	
		if clr = '0' then
			for i in 0 to 15 loop   -- clear grid show
				grid(i)  <= "00000000";
			end loop;
			current <= 0;
			alive <= '1';
			dx <= 0;
			dy <= 0;
		elsif alive = '0' then null;
		elsif clk'event and clk = '1' then   
			tmp_dx := dx;
			tmp_dy := dy + 1;
			
			case key is
				when "00" => null;
				when "01" => tmp_dx := tmp_dx + 1;
				when "10" => tmp_dx := tmp_dx - 1;
				when "11" => null;
				when others => null;
			end case;
			
			err := '0';
			fix := '0';
			for i in 0 to 3 loop
				x := shapes(current)(i)(1) + tmp_dx;
				y := shapes(current)(i)(0) + tmp_dy;
				if x < 0 or x > 7 then err := '1';
				elsif y = 16 or grid(y)(x) = '1' then fix := '1';
				end if;
			end loop;
			
			if fix = '1' then      -- touch bottom 
				for i in 0 to 3 loop
					x := shapes(current)(i)(1) + dx;
					y := shapes(current)(i)(0) + dy;
					grid(y)(x) <= '1';
				end loop;
				current <= random;
				dx <= 0;
				dy <= 0;
			elsif err = '1' then   -- out of range, just fall a step
				dy <= tmp_dy;
			else                   -- move by pressed key
				dx <= tmp_dx;
				dy <= tmp_dy;
			end if;	
			for i in 15 downto 0 loop
				full := '1';
				for j in 0 to 7 loop
					if grid(i)(j) = '0' then full := '0';
					end if;
				end loop;
				if full = '1' then
					for k in i downto 1 loop
						grid(k) <= grid(k - 1);
					end loop;
				end if;
			end loop;
		end if;
	end process move;
	
	seed: process(clk_seed)
	begin
		if clk_seed'event and clk_seed = '1' then
			random <= (random + 5) rem 28;
		end if;
	end process seed;
	
	show: process(c3, c2, c1, c0, grid, current, dx, dy)
		variable num    :integer range 0 to 15;
		variable x, y   :integer;
		variable column :t_column;
	
	begin
		num := 0;
		if c3 = '1' then num := num + 8;
		end if;
		if c2 = '1' then num := num + 4;
		end if;
		if c1 = '1' then num := num + 2;
		end if;
		if c0 = '1' then num := num + 1;
		end if;
		column := grid(num);
		
		for i in 0 to 3 loop
			x := shapes(current)(i)(1) + dx;
			y := shapes(current)(i)(0) + dy;
			if y = num then column(x) := '1';
		   end if;
		end loop;
		
		a <= column(0);
		b <= column(1);
		c <= column(2);
		d <= column(3);
		e <= column(4);
		f <= column(5);
		g <= column(6);
		h <= column(7);
	end process show;

end behave;