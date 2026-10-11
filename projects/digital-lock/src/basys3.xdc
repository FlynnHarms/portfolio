## Basys 3 (Artix-7 XC7A35T) constraints for top_lock
set_property BITSTREAM.STARTUP.STARTUPCLK JTAGCLK [current_design]

## 100 MHz system clock
set_property PACKAGE_PIN W5 [get_ports clock]
set_property IOSTANDARD LVCMOS33 [get_ports clock]

## Push buttons
set_property PACKAGE_PIN T18 [get_ports {b[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {b[0]}]
set_property PACKAGE_PIN W19 [get_ports {b[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {b[1]}]
set_property PACKAGE_PIN U18 [get_ports {b[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {b[2]}]
set_property PACKAGE_PIN T17 [get_ports {b[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {b[3]}]

## Status LEDs: z[0] unlocked, z[1] wrong code, z[2] lockout
set_property PACKAGE_PIN U16 [get_ports {z[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {z[0]}]
set_property PACKAGE_PIN V14 [get_ports {z[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {z[1]}]
set_property PACKAGE_PIN V13 [get_ports {z[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {z[2]}]

## Active-low clear on slide switch SW0
set_property PACKAGE_PIN V17 [get_ports clr]
set_property IOSTANDARD LVCMOS33 [get_ports clr]
