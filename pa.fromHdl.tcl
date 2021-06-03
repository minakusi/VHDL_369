
# PlanAhead Launch Script for Pre-Synthesis Floorplanning, created by Project Navigator

create_project -name final_project -dir "C:/Users/seoye/Xilinx/final_project_4/planAhead_run_3" -part xc3s200pq208-4
set_param project.pinAheadLayout yes
set srcset [get_property srcset [current_run -impl]]
set_property target_constrs_file "totalgame.ucf" [current_fileset -constrset]
set hdlfile [add_files [list {timelimit_369.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {led.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {lcd.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {game_369.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {totalgame.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set_property top totalgame $srcset
add_files [list {totalgame.ucf}] -fileset [get_property constrset [current_run]]
open_rtl_design -part xc3s200pq208-4
