----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/03/2020 07:29:48 PM
-- Design Name: 
-- Module Name: SquareRootBasicBlockTb - Behavioral
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

use STD.textio.all;
use IEEE.std_logic_textio.all;

library UNISIM;
use UNISIM.VComponents.all;

entity SquareRootBasicBlockTb is
    generic (
        WORD_SIZE   : integer   := 16
    );
end SquareRootBasicBlockTb;

architecture Stimulus of SquareRootBasicBlockTb is
signal  s_di, s_ri, s_qi, s_do, s_ro, s_qo : std_logic_vector(WORD_SIZE - 1 downto 0);

component SquareRootBasicBlock is
    generic (
        WORD_SIZE       : integer
    );
    port (
        di : in  std_logic_vector(WORD_SIZE-1 downto 0);
        ri : in  std_logic_vector(WORD_SIZE-1 downto 0);
        qi : in  std_logic_vector(WORD_SIZE-1 downto 0);
        do : out std_logic_vector(WORD_SIZE-1 downto 0);
        ro : out std_logic_vector(WORD_SIZE-1 downto 0);
        qo : out std_logic_vector(WORD_SIZE-1 downto 0)
    );
    end component;

begin

SquareRootBasic : SquareRootBasicBlock    
    generic map (
        WORD_SIZE   => WORD_SIZE
    )
    port map (
        di => s_di,
        ri => s_ri,
        qi => s_qi,
        do => s_do,
        ro => s_ro,
        qo => s_qo
    );

process
begin
        s_di <= x"4000";
        s_ri <= x"0000";
        s_qi <= x"0000"; 
        wait for 10 ns;
        assert (s_do = x"0000") report "Error on SQRT Value for word 4000" severity error;
        assert (s_ro = x"0000") report "Error on SQRT Value for word 4000" severity error;
        assert (s_qo = x"0001") report "Error on SQRT Value for word 4000" severity error;

        s_di <= x"8000";
        s_ri <= x"0001";
        s_qi <= x"0001"; 
        wait for 10 ns;
        assert (s_do = x"0000") report "Error on SQRT Value for word 8000" severity error;
        assert (s_ro = x"0001") report "Error on SQRT Value for word 8000" severity error;
        assert (s_qo = x"0003") report "Error on SQRT Value for word 8000" severity error;
        
        s_di <= x"FC00";
        s_ri <= x"0000";
        s_qi <= x"0001"; 
        wait for 10 ns;
        assert (s_do = x"F000") report "Error on SQRT Value for word FC00" severity error;
        assert (s_ro = x"0003") report "Error on SQRT Value for word FC00" severity error;
        assert (s_qo = x"0002") report "Error on SQRT Value for word FC00" severity error;
        
        s_di <= x"0000";
        s_ri <= x"0004";
        s_qi <= x"0002"; 
        wait for 10 ns;
        assert (s_do = x"0000") report "Error on SQRT Value for word 0000" severity error;
        assert (s_ro = x"0007") report "Error on SQRT Value for word 0000" severity error;
        assert (s_qo = x"0005") report "Error on SQRT Value for word 0000" severity error;
        
        s_di <= x"0124";
        s_ri <= x"0000";
        s_qi <= x"0000"; 
        wait for 10 ns;
        assert (s_do = x"0490") report "Error on SQRT Value for word 0000" severity error;
        assert (s_ro = x"0000") report "Error on SQRT Value for word 0000" severity error;
        assert (s_qo = x"0000") report "Error on SQRT Value for word 0000" severity error;
        
        wait;
    end process;

end Stimulus;
