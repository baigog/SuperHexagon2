library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use work.HexaPackage.all;

PACKAGE HexaPackage IS

CONSTANT BITS		: INTEGER:=	10;
CONSTANT HPIXELS	: UNSIGNED:= TO_UNSIGNED(800,BITS);		--SYNC_PULSE	+BP	+AREA VISIBLE	+FP
CONSTANT vLINES	: UNSIGNED:= TO_UNSIGNED(525,BITS);
CONSTANT HPULSE	: UNSIGNED:= TO_UNSIGNED(96,BITS);				--96
CONSTANT VPULSE	: UNSIGNED:= TO_UNSIGNED(2,BITS);				--2
CONSTANT HBP		: UNSIGNED:= TO_UNSIGNED(144,BITS);							--48
CONSTANT VBP		: UNSIGNED:= TO_UNSIGNED(35,BITS);								--33
CONSTANT HAREA		: UNSIGNED:= TO_UNSIGNED(640,BITS);									--640
CONSTANT VAREA		: UNSIGNED:= TO_UNSIGNED(480,BITS);									--480
CONSTANT HFP		: UNSIGNED:= TO_UNSIGNED(784,BITS);														--16
CONSTANT VFP		: UNSIGNED:= TO_UNSIGNED(515,BITS);														--10
CONSTANT CENTROX	: SIGNED:= TO_SIGNED(320,BITS);
CONSTANT CENTROY	: SIGNED:= TO_SIGNED(240,BITS);


function bit2bool(b: std_logic) return boolean;

--------------------------------------------------------------------------------------------------------------------
----------------------------------------------COMPONENTES-----------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
COMPONENT CONTROLADOR_VGA IS
	GENERIC( BITS:	INTEGER:=10);
	PORT(
		CLK			:	IN	STD_LOGIC;
		CLR			:	IN	STD_LOGIC;
		RED_IN		:	IN	STD_LOGIC_VECTOR(3 DOWNTO 0);
		GREEN_IN		:	IN	STD_LOGIC_VECTOR(3 DOWNTO 0);
		BLUE_IN		:	IN	STD_LOGIC_VECTOR(3 DOWNTO 0);
		
		HSYNC			:	OUT	STD_LOGIC;
		VSYNC			:	OUT	STD_LOGIC;
		VGA_SYNC_N	:	OUT	STD_LOGIC;
		VGA_BLANK_N	:	OUT	STD_LOGIC;
		X				:	OUT	UNSIGNED(BITS-1 DOWNTO 0);
		Y				:	OUT	UNSIGNED(BITS-1 DOWNTO 0);
		RED			:	OUT	STD_LOGIC_VECTOR(3 DOWNTO 0);
		GREEN			:	OUT	STD_LOGIC_VECTOR(3 DOWNTO 0);
		BLUE			:	OUT	STD_LOGIC_VECTOR(3 DOWNTO 0);
		END_FRAME	:	OUT	STD_LOGIC;
		PRE_FRAME	:	OUT	STD_LOGIC
		);
END COMPONENT;

component DesplazaXYalCentro is

	port(
		Clk		:	in	std_logic;
		Xin		:	in unsigned(9 downto 0);
		Yin		:	in unsigned(9 downto 0);
		Xout		:	out signed(9 downto 0);
		Yout		:	out signed(9 downto 0)
	);
end component;

component rotar is
	port(
		clk			:	in std_logic;
		Actualizar	:	in std_logic;
		X_in			:	in signed(9 downto 0);
		Y_in			:	in signed(9 downto 0);
		angulo		:	in	unsigned(9 downto 0);
		
		X_out			:	out	signed(9 downto 0);
		Y_out			:	out	signed(9 downto 0)
	);
end component;

component conv_hexagonal is
	port(
		clk			: in std_logic;
		x				: in signed (9 downto 0);
		y				: in signed (9 downto 0);
		
		cuadrante	: out unsigned (2 downto 0);
		radio			: out unsigned (9 downto 0)
		);
end component;


COMPONENT PAREDES IS
	PORT(
		CLK				:		IN	STD_LOGIC;
		RESET				:		IN	STD_LOGIC;
		ACTUALIZAR		:		IN	STD_LOGIC;
		DIFICULTAD		:		IN	STD_LOGIC_VECTOR(1 DOWNTO 0);
		DATA				:		IN	STD_LOGIC_VECTOR(6 DOWNTO 0);
		CCUADRANTE		:		IN	UNSIGNED(2 DOWNTO 0);
		CRADIO			:		IN	UNSIGNED(9 DOWNTO 0);
		CUADRANTE		:		IN	UNSIGNED(2 DOWNTO 0);
		RADIO				:		IN	UNSIGNED(9 DOWNTO 0);
		
		MANTIENE			:		OUT	STD_LOGIC;
		DATA_ADDR		:		OUT	STD_LOGIC_VECTOR(5 DOWNTO 0);
		CUADRANTE_OUT	:		OUT	STD_LOGIC_VECTOR(2 DOWNTO 0);
		VISIBLE			:		OUT	STD_LOGIC;
		ISLA				:		OUT	STD_LOGIC;
		CVISIBLE			:		OUT	STD_LOGIC
	);
END COMPONENT;

component control_giro is 
port(
	clk					:	in	std_logic;
	reset					:	in	std_logic;
	Actualizar			:	in	std_logic;
	Random				:	in	std_logic_vector(63 downto 0);
	Subir_velocidad	:	in	std_logic;
	
	angulo				:	out	unsigned(9 downto 0)
);
end component;

component Juego_Fsm is
	port(
		Clk				:	in	std_logic;
		Frame_inicio	:	in	std_logic;
		Frame_fin		:	in	std_logic;
		Nuevo_juego		:	in	std_logic;
		Colision_nuevo	:	in	std_logic;
		Colision_viejo	:	in	std_logic;
		Reset				:	in std_logic;
		
		Actualizar		:	out std_logic;
		Rst				:	out std_logic;
		Vuelve_jugador	:	out std_logic;
		Game_over		:	out std_logic	
	);
end component;

component senocoseno is
	port(
	clk		:	in	std_logic;
	angulo	:	in	unsigned(9 downto 0);
	seno		:	out	signed(11 downto 0);
	coseno	:	out	signed(11 downto 0)
	);
end component;



--------------------------------------------------------------------------------------------------------------------
END PACKAGE;
--------------------------------------------------------------------------------------------------------------------

PACKAGE BODY HexaPackage IS

function bit2bool(b: std_logic) return boolean is
begin
	if (b='1') then
		return true;
	else
		return false;
	end if;
end function bit2bool;

END PACKAGE BODY;