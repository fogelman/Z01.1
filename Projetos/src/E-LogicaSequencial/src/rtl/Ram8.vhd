-- Elementos de Sistemas
-- by Luciano Soares
-- Ram8.vhd

Library ieee;
use ieee.std_logic_1164.all;

entity Ram8 is
	port(
		clock:   in  STD_LOGIC;
		input:   in  STD_LOGIC_VECTOR(15 downto 0);
		load:    in  STD_LOGIC;
		address: in  STD_LOGIC_VECTOR(2 downto 0);
		output:  out STD_LOGIC_VECTOR(15 downto 0)
	);
end entity;

architecture rtl of Ram8 is

  --Chamando o componente Register16
  component Register16 is
    port (
      clock: in STD_LOGIC;
      load: in STD_LOGIC;
      input: in STD_LOGIC_VECTOR(15 downto 0);
      output: out STD_LOGIC_VECTOR(15 downto 0)
    );
  end component;

  --Chamando o componente Mux8Way
  component Mux8Way16 is
    port(
    a,b,c,d,e,f,g,h : in STD_LOGIC_VECTOR(15 downto 0);
    sel: in STD_LOGIC_VECTOR(2 downto 0);
    q: out STD_LOGIC_VECTOR(15 downto 0)
    );
  end component;

  --Chamando o componente DMux8Way
  component DMux8Way is
    port(
    a: in STD_LOGIC;
    sel: in STD_LOGIC_VECTOR(2 downto 0);
    q0,q1,q2,q3,q4,q5,q6,q7: out STD_LOGIC
    );
  end component;

  signal s0,s1,s2,s3,s4,s5,s6,s7: STD_LOGIC_VECTOR(15 downto 0); --Sinal do Mux8Way
  signal r0,r1,r2,r3,r4,r5,r6,r7: STD_LOGIC; --Sinal do DMux8Way

begin
  k0 : Mux8Way16 port map(
    a => s0,
    b => s1,
    c => s2,
    d => s3,
    e => s4,
    f => s5,
    g => s6,
    h => s7,
    sel => address,
    q => output
  );

  k1: DMux8Way port map(
    a => load,
    sel => address,
    q0 => r0,
    q1 => r1,
    q2 => r2,
    q3 => r3,
    q4 => r4,
    q5 => r5,
    q6 => r6,
    q7 => r7
  );

  k2: Register16 port map(
		clock => clock,
		input => input,
		load => r0,
		output => s0
	);

	k3: Register16 port map(
		clock => clock,
		input => input,
		load => r1,
		output => s1
	);

	k4: Register16 port map(
		clock => clock,
		input => input,
		load => r2,
		output => s2
	);

	k5: Register16 port map(
		clock => clock,
		input => input,
		load => r3,
		output => s3
	);

	k6: Register16 port map(
		clock => clock,
		input => input,
		load => r4,
		output => s4
	);

	k7: Register16 port map(
		clock => clock,
		input => input,
		load => r5,
		output => s5
	);

	k8: Register16 port map(
		clock => clock,
		input => input,
		load => r6,
		output => s6
	);

	k9: Register16 port map(
		clock => clock,
		input => input,
		load => r7,
		output => s7
    );

end rtl;
