#IO_L11P_T1_SRCC_35
set_property PACKAGE_PIN Y9 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} -add [get_ports clk]

#IO_L20N_T3_34
set_property PACKAGE_PIN N15 [get_ports reset]
set_property IOSTANDARD LVCMOS33 [get_ports reset]

#IO_L23P_T3_35
set_property PACKAGE_PIN U21 [get_ports led_out]
set_property IOSTANDARD LVCMOS33 [get_ports led_out]


