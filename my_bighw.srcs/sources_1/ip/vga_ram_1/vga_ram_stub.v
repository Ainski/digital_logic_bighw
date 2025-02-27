// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.2 (win64) Build 1577090 Thu Jun  2 16:32:40 MDT 2016
// Date        : Sun Jan 05 00:14:20 2025
// Host        : Nicolas-ainski running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               E:/model/my_bighw/my_bighw.srcs/sources_1/ip/vga_ram_1/vga_ram_stub.v
// Design      : vga_ram
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_3_3,Vivado 2016.2" *)
module vga_ram(clka, ena, wea, addra, dina, clkb, enb, addrb, doutb)
/* synthesis syn_black_box black_box_pad_pin="clka,ena,wea[0:0],addra[18:0],dina[8:0],clkb,enb,addrb[18:0],doutb[8:0]" */;
  input clka;
  input ena;
  input [0:0]wea;
  input [18:0]addra;
  input [8:0]dina;
  input clkb;
  input enb;
  input [18:0]addrb;
  output [8:0]doutb;
endmodule
