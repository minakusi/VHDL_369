library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity totalgame is
   Port ( FPGA_RSTB : in  STD_LOGIC;
          FPGA_CLK : in  STD_LOGIC;
          load_plus : in STD_LOGIC;
          load_minus : in STD_LOGIC;
          load_game : in STD_LOGIC;
          load_operand1: in STD_LOGIC;                  -- PUSH 1
          load_operand2: in STD_LOGIC;               -- PUSH 3
          DIGIT : out std_logic_vector( 6 downto 1 ); 
          SEG_A : out std_logic;                      
          SEG_B : out std_logic;
          SEG_C : out std_logic;
          SEG_D : out std_logic;
          SEG_E : out std_logic;
          SEG_F : out std_logic;
          SEG_G : out std_logic;
          SEG_DP : out std_logic;
          LCD_A : OUT std_logic_vector (1 downto 0);  -- RS,RW를 signal
          LCD_EN : OUT std_logic;                     -- LCD Enable
          LCD_D : OUT std_logic_vector (7 downto 0); -- LCD data
          playernum: IN std_logic_vector (3 downto 0)
          );
end totalgame;

architecture Behavioral of totalgame is
   
   component game_369 is
      Port ( 
           state : out STD_LOGIC;
           FPGA_RSTB : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           load_operand1 :in  STD_LOGIC;
           load_operand2 :in  STD_LOGIC;
           situation : in std_logic_vector (1 downto 0);                                                     
           cnt_369 : in integer range 1 to 100); 
   end component;
   
   component timelimit_369 is
     Port ( 
            state : in std_logic;
            FPGA_RSTB : in  STD_LOGIC;
           FPGA_CLK : in  STD_LOGIC;
           --cor: in STD_LOGIC; 
           PUSH1: in STD_LOGIC;
           PUSH3: in STD_LOGIC;
           w_enable: in STD_LOGIC;
           player_num: in integer range 2 to 4;   
           restime: out integer range 0 to 3;
           data_out: out STD_LOGIC;           
           data: out integer range 0 to 255;
			  score_turn : out integer range 0 to 3;
           player: out integer range 0 to 3;
           count_369 : out integer range 0 to 100; 
           situation : in std_logic_vector (1 downto 0)); 
   end component;
   
   component led is
      Port ( 
            winner : in integer range 0 to 3;
            rst_n : in std_logic; 
            clk : in std_logic;  
            t : in integer range 0 to 3;                   
            num_player : in integer range 2 to 4;        
            count_369 : in integer range 1 to 99;     
            DIGIT : out std_logic_vector( 6 downto 1 ); 
            SEG_A : out std_logic;                      
            SEG_B : out std_logic;
            SEG_C : out std_logic;
            SEG_D : out std_logic;
            SEG_E : out std_logic;
            SEG_F : out std_logic;
            SEG_G : out std_logic;
            SEG_DP : out std_logic;
            situation : in std_logic_vector(1 downto 0));
   end component;
   
   component lcd is
      port (
				score_turn: IN integer range 0 to 3;
            winner : out integer range 0 to 3;
            w_enable : out std_logic;

            PUSH1 : in std_logic;
            PUSH3 : in std_logic;
            FPGA_RSTB : IN std_logic;                    -- Reset
            FPGA_CLK : IN std_logic;                     -- FPFA clock
            load_plus : in std_logic;                    -- + button
            load_minus : in std_logic;                   -- - button
            load_game : in std_logic;                    -- game start button (PUSH3)
            count_369: in integer range 0 to 100;          -- 369 숫자 
            num_player : in integer range 2 to 4;         -- player 수
            t : in integer range 0 to 3;
            player : in integer range 0 to 3;            -- 현재 player (서연 코드)
            data : in integer range 0 to 255;            -- 현재 player의 점수 (서연 코드)
            LCD_A : OUT std_logic_vector (1 downto 0);   -- RS,RW를 signal
            LCD_EN : OUT std_logic;                      -- LCD Enable
            LCD_D : OUT std_logic_vector (7 downto 0);   -- LCD data
            situation : in std_logic_vector (1 downto 0));
   end component;
   
   signal num: integer range 0 to 100;
   signal correct: STD_LOGIC;
   signal pn: integer range 2 to 4;
   signal pn_test: integer range 2 to 4; 
   signal num_player: integer range 2 to 4;
   signal w_enable_reg, data_out_reg: STD_LOGIC;
   signal t: integer range 0 to 3;
   signal data: integer range 0 to 255;
   signal p: integer range 0 to 3;
   signal sit : std_logic_vector (1 downto 0);
   signal s : std_logic;
   signal winner : integer range 0 to 3;
	signal score_turn: integer range 0 to 3;
   
   
begin

   game369: game_369 port map(s, FPGA_RSTB, FPGA_CLK, load_operand1, load_operand2, sit, num);
   timelimit369: timelimit_369 port map(s, FPGA_RSTB, FPGA_CLK, load_operand1, load_operand2, w_enable_reg, pn, t, data_out_reg, data, score_turn, p, num, sit);
   led_display : led port map(winner, FPGA_RSTB, FPGA_CLK, t, pn, num, DIGIT, SEG_A, SEG_B, SEG_C, SEG_D, SEG_E, SEG_F, SEG_G, SEG_DP, sit);
   lcd_display : lcd port map(score_turn, winner, w_enable_reg, load_operand1, load_operand2, FPGA_RSTB, FPGA_CLK, load_plus, load_minus, load_game, num, pn, t, p, data, LCD_A, LCD_EN, LCD_D, sit);
   
      process(FPGA_RSTB, load_plus, load_minus, load_game)
      begin
         if FPGA_RSTB = '0' then
            pn <= 2;      
            sit <= "00";            -- 초기 상황
            
         elsif (sit = "00" and load_game = '0') then               -- situation = "01"(초기 상황)
               pn <= conv_integer(playernum);
               sit <= "01";
         
         elsif num = 40 then
               sit <= "10";               -- 게임 종료 화면
         end if;
      end process;
      num_player <= pn;
end Behavioral;