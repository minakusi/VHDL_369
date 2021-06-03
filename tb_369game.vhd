LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY game_tb IS
END game_tb;
 
ARCHITECTURE behavior OF game_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT totalgame
    PORT(
         FPGA_RSTB : IN  std_logic;
         FPGA_CLK : IN  std_logic;
         load_plus : IN  std_logic;
         load_minus : IN  std_logic;
         load_game : IN  std_logic;
         load_operand1 : IN  std_logic;
         load_operand2 : IN  std_logic;
         DIGIT : OUT  std_logic_vector(6 downto 1);
         SEG_A : OUT  std_logic;
         SEG_B : OUT  std_logic;
         SEG_C : OUT  std_logic;
         SEG_D : OUT  std_logic;
         SEG_E : OUT  std_logic;
         SEG_F : OUT  std_logic;
         SEG_G : OUT  std_logic;
         SEG_DP : OUT  std_logic;
         LCD_A : OUT  std_logic_vector(1 downto 0);
         LCD_EN : OUT  std_logic;
         LCD_D : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal FPGA_RSTB : std_logic := '0';
   signal FPGA_CLK : std_logic := '0';
   signal load_plus : std_logic := '0';
   signal load_minus : std_logic := '0';
   signal load_game : std_logic := '0';
   signal load_operand1 : std_logic := '0';
   signal load_operand2 : std_logic := '0';

    --Outputs
   signal DIGIT : std_logic_vector(6 downto 1);
   signal SEG_A : std_logic;
   signal SEG_B : std_logic;
   signal SEG_C : std_logic;
   signal SEG_D : std_logic;
   signal SEG_E : std_logic;
   signal SEG_F : std_logic;
   signal SEG_G : std_logic;
   signal SEG_DP : std_logic;
   signal LCD_A : std_logic_vector(1 downto 0);
   signal LCD_EN : std_logic;
   signal LCD_D : std_logic_vector(7 downto 0);
	--signal playernumber : integer range 2 to 4;
   -- Clock period definitions
   constant FPGA_CLK_period : time := 250 ns;
 
BEGIN
 
   -- Instantiate the Unit Under Test (UUT)
   uut: totalgame PORT MAP (
          FPGA_RSTB => FPGA_RSTB,
          FPGA_CLK => FPGA_CLK,
          load_plus => load_plus,
          load_minus => load_minus,
          load_game => load_game,
          load_operand1 => load_operand1,
          load_operand2 => load_operand2,
          DIGIT => DIGIT,
          SEG_A => SEG_A,
          SEG_B => SEG_B,
          SEG_C => SEG_C,
          SEG_D => SEG_D,
          SEG_E => SEG_E,
          SEG_F => SEG_F,
          SEG_G => SEG_G,
          SEG_DP => SEG_DP,
          LCD_A => LCD_A,
          LCD_EN => LCD_EN,
          LCD_D => LCD_D
			 --playernumber => playernumber
        );

   -- Clock process definitions
   FPGA_CLK_process :process
   begin
      FPGA_CLK <= '0';
      wait for FPGA_CLK_period/2;
      FPGA_CLK <= '1';
      wait for FPGA_CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin      
		
		load_plus <= '1';
		load_minus <= '1';
		load_game <= '1';
		load_operand1 <= '1';
		load_operand2 <= '1';
      wait for 10 ms;   
		
      FPGA_RSTB <= '1';
      wait for 1600 ms;
      load_plus <= '0';				-- 3p 
      wait for 500 ms;
      load_plus <= '1';			
      wait for 1000 ms;
      load_plus <= '0';				-- 4p
      wait for 500 ms;
      load_plus <= '1';
      wait for 1000 ms;
      load_minus <= '0';			-- 3p 
      wait for 500 ms;
      load_minus <= '1';
		wait for 1000 ms;
		
		load_game <= '0';				-- game start
		wait for 500 ms;
		load_game <= '1';
		
		wait for 2000 ms;
		
      load_operand1 <= '0';		-- 1p correct
      wait for 100 ms;
      load_operand1 <= '1';
		wait for 2000 ms;
		
      load_operand2 <= '0';		-- 2p wrong
      wait for 100 ms;
      load_operand2 <= '1';
		wait for 2000 ms;
		
      load_operand2 <= '0'; 		-- 3p correct
      wait for 100 ms;
      load_operand2 <= '1';
      
      wait;


   end process;

END;