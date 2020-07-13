---------------------------------------------------------------------------------
-- Company: University of Aveiro
-- Engineer: Paulo Vasconcelos, Pedro Teixeira
-- 
-- Create Date: 07/03/2020 07:30:20 PM
-- Design Name: 
-- Module Name: SquareRootTb - Behavioral
-- Project Name: SquareRootBasicBlockTb
-- Target Devices: Nexsys 4
-- Tool Versions: Vivado 2019.2
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision: 1
-- Revision 1 - Final Version
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

use IEEE.std_logic_textio.all;
use STD.textio.all;

library UNISIM;
use UNISIM.VComponents.all;

entity SquareRootTb is
    generic (
        WORD_SIZE   : integer   := 32
    );
end SquareRootTb;

architecture Stimulus of SquareRootTb is
    signal s_data_in, s_sqrt, s_remainer : std_logic_vector(WORD_SIZE - 1 downto 0);
    signal s_clk, s_new_value, s_is_square_num, s_done: std_logic;

    component SquareRoot is
        generic (
            DATA_WIDTH      : integer  
        );
        port (
            CLK             : in  std_logic;
            NEW_VALUE       : in  std_logic;
            DATA_IN         : in  std_logic_vector(DATA_WIDTH-1 downto 0);
            IS_SQUARE_NUM   : out std_logic;
            DONE            : out std_logic;
            SQRT            : out std_logic_vector(DATA_WIDTH-1 downto 0);
            REMAINER        : out std_logic_vector(DATA_WIDTH-1 downto 0)
         );
    end component;

begin

SquareRootBlock : SquareRoot    
    generic map (
        DATA_WIDTH   => WORD_SIZE
    )
    port map (
        CLK             => s_clk,
        NEW_VALUE       => s_new_value,
        DATA_IN         => s_data_in,
        IS_SQUARE_NUM   => s_is_square_num,
        DONE            => s_done,
        SQRT            => s_sqrt,
        REMAINER        => s_remainer
    );

    clock_proc : process
    begin
        s_clk <= '0'; wait for 10 ns;
        s_clk <= '1'; wait for 10 ns;
    end process;
    
    assert_proc: process
    begin
        wait for 350 ns;
        assert (s_sqrt          = x"00000002") report "Error on SQRT Value for word 0004"       severity error;
        assert (s_is_square_num = '1')     report "Error on IS_SQUARE_NUM Value for word 0004"  severity error;
        assert (s_remainer      = x"00000000") report "Error on REMAINER Value for word 0004"   severity error;
        
        wait for 100 ns;
        assert (s_sqrt          = x"00000003") report "Error on SQRT Value for word 000A"       severity error;
        assert (s_is_square_num = '0') report "Error on IS_SQUARE_NUM Value for word 000A"      severity error;
        assert (s_remainer      = x"00000001") report "Error on REMAINER Value for word 000A"   severity error;
        
        wait for 100 ns;
        assert (s_sqrt          = x"00000008") report "Error on SQRT Value for word 0049"       severity error;
        assert (s_is_square_num = '0') report "Error on IS_SQUARE_NUM Value for word 0049"      severity error;
        assert (s_remainer      = x"00000009") report "Error on REMAINER Value for word 0049"   severity error;
        
        wait for 100 ns;
        assert (s_sqrt          = x"0000000B") report "Error on SQRT Value for word 007F"       severity error;
        assert (s_is_square_num = '0') report "Error on IS_SQUARE_NUM Value for word 007F"      severity error;
        assert (s_remainer      = x"0006") report "Error on REMAINER Value for word 007F"       severity error;
        
        wait for 100 ns;
        assert (s_sqrt          = x"0000000B") report "Error on SQRT Value for word 0080"       severity error;
        assert (s_is_square_num = '0') report "Error on IS_SQUARE_NUM Value for word 0080"      severity error;
        assert (s_remainer      = x"00000007") report "Error on REMAINER Value for word 0080"   severity error;
        
        wait for 100 ns;
        assert (s_sqrt          = x"000000F0") report "Error on SQRT Value for word E11C"       severity error;
        assert (s_is_square_num = '0') report "Error on IS_SQUARE_NUM Value for word E11C"      severity error;
        assert (s_remainer      = x"0000001C") report "Error on REMAINER Value for word E11C"   severity error;
        
        wait for 100 ns;
        assert (s_sqrt          = x"000000D1") report "Error on SQRT Value for word AB83"       severity error;
        assert (s_is_square_num = '0') report "Error on IS_SQUARE_NUM Value for word AB83"      severity error;
        assert (s_remainer      = x"000000E2") report "Error on REMAINER Value for word AB83"   severity error;
        
        wait for 100 ns;
        assert (s_sqrt          = x"0000F926") report "Error on SQRT Value for word F27CAB83"       severity error;
        assert (s_is_square_num = '0') report "Error on IS_SQUARE_NUM Value for word F27CAB83"      severity error;
        assert (s_remainer      = x"0001B9Df") report "Error on REMAINER Value for word F27CAB83"   severity error;
        
        wait for 100 ns;
        assert (s_sqrt          = x"0000FFFF") report "Error on SQRT Value for word FFFFFFFF"       severity error;
        assert (s_is_square_num = '0') report "Error on IS_SQUARE_NUM Value for word FFFFFFFF"      severity error;
        assert (s_remainer      = x"0001FFFE") report "Error on REMAINER Value for word FFFFFFFF"   severity error;
        
    end process;
    
    stimul_proc: process
    begin
        s_data_in <= x"00000004";
        s_new_value <= '1';
        wait for 100 ns;
        
        s_data_in <= x"0000000A";
        s_new_value <= '1';
        wait for 100 ns;
      
        s_data_in <= x"00000049";
        s_new_value <= '1';
        wait for 100 ns;
        
        s_data_in <= x"0000007F";
        s_new_value <= '1';
        wait for 100 ns;
        
        s_data_in <= x"00000080";
        s_new_value <= '1';
        wait for 100 ns;
        
        s_data_in <= x"0000E11C";
        s_new_value <= '1';
        wait for 100 ns;
        
        s_data_in <= x"0000AB83";
        s_new_value <= '1';
        wait for 100 ns;
        
        s_data_in <= x"F27CAB83";
        s_new_value <= '1';
        wait for 100 ns;
        
        s_data_in <= x"FFFFFFFF";
        s_new_value <= '1';
        wait for 100 ns;
        
        wait;
    end process;

end Stimulus;
