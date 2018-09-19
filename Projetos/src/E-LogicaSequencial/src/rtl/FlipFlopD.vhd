-- Elementos de Sistemas
-- by Luciano Soares
-- FlipFlopD.vhd

library ieee;
use ieee.std_logic_1164.all;

entity FlipFlopD is
	port(
		clock:  in std_logic;
		d:      in std_logic;
		clear:  in std_logic;
		preset: in std_logic;
		q:     out std_logic
	);
end entity;

architecture arch of FlipFlopD is
begin
	
	if (rising_edge(clock)) then
		q <= d;
	elsif (clear = '1') then
		q <= '0';
	elsif (preset = '1') then
		q <= '1';
	end if;

end architecture;
