library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity block_ram_gen is
generic(
WIDTH : integer := 8;
DEPTH : integer := 12;  
read_type : string := "WRITE_FIRST"      -- READ_FIRST vs WRITE_FIRST property configuration  
);
port (
    clk : in  std_logic;
    we_i : in std_logic;    -- write enable
    addr_i : in std_logic_vector(DEPTH-1 downto 0);    -- address of the variable
    din_i : in std_logic_vector(WIDTH-1 downto 0);     -- input data
    dout_o : out std_logic_vector(WIDTH-1 downto 0)
);
end block_ram_gen;

architecture Behavioral of block_ram_gen is

type t_ram is array (0 to 2**DEPTH-1) of std_logic_vector(WIDTH-1 downto 0);
signal ram : t_ram := (others => (others => '0'));

begin

    G_READ_FIRST : if read_type = "READ_FIRST" generate

        process(clk)
        begin
            if rising_edge(clk) then
                if (we_i = '1') then
                    ram(to_integer(unsigned(addr_i))) <= din_i;
                end if;
            dout_o <= ram(to_integer(unsigned(addr_i)));
            end if;
        end process;

    end generate G_READ_FIRST;

    G_WRITE_FIRST : if read_type = "WRITE_FIRST" generate

        process(clk)
        begin
            if rising_edge(clk) then
                dout_o <= ram(to_integer(unsigned(addr_i)));
                if (we_i = '1') then
                    ram(to_integer(unsigned(addr_i))) <= din_i;
                    dout_o <= din_i;
                end if;
            end if;
        end process;

    end generate G_WRITE_FIRST;

end Behavioral;
