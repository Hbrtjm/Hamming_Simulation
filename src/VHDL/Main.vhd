----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.05.2025 22:55:37
-- Design Name: 
-- Module Name: Main - Behavioral
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

entity Main is
    Port ( 
        TX7SEG : out STD_LOGIC_VECTOR (3 downto 0);
        RX7SEG : out STD_LOGIC_VECTOR (3 downto 0);
        CLOCK100MHZ : in STD_LOGIC
    );
end Main;

architecture Behavioral of Main is

    component Hamming_Generator is 
        Port( 
            INPUT : in  STD_LOGIC_VECTOR(3 downto 0);
            HCODE : out STD_LOGIC_VECTOR(5 downto 0)
        );
    end component;

    component Hamming_Corrector is 
        Port( 
            HCODEIN : in  STD_LOGIC_VECTOR (5 downto 0);
            DECODED : out STD_LOGIC_VECTOR (3 downto 0)
        );
    end component;

    component Signal_Emitter is 
        Port( 
            OUTPUT : out STD_LOGIC_VECTOR(3 downto 0);
            RESET  : in  STD_LOGIC;
            CLK    : in  STD_LOGIC
        );
    end component;

    component Signal_Transmitter_Receiver is
        Port (
            TX : in  STD_LOGIC_VECTOR(5 downto 0);
            RX : out STD_LOGIC_VECTOR(5 downto 0)
        );
    end component;

    signal SIGNAL_TO_GENERATOR  : STD_LOGIC_VECTOR(3 downto 0);
    signal ENCODED_HAMMING      : STD_LOGIC_VECTOR(5 downto 0);
    signal MODIFIED_HAMMING     : STD_LOGIC_VECTOR(5 downto 0);
    signal FINAL_DATA           : STD_LOGIC_VECTOR(3 downto 0);

begin

    SignalGenerator: Signal_Emitter 
        port map ( 
            OUTPUT => SIGNAL_TO_GENERATOR,
            RESET  => '0',
            CLK    => CLOCK100MHZ
        );

    HammingGenerator: Hamming_Generator 
        port map ( 
            INPUT => SIGNAL_TO_GENERATOR,
            HCODE => ENCODED_HAMMING
        );    

    RXTX: Signal_Transmitter_Receiver 
        port map (
            TX => ENCODED_HAMMING,
            RX => MODIFIED_HAMMING
        );

    HammingCorrector: Hamming_Corrector 
        port map (
            HCODEIN => MODIFIED_HAMMING,
            DECODED => FINAL_DATA
        );

    TX7SEG <= SIGNAL_TO_GENERATOR;
    RX7SEG <= FINAL_DATA;

end Behavioral;
