-- Elementos de Sistemas
-- by Luciano Soares
-- FullAdder.vhd

-- Implementa Full Adder

Library ieee;
use ieee.std_logic_1164.all;

entity FullAdder is
	port(
		a,b,c:      in STD_LOGIC;   -- entradas
		soma,vaium: out STD_LOGIC   -- sum e carry
	);
end entity;

architecture rtl of FullAdder is
 
  signal w_WIRE_1 : std_logic;
  signal w_WIRE_2 : std_logic;
  signal w_WIRE_3 : std_logic;
   
begin
 
  w_WIRE_1 <= a xor b;
  w_WIRE_2 <= w_WIRE_1 and c;
  w_WIRE_3 <= a and b;
 
  soma   <= w_WIRE_1 xor c;
  vaium <= w_WIRE_2 or w_WIRE_3;
 
end rtl;
