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

entity SquareRootBasicBlockTb is
    generic (
		WORD_SIZE	: integer	:= 16
	);
end SquareRootBasicBlockTb;

architecture Behavioral of SquareRootBasicBlockTb is
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
        -- Initial values 0 4 8 10 100 128 127   
        -- 00000000  
        
        
        s_di <= x"00000000";
        s_ri <= x"00000000";
        s_qi <= x"00000000"; 
        wait for 10 ns;
        assert (s_sqrt = std_logic_vector(to_unsigned(0, 32))) report "Error on SQRT Value for word 00000000" severity error;
        assert (s_sqrt = std_logic_vector(to_unsigned(0, 32))) report "Error on Remainer Value for word 00000000" severity error;
        
        wait;
    end process;

end Stimulus;
