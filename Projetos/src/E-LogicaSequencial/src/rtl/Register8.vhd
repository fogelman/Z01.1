-- Elementos de Sistemas
-- by Luciano Soares
-- Register8.vhd

Library ieee; 
use ieee.std_logic_1164.all;
  
entity Register8 is
	port(
		clock:   in STD_LOGIC;
		input:   in STD_LOGIC_VECTOR(7 downto 0);
		load:    in STD_LOGIC;
		output: out STD_LOGIC_VECTOR(7 downto 0)
	);
end entity;

architecture arch of Register8 is

	component BinaryDigit is
		port(
			clock:	in STD_LOGIC;
			input:	in STD_LOGIC;
			load:	in STD_LOGIC;
			output:	out STD_LOGIC
		);
	end component;
begin
	B1 : BinaryDigit PORT MAP(clock,input(0),load,output(0));
	B2 : BinaryDigit PORT MAP(clock,input(1),load,output(1));
	B3 : BinaryDigit PORT MAP(clock,input(2),load,output(2));
	B4: BinaryDigit PORT MAP(clock,input(3),load,output(3));
	B5: BinaryDigit PORT MAP(clock,input(4),load,output(4));
	B6: BinaryDigit PORT MAP(clock,input(5),load,output(5));
	B7: BinaryDigit PORT MAP(clock,input(6),load,output(6));
	B8: BinaryDigit PORT MAP(clock,input(7),load,output(7));
	
end architecture;

