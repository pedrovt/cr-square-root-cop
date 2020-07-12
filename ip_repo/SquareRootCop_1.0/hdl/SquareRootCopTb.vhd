----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/12/2020 12:36:05 AM
-- Design Name: 
-- Module Name: SquareRootCopTb - Behavioral
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

entity SquareRootCopTb is
    generic (
        WORD_SIZE   : integer   := 32
    );
end SquareRootCopTb;

architecture Stimulus of SquareRootCopTb is
    signal s_data_in, s_sqrt, s_remainer : std_logic_vector(WORD_SIZE - 1 downto 0);
    signal s_is_square_num : std_logic;

    component SquareRootCop_v1_0 is
        generic (
            -- Users to add parameters here
    
            -- User parameters ends
            -- Do not modify the parameters beyond this line
    
    
            -- Parameters of Axi Slave Bus Interface S00_AXIS
            C_S00_AXIS_TDATA_WIDTH	: integer	:= 32;
    
            -- Parameters of Axi Master Bus Interface M00_AXIS
            C_M00_AXIS_TDATA_WIDTH	: integer	:= 32;
            C_M00_AXIS_START_COUNT	: integer	:= 32;
    
            -- Parameters of Axi Master Bus Interface M01_AXIS
            C_M01_AXIS_TDATA_WIDTH	: integer	:= 32;
            C_M01_AXIS_START_COUNT	: integer	:= 32
        );
        port (
            -- Users to add ports here
    
            -- User ports ends
            -- Do not modify the ports beyond this line
    
    
            -- Ports of Axi Slave Bus Interface S00_AXIS
            s00_axis_aclk	: in std_logic;
            s00_axis_aresetn: in std_logic;
            s00_axis_tready	: out std_logic;
            s00_axis_tdata	: in std_logic_vector(C_S00_AXIS_TDATA_WIDTH-1 downto 0);
            s00_axis_tstrb	: in std_logic_vector((C_S00_AXIS_TDATA_WIDTH/8)-1 downto 0);
            s00_axis_tlast	: in std_logic;
            s00_axis_tvalid	: in std_logic;
    
            -- Ports of Axi Master Bus Interface M00_AXIS
            m00_axis_aclk	: in std_logic;
            m00_axis_aresetn	: in std_logic;
            m00_axis_tvalid	: out std_logic;
            m00_axis_tdata	: out std_logic_vector(C_M00_AXIS_TDATA_WIDTH-1 downto 0);
            m00_axis_tstrb	: out std_logic_vector((C_M00_AXIS_TDATA_WIDTH/8)-1 downto 0);
            m00_axis_tlast	: out std_logic;
            m00_axis_tready	: in std_logic;
    
            -- Ports of Axi Master Bus Interface M01_AXIS
            m01_axis_aclk	: in std_logic;
            m01_axis_aresetn	: in std_logic;
            m01_axis_tvalid	: out std_logic;
            m01_axis_tdata	: out std_logic_vector(C_M01_AXIS_TDATA_WIDTH-1 downto 0);
            m01_axis_tstrb	: out std_logic_vector((C_M01_AXIS_TDATA_WIDTH/8)-1 downto 0);
            m01_axis_tlast	: out std_logic;
            m01_axis_tready	: in std_logic
        );
    end component;

begin

SquareRootCop_v1_0 : SquareRootCop_v1_0    
    port map (
    -- Ports of Axi Slave Bus Interface S00_AXIS
        s00_axis_aclk	: s_clk;
        s00_axis_aresetn: '1';
        s00_axis_tready	: out std_logic;
        s00_axis_tdata	=> s_data_in,
        s00_axis_tstrb	: (others => '1');
        s00_axis_tlast	: open;
        s00_axis_tvalid	: in ....;

        -- Ports of Axi Master Bus Interface M00_AXIS
        m00_axis_aclk	: s_clk;
        m00_axis_aresetn: '1';
        m00_axis_tvalid	: out std_logic;
        m00_axis_tdata	: out std_logic_vector(C_M00_AXIS_TDATA_WIDTH-1 downto 0);
        m00_axis_tstrb	: out std_logic_vector((C_M00_AXIS_TDATA_WIDTH/8)-1 downto 0);
        m00_axis_tlast	: out std_logic;
        m00_axis_tready	: in std_logic;

        -- Ports of Axi Master Bus Interface M01_AXIS
        m01_axis_aclk	: s_clk;
        m01_axis_aresetn: '1';
        m01_axis_tvalid	: out std_logic;
        m01_axis_tdata	: out std_logic_vector(C_M01_AXIS_TDATA_WIDTH-1 downto 0);
        m01_axis_tstrb	: out std_logic_vector((C_M01_AXIS_TDATA_WIDTH/8)-1 downto 0);
        m01_axis_tlast	: out std_logic;
        m01_axis_tready	: in std_logic
    );

process
    begin
    s_clk <= '0';
    wait for 10 ns;
    s_clk <= '1';
    wait for 10 ns;
    end process;

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

