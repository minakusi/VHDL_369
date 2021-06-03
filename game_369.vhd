
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


--�Է�: reset,clk,push1, push2,
--���: situation(100������ 10����), correct(timelimit���� ������0, Ʋ����1����), count_369(369�� ����) 
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
   --signal turn: integer range 0 to 3; --- ���� �ۼ��ڵ�� �̾���

begin
  
 --quotient�� 10���ڸ�, remainder�� 1���ڸ� 
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

   
 --push1,push3(�Է�)�� state(count_369�� ����)���� ������ cor=0, �ƹ��͵� �ȴ����ų� Ʋ���� cor=1, correct�� ����                 
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