## Generated SDC file "RESDMAC.out.sdc"

## Copyright (C) 1991-2013 Altera Corporation
## Your use of Altera Corporation's design tools, logic functions 
## and other software and tools, and its AMPP partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Altera Program License 
## Subscription Agreement, Altera MegaCore Function License 
## Agreement, or other applicable license agreement, including, 
## without limitation, that your use is for the sole purpose of 
## programming logic devices manufactured by Altera and sold by 
## Altera or its authorized distributors.  Please refer to the 
## applicable agreement for further details.


## VENDOR  "Altera"
## PROGRAM "Quartus II"
## VERSION "Version 13.0.1 Build 232 06/12/2013 Service Pack 1 SJ Web Edition"

## DATE    "Sun Aug 27 17:04:05 2023"

##
## DEVICE  "EP2C5T144C8"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {sclk} -period 40.000 -waveform { 0.000 20.000 } [get_ports {SCLK}]


#**************************************************************
# Create Generated Clock
#**************************************************************

create_generated_clock -name {u_PLL|APLL_inst|altpll_component|pll|clk[0]} -source [get_pins {u_PLL|APLL_inst|altpll_component|pll|inclk[0]}] -duty_cycle 50.000 -multiply_by 1 -phase 45.000 -master_clock {sclk} [get_pins {u_PLL|APLL_inst|altpll_component|pll|clk[0]}] 
create_generated_clock -name {u_PLL|APLL_inst|altpll_component|pll|clk[1]} -source [get_pins {u_PLL|APLL_inst|altpll_component|pll|inclk[0]}] -duty_cycle 50.000 -multiply_by 1 -phase 90.000 -master_clock {sclk} [get_pins {u_PLL|APLL_inst|altpll_component|pll|clk[1]}] 
create_generated_clock -name {u_PLL|APLL_inst|altpll_component|pll|clk[2]} -source [get_pins {u_PLL|APLL_inst|altpll_component|pll|inclk[0]}] -duty_cycle 50.000 -multiply_by 1 -phase 135.000 -master_clock {sclk} [get_pins {u_PLL|APLL_inst|altpll_component|pll|clk[2]}] 


#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************



#**************************************************************
# Set Input Delay
#**************************************************************



#**************************************************************
# Set Output Delay
#**************************************************************

set_output_delay -add_delay -rise -max -clock [get_clocks {sclk}]  20.000 [get_ports {DATA_IO[0]}]
set_output_delay -add_delay -rise -max -clock [get_clocks {sclk}]  20.000 [get_ports {DATA_IO[1]}]
set_output_delay -add_delay -rise -max -clock [get_clocks {sclk}]  20.000 [get_ports {DATA_IO[2]}]
set_output_delay -add_delay -rise -max -clock [get_clocks {sclk}]  20.000 [get_ports {DATA_IO[3]}]
set_output_delay -add_delay -rise -max -clock [get_clocks {sclk}]  20.000 [get_ports {DATA_IO[4]}]
set_output_delay -add_delay -rise -max -clock [get_clocks {sclk}]  20.000 [get_ports {DATA_IO[5]}]
set_output_delay -add_delay -rise -max -clock [get_clocks {sclk}]  20.000 [get_ports {DATA_IO[6]}]
set_output_delay -add_delay -rise -max -clock [get_clocks {sclk}]  20.000 [get_ports {DATA_IO[7]}]
set_output_delay -add_delay -rise -max -clock [get_clocks {sclk}]  20.000 [get_ports {DATA_IO[8]}]
set_output_delay -add_delay -rise -max -clock [get_clocks {sclk}]  20.000 [get_ports {DATA_IO[9]}]
set_output_delay -add_delay -rise -max -clock [get_clocks {sclk}]  20.000 [get_ports {DATA_IO[10]}]
set_output_delay -add_delay -rise -max -clock [get_clocks {sclk}]  20.000 [get_ports {DATA_IO[11]}]
set_output_delay -add_delay -rise -max -clock [get_clocks {sclk}]  20.000 [get_ports {DATA_IO[12]}]
set_output_delay -add_delay -rise -max -clock [get_clocks {sclk}]  20.000 [get_ports {DATA_IO[13]}]
set_output_delay -add_delay -rise -max -clock [get_clocks {sclk}]  20.000 [get_ports {DATA_IO[14]}]
set_output_delay -add_delay -rise -max -clock [get_clocks {sclk}]  20.000 [get_ports {DATA_IO[15]}]
set_output_delay -add_delay -rise -max -clock [get_clocks {sclk}]  20.000 [get_ports {DATA_IO[16]}]
set_output_delay -add_delay -rise -max -clock [get_clocks {sclk}]  20.000 [get_ports {DATA_IO[17]}]
set_output_delay -add_delay -rise -max -clock [get_clocks {sclk}]  20.000 [get_ports {DATA_IO[18]}]
set_output_delay -add_delay -rise -max -clock [get_clocks {sclk}]  20.000 [get_ports {DATA_IO[19]}]
set_output_delay -add_delay -rise -max -clock [get_clocks {sclk}]  20.000 [get_ports {DATA_IO[20]}]
set_output_delay -add_delay -rise -max -clock [get_clocks {sclk}]  20.000 [get_ports {DATA_IO[21]}]
set_output_delay -add_delay -rise -max -clock [get_clocks {sclk}]  20.000 [get_ports {DATA_IO[22]}]
set_output_delay -add_delay -rise -max -clock [get_clocks {sclk}]  20.000 [get_ports {DATA_IO[23]}]
set_output_delay -add_delay -rise -max -clock [get_clocks {sclk}]  20.000 [get_ports {DATA_IO[24]}]
set_output_delay -add_delay -rise -max -clock [get_clocks {sclk}]  20.000 [get_ports {DATA_IO[25]}]
set_output_delay -add_delay -rise -max -clock [get_clocks {sclk}]  20.000 [get_ports {DATA_IO[26]}]
set_output_delay -add_delay -rise -max -clock [get_clocks {sclk}]  20.000 [get_ports {DATA_IO[27]}]
set_output_delay -add_delay -rise -max -clock [get_clocks {sclk}]  20.000 [get_ports {DATA_IO[28]}]
set_output_delay -add_delay -rise -max -clock [get_clocks {sclk}]  20.000 [get_ports {DATA_IO[29]}]
set_output_delay -add_delay -rise -max -clock [get_clocks {sclk}]  20.000 [get_ports {DATA_IO[30]}]
set_output_delay -add_delay -rise -max -clock [get_clocks {sclk}]  20.000 [get_ports {DATA_IO[31]}]
set_output_delay -add_delay -rise -max -clock [get_clocks {sclk}]  20.000 [get_ports {DATA_OE_}]


#**************************************************************
# Set Clock Groups
#**************************************************************



#**************************************************************
# Set False Path
#**************************************************************



#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************
