library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Hamming_Corrector is
    Port (
        HCODEIN : in  STD_LOGIC_VECTOR (6 downto 0);
        CORRECTION : out STD_LOGIC_VECTOR (2 downto 0);
        DECODED : out STD_LOGIC_VECTOR (3 downto 0);
        CLK : in STD_LOGIC
    );
end Hamming_Corrector;

architecture Behavioral of Hamming_Corrector is
    signal PLACE_TO_CORRECT : STD_LOGIC_VECTOR(2 downto 0);
    signal TEMP             : STD_LOGIC_VECTOR(6 downto 0) := (others => '0');
    signal FIXED            : STD_LOGIC_VECTOR(3 downto 0);
begin

process(CLK)
    variable syndrome : integer;
    variable p : STD_LOGIC_VECTOR(2 downto 0);
    variable temp_v : STD_LOGIC_VECTOR(6 downto 0);
begin
    if rising_edge(CLK) then
        p(0) := HCODEIN(0) XOR HCODEIN(2) XOR HCODEIN(4) XOR HCODEIN(6);
        p(1) := HCODEIN(1) XOR HCODEIN(2) XOR HCODEIN(5) XOR HCODEIN(6);
        p(2) := HCODEIN(3) XOR HCODEIN(4) XOR HCODEIN(5) XOR HCODEIN(6);

        PLACE_TO_CORRECT <= p;

        syndrome := to_integer(unsigned(p));

        temp_v := HCODEIN;
        if syndrome /= 0 then
            temp_v(syndrome - 1) := not HCODEIN(syndrome - 1);
        end if;

        TEMP <= temp_v;
    end if;
end process;

    
    FIXED(3) <= TEMP(2);
    FIXED(2) <= TEMP(4);
    FIXED(1) <= TEMP(5);
    FIXED(0) <= TEMP(6);
    DECODED <= FIXED;
    CORRECTION <= PLACE_TO_CORRECT;
end Behavioral;
