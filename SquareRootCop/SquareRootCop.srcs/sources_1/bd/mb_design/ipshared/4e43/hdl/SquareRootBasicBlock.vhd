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
use IEEE.NUMERIC_STD.ALL;

entity SquareRootBasicBlock is
    generic (
        WORD_SIZE   : integer 
    );
    port (
        di : in  std_logic_vector(WORD_SIZE-1 downto 0);
        ri : in  std_logic_vector(WORD_SIZE-1 downto 0);
        qi : in  std_logic_vector(WORD_SIZE-1 downto 0);
        do : out std_logic_vector(WORD_SIZE-1 downto 0);
        ro : out std_logic_vector(WORD_SIZE-1 downto 0);
        qo : out std_logic_vector(WORD_SIZE-1 downto 0)
    );
end SquareRootBasicBlock;

architecture Structural of SquareRootBasicBlock is

    signal mux1out, mux2out             : std_logic_vector(WORD_SIZE-1 downto 0);
    signal rtemp, compval, op_result    : std_logic_vector(WORD_SIZE-1 downto 0);
    signal mux2_in_0, mux2_in_1         : std_logic_vector(WORD_SIZE-1 downto 0);
    signal condition                    : std_logic;

    component comparatorLessThan
        generic (
            WORD_SIZE   : integer   
        );
        port (
            i0, i1  : in  std_logic_vector(WORD_SIZE-1 downto 0);
            o       : out std_logic
        );
    end component;

    component mux2NtoN
        generic (
            WORD_SIZE   : integer  
        );
        port (
            i0, i1  : in  std_logic_vector(WORD_SIZE-1 downto 0);
            s       : in  std_logic;
            o       : out std_logic_vector(WORD_SIZE-1 downto 0)
        );
    end component;

begin

    comp1 : comparatorLessThan
        generic map (
            WORD_SIZE => WORD_SIZE
        )
        port map (
            i0 => rtemp,
            i1 => compval,
            o  => condition
        );
        
    mux1 : mux2NtoN
        generic map (
            WORD_SIZE => WORD_SIZE
        )
        port map (
            i0 => op_result,
            i1 => rtemp,
            s  => condition,
            o  => mux1out
        );
        
    mux2 : mux2NtoN
        generic map (
            WORD_SIZE => WORD_SIZE
        )
        port map (
            i0 => mux2_in_0,
            i1 => mux2_in_1,
            s  => condition,
            o  => mux2out
        );

    rtemp     <= ri(WORD_SIZE-3 downto 0) & di(WORD_SIZE-1 downto WORD_SIZE-2);
    compval   <= qi(WORD_SIZE-3 downto 0) & "01";
    op_result <= std_logic_vector(unsigned(rtemp) - unsigned(compval));
    
    mux2_in_0 <= qi(WORD_SIZE-2 downto 0) & "1";
    mux2_in_1 <= qi(WORD_SIZE-2 downto 0) & "0";
    
   
    do <= di(WORD_SIZE-3 downto 0) & "00";
    ro <= mux1out;
    qo <= mux2out;
    
end Structural;


--
-- Comparator (Less than)
--
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity comparatorLessThan is
    generic (
        WORD_SIZE   : integer
    );
    port (
        i0, i1  : in  std_logic_vector(WORD_SIZE-1 downto 0);
        o       : out std_logic
    );
end comparatorLessThan;

architecture Structural of comparatorLessThan is

begin
    process(i0, i1)
        begin
        if i0 < i1 then
            o <= '1';
        else
            o <= '0';
        end if;
    end process;

end Structural;


--
-- Mux 2N:N
--
library IEEE;
use IEEE.std_logic_1164.all;

entity mux2NtoN is
    generic (
        WORD_SIZE   : integer
    );
    port (
        i0, i1  : in  std_logic_vector(WORD_SIZE-1 downto 0);
        s       : in  std_logic;
        o       : out std_logic_vector(WORD_SIZE-1 downto 0)
    );
end mux2NtoN;

architecture Behavioral of mux2NtoN is

begin
    
    o <= i1 when (s = '1') else i0;

end Behavioral;