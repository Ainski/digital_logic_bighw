@echo off
set xv_path=D:\\Vivado\\2016.2\\bin
call %xv_path%/xsim vga_top_tb_behav -key {Behavioral:sim_1:Functional:vga_top_tb} -tclbatch vga_top_tb.tcl -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
