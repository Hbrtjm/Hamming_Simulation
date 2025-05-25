----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.05.2025 00:27:09
-- Design Name: 
-- Module Name: Main_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Main_tb is
end Main_tb;

architecture Behavioral of Main_tb is

    component Main is
        Port ( 
            TX7SEG : out STD_LOGIC_VECTOR (3 downto 0);
            RX7SEG : out STD_LOGIC_VECTOR (3 downto 0);
            CLOCK100MHZ : in STD_LOGIC
        );
    end component;

    signal tx7seg      : STD_LOGIC_VECTOR(3 downto 0);
    signal rx7seg      : STD_LOGIC_VECTOR(3 downto 0);
    signal clk         : STD_LOGIC := '0';

    constant CLK_PERIOD : time := 100 ns; -- 10 MHz

begin

    -- Instantiate the Main unit
    UUT: Main 
        port map (
            TX7SEG => tx7seg,
            RX7SEG => rx7seg,
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

