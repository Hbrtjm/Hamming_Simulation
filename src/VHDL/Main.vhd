----------------------------------------------------------------------------------
-- Company: AGH UST
-- Student: Hubert Miklas
-- 
-- Create Date: 21.05.2025 22:55:37
-- Design Name: Hamming Visualization
-- Module Name: Main - Behavioral
-- Project Name: Hamming
-- Target Devices: DE2-70
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

entity Main is
    Port ( 
        -- Data + Enable
        SW          : in    STD_LOGIC_VECTOR(4 downto 0);
        -- Data encoded with Hamming code display
        LED         : out   STD_LOGIC_VECTOR(6 downto 0);
        LED_OUT     : out   STD_LOGIC_VECTOR(2 downto 0);
        -- Initial data display
        HEX0_D      : out   STD_LOGIC_VECTOR(6 downto 0);
        -- Corrupted data display
        HEX1_D      : out   STD_LOGIC_VECTOR(6 downto 0);
        -- Fixed data display
        HEX2_D      : out   STD_LOGIC_VECTOR(6 downto 0);
        CLOCK100MHZ : in    STD_LOGIC;
        CLDL        : out   STD_LOGIC
    );
end Main;

architecture Behavioral of Main is

    component clock_divider is
    port (
        clk     : in  std_logic;
        reset   : in  std_logic;
        clk_out : out std_logic
    );
    end component;

    component Multiplexer is
        Port (
            FIRST   : in  STD_LOGIC_VECTOR(3 downto 0);
            SECOND  : in  STD_LOGIC_VECTOR(3 downto 0);
            CONTROL : in  STD_LOGIC; 
            OUTPUT  : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    component Signal_Emitter is 
        Port( 
            OUTPUT : out STD_LOGIC_VECTOR(3 downto 0);
            RESET  : in  STD_LOGIC;
            CLK    : in  STD_LOGIC
        );
    end component;

    component Hamming_Generator is 
        Port( 
            INPUT : in  STD_LOGIC_VECTOR(3 downto 0);
            HCODE : out STD_LOGIC_VECTOR(6 downto 0);
            CLK   : in STD_LOGIC
        );
    end component;

    component Signal_Transmitter_Receiver is
        Port (
            TX          : in  STD_LOGIC_VECTOR(6 downto 0);
            RX          : out STD_LOGIC_VECTOR(6 downto 0);
            SEND_CLK    : in STD_LOGIC
--            CLK         : in STD_LOGIC
        );
    end component;

    component Hamming_Corrector is 
        Port( 
            HCODEIN : in  STD_LOGIC_VECTOR (6 downto 0);
            CORRECTION : out STD_LOGIC_VECTOR(2 downto 0);
            DECODED : out STD_LOGIC_VECTOR (3 downto 0);
            CLK : in STD_LOGIC
        );
    end component;

    component SEG7 is 
        Port (
            BINARY  : in  STD_LOGIC_VECTOR(3 downto 0);
            SEG     : out STD_LOGIC_VECTOR(6 downto 0)
        );
    end component;
    
    signal SIGNAL_TO_GENERATOR  : STD_LOGIC_VECTOR(3 downto 0);
    signal DATA                 : STD_LOGIC_VECTOR(3 downto 0);
    signal ENCODED_HAMMING      : STD_LOGIC_VECTOR(6 downto 0);
    signal MODIFIED_HAMMING     : STD_LOGIC_VECTOR(6 downto 0);
    signal FINAL_DATA           : STD_LOGIC_VECTOR(3 downto 0);
    signal TX7SEG               : STD_LOGIC_VECTOR(3 downto 0);
    signal RX7SEG               : STD_LOGIC_VECTOR(3 downto 0);
    signal CLOCK_LOCAL          : STD_LOGIC;
begin

    Clock: clock_divider 
            port map (
                clk     => CLOCK100MHZ,
                reset   => '0',
                clk_out => CLOCK_LOCAL 
            );

    SignalGenerator: Signal_Emitter 
        port map ( 
            OUTPUT => SIGNAL_TO_GENERATOR,
            RESET  => '0',
            CLK    => CLOCK_LOCAL
        );

    SignalSelector: Multiplexer
        port map (
            FIRST(0) => SW(0),
            FIRST(1) => SW(1),
            FIRST(2) => SW(2),
            FIRST(3) => SW(3),
            CONTROL  => SW(4),
            SECOND   => SIGNAL_TO_GENERATOR,
            OUTPUT   => DATA            
        );
    
    OriginalDisplay: SEG7 
        port map (
                BINARY => DATA,
                SEG    => HEX0_D
            );

    HammingGenerator: Hamming_Generator 
        port map ( 
            INPUT => DATA,
            HCODE => ENCODED_HAMMING,
            CLK   => CLOCK_LOCAL
        );    
    
    LED <= ENCODED_HAMMING;
    
    RXTX: Signal_Transmitter_Receiver 
        port map (
            TX => ENCODED_HAMMING,
            RX => MODIFIED_HAMMING,
            SEND_CLK => CLOCK_LOCAL
--            CLK => CLOCK100MHZ
        );

    CorruptedDisplay: SEG7 
        port map (
                BINARY(0) => MODIFIED_HAMMING(6),
                BINARY(1) => MODIFIED_HAMMING(5),
                BINARY(2) => MODIFIED_HAMMING(4),
                BINARY(3) => MODIFIED_HAMMING(2),
                SEG    => HEX1_D
            );

    HammingCorrector: Hamming_Corrector 
        port map (
            HCODEIN => MODIFIED_HAMMING,
            CORRECTION => LED_OUT,
            DECODED => FINAL_DATA,
            CLK     => CLOCK_LOCAL
        );
    
    CorrectedDisplay: SEG7 
        port map (
                BINARY => FINAL_DATA,
                SEG    => HEX2_D
            );
    
    TX7SEG <= SIGNAL_TO_GENERATOR;
    RX7SEG <= FINAL_DATA;
    CLDL <= CLOCK_LOCAL;

end Behavioral;
