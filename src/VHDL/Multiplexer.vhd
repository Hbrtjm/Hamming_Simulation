library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Multiplexer is
    Port    ( 
            FIRST : in STD_LOGIC_VECTOR (3 downto 0);
            SECOND : in STD_LOGIC_VECTOR (3 downto 0);
            CONTROL : in STD_LOGIC;
            OUTPUT : out STD_LOGIC_VECTOR (3 downto 0)
           );
end Multiplexer;

architecture Behavioral of Multiplexer is
    
begin

    OUTPUT <= FIRST when CONTROL = '1' else SECOND;
    
end Behavioral;
