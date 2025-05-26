

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Signal_Emitter is
    Port (
        OUTPUT : OUT STD_LOGIC_VECTOR (3 downto 0);
        RESET  : IN  STD_LOGIC;
        CLK    : IN  STD_LOGIC
    );
end Signal_Emitter;

architecture Behavioral of Signal_Emitter is

    constant clock_duty : integer := 1;

    signal delay_counter : unsigned(26 downto 0) := (others => '0');
    signal counter       : unsigned(3 downto 0) := (others => '0');

begin
    process (CLK)
    begin
        if rising_edge(CLK) then
            if RESET = '1' then
                delay_counter <= (others => '0');
                counter <= (others => '0');
            else
                if delay_counter = clock_duty - 1 then
                    delay_counter <= (others => '0');

                    if counter = 16 then
                        counter <= (others => '0');
                    else
                        counter <= counter + 1;
                    end if;

                else
                    delay_counter <= delay_counter + 1;
                end if;
            end if;
        end if;
    end process;

    OUTPUT <= std_logic_vector(resize(counter, 4));

end Behavioral;

