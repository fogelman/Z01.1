library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MemoryIO is
   PORT(
     -- Sistema
     CLK_SLOW : IN  STD_LOGIC;
     CLK_FAST : IN  STD_LOGIC;
     RST      : IN  STD_LOGIC;

     -- RAM 16K oioioioioi
     ADDRESS  : IN  STD_LOGIC_VECTOR (14 DOWNTO 0);
     INPUT		: IN  STD_LOGIC_VECTOR (15 DOWNTO 0);
     LOAD	  	: IN  STD_LOGIC ;
     OUTPUT		: OUT STD_LOGIC_VECTOR (15 DOWNTO 0);

     -- LCD EXTERNAL I/OS
     LCD_CS_N     : OUT   STD_LOGIC;
     LCD_D        : INOUT STD_LOGIC_VECTOR(15 downto 0);
     LCD_RD_N     : OUT   STD_LOGIC;
     LCD_RESET_N  : OUT   STD_LOGIC;
     LCD_RS       : OUT   STD_LOGIC;	-- (DCx) 0 : reg, 1: command
     LCD_WR_N     : OUT   STD_LOGIC;
     LCD_ON       : OUT   STD_LOGIC := '1';	-- liga e desliga o LCD
     LCD_INIT_OK  : OUT   STD_LOGIC;

     -- I/Os
     SW  : in std_logic_vector(9 downto 0);
     LED : OUT std_logic_vector(9 downto 0)
		);
end entity;


ARCHITECTURE logic OF MemoryIO IS
	--Declarando o componente Screen
  component Screen is
    PORT(
      -- Sistema
      CLK_FAST : IN  STD_LOGIC;
      CLK_SLOW : IN  STD_LOGIC;
      RST 	   : IN  STD_LOGIC;

      -- interface
      INPUT        : IN STD_LOGIC_VECTOR(15 downto 0);
      LOAD         : IN  STD_LOGIC;
      ADDRESS      : IN STD_LOGIC_VECTOR(13 downto 0);
      LCD_INIT_OK  : OUT STD_LOGIC;

      -- LCD EXTERNAL I/OS
      LCD_CS_N     : OUT   STD_LOGIC;
      LCD_D        : INOUT STD_LOGIC_VECTOR(15 downto 0);
      LCD_RD_N     : OUT   STD_LOGIC;
      LCD_RESET_N  : OUT   STD_LOGIC;
      LCD_RS       : OUT   STD_LOGIC;	-- (DCx) 0 : reg, 1: command
      LCD_WR_N     : OUT   STD_LOGIC
    );
  end component;
  --Declarando o componente RAM16K
  component RAM16K is
    port  (
      clock		: IN STD_LOGIC;
      address	: IN STD_LOGIC_VECTOR (13 DOWNTO 0);
      data		: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
      wren		: IN STD_LOGIC;
      q		   : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
    );
  end component;
	--Declarando o componente Mux4Way16
  component Mux4Way16 is
    Port (
      sel : in  STD_LOGIC_VECTOR ( 1 downto 0);
      a   : in  STD_LOGIC_VECTOR (15 downto 0);
      b   : in  STD_LOGIC_VECTOR (15 downto 0);
      c   : in  STD_LOGIC_VECTOR (15 downto 0);
      d   : in  STD_LOGIC_VECTOR (15 downto 0);
      q   : out STD_LOGIC_VECTOR (15 downto 0)
    );
  end component;
	--Declarando o componente DMux4Way
  component DMux4Way is
    Port(
			a:   in  STD_LOGIC;
			sel: in  STD_LOGIC_VECTOR(1 downto 0);
			q0:  out STD_LOGIC;
			q1:  out STD_LOGIC;
			q2:  out STD_LOGIC;
			q3:  out STD_LOGIC
    );
  end component;
	--Declarando o componente Register16
  component Register16 is
    port(
      clock:   in STD_LOGIC;
      input:   in STD_LOGIC_VECTOR(15 downto 0);
      load:    in STD_LOGIC;
      output: out STD_LOGIC_VECTOR(15 downto 0)
    );
  end component;


signal sel1 : STD_LOGIC_VECTOR(1 downto 0):="00";
signal sel2 : STD_LOGIC_VECTOR(1 downto 0):="00";
signal muxSaida: STD_LOGIC_VECTOR(3 downto 0):=(others=>'0');
signal ram16Saida: STD_LOGIC_VECTOR(15 downto 0):=(others=>'0');
signal saidaReg16 : STD_LOGIC_VECTOR(15 downto 0):=(others=>'0');
signal botoes : STD_LOGIC_VECTOR(15 downto 0):=(others=>'0');
BEGIN
		--Criando o Componente Screen
    DISPLAY: Screen  port map (
          RST         => RST,
          CLK_FAST    => CLK_FAST,
          CLK_SLOW    => CLK_SLOW,
          INPUT       => INPUT(15 DOWNTO 0),
          LOAD        => muxSaida(2),
          ADDRESS     => ADDRESS(13 downto 0),
          LCD_INIT_OK => LCD_INIT_OK,
          LCD_CS_N 	  => LCD_CS_N,
          LCD_D       => LCD_D,
          LCD_RD_N 	  => LCD_RD_N,
          LCD_RESET_N => LCD_RESET_N,
          LCD_RS 	    => LCD_RS,
          LCD_WR_N 	  => LCD_WR_N
    );
		--Criando o Componente RAM16K
    RAM: RAM16K  PORT MAP(
         clock		=> CLK_FAST,
         address  => ADDRESS(13 DOWNTO 0),
         data		  => INPUT(15 DOWNTO 0),
         wren		  => muxSaida(0),
         q		    => ram16Saida
    );
  	--Criando o Componente Register16
    REG16: Register16 PORT MAP(
      clock => CLK_SLOW,
			input =>  INPUT(15 DOWNTO 0),
			load  =>  muxSaida(1),
			output => saidaReg16
    );
		--Criando o Componente DMux4Way
    DMUX: DMux4Way PORT MAP(
      a => LOAD,
      sel =>sel1,
      q0 => muxSaida(0),
      q1 =>	muxSaida(1),
      q2 => muxSaida(2),
      q3 => muxSaida(3)
    );
    --Criando o Componente Mux4Way16
    MUX: Mux4Way16 PORT Map(
      sel => sel2,
      a => botoes,
      b => ram16Saida,
      c => ram16Saida,
      d => ram16Saida,
      q => OUTPUT
      );

		--Criando o Seletor do DMux4Way
    sel1 <= "00" when ADDRESS(14 downto 0) <= "011111111111111" else
      			"10" when ADDRESS(14 downto 0) <= "101001010111111" else
      			"01" when ADDRESS(14 downto 0) = "101001011000000";

    --Criando o Seletor do Mux4Way16         
		sel2 <= "01" when ADDRESS(14 downto 0) <= "011111111111111" else
     				"00";


    LED <= saidaReg16(9 downto 0);
    botoes(9 downto 0) <= SW; 
END logic;
