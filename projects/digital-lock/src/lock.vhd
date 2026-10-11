-- Digital lock FSM with 3-strike lockout
-- Secret code: 0-3-2, entered on four one-hot push buttons.
-- z = "001" unlocked, "010" wrong sequence, "100" locked out, "000" entering.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity lock is
    Port(
        btn : in  STD_LOGIC_VECTOR(3 downto 0);
        CLR : in  STD_LOGIC;
        CLK : in  STD_LOGIC;
        z   : out STD_LOGIC_VECTOR(2 downto 0)
    );
end lock;

architecture behavioral of lock is
    type state_type is (s0, w0, s1, w1, s2, w2, s3, err, lockout);
    signal state, next_state : state_type;
    signal d0, d1, d2 : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    signal fail_count : integer range 0 to 3 := 0;
begin

    -- State register + digit storage + fail counter
    process(CLR, CLK)
    begin
        if CLR = '0' then
            state <= s0;
            d0 <= "0000";
            d1 <= "0000";
            d2 <= "0000";
            fail_count <= 0;
        elsif rising_edge(CLK) then
            state <= next_state;

            -- capture digits
            case state is
                when s0 =>
                    if btn /= "0000" then
                        d0 <= btn;
                    end if;
                when s1 =>
                    if btn /= "0000" then
                        d1 <= btn;
                    end if;
                when s2 =>
                    if btn /= "0000" then
                        d2 <= btn;
                    end if;
                when others =>
                    null;
            end case;

            -- reset on correct code
            if next_state = s3 then
                fail_count <= 0;
            -- increment ONLY when entering err
            elsif state /= err and next_state = err then
                if fail_count < 3 then
                    fail_count <= fail_count + 1;
                end if;
            end if;
        end if;
    end process;

    -- Next-state logic
    process(state, btn, d0, d1, d2, fail_count)
    begin
        next_state <= state;
        case state is
            when s0 =>
                if btn /= "0000" then
                    next_state <= w0;
                end if;
            when w0 =>
                if btn = "0000" then
                    next_state <= s1;
                end if;
            when s1 =>
                if btn /= "0000" then
                    next_state <= w1;
                end if;
            when w1 =>
                if btn = "0000" then
                    next_state <= s2;
                end if;
            when s2 =>
                if btn /= "0000" then
                    next_state <= w2;
                end if;
            when w2 =>
                if btn = "0000" then
                    if (d0 = "0001" and d1 = "1000" and d2 = "0100") then
                        next_state <= s3;
                    elsif fail_count = 2 then
                        next_state <= lockout;  -- third wrong sequence
                    else
                        next_state <= err;      -- wrong sequence 1 or 2
                    end if;
                end if;
            when s3 =>
                if btn /= "0000" then
                    next_state <= s0;
                end if;
            when err =>
                if btn /= "0000" then
                    next_state <= s0;
                end if;
            when lockout =>
                next_state <= lockout;
        end case;
    end process;

    -- Output logic
    process(state)
    begin
        case state is
            when s3 =>
                z <= "001";  -- unlocked
            when err =>
                z <= "010";  -- wrong 3-digit sequence
            when lockout =>
                z <= "100";  -- locked out
            when others =>
                z <= "000";  -- entering
        end case;
    end process;

end behavioral;
