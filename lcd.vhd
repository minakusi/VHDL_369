library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;


entity lcd is
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
      count_369: in integer range 1 to 100;          -- 369 숫자 
      num_player : in integer range 2 to 4;         -- player 수
      t : in integer range 0 to 3;
      player : in integer range 0 to 3;            -- 현재 player (서연 코드)
      data : in integer range 0 to 255;            -- 현재 player의 점수 (서연 코드)
      
      LCD_A : OUT std_logic_vector (1 downto 0);   -- RS,RW를 signal
      LCD_EN : OUT std_logic;                      -- LCD Enable
      LCD_D : OUT std_logic_vector (7 downto 0);   -- LCD data
      situation : in std_logic_vector (1 downto 0));

end lcd;


architecture Behavioral of lcd is
   signal load_100k : std_logic;
   signal clk_100k : std_logic;                        -- 100 KHz clock
   signal cnt_100k : std_logic_vector (7 downto 0);
   signal load_50 : std_logic;
   signal clk_50 : std_logic;                            -- 50 Hz clock
   signal cnt_50 : std_logic_vector (11 downto 0);
   signal lcd_cnt : std_logic_vector (8 downto 0);     -- LCD count
   signal lcd_state : std_logic_vector (7 downto 0);     -- LCD (instruction(6)+ 32)
   signal lcd_db : std_logic_vector (7 downto 0);      -- LCD data
                          
   signal w_enable_reg : std_logic;
   type turn_array is array(0 to 3) of integer range 0 to 3;               -- player 차례 보여줌
   signal turn_arr : turn_array;
   
   type turn_cgram_array is array(0 to 3) of std_logic_vector(7 downto 0);  
   signal turn_cg : turn_cgram_array;
   
   type score_array is array(0 to 3) of integer range 0 to 255;            -- player의 score array
   signal score_arr : score_array;

   type scor_num_array is array(0 to 7) of std_logic_vector(7 downto 0);   -- score array cgram 주소 
   signal scor_cg : scor_num_array;   
   
   type rank_array is array(0 to 3) of integer range 0 to 4;               -- array of rank
   signal rank : rank_array;
  
   type reg is array (0 to 19) of std_logic_vector (7 downto 0);            -- register cgram 주소
   signal reg_cg : reg;
   
   signal max : integer := -1;
   signal int_to_bin : std_logic_vector(0 to 31);                           -- 가공할 때 필요한 시그널
   
   begin
   ----------------------------------------------------- clock 설정
      process(FPGA_RSTB,FPGA_CLK,load_100k,cnt_100k)   -- make 100k Hz clock
      begin
         if FPGA_RSTB = '0' then                        -- if reset button pushed
            cnt_100k <= (others => '0');               -- initialize counting
            clk_100k <= '0';                           -- initialize clock
         elsif rising_edge (FPGA_CLK) then            -- if clk in rising_edge
            if load_100k = '1' then                     -- if 100k Hz clk is made
               cnt_100k <= (others => '0');            -- initialize count 
               clk_100k <= not clk_100k;               -- clk 반전
            else                                       -- if 100k Hz is yet made
               cnt_100k <= cnt_100k + 1;               -- clk count 증가
            end if;
         end if;
      end process;
      load_100k <= '1' when (cnt_100k = X"13") else '0'; -- clk count 19번 이후 100kHz

      process(FPGA_RSTB,clk_100k,load_50,cnt_50)      -- make 50 Hz clock
      begin
         if FPGA_RSTB = '0' then                        -- if reset button pushed
            cnt_50 <= (others => '0');                  -- initialize counting
            clk_50 <= '0';                              -- initialize clock
         elsif rising_edge (clk_100k) then            -- if clk in rising edge
            if load_50 = '1' then                     -- if 50 Hz clock is made
               cnt_50 <= (others => '0');               -- initialize count
               clk_50 <= not clk_50;                  -- clk 반전
            else                                       -- if 50 Hz clock yet made
               cnt_50 <= cnt_50 + 1;                  -- clk count 증가
            end if;
         end if;
      end process;
      load_50 <= '1' when (cnt_50 = X"40") else '0'; -- clk count 999번 이후 50 Hz
   
      process(FPGA_RSTB,clk_50,lcd_cnt)
      begin
         if FPGA_RSTB = '0' then                        -- if reset button pushed
            lcd_cnt <= (others => '0');               -- initialize lcd count
         elsif rising_edge (clk_50) then               -- if clk in rising edge
            if (lcd_cnt >= "001001110") then -- 8610
               lcd_cnt <= "000001010";
            else
               lcd_cnt <= lcd_cnt + 1;
            end if;
         end if;
      end process;
      lcd_state <= lcd_cnt (8 downto 1);          --# max: 00101011 -- 8 bits

                  
------------------------------------------------------------------------------------------------------------------------      
      process( FPGA_RSTB, FPGA_clk)
         variable smaller_numbers : integer range 0 to 3 := 0;   -- rank
      begin
      if(FPGA_RSTB ='0') then                        
         for i in 0 to 3 loop
            turn_arr(i) <= 0;                        
            score_arr(i) <= 0;
            rank(i) <= 0;                           -- rank 0으로 초기화 
            turn_cg(i) <= X"20";                     -- turn_cg 공백으로 초기화 
            
         end loop;
         for i in 0 to 7 loop
            scor_cg(i) <= X"20";                     -- scor_cg 공백으로 초기화
         end loop;
         for i in 0 to 19 loop   
            reg_cg(i) <= X"20";                     -- reg_cg 공백으로 초기화
         end loop;
         
      elsif (FPGA_clk'event and FPGA_clk='1') then
         if situation >= "01" then
            score_arr(score_turn) <= data;                                 -- 한 player game할 때마다 score array 갱신됨
                     
            for i in 0 to 3 loop                                       -- integer score를 binary로 나타내기
               int_to_bin(8*i to 8*i+7)<= std_logic_vector(to_unsigned(score_arr(i), 8));
            end loop;
            
             if num_player = 4 then
               for i in 0 to 7 loop                                       -- 32 bit binary를 4 bit씩 끊어서 hexadecimal로 나타내기
                  if int_to_bin(4*i to 4*i + 3) >= "1010" then            -- 10보다 크면
                     scor_cg(i) <= int_to_bin(4*i to 4*i + 3) + X"37";    -- CGRAM에서 알파벳부터 찾기
                  else
                     scor_cg(i) <= int_to_bin(4*i to 4*i + 3) + X"30";    -- CGRAM에서 숫자부터 찾기
                  end if;
               end loop;
            elsif num_player = 3 then
               for i in 0 to 5 loop                                       -- 32 bit binary를 4 bit씩 끊어서 hexadecimal로 나타내기
                  if int_to_bin(4*i to 4*i + 3) >= "1010" then            -- 10보다 크면
                     scor_cg(i) <= int_to_bin(4*i to 4*i + 3) + X"37";    -- CGRAM에서 알파벳부터 찾기
                  else
                     scor_cg(i) <= int_to_bin(4*i to 4*i + 3) + X"30";    -- CGRAM에서 숫자부터 찾기
                  end if;
               end loop;
            elsif num_player = 2 then
               for i in 0 to 3 loop                                       -- 32 bit binary를 4 bit씩 끊어서 hexadecimal로 나타내기
                  if int_to_bin(4*i to 4*i + 3) >= "1010" then            -- 10보다 크면
                     scor_cg(i) <= int_to_bin(4*i to 4*i + 3) + X"37";    -- CGRAM에서 알파벳부터 찾기
                  else
                     scor_cg(i) <= int_to_bin(4*i to 4*i + 3) + X"30";    -- CGRAM에서 숫자부터 찾기
                  end if;
               end loop;
            end if;

            
            if (situation = "01") then
               turn_arr(0) <= player;                                  -- 현재 player num 받아서 turn arr 채움
               if num_player = 2 then
                  if player = 0 then
                     turn_arr(1) <= 1;
                  else
                     turn_arr(1) <= 0;
                  end if;
                  
               elsif num_player = 3 then
                  if player = 0 then
                     turn_arr(1) <= 1;
                     turn_arr(2) <= 2;
                  elsif player = 1 then
                     turn_arr(1) <= 2;
                     turn_arr(2) <= 0;
                  else
                     turn_arr(1) <= 0;
                     turn_arr(2) <= 1;
                  end if;
               
               else
                  if player = 0 then
                     turn_arr(1) <= 1;
                     turn_arr(2) <= 2;
                     turn_arr(3) <= 3;
                  elsif player = 1 then
                     turn_arr(1) <= 2;
                     turn_arr(2) <= 3;
                     turn_arr(3) <= 0;
                  elsif player = 2 then
                     turn_arr(1) <= 3;
                     turn_arr(2) <= 0;
                     turn_arr(3) <= 1;
                  else
                     turn_arr(1) <= 0;
                     turn_arr(2) <= 1;
                     turn_arr(3) <= 2;
                  end if;
               end if;
               
               for i in 0 to 3 loop 
                  turn_cg(i) <= std_logic_vector(to_unsigned(turn_arr(i), 8)) + X"31";
               end loop;
                  
               
            elsif (situation = "10") then                  -- game over
               if num_player = 2 then                       -- get rank
                  for i in 0 to 1 loop                       
                     for j in 0 to 1 loop            
                        if score_arr(i) < score_arr(j) then
                           smaller_numbers := smaller_numbers + 1;
                        end if;
                     end loop;
                     rank(i) <= smaller_numbers + 1;
                     smaller_numbers := 0;
                  end loop;
                     
               elsif num_player = 3 then
                  for i in 0 to 2 loop                       
                     for j in 0 to 2 loop            
                        if score_arr(i) < score_arr(j) then
                           smaller_numbers := smaller_numbers + 1;
                        end if;
                     end loop;
                     rank(i) <= smaller_numbers + 1;
                     smaller_numbers := 0;
                  end loop;   
               else
                  for i in 0 to 3 loop                      
                     for j in 0 to 3 loop            
                        if score_arr(i) < score_arr(j) then
                           smaller_numbers := smaller_numbers + 1;
                        end if;
                     end loop;
                     rank(i) <= smaller_numbers + 1;
                     smaller_numbers := 0;
                  end loop;
               end if;
   
               for i in 0 to 3 loop
                  if rank(i) = 1 then
                     winner <= i;
                     reg_cg(i * 5) <= std_logic_vector(to_unsigned(i, 8)) + X"31";
                     reg_cg(i * 5 + 1) <= X"3A";      -- :
                     reg_cg(i * 5 + 2) <= X"31";      -- 1
                     reg_cg(i * 5 + 3) <= X"53";      -- s
                     reg_cg(i * 5 + 4) <= X"54";      -- t
                  elsif (rank(i) = 2) then
                     reg_cg(i * 5) <= std_logic_vector(to_unsigned(i, 8)) + X"31";
                     reg_cg(i * 5 + 1) <= X"3A";      -- :   
                     reg_cg(i * 5 + 2) <= X"32";      -- 2
                     reg_cg(i * 5 + 3) <= X"4E";      -- n
                     reg_cg(i * 5 + 4) <= X"44";      -- d
                  elsif (rank(i) = 3) then
                     reg_cg(i * 5) <= std_logic_vector(to_unsigned(i, 8)) + X"31";
                     reg_cg(i * 5 + 1) <= X"3A";      -- :
                     reg_cg(i * 5 + 2) <= X"33";      -- 3
                     reg_cg(i * 5 + 3) <= X"52";      -- r
                     reg_cg(i * 5 + 4) <= X"44";      -- d
                  elsif (rank(i) = 4) then            -- rank = 4
                     reg_cg(i * 5) <= std_logic_vector(to_unsigned(i, 8)) + X"31";
                     reg_cg(i * 5 + 1) <= X"3A";      -- :   
                     reg_cg(i * 5 + 2) <= X"34";      -- 4
                     reg_cg(i * 5 + 3) <= X"54";      -- t
                     reg_cg(i * 5 + 4) <= X"48";      -- h
                  end if;
               end loop;
               
            end if; -- situation = "01", "10"
         end if;     -- situation >= "01"
      end if;        -- rst, clk
    end process;  

      
      w_enable_reg <= '0' when lcd_state < X"06" else '1';
      
      process(lcd_state, situation)                    -- 초기화 & data표현, turn 바뀔 때마다 lcd 바뀜
      begin
         ------------------------------------------- LCD 표시
         if (situation = "00") then                  -- 처음 화면
            case lcd_state is                        -- 각 lcd 자리에 따라 어떤 정보가 표시될지 나타냄
               when X"00" => lcd_db <= "00111000"; -- Function set
               when X"01" => lcd_db <= "00001000"; -- Display OFF
               when X"02" => lcd_db <= "00000001"; -- Display clear
               when X"03" => lcd_db <= "00000110"; -- Entry mode set
               when X"04" => lcd_db <= "00001100"; -- Display ON
               when X"05" => lcd_db <= "00000011"; -- Return Home (initialize finished)
               when X"06" => lcd_db <= X"20";       -- 
               when X"07" => lcd_db <= X"20";       --  
               when X"08" => lcd_db <= X"20";       --  
               when X"09" => lcd_db <= X"3C";       -- <
               when X"0A" => lcd_db <= X"33";       -- 3
               when X"0B" => lcd_db <= X"36";       -- 6
               when X"0C" => lcd_db <= X"39";       -- 9
               when X"0D" => lcd_db <= X"20";       --  
               when X"0E" => lcd_db <= X"47";       -- G : 01000111
               when X"0F" => lcd_db <= X"41";       -- A : 01000001
               when X"10" => lcd_db <= X"4D";       -- M : 01001101
               when X"11" => lcd_db <= X"45";       -- E : 01000101
               when X"12" => lcd_db <= X"3E";       -- > : 00111110
               when X"13" => lcd_db <= X"20";       -- 
               when X"14" => lcd_db <= X"20";       --
               when X"15" => lcd_db <= X"20";       -- 
               
               when X"16" => lcd_db <= X"C0";       -- Change Line
               when X"17" => lcd_db <= X"20";       -- 
               when X"18" => lcd_db <= X"20";       -- 
               when X"19" => lcd_db <= X"50";       -- P : 01010000
               when X"1A" => lcd_db <= X"4C";       -- L : 01001100
               when X"1B" => lcd_db <= X"41";       -- A : 01000001
               when X"1C" => lcd_db <= X"59";       -- Y : 01011001 
               when X"1D" => lcd_db <= X"45";       -- E : 01000101
               when X"1E" => lcd_db <= X"52";       -- R : 01010010
               when X"1F" => lcd_db <= X"3A";       -- : : 00111010
               when X"20" => lcd_db <= X"32";       -- 2 
               when X"21" => lcd_db <= X"50";       -- P : 01010000
               when X"22" => lcd_db <= X"2D";       -- - : 00101101
               when X"23" => lcd_db <= X"34";       -- 4 
               when X"24" => lcd_db <= X"50";       -- P : 01010000
               when X"25" => lcd_db <= X"20";       -- 
               when X"26" => lcd_db <= X"20";       -- 
               when others => lcd_db <= (others => '0'); -- 이외의 경우에는 space
            end case;
            
         elsif (situation = "01") then 
            if (num_player=2) then
                  case lcd_state is
                     when X"00" => lcd_db <= "00111000"; -- Function set
                     when X"01" => lcd_db <= "00001000"; -- Display OFF
                     when X"02" => lcd_db <= "00000001"; -- Display clear
                     when X"03" => lcd_db <= "00000110"; -- Entry mode set
                     when X"04" => lcd_db <= "00001100"; -- Display ON
                     when X"05" => lcd_db <= "00000011"; -- Return Home (initialize finished)
                     when X"06" => lcd_db <= turn_cg(0); -- 현재 player번호
                     when X"07" => lcd_db <= X"50";      -- p 
                     when X"08" => lcd_db <= scor_cg(2 * turn_arr(0));-- 점수 10의자리  
                     when X"09" => lcd_db <= scor_cg(2 * turn_arr(0) + 1);-- 점수 1의자리
                     when X"0A" => lcd_db <= X"20";       -- 
                     when X"0B" => lcd_db <= X"20";       -- 
                     when X"0C" => lcd_db <= X"20";       -- 
                     when X"0D" => lcd_db <= X"20";       --  
                     when X"0E" => lcd_db <= turn_cg(1);  -- 두 번째 player 번호 
                     when X"0F" => lcd_db <= X"50";       -- p
                     when X"10" => lcd_db <= scor_cg(2 * turn_arr(1));-- 점수 10의자리 
                     when X"11" => lcd_db <= scor_cg(2 * turn_arr(1) + 1);-- 점수 1의자리
                     when X"12" => lcd_db <= X"20";        -- 
                     when X"13" => lcd_db <= X"20";       --  
                     when X"14" => lcd_db <= X"20";       -- 
                     when X"15" => lcd_db <= X"20";       -- 
                  
                     when X"16" => lcd_db <= X"C0";       -- Change Line
                     when X"17" => lcd_db <= X"20";       -- 
                     when X"18" => lcd_db <= X"20";       -- 
                     when X"19" => lcd_db <= X"20";       -- 
                     when X"1A" => lcd_db <= X"20";       -- 
                     when X"1B" => lcd_db <= X"20";       -- 
                     when X"1C" => lcd_db <= X"20";       --  
                     when X"1D" => lcd_db <= X"20";       --
                     when X"1E" => lcd_db <= X"20";       -- 
                     when X"1F" => lcd_db <= X"20";        -- 
                     when X"20" => lcd_db <= X"20";       -- 
                     when X"21" => lcd_db <= X"20";        -- 
                     when X"22" => lcd_db <= X"20";        -- 
                     when X"23" => lcd_db <= X"20";       -- 
                     when X"24" => lcd_db <= X"20";       -- 
                     when X"25" => lcd_db <= X"20";       -- 
                     when X"26" => lcd_db <= X"20";       -- 
                     when others => lcd_db <= (others => '0'); -- 이외의 경우에는 space
                  end case;
               
               elsif (num_player = 3) then
                  case lcd_state is
                     when X"00" => lcd_db <= "00111000"; -- Function set 8 + 16 + 32 = 56 'h' 
                     when X"01" => lcd_db <= "00001000"; -- Display OFF  8 공백
                     when X"02" => lcd_db <= "00000001"; -- Display clear 1
                     when X"03" => lcd_db <= "00000110"; -- Entry mode set 6
                     when X"04" => lcd_db <= "00001100"; -- Display ON 12
                     when X"05" => lcd_db <= "00000011"; -- Return Home (initialize finished) 3
                     when X"06" => lcd_db <= turn_cg(0); -- 현재 player번호
                     when X"07" => lcd_db <= X"50";       -- p 
                     when X"08" => lcd_db <= scor_cg(2 * turn_arr(0));     -- 점수 10의자리  
                     when X"09" => lcd_db <= scor_cg(2 * turn_arr(0) + 1);-- 점수 1의자리
                     when X"0A" => lcd_db <= X"20";       -- 
                     when X"0B" => lcd_db <= X"20";       -- 
                     when X"0C" => lcd_db <= X"20";       -- 
                     when X"0D" => lcd_db <= X"20";       --  
                     when X"0E" => lcd_db <= turn_cg(1);  -- 두 번째 player 번호 
                     when X"0F" => lcd_db <= X"50";       -- p
                     when X"10" => lcd_db <= scor_cg(2 * turn_arr(1));-- 점수 10의자리 
                     when X"11" => lcd_db <= scor_cg(2 * turn_arr(1) + 1);-- 점수 1의자리
                     when X"12" => lcd_db <= X"20";        --  
                     when X"13" => lcd_db <= X"20";       --
                     when X"14" => lcd_db <= X"20";       -- 
                     when X"15" => lcd_db <= X"20";       -- 
                  
                     when X"16" => lcd_db <= X"C0";       -- Change Line
                     when X"17" => lcd_db <= X"20";       -- 
                     when X"18" => lcd_db <= X"20";       -- 
                     when X"19" => lcd_db <= X"20";       -- 
                     when X"1A" => lcd_db <= X"20";       -- 
                     when X"1B" => lcd_db <= X"20";       -- 
                     when X"1C" => lcd_db <= X"20";       --  
                     when X"1D" => lcd_db <= X"20";       --
                     when X"1E" => lcd_db <= X"20";       -- 
                     when X"1F" => lcd_db <= turn_cg(2);  -- 세 번째 player번호
                     when X"20" => lcd_db <= X"50";       -- p
                     when X"21" => lcd_db <= scor_cg(2 * turn_arr(2));-- 점수 10의자리  
                     when X"22" => lcd_db <= scor_cg(2 * turn_arr(2) + 1);-- 점수 1의자리
                     when X"23" => lcd_db <= X"20";       -- 
                     when X"24" => lcd_db <= X"20";       -- 
                     when X"25" => lcd_db <= X"20";       -- 
                     when X"26" => lcd_db <= X"20";       -- 
                     when others => lcd_db <= (others => '0'); -- 이외의 경우에는 space
                  end case;
            
            
               elsif (num_player = 4) then 
                  case lcd_state is
                     when X"00" => lcd_db <= "00111000"; -- Function set
                     when X"01" => lcd_db <= "00001000"; -- Display OFF
                     when X"02" => lcd_db <= "00000001"; -- Display clear
                     when X"03" => lcd_db <= "00000110"; -- Entry mode set
                     when X"04" => lcd_db <= "00001100"; -- Display ON
                     when X"05" => lcd_db <= "00000011"; -- Return Home (initialize finished)
                     when X"06" => lcd_db <= turn_cg(0); -- 현재 player번호
                     when X"07" => lcd_db <= X"50";       -- p 
                     when X"08" => lcd_db <= scor_cg(2 * turn_arr(0));-- 점수 10의자리  
                     when X"09" => lcd_db <= scor_cg(2 * turn_arr(0) + 1);-- 점수 1의자리
                     when X"0A" => lcd_db <= X"20";      -- 
                     when X"0B" => lcd_db <= X"20";       -- 
                     when X"0C" => lcd_db <= X"20";       -- 
                     when X"0D" => lcd_db <= X"20";       --  
                     when X"0E" => lcd_db <= turn_cg(1); -- 두 번째 player 번호 
                     when X"0F" => lcd_db <= X"50";       -- p
                     when X"10" => lcd_db <= scor_cg(2 * turn_arr(1));-- 점수 10의자리 
                     when X"11" => lcd_db <= scor_cg(2 * turn_arr(1) + 1);-- 점수 1의자리
                     when X"12" => lcd_db <= turn_cg(2); -- 세 번째 player 번호  
                     when X"13" => lcd_db <= X"50";       -- p 
                     when X"14" => lcd_db <= scor_cg(2 * turn_arr(2));-- 점수 10의자리
                     when X"15" => lcd_db <= scor_cg(2 * turn_arr(2) + 1);-- 점수 1의자리
                  
                     when X"16" => lcd_db <= X"C0";       -- Change Line
                     when X"17" => lcd_db <= X"20";       -- 
                     when X"18" => lcd_db <= X"20";       -- 
                     when X"19" => lcd_db <= X"20";       -- 
                     when X"1A" => lcd_db <= X"20";       -- 
                     when X"1B" => lcd_db <= X"20";       -- 
                     when X"1C" => lcd_db <= X"20";       --  
                     when X"1D" => lcd_db <= X"20";       --
                     when X"1E" => lcd_db <= X"20";       -- 
                     when X"1F" => lcd_db <= turn_cg(3); -- 네 번째 player번호
                     when X"20" => lcd_db <= X"50";       -- p
                     when X"21" => lcd_db <= scor_cg(2 * turn_arr(3)); -- 점수 10의자리  
                     when X"22" => lcd_db <= scor_cg(2 * turn_arr(3) + 1); -- 점수 1의자리
                     when X"23" => lcd_db <= X"20";       -- 
                     when X"24" => lcd_db <= X"20";       -- 
                     when X"25" => lcd_db <= X"20";       -- 
                     when X"26" => lcd_db <= X"20";       -- 
                     when others => lcd_db <= (others => '0'); -- 이외의 경우에는 space
                  end case;
               end if;
         elsif situation = "10" then
            case lcd_state is                        -- 각 lcd 자리에 따라 어떤 정보가 표시될지 나타냄
               when X"00" => lcd_db <= "00111000"; -- Function set
               when X"01" => lcd_db <= "00001000"; -- Display OFF
               when X"02" => lcd_db <= "00000001"; -- Display clear
               when X"03" => lcd_db <= "00000110"; -- Entry mode set
               when X"04" => lcd_db <= "00001100"; -- Display ON
               when X"05" => lcd_db <= "00000011"; -- Return Home (initialize finished)
               when X"06" => lcd_db <= reg_cg(0);-- 1
               when X"07" => lcd_db <= reg_cg(1);-- : 
               when X"08" => lcd_db <= reg_cg(2);-- number of rank
               when X"09" => lcd_db <= reg_cg(3);-- rank
               when X"0A" => lcd_db <= reg_cg(4);-- rank
               when X"0B" => lcd_db <= scor_cg(0);-- score (10의 자리 수)          
               when X"0C" => lcd_db <= scor_cg(1);-- score (1의 자리 수)  
               when X"0D" => lcd_db <= X"20";     
               when X"0E" => lcd_db <= reg_cg(5);-- 2
               when X"0F" => lcd_db <= reg_cg(6);-- :
               when X"10" => lcd_db <= reg_cg(7);-- number of rank
               when X"11" => lcd_db <= reg_cg(8);-- rank 
               when X"12" => lcd_db <= reg_cg(9);-- rank
               when X"13" => lcd_db <= scor_cg(2);-- score (10의 자리 수) 
               when X"14" => lcd_db <= scor_cg(3);-- score (1의 자리 수)
               when X"15" => lcd_db <= X"20";      -- 
               
               when X"16" => lcd_db <= X"C0";       -- Change Line
               when X"17" => lcd_db <= reg_cg(10);-- 3
               when X"18" => lcd_db <= reg_cg(11);-- :
               when X"19" => lcd_db <= reg_cg(12);-- number of rank
               when X"1A" => lcd_db <= reg_cg(13);-- rank
               when X"1B" => lcd_db <= reg_cg(14);-- rank
               when X"1C" => lcd_db <= scor_cg(4); -- score (10의 자리 수)
               when X"1D" => lcd_db <= scor_cg(5); -- score (1의 자리 수)
               when X"1E" => lcd_db <= X"20";       -- 
               when X"1F" => lcd_db <= reg_cg(15);-- 4
               when X"20" => lcd_db <= reg_cg(16);-- :
               when X"21" => lcd_db <= reg_cg(17);-- number of rank
               when X"22" => lcd_db <= reg_cg(18);-- rank
               when X"23" => lcd_db <= reg_cg(19);-- rank
               when X"24" => lcd_db <= scor_cg(6); -- score (10의 자리 수)
               when X"25" => lcd_db <= scor_cg(7); -- score (1의 자리 수)
               when X"26" => lcd_db <= X"20";       -- 
               when others => lcd_db <= (others => '0'); -- 이외의 경우에는 space
            end case;
         end if;
      end process;
   
   
   LCD_A(1) <= '0';            -- bit 1은 항상 '0'
   LCD_A(0) <= '0' when         -- initializing/change line 하는 중일 때만 read mode
         (lcd_state >= X"00" and lcd_state < X"06") or (lcd_state = X"16")
         else '1';            -- 나머지 상황에는 write mode
   LCD_EN <= not lcd_cnt(0);   -- 
   LCD_D <= lcd_db;            -- lcd_db에 저장된 data LCD_D에도 저장
   w_enable <= w_enable_reg;
   
end Behavioral;