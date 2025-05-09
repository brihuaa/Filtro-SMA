library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sma_filter is
    generic (
        N     : integer := 4;     -- Orden del filtro
        WIDTH : integer := 8      -- Ancho de palabra
    );
    port (
        clk  : in  std_logic;
        rst  : in  std_logic;
        din  : in  std_logic_vector(WIDTH-1 downto 0);
        load : in  std_logic;
        dout : out std_logic_vector(WIDTH-1 downto 0)
    );
end entity sma_filter;

architecture behavioral of sma_filter is
    type sample_array is array (0 to N-1) of unsigned(WIDTH-1 downto 0);
    signal samples : sample_array := (others => (others => '0'));
    signal sum     : unsigned(WIDTH+2 downto 0) := (others => '0'); -- +2 bits por suma
    signal avg     : unsigned(WIDTH-1 downto 0);
begin
    process(clk, rst)
    begin
        if rst = '1' then
            samples <= (others => (others => '0'));
            sum     <= (others => '0');
        elsif rising_edge(clk) then
            if load = '1' then
                -- Desplazamiento y carga nueva muestra
                sum <= sum 
                       - resize(samples(N-1), sum'length)
                       + resize(unsigned(din), sum'length);
                for i in N-1 downto 1 loop
                    samples(i) <= samples(i-1);
                end loop;
                samples(0) <= unsigned(din);
            end if;
        end if;
    end process;

    -- Media simple: división entera por N
    avg <= resize(sum / N, WIDTH);
    dout <= std_logic_vector(avg);
end architecture behavioral;
