-- Elementos de Sistemas
-- by Luciano Soares
-- comparador16.vhd

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity comparador16 is
   port(
	     a    : in STD_LOGIC_VECTOR(15 downto 0);
       zr   : out STD_LOGIC;
       ng   : out STD_LOGIC
   );
end comparador16;

architecture rtl of comparador16 is

SIGNAL cm:STD_LOGIC_VECTOR(15 downto 0);

begin
  cm(0) <= '0' or a(0);
  cm(1) <= cm(0) or a(1);
  cm(2) <= cm(1) or a(2);
  cm(3) <= cm(2) or a(3);
  cm(4) <= cm(3) or a(4);
  cm(5) <= cm(4) or a(5);
  cm(6) <= cm(5) or a(6);
  cm(7) <= cm(6) or a(7);
  cm(8) <= cm(7) or a(8);
  cm(9) <= cm(8) or a(9);
  cm(10) <= cm(9) or a(10);
  cm(11) <= cm(10) or a(11);
  cm(12) <= cm(11) or a(12);
  cm(13) <= cm(12) or a(13);
  cm(14) <= cm(13) or a(14);
  cm(15) <= cm(14) or a(15);
  zr <= cm(15);
  ng <= a(15);

end architecture;
