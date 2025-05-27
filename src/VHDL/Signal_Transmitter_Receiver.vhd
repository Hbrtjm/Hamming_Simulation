library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Signal_Transmitter_Receiver is
    Port ( 
        TX        : in  STD_LOGIC_VECTOR (6 downto 0);
        RX        : out STD_LOGIC_VECTOR (6 downto 0);
        SEND_CLK  : in  STD_LOGIC
    );
end Signal_Transmitter_Receiver;

architecture Behavioral of Signal_Transmitter_Receiver is
    signal MODIFIED : STD_LOGIC_VECTOR(6 downto 0);
begin

    process(SEND_CLK)
        variable counter : integer := 0;
        variable temp    : STD_LOGIC_VECTOR(6 downto 0);
    begin
        if rising_edge(SEND_CLK) then
            temp := TX;
            temp(counter) := not TX(counter);
            MODIFIED <= temp;
            
            counter := counter + 1;
            if counter = 7 then
                counter := 0;
            end if;
        end if;
    end process;

    RX <= MODIFIED;

end Behavioral;
