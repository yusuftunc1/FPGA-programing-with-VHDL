library IEEE;
use IEEE.std_logic_1164.ALL;

entity gate_level_seq_rst_pipe is
port(
    clk,rst,a,b,c : in std_logic;
    y : out std_logic
);
end gate_level_seq_rst_pipe;

architecture Behavioral of gate_level_seq_rst_pipe is
    signal ff1 : std_logic := '0';
    signal ff2 : std_logic := '0';
    signal ff3 : std_logic := '0';
begin
    process(clk) begin
        if rising_edge(clk) then
            if (rst = '1') then
                ff1 <= '0';
                ff2 <= '0';
                ff3 <= '0';
                y <= '0';
            else
                ff1 <= a and b and (not c);
                ff2 <= (not a) and b and c;
                ff3 <= (not a) and (not b) and (not c);
                y <= ff1 or ff2 or ff3;
            end if;
        end if;
    end process;
end Behavioral;