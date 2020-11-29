library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DEM_MOD50 is
	Port (CKHT, RST, ENA_DB, SW, TOGGLE: in STD_LOGIC;
			Q: out STD_LOGIC_VECTOR (5 downto 0);
			LEDG: out STD_LOGIC_VECTOR(1 downto 0));
end DEM_MOD50;

architecture Behavioral of DEM_MOD50 is
SIGNAL UD, UD_STT: STD_LOGIC; --0 UP, 1 DOWN
SIGNAL Q_REG, Q_NEXT: STD_LOGIC_VECTOR(5 DOWNTO 0);
BEGIN
	PROCESS (CKHT, RST)
	BEGIN
		IF RST = '1' THEN 
			IF SW = '0' THEN Q_REG <= (OTHERS => '0');
								  UD <= '0';
			ELSE Q_REG <= "110001";
				  UD <= '1';
			END IF;
		ELSIF FALLING_EDGE (CKHT) THEN Q_REG <= Q_NEXT;
		END IF;
	END PROCESS;

	UD_STT <= 	TOGGLE XOR UD;
				
	Q_NEXT <= 	"000000"  WHEN (ENA_DB AND NOT(UD_STT)) = '1' AND Q_REG = "110001" ELSE
					"110001"  WHEN (ENA_DB AND UD_STT) 		 = '1' AND Q_REG = "000000" ELSE
					Q_REG + 1 WHEN (ENA_DB AND NOT(UD_STT)) = '1' ELSE
					Q_REG - 1 WHEN (ENA_DB AND UD_STT) 		 = '1' ELSE
					Q_REG;
	
	Q <= Q_REG;
	
	LEDG(0) <= TOGGLE;
	LEDG(1) <= UD;
end Behavioral;