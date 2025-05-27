library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Hamming_Generator is
    Port (
            INPUT : in STD_LOGIC_VECTOR (3 downto 0);
            HCODE : out STD_LOGIC_VECTOR (6 downto 0);
            CLK   : in STD_LOGIC
           );
end Hamming_Generator;

architecture Behavioral of Hamming_Generator is
signal HCODE_LOCAL : STD_LOGIC_VECTOR(6 downto 0);
begin

    process(CLK)
    begin
        if rising_edge(CLK) then
            HCODE_LOCAL(6) <= INPUT(0); 
            HCODE_LOCAL(5) <= INPUT(1); 
            HCODE_LOCAL(4) <= INPUT(2); 
            HCODE_LOCAL(2) <= INPUT(3); 
    
--            HCODE_LOCAL(0) <= HCODE_LOCAL(2) xor HCODE_LOCAL(4) xor HCODE_LOCAL(6); 
--            HCODE_LOCAL(1) <= HCODE_LOCAL(2) xor HCODE_LOCAL(5) xor HCODE_LOCAL(6);
--            HCODE_LOCAL(3) <= HCODE_LOCAL(4) xor HCODE_LOCAL(5) xor HCODE_LOCAL(6);
    
            HCODE_LOCAL(0) <= INPUT(3) xor INPUT(2) xor INPUT(0); -- P1
            HCODE_LOCAL(1) <= INPUT(3) xor INPUT(1) xor INPUT(0); -- P2
            HCODE_LOCAL(3) <= INPUT(2) xor INPUT(1) xor INPUT(0); -- P4
        end if;
    end process;
    HCODE <= HCODE_LOCAL;
end Behavioral;
