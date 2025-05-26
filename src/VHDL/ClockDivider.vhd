library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity clock_divider is
    generic (
        DIVIDE_BY : integer := 10
    );
    port (
        clk     : in  std_logic;
        reset   : in  std_logic;
        clk_out : out std_logic
    );
end clock_divider;

architecture Behavioral of clock_divider is
    signal counter : integer := 0;
    signal clk_div : std_logic := '0';
begin
    process(clk, reset)
    begin
        if reset = '1' then
            counter <= 0;
            clk_div <= '0';
        elsif rising_edge(clk) then
            if DIVIDE_BY <= 0 then
                clk_div <= '0';
            else
                if counter >= (DIVIDE_BY / 2 - 1) then
                    counter <= 0;
                    clk_div <= not clk_div;
                else
                    counter <= counter + 1;
                end if;
            end if;
        end if;
    end process;

    clk_out <= clk_div;
end Behavioral;
