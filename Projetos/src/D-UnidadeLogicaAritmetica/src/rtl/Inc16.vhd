-- Elementos de Sistemas
-- by Luciano Soares
-- Inc16.vhd

-- Incrementador de 16 bits
-- adiciona 1 ao valore de entrada (adição aritmética)

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Inc16 is
	port(
		a   :  in STD_LOGIC_VECTOR(15 downto 0);
		q   : out STD_LOGIC_VECTOR(15 downto 0)
	);
end entity;

architecture rtl of Inc16 is

component HalfAdder is
	port(
		a,b:        in STD_LOGIC;   -- entradas
		soma,vaium: out STD_LOGIC   -- sum e carry
	);
end component;

signal guarda : STD_LOGIC_VECTOR(15 downto 0);

begin

H01: HalfAdder port map(a(0),'1',q(0),guarda(0));
H02: HalfAdder port map(a(1),guarda(0),q(1),guarda(1));
H03: HalfAdder port map(a(2),guarda(1),q(2),guarda(2));
H04: HalfAdder port map(a(3),guarda(2),q(3),guarda(3));
H05: HalfAdder port map(a(4),guarda(3),q(4),guarda(4));
H06: HalfAdder port map(a(5),guarda(4),q(5),guarda(5));
H07: HalfAdder port map(a(6),guarda(5),q(6),guarda(6));
H08: HalfAdder port map(a(7),guarda(6),q(7),guarda(7));
H09: HalfAdder port map(a(8),guarda(7),q(8),guarda(8));
H10: HalfAdder port map(a(9),guarda(8),q(9),guarda(9));
H11: HalfAdder port map(a(10),guarda(9),q(10),guarda(10));
H12: HalfAdder port map(a(11),guarda(10),q(11),guarda(11));
H13: HalfAdder port map(a(12),guarda(11),q(12),guarda(12));
H14: HalfAdder port map(a(13),guarda(12),q(13),guarda(13));
H15: HalfAdder port map(a(14),guarda(13),q(14),guarda(14));
H16: HalfAdder port map(a(15),guarda(14),q(15),guarda(15));

end architecture;
