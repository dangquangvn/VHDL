LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY DEM_8BIT IS
	PORT(CKHT,RST, ENA_DB,CK1HZ,CK5HZ:IN STD_LOGIC;
			UP_DOWN,SS,ENA_KQ:OUT STD_LOGIC
			);
END DEM_8BIT;

ARCHITECTURE BEHAVIORAL OF DEM_8BIT IS
SIGNAL Q_REG,Q_NEXT : STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN
	PROCESS(CKHT,RST)
	BEGIN
		IF(RST='1') THEN Q_REG <= (OTHERS=>'0');
		ELSIF FALLING_EDGE(CKHT) THEN Q_REG <= Q_NEXT;
		END IF;
	END PROCESS;
	Q_NEXT <= X"01" WHEN ENA_DB ='1' AND Q_REG = X"04"  ELSE
				Q_REG +1 WHEN ENA_DB ='1'   ELSE
				Q_REG;
	UP_DOWN <= '1' WHEN Q_REG= X"03" ELSE
				  '0';
	SS<= '1' WHEN Q_REG= X"01" OR Q_REG= X"03" ELSE	
			'0';	
	ENA_KQ<=	CK1HZ WHEN 		Q_REG= X"01" ELSE
				CK5HZ;
END BEHAVIORAL;