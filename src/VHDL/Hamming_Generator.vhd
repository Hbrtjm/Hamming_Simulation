library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Hamming_Generator is
    Port (
            INPUT : in STD_LOGIC_VECTOR (3 downto 0);
            HCODE : out STD_LOGIC_VECTOR (6 downto 0)
           );
end Hamming_Generator;

architecture Behavioral of Hamming_Generator is
begin

    process(INPUT)
        variable temp : STD_LOGIC_VECTOR (6 downto 0);
    begin
        -- Place data bits
        temp(6) := INPUT(0); 
        temp(5) := INPUT(1); 
        temp(4) := INPUT(2); 
        temp(2) := INPUT(3); 

        -- Calculate parity bits
        temp(0) := temp(2) xor temp(4) xor temp(6); 
        temp(1) := temp(2) xor temp(5) xor temp(6);
        temp(3) := temp(4) xor temp(5) xor temp(6);

        -- Assign final result
        HCODE <= temp;
    end process;

end Behavioral;
