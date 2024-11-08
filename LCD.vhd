library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity LCD_interface is
    Port ( 	rst : in std_logic;
				clk : in std_logic;
				RS : out std_logic; 
				RW : out std_logic; 
				EN : out std_logic;
				LCD : out std_logic_vector(7 downto 0));
end LCD_interface;

architecture arch_LCD_interface of LCD_interface is
signal count: integer range 0 to 47;
signal clock: std_logic;
signal flag : std_logic:='0';

begin
process(rst,clk)
variable temp: integer range 0 to 999999;
begin	

--Clock divider, to slow the clock
if(not rst='1')then
	temp:=0;
	clock<='0';
elsif(clk='1' and clk' event)then
	temp:=temp+1;
	if(temp =250000)then
		clock<= not clock;
		temp:=0;
	end if;
end if;
end process;


-- counter to go through the stages of LCD writing
process (rst,clock)
begin
   	if (not rst ='1') then
         COUNT <=0;
     elsif (clock' event and clock = '1') then
		if (count < 47  and flag='0' ) then
			count <= count+ 1;
	
end if;
end if;
END PROCESS;


-- process to allocate ouput on counter vaules
-- writes on LCD in HEX format
Process(count,rst,clock)
begin
if (NOT rst ='1') then
				RW<='0';
				RS<='0';
				EN<='0';
				LCD <= "00000000";
				flag<='0';
elsif(rising_edge(clock))	then	

-- first few counts are to initialize LCD		
case count is
 when 0 => 	RW <= '0'; 
				RS <= '0';
				LCD <= x"38"; -- init in 2 lin mode
				EN <= '1';
 when 1 => 	EN <= '0';

 when 2 => 	RW <= '0'; 
				RS <=  '0';
				LCD <= x"0E";-- display on, cursor blink
				EN <= '1';
 when 3 => 	EN <= '0';

 when 4 => 	RW <= '0'; 
				RS <=  '0';
				LCD <= x"01"; -- clear display
				EN <= '1';	
 when 5 => 	EN <= '0';

 when 6 => 	RW <= '0'; 
				RS <=  '0';
				LCD <= x"06";-- shift cursor to right
				EN <= '1';
 when 7 => 	EN <= '0'; 

 when 8=> 	RW <= '0'; 
				RS <=  '0';
				LCD <= x"81"; -- initialize to 1st line, 2nd position
				EN <= '1';
 when 9=> 	EN <= '0';
 
 -- Data wriing starts
 when 10 => RW <= '0'; 
				RS <=  '1';
				LCD <=x"4A"; 	--J
				EN <= '1';
 when 11 => EN <= '0';
 
 when 12 => RW <= '0'; 
				RS<=  '1';
				LCD<= x"53";	--S
				EN <= '1';
 when 13 => EN <= '0';
 
 when 14 => RW <= '0'; 
				RS<=  '1';
				LCD<= x"50"; 	--P
				EN <= '1';
 when 15 => EN <= '0';
 
 when 16 => RW <= '0'; 
				RS<=  '1';
				LCD<= x"4D";	--M
				EN <= '1';
 when 17 => EN <= '0';
 
 when 18 => RW <= '0'; 
				RS<=  '1';
				LCD<= x"20";	--space
				EN <= '1';
 when 19 => EN <= '0';
 
 when 20 => RW <= '0'; 
				RS<=  '1';
				LCD<= x"47";	--G 
				EN <= '1';
 when 21 => EN <= '0';
 
 when 22 => RW <= '0'; 
				RS<=  '1';
				LCD<= x"52";  	--R
				EN <= '1';
 when 23 => EN <= '0';
 
 when 24 => RW <= '0'; 
				RS<=  '1';
				LCD<= x"4F";  	--O
				EN <= '1';
 when 25 => EN <= '0';
 
 when 26 => RW <= '0'; 
				RS<=  '1';
				LCD<= x"55"; 	--U
				EN <= '1';
 when 27 => EN <= '0';
 
 when 28 => RW <= '0'; 
				RS<=  '1';
				LCD<= x"50"; 	--P
				EN <= '1';
 when 29=> 	EN <= '0';
 
 when 30 => RW <= '0'; 
				RS<=  '1';
				LCD<= x"20"; 	--space
				EN <= '1';
 when 31=> 	EN <= '0';
 
 when 32 => RW <= '0'; 
				RS<=  '1';
				LCD<= x"20"; 	--space
				EN <= '1';
 when 33=> 	EN <= '0';
 
 when 34 => RW <= '0'; 
				RS<=  '1';
				LCD<= x"20"; 	--space
				EN <= '1';
 when 35=> 	EN <= '0';
 
 when 36 => RW <= '0'; 
				RS<=  '1';
				LCD<= x"20";  	--space
				EN <= '1';
 when 37 => EN <= '0';
 
 when 38 => RW <= '0'; 
				RS<=  '0';
				LCD<= x"C6";	--2nd line(0xC5)
				EN <= '1';
 when 39 => EN <= '0';
 
 when 40 => RW <= '0'; 
				RS<=  '1';
				LCD<= x"50";   --P
				EN <= '1';
 when 41 => EN <= '0';
 
 when 42 => RW <= '0'; 
				RS<=  '1';
				LCD<= x"55";   --U
				EN <= '1';
 when 43 => EN <= '0';
 
 when 44 => RW <= '0'; 
				RS<=  '1';
				LCD<= x"4E";   --N
				EN <= '1';
 when 45 => EN <= '0';
 
 when 46 => RW <= '0'; 
				RS<=  '1';
				LCD<= x"45";   --E
				EN <= '1';
 when 47 => EN <= '0';
				flag<='1';
	
END CASE;
end if;
END PROCESS;

end arch_LCD_interface;

















>UCF file


# clock pin for FPGA Board
NET "clk" LOC = "P56"; # Bank = 0, Signal name = MCLK
NET "rst" LOC = "P22"; # Bank = 2, Signal name = Reset
NET "rst" CLOCK_DEDICATED_ROUTE = FALSE;

# Pin Connected to LCD data 
NET "LCD[0]" LOC = "P85"; 
NET "LCD[1]" LOC = "P82"; 
NET "LCD[2]" LOC = "P83"; 
NET "LCD[3]" LOC = "P80"; 
NET "LCD[4]" LOC = "P81"; 
NET "LCD[5]" LOC = "P78"; 
NET "LCD[6]" LOC = "P79"; 
NET "LCD[7]" LOC = "P74"; 


#Control line
NET "RS" LOC = "P88"; 
NET "EN" LOC = "P84"; 
NET "RW" LOC = "P2"; 
