onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+vga_ram -L unisims_ver -L unimacro_ver -L secureip -L xil_defaultlib -L xpm -L blk_mem_gen_v8_3_3 -O5 xil_defaultlib.vga_ram xil_defaultlib.glbl

do {wave.do}

view wave
view structure
view signals

do {vga_ram.udo}

run -all

endsim

quit -force
