-- 4-bit push-button debouncer.
-- Divides the 100 MHz board clock by 2^18 (~381 Hz) and only passes a
-- button through once it has been high for three consecutive samples.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity debounce is
    Port ( clock, clr : in  STD_LOGIC;
           inp        : in  STD_LOGIC_VECTOR(3 downto 0);
           outp       : out STD_LOGIC_VECTOR(3 downto 0) );
end debounce;

architecture Behavioral of debounce is
    signal count  : STD_LOGIC_VECTOR(17 downto 0);
    signal clk190 : STD_LOGIC;
    signal delay1, delay2, delay3 : STD_LOGIC_VECTOR(3 downto 0);
begin

    process (clr, clock)
    begin
        if clr = '0' then
            count <= (others => '0');
        elsif clock'event and clock = '1' then
            count <= count + 1;
        end if;
    end process;

    clk190 <= count(17);

    process (clr, clk190)
    begin
        if clr = '0' then
            delay1 <= "0000";
            delay2 <= "0000";
            delay3 <= "0000";
        elsif clk190'event and clk190 = '1' then
            delay1 <= inp;
            delay2 <= delay1;
            delay3 <= delay2;
        end if;
    end process;

    outp <= delay1 and delay2 and delay3;

end Behavioral;
