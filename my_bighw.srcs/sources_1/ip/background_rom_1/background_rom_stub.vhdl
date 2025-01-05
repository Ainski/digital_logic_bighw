-- Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2016.2 (win64) Build 1577090 Thu Jun  2 16:32:40 MDT 2016
-- Date        : Fri Jan 03 22:02:02 2025
-- Host        : Nicolas-ainski running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               e:/model/my_bighw/my_bighw.srcs/sources_1/ip/background_rom_1/background_rom_stub.vhdl
-- Design      : background_rom
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a100tcsg324-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity background_rom is
  Port ( 
    clka : in STD_LOGIC;
    ena : in STD_LOGIC;
    addra : in STD_LOGIC_VECTOR ( 18 downto 0 );
    douta : out STD_LOGIC_VECTOR ( 8 downto 0 )
  );

end background_rom;

architecture stub of background_rom is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clka,ena,addra[18:0],douta[8:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "blk_mem_gen_v8_3_3,Vivado 2016.2";
begin
end;
