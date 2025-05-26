library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SEG7 is
    Port (
            BINARY  : in  STD_LOGIC_VECTOR(3 downto 0);
            SEG     : out STD_LOGIC_VECTOR(6 downto 0)
          );
end SEG7;

architecture Behavioral of SEG7 is
begin
    process(binary)
    begin
        case BINARY is
            when "0000" => SEG <= "1000000";
            when "0001" => SEG <= "1111001";
            when "0010" => SEG <= "0100100";
            when "0011" => SEG <= "0110000";
            when "0100" => SEG <= "0011001";
            when "0101" => SEG <= "0010010";
            when "0110" => SEG <= "0000010";
            when "0111" => SEG <= "1111000";
            when "1000" => SEG <= "0000000";
            when "1001" => SEG <= "0010000";
            when "1010" => SEG <= "0001000";
            when "1011" => SEG <= "0000011";
            when "1100" => SEG <= "1000110";
            when "1101" => SEG <= "0100001";
            when "1110" => SEG <= "0000110";
            when others => SEG <= "0001110";
        end case;
    end process;
end Behavioral;
