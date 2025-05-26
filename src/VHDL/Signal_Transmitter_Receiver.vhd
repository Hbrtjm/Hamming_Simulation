library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Signal_Transmitter_Receiver is
    Port ( 
            TX  : in STD_LOGIC_VECTOR (6 downto 0);
            RX  : out STD_LOGIC_VECTOR (6 downto 0);
            CLK : STD_LOGIC
           );
end Signal_Transmitter_Receiver;

architecture Behavioral of Signal_Transmitter_Receiver is

    signal MODIFIED : STD_LOGIC_VECTOR(6 downto 0);
    shared variable counter : integer := 0;
    
begin

    process(TX)
    begin
        MODIFIED <= TX;
        -- Flip the pseudo-random bit
        MODIFIED(counter) <= NOT TX(counter);

        RX <= MODIFIED;
    end process;

    process(CLK)
    begin
        counter := counter + 1;
        if counter = 7 
        then
            counter := 0;
        end if;
    end process;
    
end Behavioral;