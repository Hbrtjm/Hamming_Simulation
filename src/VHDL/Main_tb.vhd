library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Main_tb is
end Main_tb;

architecture Behavioral of Main_tb is

    component Main is
        Port ( 
        -- Data + Enable
        SW          : in    STD_LOGIC_VECTOR(4 downto 0);
        -- Data encoded with Hamming code display
        LED         : out   STD_LOGIC_VECTOR(6 downto 0);
        -- Initial data display
        HEX0_D      : out   STD_LOGIC_VECTOR(6 downto 0);
        -- Corrupted data display
        HEX1_D      : out   STD_LOGIC_VECTOR(6 downto 0);
        -- Fixed data display
        HEX2_D      : out   STD_LOGIC_VECTOR(6 downto 0);
        CLOCK100MHZ : in    STD_LOGIC
        );
    end component;

    signal rx7seg       : STD_LOGIC_VECTOR(6 downto 0);
    signal tx7seg       : STD_LOGIC_VECTOR(6 downto 0);
    signal corr7seg     : STD_LOGIC_VECTOR(6 downto 0);  
    signal clk          : STD_LOGIC := '0';
    signal ledDisplay   : STD_LOGIC_VECTOR(6 downto 0);
    constant CLK_PERIOD : time := 10 ns; -- 10 MHz

begin

    -- Instantiate the Main unit
    UUT: Main 
        port map (
        SW          => "01101", -- Signal generator enabled
        LED         => ledDisplay,
        HEX0_D      => rx7seg,
        HEX1_D      => tx7seg,
        HEX2_D      => corr7seg, 
        CLOCK100MHZ => clk
        );

    -- Clock generation
    clk_process: process
    begin
        while now < 1 ms loop
            clk <= '0';
            wait for CLK_PERIOD / 2;
            clk <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
        wait;
    end process;

end Behavioral;

