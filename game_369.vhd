library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


--입력: reset,clk,push1, push2,
--출력: situation(40넘으면 10전달), correct(timelimit으로 맞으면0, 틀리면1전달), count_369(369값 전달) 
entity game_369 is
    Port ( 
           state : out STD_LOGIC;
           FPGA_RSTB : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           load_operand1 :in  STD_LOGIC;
           load_operand2 :in  STD_LOGIC;
           situation : in std_logic_vector (1 downto 0);                                                     
           cnt_369 : in integer range 0 to 100); 
end game_369;

architecture Behavioral of game_369 is

   signal quotient: integer := 0;
   signal remainder: integer := 0;

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

   
 --숫자에 3, 6, 9 들어있는지 확인 state로 전달                 
   process(FPGA_RSTB, quotient, remainder) 
   begin
      if FPGA_RSTB='0' then
         state <= '1';
			
      elsif situation = "01" then  -- 게임 중         
         if (remainder = 3 or remainder = 6 or remainder = 9) or (quotient = 3 or quotient = 6 or quotient = 9) then -- 숫자 안에 3, 6, 9 포함이면  
            state <= '0';
         else 
            state <='1';
         end if;
      end if;
   end process;
   
end Behavioral;