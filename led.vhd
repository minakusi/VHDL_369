library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;
 
entity led is 
Port ( 
      winner : in integer range 0 to 3;
      rst_n : in std_logic; 
      clk : in std_logic;  
      t : in integer range 0 to 3;                   -- ���� �ڵ忡�� ��
      num_player : in integer range 2 to 4;        -- player �� ���� �޾ƿ´�. 
      count_369 : in integer range 0 to 100;       -- �Ը� �ڵ忡�� ��
      
      DIGIT : out std_logic_vector( 6 downto 1 ); --����Ϸ��� ����
      SEG_A : out std_logic;                      --7segment
      SEG_B : out std_logic;
      SEG_C : out std_logic;
      SEG_D : out std_logic;
      SEG_E : out std_logic;
      SEG_F : out std_logic;
      SEG_G : out std_logic;
      SEG_DP : out std_logic;
      
      situation : in std_logic_vector(1 downto 0));
end led;
 
architecture Behavioral of led is  
   signal sel : std_logic_vector( 2 downto 0);  --   �ڸ�
   signal data : std_logic_vector( 4 downto 0); -- 16���� ���� �� time count
   signal seg : std_logic_vector( 7 downto 0);  --   ���׸�Ʈ
   signal bin_to_hex_0 : std_logic_vector(7 downto 0);
   --signal t : integer range 0 to 3;

begin
  process(rst_n, clk, t)    -- ���� ���� �� time�� �޶��� �� ���� �� process
   begin
      if (rst_n = '0') then
      --00���·� ���ư���
      elsif rising_edge(clk) then   -- �ʱ� ��Ȳ�� ���
         if situation = "00" then
            case sel is
               when "000" =>
                  DIGIT <= "000001";   
                  data <= "10001";   --H
               when "001" =>
                  DIGIT <= "000010";
                  data <= "01110";   --E
               when "010" =>
                  DIGIT <= "000100";
                  data <= "10011";   --L
               when "011" =>
                  DIGIT <= "001000";
                  data <= "10011";   --L
               when "100" =>
                  DIGIT <= "010000";
                  data <= "00000";   --O
               when others => null;
            end case;

      
         elsif situation  = "01" then                                                -- ���� ���� �� time�� ���� ���
            bin_to_hex_0 <= std_logic_vector(to_unsigned(count_369, 8));				 -- ���ڸ� 16������
            case sel is       
               when "000" =>                            --369���� 10���ڸ�
                  DIGIT <= "000001";
                  if count_369 = 0 and t = 3 then		  -- �غ� �� �϶�
                     data <= "00011";
                  elsif count_369 = 0 and t < 3 then
                     data <= "11000";
                  else               						  -- ���� ��¥ ����
                     data <= '0' & bin_to_hex_0(7 downto 4);         
                  end if;
               when "001" =>                            --369���� 1���ڸ�
                  DIGIT <= "000010"; 
                  if count_369 = 0 then					  -- �غ� �� �϶�
                     data <= "11000";
                  else											  -- ���� ��¥ ����
                     data <= '0' & bin_to_hex_0(3 downto 0);     
                  end if;
               when "010" =>                            --����
                  DIGIT <= "000100";   
                  if count_369 = 0 and t = 2 then		  -- �غ� �� �϶�
                     data <= "00010";
                  else											  -- ���� ��¥ ����
                     data <= "11000";
                  end if;
               when "011" =>
                  DIGIT <= "001000";
                  if count_369 = 0 then					  -- �غ� �� �϶�
                     data <= "11000";
                  elsif(t = 3) then                     -- ���� ��¥ ���� �� ���� ���� �ð� ǥ��
                     data <= "10000";
                  else                   
                     data <= "11000";
                  end if;
               when "100" =>
						DIGIT <= "010000";
                  if count_369 = 0 and t = 1 then		  -- �غ� �� �϶�                   
                     data <= "00001";
                     
                  elsif(t = 3 or t = 2) then            -- ���� ��¥ ���� �� ���� ���� �ð� ǥ��               
                     data <= "10000";
                  else                  
                     data <= "11000";
                  end if;
               when "101" =>  
						DIGIT <= "100000";
                  if count_369 = 0 then					  -- �غ� �� �϶�                    
                     data <= "11000";
                     
                  elsif(t = 1 or t = 2 or t = 3) then   -- ���� ��¥ ���� �� ���� ���� �ð� ǥ��          
                     data <= "10000";    
                  else               
                     data <= "11000";   
                  end if;
               when others => null; 
            end case;
            
         elsif situation = "10" then	 -- ���� ����
            case sel is
               when "000" =>
                  DIGIT <= "000001";   
                  data <= "00001";      --1
               when "001" =>
                  DIGIT <= "000010";
                  data <= "00101";      --S
               when "010" =>
                  DIGIT <= "000100";
                  data <= "10100";      --t
               when "011" => 
                  DIGIT <= "001000";
                  data <= "10000";      ---
               when "100" => 
                  DIGIT <= "010000";   
                  if winner = 0 then
                     data <= "00001";      --(1�� player number)
                  elsif winner = 1 then
                     data <= "00010";
                  elsif winner = 2 then
                     data <= "00011";
                  elsif winner = 3 then
                     data <= "00100";
                  end if;
               when "101" => 
                  DIGIT <= "100000";
                  data <= "10101";      --P
               when others => null;
            end case;
         end if;
       end if;
   end process;
                                                                   

   process( rst_n, clk )                                       -- 50us(sel��ȭ)���� 7segment�� �� �ڸ��� ��Ÿ����.
      variable seg_clk_cnt : integer range 0 to 200; 
   begin
      if( rst_n = '0' ) then 
         sel <= "000";
         seg_clk_cnt := 0;
      elsif( clk'event and clk='1' ) then 
         if( seg_clk_cnt = 200 ) then 
            seg_clk_cnt := 0;
            if( sel = "101" ) then 
               sel <= "000";
            else
               sel <= sel + 1;
            end if;
         else 
            seg_clk_cnt := seg_clk_cnt + 1;
         end if;
      end if;
   end process;
   
   
   process (data)                                            --�ǽ��� ������, segment�� ��Ÿ���ִ� �ڵ�  
   begin
      case data is 
      -----------16���� ���� ǥ��------------
         when "00000" => seg <= "00111111"; --0
         when "00001" => seg <= "00000110"; --1 
         when "00010" => seg <= "01011011"; --2
         when "00011" => seg <= "01001111"; --3
         when "00100" => seg <= "01100110"; --4
         when "00101" => seg <= "01101101"; --5
         when "00110" => seg <= "01111101"; --6
         when "00111" => seg <= "00100111"; --7
         when "01000" => seg <= "01111111"; --8
         when "01001" => seg <= "01101111"; --9
         when "01010" => seg <= "01110111"; --a
         when "01011" => seg <= "01111100"; --b
         when "01100" => seg <= "01011000"; --c
         when "01101" => seg <= "01011110"; --d
         when "01110" => seg <= "01111001"; --E
         when "01111" => seg <= "01110001"; --F
      -----------time count ǥ��------------
         when "10000" => seg <= "01000000"; ---
      -----------���� ǥ��-------------------
         when "11000" => seg <= "00000000"; --
      -----------���ĺ� ǥ��-----------------
         when "10001" => seg <= "01110110"; --H
         when "10011" => seg <= "00111000"; --L
         when "10100" => seg <= "01111000"; --t
         when "10101" => seg <= "01110011"; --P
         when others => seg <= "00000000"; 
      end case;
   end process;
   
   SEG_A <= seg( 0 );
   SEG_B <= seg( 1 );
   SEG_C <= seg( 2 );
   SEG_D <= seg( 3 );
   SEG_E <= seg( 4 );
   SEG_F <= seg( 5 );
   SEG_G <= seg( 6 );
   SEG_DP <= seg( 7 );
   
End behavioral;