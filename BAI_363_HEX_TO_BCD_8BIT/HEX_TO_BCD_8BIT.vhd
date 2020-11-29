-- HEX 8 BIT -> 3 SO BCD
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity HEX_TO_BCD_8BIT is
Port ( SW: in STD_LOGIC_VECTOR (7 downto 0);
		LEDR: out STD_LOGIC_VECTOR (11 downto 0));
end HEX_TO_BCD_8BIT;

architecture Behavioral of HEX_TO_BCD_8BIT is
begin
	HEXTOBCD: ENTITY WORK.HEXTOBCD_8BIT
	PORT MAP( SOHEX8BIT => SW,
	DONVI => LEDR(3 DOWNTO 0),
	CHUC => LEDR(7 DOWNTO 4),
	TRAM => LEDR(11 DOWNTO 8));
end Behavioral;