library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.HexaPackage.all;

ENTITY SUPERHEXAGON2 IS
	PORT(
		CLK			:	IN	STD_LOGIC;
		CLR			:	IN	STD_LOGIC;
		Nuevo_juego	:	in	std_logic;
	
		HSYNC			:	OUT	STD_LOGIC;
		VSYNC			:	OUT	STD_LOGIC;
		VGA_SYNC_N	:	OUT	STD_LOGIC;
		VGA_BLANK_N	:	OUT	STD_LOGIC;
	);
END ENTITY;


ARCHITECTURE BEH OF SUPERHEXAGON2 IS

SIGNAL CLK25MHZ				:	STD_LOGIC;
SIGNAL RED,GREEN,BLUE		:	STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL X,Y						:	UNSIGNED(9 DOWNTO 0);
SIGNAL XC,YC					:	SIGNED(9 downto 0);
SIGNAL XCR,YCR					:	SIGNED(9 downto 0);
SIGNAL END_FRAME,PRE_FRAME	:	STD_LOGIC;
SIGNAL Actualizar				:	std_logic;
SIGNAL angulo					:	unsigned(9 downto 0)
SIGNAL RESET					:	STD_LOGIC;
BEGIN

GEN_CLOCK:PROCESS(CLK,CLR)
BEGIN
	IF (CLR='1') THEN
		CLK25MHZ<='0';
	ELSIF(RISING_EDGE(CLK)) THEN
		CLK25MHZ<=NOT(CLK25MHZ);
	END IF;
END PROCESS;

DRIVER_VGA: CONTROLADOR_VGA
	PORT MAP(
		CLK			=>CLK25MHZ,
		CLR			=>CLR,
		RED_IN		=>RED,
		GREEN_IN		=>GREEN,
		BLUE_IN		=>BLUE,
		
		HSYNC			=>HSYNC,
		VSYNC			=>VSYNC,
		VGA_SYNC_N	=>VGA_SYNC_N,
		VGA_BLANK_N	=>VGA_BLANK_N,
		X				=>X,
		Y				=>Y,
		RED			=>OPEN,
		GREEN			=>OPEN,
		BLUE			=>OPEN,
		END_FRAME	=>END_FRAME,
		PRE_FRAME	=>PRE_FRAME
	);

Juego_Fsm1: Juego_Fsm port map(
		Clk				=>CLK25MHZ,
		Frame_inicio	=>PRE_FRAME,
		Frame_fin		=>END_FRAME,
		Nuevo_juego		=>Nuevo_juego,
		Colision_nuevo	=>'0',					--REVISAR
		Colision_viejo	=>'0',					--REVISAR
		Reset				=>CLR,
		
		Actualizar		=>Actualizar,
		Rst				=>RESET,
		Vuelve_jugador	=>OPEN
		Game_over		=>OPEN
	);
		
		
CoordenadasCentro: DesplazaXYalCentro port map(
		Clk		=>CLK25MHZ,
		Xin		=>X,
		Yin		=>Y,
		Xout		=>XC,
		Yout		=>YC,
	);

Rotar1: rotar port map(
		clk			=>CLK25MHZ,
		Actualizar	=>Actualizar,
		X_in			=>XC,
		Y_in			=>YC,
		angulo		=>angulo,
		
		X_out			=>XCR,
		Y_out			=>YCR
	);

Rect2Hex1: conv_hexagonal port map(
		clk			=>CLK25MHZ,
		x				=>XC,
		y				=>YC,
		
		cuadrante	=>
		radio			=>
	);

Rect2Hex2: conv_hexagonal port map(
		clk			=>CLK25MHZ
		x				=>XCR,
		y				=>YCR,
		
		cuadrante	=>
		radio			=>
	);
	
--Paredes1: PAREDES PORT MAP(
--		CLK				=>
--		RESET				=>
--		ACTUALIZAR		=>
--		DIFICULTAD		=>
--		DATA				=>
--		CCUADRANTE		=>
--		CRADIO			=>
--		CUADRANTE		=>
--		RADIO				=>
--		
--		MANTIENE			=>
--		DATA_ADDR		=>
--		CUADRANTE_OUT	=>
--		VISIBLE			=>
--		ISLA				=>
--		CVISIBLE			=>
--	);
	
ControlGiro1:control_giro port map(
		clk					=>CLK25MHZ,
		reset					=>RESET,
		Actualizar			=>Actualizar,
		Random				=>
		Subir_velocidad	=>
		
		angulo				=>
	);

END ARCHITECTURE;