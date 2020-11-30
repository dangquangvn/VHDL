LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY DEM_NHI_PHAN_8BIT IS
	PORT(CKHT, BTN_N0:IN STD_LOGIC;
				LEDR: OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END DEM_NHI_PHAN_8BIT;

ARCHITECTURE BEHAVIORAL OF DEM_NHI_PHAN_8BIT IS
SIGNAL RST,ENA1HZ,ENA2HZ,ENA4HZ : STD_LOGIC;
SIGNAL ENA_DB: STD_LOGIC;
BEGIN
	RST <= NOT BTN_N0;
CHIA_10ENA: ENTITY WORK.CHIA_10ENA
		PORT MAP ( CKHT => CKHT,
						ENA1HZ=>ENA1HZ,
						ENA2HZ=>ENA2HZ,
						ENA4HZ=>ENA4HZ
						);
DEM_GIAY:		ENTITY WORK.DEM_GIAY
		PORT MAP (CKHT => CKHT,
						RST=> RST,
						ENA_DB=>ENA1HZ,
						ENA1HZ=>ENA1HZ,
						ENA2HZ=>ENA2HZ,
						ENA4HZ=>ENA4HZ,
						ENA_KQ=>ENA_DB);		
DEM_8BIT: 	  ENTITY WORK.DEM_8BIT
		PORT MAP (CKHT => CKHT,
						RST => RST,
						ENA_DB=> ENA_DB,
						Q => LEDR);
END BEHAVIORAL;