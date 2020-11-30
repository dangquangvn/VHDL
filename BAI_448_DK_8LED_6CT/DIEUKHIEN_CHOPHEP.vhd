library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DIEUKHIEN_CHOPHEP is
	Port ( CKHT, RST, ENA_DB: in STD_LOGIC;
			OE: out STD_LOGIC_VECTOR (5 downto 0));
end DIEUKHIEN_CHOPHEP;

architecture Behavioral of DIEUKHIEN_CHOPHEP is
SIGNAL DEM_REG, DEM_NEXT: INTEGER RANGE 0 TO 63:=0;
begin
	PROCESS(CKHT, RST)
	BEGIN
		IF (RST ='1') THEN DEM_REG <= 0;
		ELSIF FALLING_EDGE(CKHT) THEN DEM_REG <= DEM_NEXT;
		END IF;
	END PROCESS;
	DEM_NEXT <= 0 WHEN DEM_REG = 63 AND ENA_DB = '1' ELSE
	DEM_REG + 1 WHEN ENA_DB = '1' ELSE
	DEM_REG;
	PROCESS(DEM_REG)
	BEGIN
		OE <= "000000";
		IF DEM_REG < 16 THEN OE <= "000001";
		ELSIF DEM_REG < 32 THEN OE <= "000010";
		ELSIF DEM_REG < 40 THEN OE <= "000100";
		ELSIF DEM_REG < 48 THEN OE <= "001000";
		ELSIF DEM_REG < 56 THEN OE <= "010000";
		ELSIF DEM_REG < 64 THEN OE <= "100000";
		END IF;
	END PROCESS;
end Behavioral;