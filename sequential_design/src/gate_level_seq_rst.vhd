library IEEE;
use IEEE.std_logic_1164.ALL;

entity gate_level_seq_rst is 
port(
    clk,rst,a,b,c : in std_logic;
    y : out std_logic
);
end gate_level_seq_rst;

architecture Behavioral of gate_level_seq_rst is
begin
    process (clk) begin
        if rising_edge(clk) then
            if(rst = '1') then 
                y <= '0';
            else 
                y <= (a and b and (not c)) or 
                    ((not a) and b and c)  or
                    ((not a) and (not b) and (not c));
            end if;
        end if;
    end process;

end Behavioral;

