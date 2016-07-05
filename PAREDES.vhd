library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.HexaPackage.all;
--ESTE MÓDULO DEFINE QUE ES LO QUE ES PARED O ISLA.
ENTITY PAREDES IS
	PORT(
		CLK			:		IN	STD_LOGIC;
		RESET			:		IN	STD_LOGIC;
		ACTUALIZAR	:		IN	STD_LOGIC;
		DIFICULTAD	:		IN	STD_LOGIC_VECTOR(1 DOWNTO 0);
		DATA			:		IN	STD_LOGIC_VECTOR(6 DOWNTO 0);
		CCUADRANTE	:		IN	UNSIGNED(2 DOWNTO 0);
		CRADIO		:		IN	UNSIGNED(9 DOWNTO 0);
		CUADRANTE	:		IN	UNSIGNED(2 DOWNTO 0);
		RADIO			:		IN	UNSIGNED(9 DOWNTO 0);
		
		MANTIENE		:		OUT	STD_LOGIC;
		DATA_ADDR	:		OUT	STD_LOGIC_VECTOR(5 DOWNTO 0);
		CUADRANTE_OUT:		OUT	STD_LOGIC_VECTOR(2 DOWNTO 0);
		VISIBLE		:		OUT	STD_LOGIC;
		ISLA			:		OUT	STD_LOGIC;
		CVISIBLE		:		OUT	STD_LOGIC
	);
END ENTITY;

ARCHITECTURE BEH OF PAREDES IS

TYPE T_2D_A IS ARRAY(0 TO 127) OF STD_LOGIC_VECTOR(5 DOWNTO 0);	--ARREGLO QUE DEFINE LAS PAREDES

SIGNAL PAREDES_A	:	T_2D_A;
SIGNAL CENTRO	:	UNSIGNED(13 DOWNTO 0);
SIGNAL PUNTERO	:	UNSIGNED(6 DOWNTO 0);
SIGNAL OFFSET	:	UNSIGNED(11 DOWNTO 0);
SIGNAL COFFSET	:	UNSIGNED(11 DOWNTO 0);
SIGNAL MANTIENE_AUX:	STD_LOGIC;

BEGIN

OFFSET <= CENTRO(13 DOWNTO 2)	+ ("00" & RADIO);
COFFSET<= CENTRO(13 DOWNTO 2)	+ ("00" & CRADIO);
DATA_ADDR <= STD_LOGIC_VECTOR(PUNTERO(5 DOWNTO 0));
MANTIENE <= MANTIENE_AUX;
MANTIENE_AUX <= '1' WHEN (PUNTERO (5 DOWNTO 0)/=TO_UNSIGNED(0,6) OR 
							(PUNTERO=TO_UNSIGNED(0,7) AND bit2bool(CENTRO(13))) OR
							(PUNTERO="1000000" AND NOT(bit2bool(CENTRO(13))))) ELSE '0';


MUEVECENTRO:PROCESS(CLK,RESET,DIFICULTAD,ACTUALIZAR)
BEGIN
IF RISING_EDGE(CLK) THEN
	IF(RESET='1') THEN
		CENTRO <= TO_UNSIGNED(6144,14);
	ELSIF(ACTUALIZAR='1') THEN
		CASE DIFICULTAD IS
			WHEN "00" => CENTRO <= CENTRO + TO_UNSIGNED(6,14);
			WHEN "01" => CENTRO <= CENTRO + TO_UNSIGNED(9,14);
			WHEN "10" => CENTRO <= CENTRO + TO_UNSIGNED(12,14);
			WHEN "11" => CENTRO <= CENTRO + TO_UNSIGNED(15,14);
		END CASE;
	END IF;
END IF;
END PROCESS;
		
PROCESS (RADIO,CLK)
	VARIABLE AUX:	STD_LOGIC_VECTOR(5 DOWNTO 0);
BEGIN
	IF RISING_EDGE(CLK) THEN
		CUADRANTE_OUT	<= STD_LOGIC_VECTOR(CUADRANTE);
			VISIBLE <= '0';
			CVISIBLE <= '0';
			ISLA <= '0';
		IF (RADIO < TO_UNSIGNED(28,10)) THEN
			ISLA <= '1';
		ELSIF(RADIO < TO_UNSIGNED(32,10)) THEN
			VISIBLE <= '1';
		ELSE
			AUX := PAREDES_A(TO_INTEGER(OFFSET(11 DOWNTO 5)));
			VISIBLE <= AUX(TO_INTEGER(CUADRANTE));
			AUX := PAREDES_A(TO_INTEGER(COFFSET(11 DOWNTO 5)));
			CVISIBLE <= AUX(TO_INTEGER(CCUADRANTE));
		END IF;
	END IF;
END PROCESS;
		
PROCESS (CLK,RESET,MANTIENE_AUX)
BEGIN
IF RISING_EDGE(CLK) THEN
	IF (RESET='1') THEN
		PUNTERO <= TO_UNSIGNED(64,7);
		FOR i IN 0 TO 127 LOOP
			PAREDES_A(i) <= STD_LOGIC_VECTOR(TO_UNSIGNED(0,6));
		END LOOP;
	ELSIF(MANTIENE_AUX='1') THEN
		PAREDES_A(TO_INTEGER(PUNTERO))<= DATA;
		PUNTERO <= PUNTERO+1;
	END IF;
END IF;
END PROCESS;

END ARCHITECTURE;