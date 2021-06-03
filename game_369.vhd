
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


--입력: reset,clk,push1, push2,
--출력: situation(100넘으면 10전달), correct(timelimit으로 맞으면0, 틀리면1전달), count_369(369값 전달) 
entity game_369 is
    Port ( 
           state : out STD_LOGIC;
           FPGA_RSTB : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           load_operand1 :in  STD_LOGIC;
           load_operand2 :in  STD_LOGIC;
           situation : in std_logic_vector (1 downto 0);                                                     
           cnt_369 : in integer range 1 to 100); 
           --correct : out STD_LOGIC);
end game_369;

architecture Behavioral of game_369 is

   --signal state : STD_LOGIC; 
   --signal cor: STD_LOGIC; 
   signal quotient: integer := 0;
   signal remainder: integer := 0;
   --signal division_complete: std_logic := '0';                       
   --signal turn: integer range 0 to 3; --- 서연 작성코드랑 이어짐

begin
  
 --quotient에 10의자리, remainder에 1의자리 
   process(cnt_369)
      variable n_quotient: integer := 0;
      variable n_remainder: integer;
   begin
      n_quotient := 0;
      n_remainder := cnt_369;
      while(n_remainder >= 10) loop         
         n_quotient := n_quotient + 1;
         n_remainder := n_remainder - 10;
      end loop;
      quotient <= n_quotient;
      remainder <= n_remainder;
   end process;

   
 --push1,push3(입력)와 state(count_369로 결정)비교해 맞으면 cor=0, 아무것도 안누르거나 틀리면 cor=1, correct로 전달                 
   process(FPGA_RSTB, quotient, remainder) 
   begin
      if FPGA_RSTB='0' then
         state <= '1';             
      elsif situation = "01" then  
         
         if (remainder = 3 or remainder = 6 or remainder = 9) or (quotient = 3 or quotient = 6 or quotient = 9) then  
            state <= '0';
         else 
            state <='1';
         end if;
      end if;
   end process;
   --correct <=cor;
   --correct <=cor;
   
end Behavioral;