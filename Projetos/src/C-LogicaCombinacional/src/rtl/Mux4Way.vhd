library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux4Way is
	port (
			a:   in  STD_LOGIC;
			b:   in  STD_LOGIC;
			c:   in  STD_LOGIC;
			d:   in  STD_LOGIC;
			sel: in  STD_LOGIC_VECTOR(1 downto 0);
			q:   out STD_LOGIC);
end entity;
architecture rtl of Mux4Way is

begin
	process(a,b,c,d,sel)
	begin
		if (sel = "00") then
			q <= a;
		elsif (sel = "01") then
			q <= b;
		elsif (sel = "10") then
			q <= c;
		elsif (sel = "11") then
			q <= d;
		end if;
	end process;
end rtl;
