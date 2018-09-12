library ieee;
use ieee.std_logic_1164.all;

entity TopLevel is
        port
        (  A         : in  std_logic_vector(31 downto 0);
		   B         : in  std_logic_vector(31 downto 0);
           Vai1      : out std_logic;
		   Zero      : out std_logic;  
		   Resultado : out std_logic_vector(31 downto 0));
end TopLevel;

architecture teste of TopLevel is

	component inverter port (
		In1      : in  std_logic_vector(31 downto 0);
		In2      : in  std_logic_vector(31 downto 0);
		Controle : in  std_logic;
		Saida    : out std_logic_vector(31 downto 0)
	);
	end component;

	component adder port (
		In1      : in  std_logic_vector(31 downto 0);
		In2      : in  std_logic_vector(31 downto 0);
		Vem1     : in  std_logic;
		Saida    : out std_logic_vector(31 downto 0);		
		Vai1     : out std_logic
	);
	end component;
	
	component mux2 port (
		In0      : in  std_logic_vector(31 downto 0);
		In1      : in  std_logic_vector(31 downto 0);
		Controle : in  std_logic;
		Saida    : out std_logic_vector(31 downto 0)		
	);
	end component;	
	
	component mux4 port (
		In0      : in  std_logic_vector(31 downto 0);
		In1      : in  std_logic_vector(31 downto 0);
		In2      : in  std_logic_vector(31 downto 0);
		In3      : in  std_logic_vector(31 downto 0);
		Controle : in  std_logic;--_vector(1  downto 0);
		Saida    : out std_logic_vector(31 downto 0)		
	);
	end component;

	
begin

u1 : mux4 port map( 
     in0 => A,
	 in1 => open,
	 in2 => open,
	 in3 => B,
	 controle => '0',
	 Saida => resultado
	 );

	
end teste;

