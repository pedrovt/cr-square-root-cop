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

    component RegisterBank is
        generic (
            WORD_SIZE       : integer
        );
        port (
            clk, nSet, nRst : in  std_logic;
            D0, D1, D2      : in  std_logic_vector(WORD_SIZE-1 downto 0);
            Q0, Q1, Q2      : out std_logic_vector(WORD_SIZE-1 downto 0)
        );
	end component;

	constant N_ITER : integer := DATA_WIDTH / 2;
--	type TSquareRootData is array (0 to (N_ITER-1)) of std_logic_vector(DATA_WIDTH-1 downto 0);
	type TSquareRootData is array (0 to 2*(N_ITER-1)) of std_logic_vector(DATA_WIDTH-1 downto 0);
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
                di => d_array(2*I),
                ri => r_array(2*I),
                qi => q_array(2*I),
                do => d_array(2*I+1),
                ro => r_array(2*I+1),
                qo => q_array(2*I+1)
            );
        RegisterBank : RegisterBank
            generic map (
                WORD_SIZE   => DATA_WIDTH
            )
            port map (
                clk  => clk,
                nSet => '1',
                nRst => '1',
                D0   => d_array(2*I+1),
                D1   => r_array(2*I+1),
                D2   => q_array(2*I+1),
                Q0   => d_array(2*(I+1)),
                Q1   => r_array(2*(I+1)),
                Q2   => q_array(2*(I+1))
            );
    end generate NORMAL_ITER;
    
    LAST_ITER: if I=N_ITER-1 generate
        SquareRootBasic : SquareRootBasicBlock    
            generic map (
                WORD_SIZE   => DATA_WIDTH
            )
            port map (
                di => d_array(2*I),
                ri => r_array(2*I),
                qi => q_array(2*I),
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



-- ============
-- = FlipFlop =
-- ============
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity flipFlopDPET is
    port (
        clk, D      : in  std_logic;
        nSet, nRst  : in  std_logic;
        Q, nQ       : out std_logic
    );
end flipFlopDPET;

architecture Behavioral of flipFlopDPET is
begin
    process (clk, nSet, nRst)
    begin
        if (nRst = '0') then
            Q <= '0';
            nQ <= '1';
        elsif (nSet = '0') then
            Q <= '1';
            nQ <= '0';
        elsif (clk = '1') and (clk'event) then
            Q <= D;
            nQ <= not D;
        end if;
    end process;
end Behavioral;



-- ============
-- = Register =
-- ============
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Register is
    generic (
        WORD_SIZE: integer
    );
    port (
        clk, nSet, nRst : in  std_logic;
        D               : in  std_logic_vector(WORD_SIZE-1 downto 0);
        Q, nQ           : out std_logic_vector(WORD_SIZE-1 downto 0)
    );
end Register;

architecture Structural of Register is

    component flipFlopDPET
        port (
            clk, D      : in  std_logic;
            nSet, nRst  : in  std_logic;
            Q, nQ       : out std_logic
        );
    end component;

begin
gen_reg: for I in 0 to WORD_SIZE-1 generate
    FlipFlop : flipFlopDPET
        port map (
            clk     => clk,
            D       => D(I),
            nSet    => nSet,
            nRst    => nRst,
            Q       => Q(I),
            nQ      => nQ(I)
        );
end generate gen_reg;
end Structural;



-- =================
-- = Register Bank =
-- =================
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RegisterBank is
    generic (
        WORD_SIZE: integer
    );
    port (
        clk, nSet, nRst : in  std_logic;
        D0, D1, D2      : in  std_logic_vector(WORD_SIZE-1 downto 0);
        Q0, Q1, Q2      : out std_logic_vector(WORD_SIZE-1 downto 0)
    );
end RegisterBank;

architecture Structural of RegisterBank is

    component Register
        generic (
            WORD_SIZE       : integer
        );
        port (
            clk, nSet, nRst : in  std_logic;
            D               : in  std_logic_vector(WORD_SIZE-1 downto 0);
            Q, nQ           : out std_logic_vector(WORD_SIZE-1 downto 0)
        );
    end component;

begin

    ff0: Register
        generic map (WORD_SIZE)
        port map (clk, nSet, nRst, D(0), Q(0), open);

    ff1: Register
        generic map (WORD_SIZE)
        port map (clk, nSet, nRst, D(1), Q(1), open);

    ff2: Register
        generic map (WORD_SIZE)
        port map (clk, nSet, nRst, D(2), Q(2), open);

end Structural;