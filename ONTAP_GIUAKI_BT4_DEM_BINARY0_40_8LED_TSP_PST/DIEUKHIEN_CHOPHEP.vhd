library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity DIEUKHIEN_CHOPHEP is
	Port ( CKHT, ENA_DB, RST: in STD_LOGIC;
			 OE: out STD_LOGIC_VECTOR (1 downto 0)
			 --OE: IN STD_LOGIC;
			 );
	end DIEUKHIEN_CHOPHEP;
architecture Behavioral of DIEUKHIEN_CHOPHEP is
SIGNAL DEM_REG, DEM_NEXT: INTEGER RANGE 0 TO 57:=0;
begin
	PROCESS(CKHT, RST)
	BEGIN
		IF (RST ='1') THEN DEM_REG <= 0;
		ELSIF FALLING_EDGE(CKHT) THEN DEM_REG <= DEM_NEXT;
		END IF;
		
	END PROCESS;
	DEM_NEXT <= 0 WHEN DEM_REG = 57 AND ENA_DB = '1' ELSE
	DEM_REG + 1 WHEN ENA_DB = '1' ELSE
	DEM_REG;
	PROCESS(DEM_REG)
	BEGIN
		OE <= "00";
		IF DEM_REG < 20 THEN OE <= "01";
		ELSIF DEM_REG < 28 THEN OE <= "10";
		ELSIF DEM_REG < 48 THEN OE <= "01";
		ELSIF DEM_REG < 56 THEN OE <= "10";
		END IF;
	END PROCESS;
end Behavioral;