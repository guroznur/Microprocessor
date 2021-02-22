
library ieee;
use ieee.std_logic_1164.all;
use IEEE.Numeric_Std.all;
--use ieee.std_logic_arith.all;
--use ieee.std_logic_unsigned.all;

entity eIslemci is
generic(n:natural:=8);
port( s, r : in std_logic;  --Reset
         kmt: in std_logic_vector(2*n-1 downto 0) -- 16 bit girisi secme
);
end entity;

Architecture struct of eIslemci is


TYPE tMEM IS ARRAY(0 TO 63) OF std_logic_vector(n-1 DOWNTO 0);
SIGNAL Ram : tMEM;  -- RAM

TYPE tREG IS ARRAY(0 TO 15) OF std_logic_vector(n-1 DOWNTO 0);
SIGNAL Reg : tREG;  --REG

--TYPE tROM is array(0 TO 31) OF std_logic_vector(n-1 DOWNTO 0);
--SIGNAL Rom :tROM;   -- ROM


Begin -- mimari

Komut:
process(s, r)
Begin
     If( Rising_edge(s) ) then 
     
      if(r='1')then
     if(s='1')then
      Ram(to_integer(unsigned(Kmt(7 downto 0)))) <= "ZZZZZZZZ";   
    else
      Reg(to_integer(unsigned(Kmt(11 downto 8)))) <="ZZZZZZZZ";
    end if;
  end if;
     
     
   else
     Case Kmt(15 downto 12) is -- en anlamli 4 bit
     
       
	When "0000" =>
	    null;   -- islem yok... ... 
	    

	
	When "0001" =>
		Reg(to_integer(unsigned(Kmt(11 downto 8)))) <= Kmt(7 downto 0);  

	
	When "0010" =>  
		Reg(  to_integer(unsigned(Kmt(11 downto 8))))  <= Reg(  to_integer(unsigned(Kmt(7 downto 4)) ))  ;
		
		
	When "0011" =>   
		Reg(  to_integer(unsigned(Kmt(11 downto 8))))  <= Ram(  to_integer(unsigned(Kmt(7 downto 0)) ))  ;

	
	When "0100" =>   
		Reg(  to_integer(unsigned(Kmt(11 downto 8))))  <= 
			Ram( to_integer(unsigned( Reg( to_integer(unsigned(Kmt(7 downto 4)))  ))))  ;

	
 	When "0101" =>  
           Ram( to_integer(unsigned(Kmt(7 downto 0))) ) <= 
			Reg( to_integer(unsigned(Kmt(11 downto 8))));
	
	
 	When "0110" =>  
           Reg(  to_integer(unsigned(Kmt(11 downto 8))) )   <= 
				std_logic_vector( 
					unsigned(Reg( to_integer(unsigned(Kmt(11 downto 8)))))
					 + unsigned(Kmt (7 downto 0)));
	
	
 	When "0111" =>  
           Reg( to_integer(unsigned(Kmt(11 downto 8)) ))   <= 
			std_logic_vector( unsigned(Reg( to_integer(unsigned(Kmt(7 downto 4)))))   
			+ unsigned(Reg( to_integer(unsigned(Kmt(3 downto 8)))))  );

		

When "1000" =>
  Reg(  to_integer(unsigned(Kmt(7 downto 4))) )   <= 
				std_logic_vector(
				unsigned(Reg( to_integer(unsigned(Kmt(7 downto 4)))))
					 - unsigned(Kmt (7 downto 0)));
					 

					 
 When "1001" =>  
    Reg( to_integer(unsigned(Kmt(11 downto 8)) ))   <= 
			std_logic_vector( unsigned(Reg( to_integer(unsigned(Kmt(11 downto 8)))))   
			- unsigned(Reg( to_integer(unsigned(Kmt(3 downto 0)))))  );
			
		
 

When "1010" =>  
   Reg(  to_integer(unsigned(Kmt(11 downto 8))) )   <= 
				std_logic_vector( 
					unsigned(Reg( to_integer(unsigned(Kmt(11 downto 8)))))
					 and unsigned(Kmt (7 downto 0)));
					 


When "1011" =>  
   Reg(  to_integer(unsigned(Kmt(11 downto 8))) )   <= 
				std_logic_vector( 
					unsigned(Reg( to_integer(unsigned(Kmt(11 downto 8)))))
					 or unsigned(Kmt (7 downto 0)));


When "1100" => Reg( to_integer(unsigned(Kmt(11 downto 8)) ))   <= 
			std_logic_vector( unsigned(Reg( to_integer(unsigned(Kmt(7 downto 4)))))   
			xor unsigned(Reg( to_integer(unsigned(Kmt(3 downto 0)))))  );
		

When "1101" => Reg( to_integer(unsigned(Kmt(11 downto 8)) ))   <= 
			std_logic_vector( unsigned(Reg( to_integer(unsigned(Kmt(7 downto 4)))))   
			xnor unsigned(Reg( to_integer(unsigned(Kmt(3 downto 0)))))  );

When "1110" =>

Reg(  to_integer(unsigned(Kmt(7 downto 4))) )   <= 
				std_logic_vector( 
					unsigned(Reg( to_integer(unsigned(Kmt(7 downto 4)))))
					/ unsigned(Kmt (7 downto 0)));
					


When "1111" =>

Reg(  to_integer(unsigned(Kmt(7 downto 4))) )   <= 
				std_logic_vector( 
					unsigned(Reg( to_integer(unsigned(Kmt(7 downto 4)))))
					/ unsigned(Kmt (7 downto 0)));


 	When others =>
	    null;
      end case; 
   end if;
end Process;

end struct;


