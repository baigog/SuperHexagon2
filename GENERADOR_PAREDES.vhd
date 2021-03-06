ENTITY GENERADOR_PAREDES IS
	PORT(
		CLK		:	IN	STD_LOGIC;
		RAND		:	IN	STD_LOGIC_VECTOR(63 DOWNTO 0);
		MANTIENE	:	IN	STD_LOGIC;
		ADDR		:	IN	STD_LOGIC_VECTOR(5 DOWNTO 0);
		DATA		:	IN	STD_LOGIC_VECTOR(5 DOWNTO 0);
	);
END ENTITY;
		
ARCHITECTURE BEH OF GENERADOR_PAREDES IS

TYPE RAND_2D	IS ARRAY(0 TO 63) OF STD_LOGIC_VECTOR(5 DOWNTO 0);
TYPE LABE_2D	IS ARRAY(0 TO 127) OF STD_LOGIC_VECTOR(5 DOWNTO 0);

SIGNAL RANDH			:	STD_LOGIC_VECTOR(63 DOWNTO 0);
SIGNAL PAREDES_RAND	:	RAND_2D;
SIGNAL PAREDES_ALT	:	RAND_2D;
SIGNAL PAREDES_LABE	:	LABE_2D;

MANTIENERAND:PROCESS(CLK,MANTIENE)
BEGIN
	IF RISING_EDGE(CLK) THEN
		IF (MANTIENE='0') THEN
			RANDH	<= RAND;
		END IF;
	END IF;
END PROCESS;

PROCESS (ADDR)
BEGIN
	CASE ADDR(5 DOWNTO 4) IS
		WHEN "00" =>
			
		WHEN "01" =>
		WHEN "10" =>
		WHEN "11" =>
END PROCESS

always @* begin
	case(address[5:4])
	2'd0: begin
		data <= walls_rand[{randh[1:0],address[3:0]}];
	end
	2'd1: begin
		data <= walls_alt[{randh[3:2],address[3:0]}];
	end
	2'd2: begin
		data <= walls_rand[{randh[5:4],address[3:0]}];
	end
	2'd3: begin
		data <= walls_maze[{randh[8:6],address[3:0]}];
	end
	endcase
end