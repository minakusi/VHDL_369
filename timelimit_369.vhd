library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--�Է�: cor(���俩��. game_369����), player_num(�÷��̾� ����.��𿡼�??)
--���: restime(t. LED��),data,player,data_out(�� �÷��̾� ����. LCD��)
entity timelimit_369 is
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
end timelimit_369;

architecture Behavioral of timelimit_369 is
   
   signal turn: integer range 0 to 3;
   signal t: integer range 0 to 3;
   signal s01_clk: STD_LOGIC;
   signal half_clk: STD_LOGIC;
   signal cnt_369 : integer range 0 to 100;
   signal cor: STD_LOGIC; 
   type score is array (0 to 3) of integer range 0 to 255;
   signal score_arr: score;
   
      
begin   
   --0.5�� �ֱ��� half_clk����
   process(FPGA_RSTB, FPGA_CLK)
      variable count_clk: integer range 0 to 1000000; 
   begin
      if(FPGA_RSTB = '0') then 
         half_clk <= '1';
         count_clk := 0;
      elsif rising_edge(FPGA_CLK) then
         if(count_clk = 1000000) then 
            count_clk := 0; 
            half_clk <= not half_clk; 
         else 
            count_clk := count_clk + 1; 
            half_clk<= half_clk; 
         end if;
      end if;
   end process;
   
   --��ư�� ���� ���: turn��ȭ, time<=3, ��ư�� ������ ���� ���: 1�ʸ��� time������ time=0�̸� turn��ȭ, time <=3
   -- ��ư �����ų�, �ð��ʰ��Ǵ� ��� ���� situation, count_369�����ǵ���.
   -- score �ٲٱ�
   process(FPGA_RSTB, half_clk)
   begin     
      if(FPGA_RSTB = '0') then
         t <= 3;
         turn <= 0;
         cnt_369 <= 0;
         for i in 0 to 3 loop
            score_arr(i) <= 0;
         end loop;
         cor <= '1';
      elsif situation = "01" then            
         if rising_edge(half_clk) then
				if cnt_369 = 0 and t = 0 then
					cnt_369 <= 1;
					t <= 3;
				
				else	
					if (PUSH1 = '0' or PUSH3 = '0') then          -- ��ư ������ �� ���� 
						if PUSH3='0' then      
            
							if state='0' then 
								cor <= '1';  -- ����
							else 
								cor <= '0';  -- Ʋ��
							end if;
                  
						elsif PUSH1='0' then   
                  
							if state='0' then 
								cor <= '0';
							else            
								cor <= '1';                        
							end if;
						end if;
                  
						if(cor = '1' and t > 2) then 
							score_arr(turn) <= score_arr(turn) + 5;
               
						elsif(cor = '1' and t > 1) then 
							score_arr(turn) <= score_arr(turn) + 3;
               
						elsif(cor = '1' and t > 0) then 
							score_arr(turn) <= score_arr(turn) + 1;
               
						elsif(cor = '0') then 
							if score_arr(turn) > 3 then
								score_arr(turn) <= score_arr(turn) - 3;
							else
								score_arr(turn) <= 0;
							end if;               
						end if;
						
						if(turn = player_num - 1) then         
							turn <= 0;
						else
							turn <= turn + 1;                         -- ���� �÷��̾�� �Ѱ��ֱ�
						end if;
						t <= 3;                                     -- ���� �ð� �ʱ�ȭ
						cnt_369 <= cnt_369 + 1;
					elsif(t = 0) then                             -- �ð� �ʰ����� �� ����
						if score_arr(turn) > 2 then
							score_arr(turn) <= score_arr(turn) - 2;
						else
							score_arr(turn) <= 0;
						end if;

						if(turn = player_num - 1) then
							turn <= 0;
						else
							turn <= turn + 1;                      -- ���� �÷��̾�� �Ѱ��ֱ�
						end if; 
						t <= 3;                                  -- ���� �ð� �ʱ�ȭ              
						cnt_369 <= cnt_369 + 1;                -- count ����
                      
					else
						t <= t - 1; 
					end if;
				end if;
			end if;
		end if;
   end process;
   count_369 <= cnt_369; 
   
   --LCD��: data,player,data_out�ѱ��.
   process(FPGA_RSTB, FPGA_CLK)
		variable tur : integer range 0 to 3;
   begin
      if(FPGA_RSTB = '0') then
      elsif rising_edge(FPGA_CLK) then
         if tur = player_num then
				tur := 0;
			else
				tur := tur + 1;
			end if;
			score_turn <= tur;
			data <= score_arr(tur);
			if w_enable = '1' then
            player <= turn;
			end if;
		end if;
   end process;
   
   -- LED��: time�ѱ��.
   restime <= t;
   
end Behavioral;