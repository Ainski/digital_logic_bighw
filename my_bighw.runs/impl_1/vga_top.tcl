proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}

set_msg_config -id {Common 17-41} -limit 10000000

start_step init_design
set rc [catch {
  create_msg_db init_design.pb
  set_property design_mode GateLvl [current_fileset]
  set_param project.singleFileAddWarning.threshold 0
  set_property webtalk.parent_dir E:/model/my_bighw/my_bighw.cache/wt [current_project]
  set_property parent.project_path E:/model/my_bighw/my_bighw.xpr [current_project]
  set_property ip_repo_paths e:/model/my_bighw/my_bighw.cache/ip [current_project]
  set_property ip_output_repo e:/model/my_bighw/my_bighw.cache/ip [current_project]
  set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
  add_files -quiet E:/model/my_bighw/my_bighw.runs/synth_1/vga_top.dcp
  add_files -quiet e:/model/my_bighw/my_bighw.srcs/sources_1/ip/vga_ram_1/vga_ram.dcp
  set_property netlist_only true [get_files e:/model/my_bighw/my_bighw.srcs/sources_1/ip/vga_ram_1/vga_ram.dcp]
  add_files -quiet e:/model/my_bighw/my_bighw.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.dcp
  set_property netlist_only true [get_files e:/model/my_bighw/my_bighw.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.dcp]
  add_files -quiet E:/model/my_bighw/my_bighw.srcs/sources_1/ip/background_rom/background_rom.dcp
  set_property netlist_only true [get_files E:/model/my_bighw/my_bighw.srcs/sources_1/ip/background_rom/background_rom.dcp]
  read_xdc -mode out_of_context -ref vga_ram -cells U0 e:/model/my_bighw/my_bighw.srcs/sources_1/ip/vga_ram_1/vga_ram_ooc.xdc
  set_property processing_order EARLY [get_files e:/model/my_bighw/my_bighw.srcs/sources_1/ip/vga_ram_1/vga_ram_ooc.xdc]
  read_xdc -mode out_of_context -ref clk_wiz_0 -cells inst e:/model/my_bighw/my_bighw.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_ooc.xdc
  set_property processing_order EARLY [get_files e:/model/my_bighw/my_bighw.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_ooc.xdc]
  read_xdc -prop_thru_buffers -ref clk_wiz_0 -cells inst e:/model/my_bighw/my_bighw.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_board.xdc
  set_property processing_order EARLY [get_files e:/model/my_bighw/my_bighw.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_board.xdc]
  read_xdc -ref clk_wiz_0 -cells inst e:/model/my_bighw/my_bighw.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xdc
  set_property processing_order EARLY [get_files e:/model/my_bighw/my_bighw.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xdc]
  read_xdc -mode out_of_context -ref background_rom -cells U0 e:/model/my_bighw/my_bighw.srcs/sources_1/ip/background_rom/background_rom_ooc.xdc
  set_property processing_order EARLY [get_files e:/model/my_bighw/my_bighw.srcs/sources_1/ip/background_rom/background_rom_ooc.xdc]
  read_xdc E:/model/my_bighw/my_bighw.srcs/constrs_1/new/vga_test_xdc.xdc
  link_design -top vga_top -part xc7a100tcsg324-1
  write_hwdef -file vga_top.hwdef
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
}

start_step opt_design
set rc [catch {
  create_msg_db opt_design.pb
  opt_design 
  write_checkpoint -force vga_top_opt.dcp
  report_drc -file vga_top_drc_opted.rpt
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
}

start_step place_design
set rc [catch {
  create_msg_db place_design.pb
  implement_debug_core 
  place_design 
  write_checkpoint -force vga_top_placed.dcp
  report_io -file vga_top_io_placed.rpt
  report_utilization -file vga_top_utilization_placed.rpt -pb vga_top_utilization_placed.pb
  report_control_sets -verbose -file vga_top_control_sets_placed.rpt
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
}

start_step route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  write_checkpoint -force vga_top_routed.dcp
  report_drc -file vga_top_drc_routed.rpt -pb vga_top_drc_routed.pb
  report_timing_summary -warn_on_violation -max_paths 10 -file vga_top_timing_summary_routed.rpt -rpx vga_top_timing_summary_routed.rpx
  report_power -file vga_top_power_routed.rpt -pb vga_top_power_summary_routed.pb -rpx vga_top_power_routed.rpx
  report_route_status -file vga_top_route_status.rpt -pb vga_top_route_status.pb
  report_clock_utilization -file vga_top_clock_utilization_routed.rpt
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
}

