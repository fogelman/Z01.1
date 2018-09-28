-- Elementos de Sistemas
-- by Luciano Soares
-- Ram4K.vhd

Library ieee; 
use ieee.std_logic_1164.all;
  
entity Ram4K is
	port(
		clock:   in  STD_LOGIC;
		input:   in  STD_LOGIC_VECTOR(15 downto 0);
		load:    in  STD_LOGIC;
		address: in  STD_LOGIC_VECTOR(11 downto 0);
		output:  out STD_LOGIC_VECTOR(15 downto 0)
	);
end entity;




architecture rtl of Ram4K is 


signal s : std_logic_vector(7 downto 0):="00000000";
signal outA, outB, outC, outD, outE, outF, outG, outH :std_logic_vector(15 downto 0):= (others => '0');

component Ram512 is
	port(
		clock:   in  STD_LOGIC;
		input:   in  STD_LOGIC_VECTOR(15 downto 0);
		load:    in  STD_LOGIC;
		address: in  STD_LOGIC_VECTOR( 8 downto 0);
		output:  out STD_LOGIC_VECTOR(15 downto 0)
	);
end component;


component DMux8Way is
	port ( 
			a:   in  STD_LOGIC;
			sel: in  STD_LOGIC_VECTOR(2 downto 0);
			q0:  out STD_LOGIC;
			q1:  out STD_LOGIC;
			q2:  out STD_LOGIC;
			q3:  out STD_LOGIC;
			q4:  out STD_LOGIC;
			q5:  out STD_LOGIC;
			q6:  out STD_LOGIC;
			q7:  out STD_LOGIC);
end component;



component Mux8Way16 is
	port (
			a:   in  STD_LOGIC_VECTOR(15 downto 0);
			b:   in  STD_LOGIC_VECTOR(15 downto 0);
			c:   in  STD_LOGIC_VECTOR(15 downto 0);
			d:   in  STD_LOGIC_VECTOR(15 downto 0);
			e:   in  STD_LOGIC_VECTOR(15 downto 0);
			f:   in  STD_LOGIC_VECTOR(15 downto 0);
			g:   in  STD_LOGIC_VECTOR(15 downto 0);
			h:   in  STD_LOGIC_VECTOR(15 downto 0);
			sel: in  STD_LOGIC_VECTOR(2 downto 0);
			q:   out STD_LOGIC_VECTOR(15 downto 0));
end component;



begin

dmux : DMux8Way port map(load, address(11 downto 9),s(0),s(1),s(2),s(3),s(4),s(5),s(6),s(7));
a : Ram512 port map (clock, input, s(0), address(8 downto 0), outA);
b : Ram512 port map (clock, input, s(1), address(8 downto 0), outB);
c : Ram512 port map (clock, input, s(2), address(8 downto 0), outC);
d : Ram512 port map (clock, input, s(3), address(8 downto 0), outD);
e : Ram512 port map (clock, input, s(4), address(8 downto 0), outE);
f : Ram512 port map (clock, input, s(5), address(8 downto 0), outF);
g : Ram512 port map (clock, input, s(6), address(8 downto 0), outG);
h : Ram512 port map (clock, input, s(7), address(8 downto 0), outH);
outAll : Mux8Way16 port map (outA, outB, outC, outD, outE, outF, outG, outH, address(11 downto 9), output);


end rtl;