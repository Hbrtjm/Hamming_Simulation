----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.05.2025 22:55:37
-- Design Name: 
-- Module Name: Hamming_Corrector - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Hamming_Corrector is
    Port (
        HCODEIN : in  STD_LOGIC_VECTOR (5 downto 0);
        DECODED : out STD_LOGIC_VECTOR (3 downto 0)
    );
end Hamming_Corrector;

architecture Behavioral of Hamming_Corrector is
    signal PLACE_TO_CORRECT : STD_LOGIC_VECTOR(1 downto 0);
    signal TEMP             : STD_LOGIC_VECTOR(6 downto 0);
    signal FIXED            : STD_LOGIC_VECTOR(3 downto 0);
begin

    process(HCODEIN)
        variable syndrome : integer;
        variable corrected : STD_LOGIC_VECTOR(5 downto 0);
    begin
        PLACE_TO_CORRECT(0) <= HCODEIN(1) XOR HCODEIN(3) XOR HCODEIN(4); -- parity bit 1
        PLACE_TO_CORRECT(1) <= HCODEIN(2) XOR HCODEIN(3) XOR HCODEIN(5); -- parity bit 2
	PLACE_TO_CORRECT(2) <= HCODEIN(3) XOR HCODEIN(6);
        
	-- Where to place this
	syndrome := to_integer(unsigned(PLACE_TO_CORRECT));

        -- Corrected to temp
        corrected := HCODEIN;

	-- Correct the bit if there was an error
        if syndrome /= 0 then
            corrected(syndrome) := not corrected(syndrome);
        end if;

        -- Assume HCODE format: [5]=P2, [4]=P1, [3]=D3, [2]=D2, [1]=D1, [0]=D0
        FIXED(3) <= corrected(3);
        FIXED(2) <= corrected(2);
        FIXED(1) <= corrected(1);
        FIXED(0) <= corrected(0);

        DECODED <= FIXED;
    end process;
end Behavioral;
