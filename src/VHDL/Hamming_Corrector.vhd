library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Hamming_Corrector is
    Port (
        HCODEIN : in  STD_LOGIC_VECTOR (6 downto 0);
        DECODED : out STD_LOGIC_VECTOR (3 downto 0)
    );
end Hamming_Corrector;

architecture Behavioral of Hamming_Corrector is
    signal PLACE_TO_CORRECT : STD_LOGIC_VECTOR(2 downto 0);
    signal TEMP             : STD_LOGIC_VECTOR(6 downto 0);
    signal FIXED            : STD_LOGIC_VECTOR(3 downto 0);
begin

    process(HCODEIN)
        variable syndrome : integer;
        variable corrected : STD_LOGIC_VECTOR(6 downto 0);
    begin
        -- Syndrome bits (and error location indicator)
        PLACE_TO_CORRECT(0) <= HCODEIN(0) XOR HCODEIN(2) XOR HCODEIN(4) XOR HCODEIN(6); 
        PLACE_TO_CORRECT(1) <= HCODEIN(1) XOR HCODEIN(2) XOR HCODEIN(5) XOR HCODEIN(6);
        PLACE_TO_CORRECT(2) <= HCODEIN(3) XOR HCODEIN(4) XOR HCODEIN(5) XOR HCODEIN(6);
        
        -- Calculate integer syndrome
        syndrome := to_integer(unsigned(PLACE_TO_CORRECT));
        
        corrected := HCODEIN;

        -- Correct the bit if syndrome != 0
        if syndrome /= 0 then
            corrected(syndrome) := not corrected(syndrome - 1);
        end if;

        FIXED(3) <= corrected(2);
        FIXED(2) <= corrected(4);
        FIXED(1) <= corrected(5);
        FIXED(0) <= corrected(6);

        DECODED <= FIXED;
    end process;
end Behavioral;
