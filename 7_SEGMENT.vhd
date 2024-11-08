library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
----------------------------------------------------------------------------------
entity keypad is
    Port ( clk 	: in  STD_LOGIC;
           rst 	: in  STD_LOGIC;
           row 	: inout  STD_LOGIC_VECTOR (3 downto 0);
           col 	: inout STD_LOGIC_VECTOR (3 downto 0);
			  digit 	: out STD_LOGIC_VECTOR (3 downto 0);
           display: out STD_LOGIC_VECTOR (7 downto 0));
end keypad;
----------------------------------------------------------------------------------
architecture Behavioral of keypad is
TYPE STATE_TYPE IS ( Col1Set, Col2Set, Col3Set, Col4Set );
SIGNAL coltest :   STATE_TYPE;
SIGNAL data:STD_LOGIC_VECTOR (7 downto 0);
SIGNAL rowm:STD_LOGIC_VECTOR (3 downto 0);
SIGNAL clock:STD_LOGIC;
begin
----------------------------------------------------------------------------------
---------Process for clock divide by 10-------------------------------------------
----------------------------------------------------------------------------------
Process(clk,rst)
variable temp:integer range 1 to 10;
begin
if(rst='0') then
temp:=1;
elsif(rising_edge(clk)) then
temp:=temp+1;
if(temp=10) then
clock<= not clock;
temp:=1;
end if;
end if;
end process;
---------------------------------------------------------------------------------
--------Process for Keypad scan & Display----------------------------------------
---------------------------------------------------------------------------------
process(clock,rst)
begin
if (rst='0') then
coltest<=col1set;
rowm<="1111";
data<=x"00";
elsif rising_edge (clock) then
	digit<="1111";
	case coltest is
	when col1set=>	 rowm<="0111";
				case col is	
				  when "0111"=>data<= x"C6";  -----------C 
				  when "1011"=>data<= x"A1";  -----------D
				  when "1101"=>data<= x"86";  -----------E
				  when "1110"=>data<= x"8E";  -----------F
				  when others=>coltest<=col2set;
				 end case;
	when col2set=>  rowm<="1011";
				case col is
				  when "0111"=>data<= x"C0";  -----------0  
				  when "1011"=>data<= x"F9";	-----------1
				  when "1101"=>data<= x"A4";  -----------2
				  when "1110"=>data<= x"B0";  -----------3
				  when others=>coltest<=col3set;
				 end case;
	when col3set=>   rowm<="1101";
				case col is
				  when "0111"=>data<= x"99";  -----------4 
				  when "1011"=>data<= x"92";  -----------5 
				  when "1101"=>data<= x"82";  -----------6 
				  when "1110"=>data<= x"F8";  -----------7
				  when others=>coltest<=col4set;
				 end case;
	when col4set=>   rowm <="1110";
				case col is
				  when "0111"=>data<= x"80";  -----------8 
				  when "1011"=>data<= x"90";	-----------9 
				  when "1101"=>data<= x"88";	-----------A 
				  when "1110"=>data<= x"83";  -----------B
				  when others=>coltest<=col1set;
				 end case;
end case;
end if;
end process;
display<=data;
row<=rowm;
end Behavioral;
----------------------------------------------------------------------------------
----------------------------------------------------------------------------------








.UCF


NET "clk" LOC = "P56"; 
NET "rst" LOC = "P22";
NET "clk" CLOCK_DEDICATED_ROUTE = true;
NET "rst" CLOCK_DEDICATED_ROUTE = FALSE;


NET "display[0]" LOC = "P48"; 
NET "display[1]" LOC = "P45"; 
NET "display[2]" LOC = "P51"; 
NET "display[3]" LOC = "P47"; 
NET "display[4]" LOC = "P57"; 
NET "display[5]" LOC = "P50"; 
NET "display[6]" LOC = "P59"; 
NET "display[7]" LOC = "P55"; 


NET "digit[0]" LOC = "P46"; 
NET "digit[1]" LOC = "P43"; 
NET "digit[2]" LOC = "P44"; 
NET "digit[3]" LOC = "P40"; 

NET "col[0]" LOC = "P58"  | PULLUP | DRIVE = 2;
NET "col[1]" LOC = "P62"  | PULLUP | DRIVE = 2;
NET "col[2]" LOC = "P61"  | PULLUP | DRIVE = 2;
NET "col[3]" LOC = "P66"  | PULLUP | DRIVE = 2; 
 
NET "row[0]" LOC = "P64"; 
NET "row[1]" LOC = "P16"; 
NET "row[2]" LOC = "P117";
NET "row[3]" LOC = "P75"; 



