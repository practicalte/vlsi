library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity alu is
    Port ( a : in  STD_LOGIC_VECTOR (3 downto 0);
           b : in  STD_LOGIC_VECTOR (3 downto 0);
           y : out  STD_LOGIC_VECTOR (3 downto 0);
           s : in  STD_LOGIC_VECTOR (1 downto 0));
end alu;

architecture Behavioral of alu is

begin

 y <= a and b when s="00" else 
      a or b when s="01"  else
		a nor b when s="10" else
		not a ;


end Behavioral;



.ucf

NET "a<0>" LOC = "P58";
NET "a<1>" LOC = "P64";
NET "a<2>" LOC = "P75";
NET "a<3>" LOC = "P1";

NET "b<0>" LOC = "P141";
NET "b<1>" LOC = "P137";
NET "b<2>" LOC = "P131";
NET "b<3>" LOC = "P8";

NET "s<1>" LOC = "P126";
NET "s<0>" LOC = "P133";

NET "y<0>" LOC = "P115";
NET "y<1>" LOC = "P114";
NET "y<2>" LOC = "P10";
NET "y<3>" LOC = "P5";
