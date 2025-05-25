----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.05.2025 22:55:37
-- Design Name: 
-- Module Name: Signal_Transmitter_Receiver - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
use STD.TEXTIO.ALL;
use IEEE.MATH_REAL.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Signal_Transmitter_Receiver is
    Port ( TX : in STD_LOGIC_VECTOR (5 downto 0);
           RX : out STD_LOGIC_VECTOR (5 downto 0));
end Signal_Transmitter_Receiver;

architecture Behavioral of Signal_Transmitter_Receiver is

    signal MODIFIED : STD_LOGIC_VECTOR(5 downto 0);
    shared variable seed1, seed2 : positive := 1;
    shared variable rand : real;

begin

    process(TX)
        variable bit_index : integer;
    begin
        -- Copy input
        MODIFIED <= TX;

        -- Generate a fake random index between 0 and 5
        UNIFORM(seed1, seed2, rand);
        bit_index := integer(rand * 5.0);

        -- Flip the selected bit
        MODIFIED(bit_index) <= NOT TX(bit_index);

        -- Output result
        RX <= MODIFIED;
    end process;
    end Behavioral;