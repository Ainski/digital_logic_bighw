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

#set_property CFGBVS VCCO [current_design]          #�� CFGBVS ������ Bank 0 �� VCCO ʱ��Bank 0 �� VCCO ����Ϊ 2.5V �� 3.3V
#set_property CONFIG_VOLTAGE 3.3 [current_design]   #����CONFIG_VOLTAGE ҲҪ����Ϊ3.3V
#set_property BITSTREAM.GENERAL.COMPRESS true [current_design]  #����bit�Ƿ�ѹ��
#set_property BITSTREAM.CONFIG.CONFIGRATE 50 [current_design]   #����QSPI�ļ���ʱ��
#set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]  #����QSPI��λ��
#set_property BITSTREAM.CONFIG.SPI_FALL_EDGE Yes [current_design]  #����QPSI�����ݼ���ʱ�ӱ���

