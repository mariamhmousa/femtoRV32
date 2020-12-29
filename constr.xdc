set_property PACKAGE_PIN E3 [get_ports ssdclk]
set_property IOSTANDARD LVCMOS33 [get_ports ssdclk]

set_property PACKAGE_PIN J17 [get_ports {Anode[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Anode[0]}]

set_property PACKAGE_PIN J18 [get_ports {Anode[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Anode[1]}]

set_property PACKAGE_PIN T9 [get_ports {Anode[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Anode[2]}]

set_property PACKAGE_PIN J14 [get_ports {Anode[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Anode[3]}]


set_property PACKAGE_PIN L18 [get_ports {LED_out[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED_out[0]}]

set_property PACKAGE_PIN T11 [get_ports {LED_out[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED_out[1]}]

set_property PACKAGE_PIN P15 [get_ports {LED_out[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED_out[2]}]

set_property PACKAGE_PIN K13 [get_ports {LED_out[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED_out[3]}]

set_property PACKAGE_PIN K16 [get_ports {LED_out[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED_out[4]}]

set_property PACKAGE_PIN R10 [get_ports {LED_out[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED_out[5]}]

set_property PACKAGE_PIN T10 [get_ports {LED_out[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED_out[6]}]

set_property PACKAGE_PIN C4 [get_ports uart_in]
set_property IOSTANDARD LVCMOS33 [get_ports uart_in]

set_property PACKAGE_PIN V11 [get_ports out[15]]
set_property IOSTANDARD LVCMOS33 [get_ports out[15]]
set_property PACKAGE_PIN V12 [get_ports out[14]]
set_property IOSTANDARD LVCMOS33 [get_ports out[14]]
set_property PACKAGE_PIN V14 [get_ports out[13]]
set_property IOSTANDARD LVCMOS33 [get_ports out[13]]
set_property PACKAGE_PIN V15 [get_ports out[12]]
set_property IOSTANDARD LVCMOS33 [get_ports out[12]]
set_property PACKAGE_PIN T16 [get_ports out[11]]
set_property IOSTANDARD LVCMOS33 [get_ports out[11]]
set_property PACKAGE_PIN U14 [get_ports out[10]]
set_property IOSTANDARD LVCMOS33 [get_ports out[10]]
set_property PACKAGE_PIN T15 [get_ports out[9]]
set_property IOSTANDARD LVCMOS33 [get_ports out[9]]
set_property PACKAGE_PIN V16 [get_ports out[8]]
set_property IOSTANDARD LVCMOS33 [get_ports out[8]]

set_property PACKAGE_PIN U16 [get_ports out[7]]
set_property IOSTANDARD LVCMOS33 [get_ports out[7]]
set_property PACKAGE_PIN U17 [get_ports out[6]]
set_property IOSTANDARD LVCMOS33 [get_ports out[6]]
set_property PACKAGE_PIN V17 [get_ports out[5]]
set_property IOSTANDARD LVCMOS33 [get_ports out[5]]
set_property PACKAGE_PIN R18 [get_ports out[4]]
set_property IOSTANDARD LVCMOS33 [get_ports out[4]]
set_property PACKAGE_PIN N14 [get_ports out[3]]
set_property IOSTANDARD LVCMOS33 [get_ports out[3]]
set_property PACKAGE_PIN J13 [get_ports out[2]]
set_property IOSTANDARD LVCMOS33 [get_ports out[2]]
set_property PACKAGE_PIN K15 [get_ports out[1]]
set_property IOSTANDARD LVCMOS33 [get_ports out[1]]
set_property PACKAGE_PIN H17 [get_ports out[0]]
set_property IOSTANDARD LVCMOS33 [get_ports out[0]]

#set_property ALLOW_COMBINATORIAL_LOOPS true [get_nets -of_objects [get_cells counter[0]_i_7]]
#set_property ALLOW_COMBINATORIAL_LOOPS true [get_nets -of_objects [get_cells counter[0]_i_8]]

#set_property SEVERITY {Warning}  [get_drc_checks LUTLP-1]

#set_property SEVERITY {Warning} [get_drc_checks NSTD-1]

#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets out[0]]