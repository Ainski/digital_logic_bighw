set_property IOSTANDARD LVCMOS33 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports {b[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {b[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {b[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {b[0]}]
set_property PACKAGE_PIN D8 [get_ports {b[3]}]
set_property PACKAGE_PIN D7 [get_ports {b[2]}]
set_property PACKAGE_PIN C7 [get_ports {b[1]}]
set_property PACKAGE_PIN B7 [get_ports {b[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {g[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {g[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {g[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {g[0]}]
set_property PACKAGE_PIN A6 [get_ports {g[3]}]
set_property PACKAGE_PIN B6 [get_ports {g[2]}]
set_property PACKAGE_PIN A5 [get_ports {g[1]}]
set_property PACKAGE_PIN C6 [get_ports {g[0]}]
set_property PACKAGE_PIN A4 [get_ports {r[3]}]
set_property PACKAGE_PIN C5 [get_ports {r[2]}]
set_property PACKAGE_PIN B4 [get_ports {r[1]}]
set_property PACKAGE_PIN A3 [get_ports {r[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {r[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {r[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {r[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {r[0]}]
set_property PACKAGE_PIN J15 [get_ports clr_n]
set_property PACKAGE_PIN B11 [get_ports hsync]
set_property PACKAGE_PIN H17 [get_ports rdn]
set_property PACKAGE_PIN B12 [get_ports vsync]
set_property IOSTANDARD LVCMOS33 [get_ports clr_n]
set_property IOSTANDARD LVCMOS33 [get_ports hsync]
set_property IOSTANDARD LVCMOS33 [get_ports rdn]
set_property IOSTANDARD LVCMOS33 [get_ports vsync]

set_property PACKAGE_PIN E3 [get_ports clk]

create_clock -period 20.000 -name clk_all -waveform {0.000 10.000} -add

#set_property CFGBVS VCCO [current_design]          #当 CFGBVS 连接至 Bank 0 的 VCCO 时，Bank 0 的 VCCO 必须为 2.5V 或 3.3V
#set_property CONFIG_VOLTAGE 3.3 [current_design]   #设置CONFIG_VOLTAGE 也要配置为3.3V
#set_property BITSTREAM.GENERAL.COMPRESS true [current_design]  #设置bit是否压缩
#set_property BITSTREAM.CONFIG.CONFIGRATE 50 [current_design]   #设置QSPI的加载时钟
#set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]  #设置QSPI的位宽
#set_property BITSTREAM.CONFIG.SPI_FALL_EDGE Yes [current_design]  #设置QPSI的数据加载时钟边沿

