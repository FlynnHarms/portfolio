-- Top level for the Basys 3: buttons -> debounce -> lock FSM -> LEDs
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_lock is
    port( clock : in  STD_LOGIC;
          clr   : in  STD_LOGIC;
          b     : in  STD_LOGIC_VECTOR(3 downto 0);
          z     : out STD_LOGIC_VECTOR(2 downto 0) );
end top_lock;

architecture Behavioral of top_lock is
    signal debounce_b : STD_LOGIC_VECTOR(3 downto 0);

    component debounce
        Port ( clock, clr : in  STD_LOGIC;
               inp        : in  STD_LOGIC_VECTOR(3 downto 0);
               outp       : out STD_LOGIC_VECTOR(3 downto 0) );
    end component;

    component lock
        Port(
            btn : in  STD_LOGIC_VECTOR(3 downto 0);
            CLR : in  STD_LOGIC;
            CLK : in  STD_LOGIC;
            z   : out STD_LOGIC_VECTOR(2 downto 0)
        );
    end component;
begin

    U1: lock port map(
        CLK => clock,
        btn => debounce_b,
        CLR => clr,
        z   => z);

    U2: debounce port map(
        clock => clock,
        clr   => clr,
        inp   => b,
        outp  => debounce_b);

end Behavioral;
