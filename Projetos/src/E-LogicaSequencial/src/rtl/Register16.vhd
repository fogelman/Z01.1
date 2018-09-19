-- Elementos de Sistemas
-- by Luciano Soares
-- Register16.vhd

Library ieee; 
use ieee.std_logic_1164.all;
  
entity Register16 is
	port(
		clock:   in STD_LOGIC;
		input:   in STD_LOGIC_VECTOR(15 downto 0);
		load:    in STD_LOGIC;
		output: out STD_LOGIC_VECTOR(15 downto 0)
	);
end entity;

architecture behavior of Register16 is

    signal temp: std_logic_vector(15 downto 0);

begin

    process(clock, input, load)
    begin

	if (clock='1' and clock'event) then
	    if load = '1' then
		temp <= input;
	    end if;
	end if;

    end process;

    output <= temp;

end behavior;
