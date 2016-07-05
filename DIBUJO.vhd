library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.HexaPackage.all;

ENTITY DIBUJO IS
	PORT(
		CLK		:	IN	STD_LOGIC;
		ALTERNA	:	IN	STD_LOGIC;
		CCOLOR	:	IN	STD_LOGIC;
		--RESET		:	IN	STD_LOGIC;
		DPAREDES	:	IN	STD_LOGIC;
		DISLA		:	IN	STD_LOGIC;
		DJUGADOR	:	IN	STD_LOGIC;
		CUADRANTE:	IN	STD_LOGIC_VECTOR(2 DOWNTO 0);
		RAND		:	IN	STD_LOGIC_VECTOR(63 DOWNTO 0);
		
		ROJO		:	OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		VERDE		:	OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		AZUL		:	OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END ENTITY;
ARCHITECTURE BEH OF DIBUJO IS

TYPE A_2D IS ARRAY(0 TO 15) OF STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL INV_COLOR:	STD_LOGIC;
CONSTANT ESQUEMAS_COLOR: A_2D	:=
	(0=>X"311"	,	1=>X"000"	,	2=>X"F11"	,	3=>X"EEE"	,
	4=>X"131"	,	5=>X"000"	,	6=>X"1F1"	,	7=>X"EEE"	,
	8=>X"113"	,	9=>X"000"	,	10=>X"11F"	,	11=>X"EEE"	,
	12=>X"313"	,	13=>X"000"	,	14=>X"F1F"	,	15=>X"EEE"	);

SIGNAL ESQUEMA:	UNSIGNED(1 DOWNTO 0);

BEGIN

INVIERTECOLOR:PROCESS (CLK,ALTERNA)
BEGIN
IF (RISING_EDGE(CLK)) THEN
	IF (ALTERNA='1') THEN
		INV_COLOR<= NOT(INV_COLOR);
	END IF;
END IF;
END PROCESS;

CAMBIACOLORES:PROCESS (CLK,CCOLOR)
BEGIN
IF RISING_EDGE(CLK) THEN
	IF (CCOLOR='1') THEN
		ESQUEMA <= UNSIGNED(RAND(18 DOWNTO 17));
	END IF;
END IF;
END PROCESS;

DEFINEDIBUJO:PROCESS(CLK,DJUGADOR,DISLA,DPAREDES,CUADRANTE,INV_COLOR)
VARIABLE INDICE: INTEGER;
VARIABLE DATO	: STD_LOGIC_VECTOR(11 DOWNTO 0);
BEGIN
	IF (RISING_EDGE(CLK)) THEN
		IF(DJUGADOR='1') THEN
			INDICE := TO_INTEGER(ESQUEMA)*4+3;
			DATO	:=	ESQUEMAS_COLOR(INDICE);
			ROJO <=	DATO(3 DOWNTO 0);
			VERDE <=	DATO(7 DOWNTO 4);
			AZUL <=	DATO(11 DOWNTO 8);
		ELSIF(DISLA='1') THEN
			INDICE := TO_INTEGER(ESQUEMA)*4+1;
			DATO	:=	ESQUEMAS_COLOR(INDICE);
			ROJO <=	DATO(3 DOWNTO 0);
			VERDE <=	DATO(7 DOWNTO 4);
			AZUL <=	DATO(11 DOWNTO 8);
		ELSIF(DPAREDES='1') THEN
			INDICE := TO_INTEGER(ESQUEMA)*4+2;
			DATO	:=	ESQUEMAS_COLOR(INDICE);
			ROJO <=	DATO(3 DOWNTO 0);
			VERDE <=	DATO(7 DOWNTO 4);
			AZUL <=	DATO(11 DOWNTO 8);
		ELSE
			IF(bit2bool(CUADRANTE(0)) XOR bit2bool(INV_COLOR)) THEN
				INDICE := TO_INTEGER(ESQUEMA)*4+0;
				DATO	:=	ESQUEMAS_COLOR(INDICE);
				ROJO <=	DATO(3 DOWNTO 0);
				VERDE <=	DATO(7 DOWNTO 4);
				AZUL <=	DATO(11 DOWNTO 8);
			ELSE
				INDICE := TO_INTEGER(ESQUEMA)*4+1;
				DATO	:=	ESQUEMAS_COLOR(INDICE);
				ROJO <=	DATO(3 DOWNTO 0);
				VERDE <=	DATO(7 DOWNTO 4);
				AZUL <=	DATO(11 DOWNTO 8);
			END IF;
		END IF;
	END IF;
END PROCESS;

END ARCHITECTURE;