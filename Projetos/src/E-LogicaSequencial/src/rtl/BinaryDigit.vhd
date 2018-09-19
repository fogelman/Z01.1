-- Elementos de Sistemas
-- by Luciano Soares
-- BinaryDigit.vhd

Library ieee;
use ieee.std_logic_1164.all;

entity BinaryDigit is
	port(
		clock:   in STD_LOGIC;
		input:   in STD_LOGIC;
		load:    in STD_LOGIC;
		output: out STD_LOGIC
	);
end entity;

architecture rtl of BinaryDigit is

  component Mux2Way is
    port(
      a: in STD_LOGIC;
      b: in STD_LOGIC;
      sel: in STD_LOGIC;
      q: out STD_LOGIC
    );
  end component;

  component FlipFlopD is
    port(
      clock: in STD_LOGIC;
      d: in STD_LOGIC;
      clear: in STD_LOGIC;
      preset: in STD_LOGIC;
      q: out STD_LOGIC
    );
  end component;

signal tmp1,tmp2 : std_logic;

begin

  mux2: Mux2Way PORT MAP (tmp2,input,load,tmp1);
  FF: FlipFlopD PORT MAP (clock,tmp1,'0','0',tmp2);
  output <= tmp2;
end rtl;
