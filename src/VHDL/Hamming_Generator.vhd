----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.05.2025 22:55:37
-- Design Name: 
-- Module Name: Hamming_Generator - Behavioral
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

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Hamming_Generator is
    Port ( INPUT : in STD_LOGIC_VECTOR (3 downto 0);
           HCODE : out STD_LOGIC_VECTOR (6 downto 0));
end Hamming_Generator;

architecture Behavioral of Hamming_Generator is

signal Result : STD_LOGIC_VECTOR (5 downto 0);

begin

    process(INPUT)
        begin
-- TODO - Discuss which is quicker (the latter to implement, but how much of an improvement is the former in the sense of operations)
        Result(0) <= INPUT(0); 
        Result(1) <= INPUT(1); 
        Result(2) <= INPUT(2); 
        Result(3) <= INPUT(3); 

--        for i in 0 to 3 loop
--            Result(i) <= INPUT(i);
--        end loop;
        
        -- Handle the first parity bit
--        for i in 0 to 1 loop
--            Result(4) <= Result(4) XOR INPUT(2 * i + 1);
--        end loop;
        
--        -- Handle the second parity bit
--        for i in 0 to 1 loop
--            Result(5) <= Result(5) XOR INPUT(2 + i); -- Very dumb, just in this case it works
--        end loop;
        -- Calculate parity bits - not a general method and we don't like that here (1)
        Result(4) <= INPUT(0) XOR INPUT(1) XOR INPUT(3);
        Result(5) <= INPUT(0) XOR INPUT(2) XOR INPUT(3);
	Result(6) <= INPUT(3);
        HCODE <= std_logic_vector(resize(Result, 7));
    end process;
end Behavioral;
