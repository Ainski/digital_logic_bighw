onbreak {quit -f}
onerror {quit -f}

vsim -voptargs="+acc" -t 1ps -L unisims_ver -L unimacro_ver -L secureip -L xil_defaultlib -L xpm -L blk_mem_gen_v8_3_3 -lib xil_defaultlib xil_defaultlib.vga_ram xil_defaultlib.glbl

do {wave.do}

view wave
view structure
view signals

do {vga_ram.udo}

run -all

quit -force
