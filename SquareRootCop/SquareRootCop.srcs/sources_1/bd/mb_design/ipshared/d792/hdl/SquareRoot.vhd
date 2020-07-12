----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/03/2020 04:55:51 PM
-- Design Name: 
-- Module Name: SquareRoot - Behavioral
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

entity SquareRoot is
    generic (
        DATA_WIDTH      : integer   := 32
    );
    port (
        DATA_IN         : in  std_logic_vector(DATA_WIDTH-1 downto 0);
        SQRT            : out std_logic_vector(DATA_WIDTH-1 downto 0);
        IS_SQUARE_NUM   : out std_logic;
        REMAINER        : out std_logic_vector(DATA_WIDTH-1 downto 0)
    );
end SquareRoot;

architecture Structural of SquareRoot is
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
	
	constant N_ITER : integer := DATA_WIDTH / 2;
	
	type TSquareRootData is array (0 to (N_ITER-1)) of std_logic_vector(DATA_WIDTH-1 downto 0);
	signal d_array, r_array, q_array: TSquareRootData;
	
	signal s_remainer, s_sqrt, s_aux: std_logic_vector(DATA_WIDTH-1 downto 0);
begin

s_aux <= (others => '0');

-- Initialize first position of the arrays
d_array(0) <= DATA_IN;
r_array(0) <= (others => '0');
q_array(0) <= (others => '0');

gen_sqrt_blocks: for I in 0 to N_ITER-1 generate      -- + DATA_WIDTH REM 2;
    NORMAL_ITER: if I<N_ITER-1 generate
        SquareRootBasic : SquareRootBasicBlock    
            generic map (
                WORD_SIZE   => DATA_WIDTH
            )
            port map (
                di => d_array(I),
                ri => r_array(I),
                qi => q_array(I),
                do => d_array(I+1),
                ro => r_array(I+1),
                qo => q_array(I+1)
            );
    end generate NORMAL_ITER;
    
    LAST_ITER: if I=N_ITER-1 generate
        SquareRootBasic : SquareRootBasicBlock    
            generic map (
                WORD_SIZE   => DATA_WIDTH
            )
            port map (
                di => d_array(I),
                ri => r_array(I),
                qi => q_array(I),
                do => open,
                ro => s_remainer,
                qo => s_sqrt
            );
    end generate LAST_ITER;
   
    SQRT          <= s_sqrt;
    REMAINER      <= s_remainer;
    IS_SQUARE_NUM <= '1' when s_remainer = s_aux else '0';
   
end generate gen_sqrt_blocks;


end Structural;
