----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/03/2020 07:30:20 PM
-- Design Name: 
-- Module Name: SquareRootTb - Behavioral
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

use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

use IEEE.std_logic_textio.all;
use STD.textio.all;

library UNISIM;
use UNISIM.VComponents.all;

entity SquareRootTb is
    generic (
        WORD_SIZE   : integer   := 16
    );
end SquareRootTb;

architecture Stimulus of SquareRootTb is
    signal s_data_in, s_sqrt, s_remainer : std_logic_vector(WORD_SIZE - 1 downto 0);
    signal s_is_square_num : std_logic;

    component SquareRoot is
        generic (
            DATA_WIDTH      : integer  
        );
        port (
            DATA_IN         : in  std_logic_vector(WORD_SIZE-1 downto 0);
            SQRT            : out std_logic_vector(WORD_SIZE-1 downto 0);
            IS_SQUARE_NUM   : out std_logic;
            REMAINER        : out std_logic_vector(WORD_SIZE-1 downto 0)
        );
    end component;

begin

SquareRootBlock : SquareRoot    
    generic map (
        DATA_WIDTH   => WORD_SIZE
    )
    port map (
        DATA_IN         => s_data_in,
        SQRT            => s_sqrt,
        IS_SQUARE_NUM   => s_is_square_num,
        REMAINER        => s_remainer
    );

process
begin
        s_data_in <= x"0004";
        wait for 10 ns;
        assert (s_sqrt          = x"0002") report "Error on SQRT Value for word 0004"       severity error;
        assert (s_is_square_num = '1') report "Error on IS_SQUARE_NUM Value for word 0004"  severity error;
        assert (s_remainer      = x"0000") report "Error on REMAINER Value for word 0004"   severity error;


        s_data_in <= x"000A";
        wait for 10 ns;
        assert (s_sqrt          = x"0003") report "Error on SQRT Value for word 000A"       severity error;
        assert (s_is_square_num = '0') report "Error on IS_SQUARE_NUM Value for word 000A"  severity error;
        assert (s_remainer      = x"0001") report "Error on REMAINER Value for word 000A"   severity error;
        
        s_data_in <= x"0049";
        wait for 10 ns;
        assert (s_sqrt          = x"0008") report "Error on SQRT Value for word 0049"       severity error;
        assert (s_is_square_num = '0') report "Error on IS_SQUARE_NUM Value for word 0049"  severity error;
        assert (s_remainer      = x"0009") report "Error on REMAINER Value for word 0049"   severity error;
        
        s_data_in <= x"007F";
        wait for 10 ns;
        assert (s_sqrt          = x"000B") report "Error on SQRT Value for word 007F"       severity error;
        assert (s_is_square_num = '0') report "Error on IS_SQUARE_NUM Value for word 007F"  severity error;
        assert (s_remainer      = x"0006") report "Error on REMAINER Value for word 007F"   severity error;
        
        s_data_in <= x"0080";
        wait for 10 ns;
        assert (s_sqrt          = x"000B") report "Error on SQRT Value for word 0080"       severity error;
        assert (s_is_square_num = '0') report "Error on IS_SQUARE_NUM Value for word 0080"  severity error;
        assert (s_remainer      = x"0007") report "Error on REMAINER Value for word 0080"   severity error;
        
        s_data_in <= x"E11C";
        wait for 10 ns;
        assert (s_sqrt          = x"00F0") report "Error on SQRT Value for word E11C"       severity error;
        assert (s_is_square_num = '0') report "Error on IS_SQUARE_NUM Value for word E11C"  severity error;
        assert (s_remainer      = x"001C") report "Error on REMAINER Value for word E11C"   severity error;
        
        s_data_in <= x"AB83";
        wait for 10 ns;
        assert (s_sqrt          = x"00D1") report "Error on SQRT Value for word AB83"       severity error;
        assert (s_is_square_num = '0') report "Error on IS_SQUARE_NUM Value for word AB83"  severity error;
        assert (s_remainer      = x"00E2") report "Error on REMAINER Value for word AB83"   severity error;
        
        wait;
    end process;

end Stimulus;
