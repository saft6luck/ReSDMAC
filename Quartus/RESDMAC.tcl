# Copyright (C) 1991-2013 Altera Corporation
# Your use of Altera Corporation's design tools, logic functions 
# and other software and tools, and its AMPP partner logic 
# functions, and any output files from any of the foregoing 
# (including device programming or simulation files), and any 
# associated documentation or information are expressly subject 
# to the terms and conditions of the Altera Program License 
# Subscription Agreement, Altera MegaCore Function License 
# Agreement, or other applicable license agreement, including, 
# without limitation, that your use is for the sole purpose of 
# programming logic devices manufactured by Altera and sold by 
# Altera or its authorized distributors.  Please refer to the 
# applicable agreement for further details.

# Quartus II: Generate Tcl File for Project
# File: RESDMAC.tcl
# Generated on: Sat Jan 07 20:15:28 2023

# Load Quartus II Tcl Project package
package require ::quartus::project

set need_to_close_project 0
set make_assignments 1

# Check that the right project is open
if {[is_project_open]} {
	if {[string compare $quartus(project) "RESDMAC"]} {
		puts "Project RESDMAC is not open"
		set make_assignments 0
	}
} else {
	# Only open if not already open
	if {[project_exists RESDMAC]} {
		project_open -revision RESDMAC RESDMAC
	} else {
		project_new -revision RESDMAC RESDMAC
	}
	set need_to_close_project 1
}

# Make assignments
if {$make_assignments} {
	set_global_assignment -name FAMILY "Cyclone II"
	set_global_assignment -name DEVICE EP2C5T144C8
	set_global_assignment -name ORIGINAL_QUARTUS_VERSION "13.0 SP1"
	set_global_assignment -name PROJECT_CREATION_TIME_DATE "23:14:24  DECEMBER 29, 2022"
	set_global_assignment -name LAST_QUARTUS_VERSION "13.0 SP1"
	set_global_assignment -name VERILOG_FILE ../RTL/SCSI_SM/scsi_sm_outputs.v
	set_global_assignment -name VERILOG_FILE ../RTL/SCSI_SM/scsi_sm_inputs.v
	set_global_assignment -name VERILOG_FILE ../RTL/SCSI_SM/SCSI_SM.v
	set_global_assignment -name VERILOG_FILE ../RTL/Registers/registers_term.v
	set_global_assignment -name VERILOG_FILE ../RTL/Registers/registers_istr.v
	set_global_assignment -name VERILOG_FILE ../RTL/Registers/registers_cntr.v
	set_global_assignment -name VERILOG_FILE ../RTL/Registers/registers.v
	set_global_assignment -name VERILOG_FILE ../RTL/Registers/addr_decoder.v
	set_global_assignment -name VERILOG_FILE ../RTL/FIFO/fifo_write_strobes.v
	set_global_assignment -name VERILOG_FILE ../RTL/FIFO/fifo_full_empty_ctr.v
	set_global_assignment -name VERILOG_FILE ../RTL/FIFO/fifo_byte_ptr.v
	set_global_assignment -name VERILOG_FILE ../RTL/FIFO/fifo_3bit_cntr.v
	set_global_assignment -name VERILOG_FILE ../RTL/FIFO/fifo.v
	set_global_assignment -name VERILOG_FILE ../RTL/datapath/datapath_scsi.v
	set_global_assignment -name VERILOG_FILE ../RTL/datapath/datapath_output.v
	set_global_assignment -name VERILOG_FILE ../RTL/datapath/datapath_input.v
	set_global_assignment -name VERILOG_FILE ../RTL/datapath/datapath_24dec.v
	set_global_assignment -name VERILOG_FILE ../RTL/datapath/datapath_8b_MUX.v
	set_global_assignment -name VERILOG_FILE ../RTL/datapath/datapath.v
	set_global_assignment -name VERILOG_FILE ../RTL/CPU_SM/cpudff5.v
	set_global_assignment -name VERILOG_FILE ../RTL/CPU_SM/cpudff4.v
	set_global_assignment -name VERILOG_FILE ../RTL/CPU_SM/cpudff3.v
	set_global_assignment -name VERILOG_FILE ../RTL/CPU_SM/cpudff2.v
	set_global_assignment -name VERILOG_FILE ../RTL/CPU_SM/cpudff1.v
	set_global_assignment -name VERILOG_FILE ../RTL/CPU_SM/CPU_SM_output.v
	set_global_assignment -name VERILOG_FILE ../RTL/CPU_SM/CPU_SM_inputs.v
	set_global_assignment -name VERILOG_FILE ../RTL/CPU_SM/CPU_SM.v
	set_global_assignment -name VERILOG_FILE ../RTL/RESDMAC.v
	set_global_assignment -name PROJECT_OUTPUT_DIRECTORY output_files
	set_global_assignment -name MIN_CORE_JUNCTION_TEMP 0
	set_global_assignment -name MAX_CORE_JUNCTION_TEMP 85
	set_global_assignment -name DEVICE_FILTER_PACKAGE TQFP
	set_global_assignment -name DEVICE_FILTER_PIN_COUNT 144
	set_global_assignment -name DEVICE_FILTER_SPEED_GRADE 8
	set_global_assignment -name ERROR_CHECK_FREQUENCY_DIVISOR 1
	set_global_assignment -name EDA_SIMULATION_TOOL "ModelSim-Altera (Verilog)"
	set_global_assignment -name EDA_OUTPUT_DATA_FORMAT "VERILOG HDL" -section_id eda_simulation
	set_global_assignment -name STRATIX_DEVICE_IO_STANDARD "3.3-V LVTTL"
	set_global_assignment -name PARTITION_NETLIST_TYPE SOURCE -section_id Top
	set_global_assignment -name PARTITION_FITTER_PRESERVATION_LEVEL PLACEMENT_AND_ROUTING -section_id Top
	set_global_assignment -name PARTITION_COLOR 16764057 -section_id Top
	set_global_assignment -name SDC_FILE RESDMAC.sdc
	set_global_assignment -name CDF_FILE output_files/RESDMAC.cdf
	set_global_assignment -name SEARCH_PATH "c:\\users\\mbtay\\sdmac-replacement\\rtl\\cpu_sm"
	set_global_assignment -name SEARCH_PATH "c:\\users\\mbtay\\sdmac-replacement\\rtl\\datapath"
	set_global_assignment -name SEARCH_PATH "c:\\users\\mbtay\\sdmac-replacement\\rtl\\fifo"
	set_global_assignment -name SEARCH_PATH "c:\\users\\mbtay\\sdmac-replacement\\rtl\\registers"
	set_global_assignment -name SEARCH_PATH "c:\\users\\mbtay\\sdmac-replacement\\rtl\\scsi_sm"
	set_global_assignment -name USE_CONFIGURATION_DEVICE ON
	set_global_assignment -name STRATIX_CONFIGURATION_DEVICE EPCS4
	set_global_assignment -name RESERVE_ALL_UNUSED_PINS "AS INPUT TRI-STATED"
	set_location_assignment PIN_53 -to ADDR[6]
	set_location_assignment PIN_52 -to ADDR[5]
	set_location_assignment PIN_30 -to ADDR[4]
	set_location_assignment PIN_22 -to ADDR[3]
	set_location_assignment PIN_21 -to ADDR[2]
	set_location_assignment PIN_103 -to DATA[31]
	set_location_assignment PIN_101 -to DATA[30]
	set_location_assignment PIN_100 -to DATA[29]
	set_location_assignment PIN_97 -to DATA[28]
	set_location_assignment PIN_87 -to DATA[27]
	set_location_assignment PIN_96 -to DATA[26]
	set_location_assignment PIN_86 -to DATA[25]
	set_location_assignment PIN_94 -to DATA[24]
	set_location_assignment PIN_71 -to DATA[23]
	set_location_assignment PIN_93 -to DATA[22]
	set_location_assignment PIN_72 -to DATA[21]
	set_location_assignment PIN_92 -to DATA[20]
	set_location_assignment PIN_75 -to DATA[19]
	set_location_assignment PIN_74 -to DATA[18]
	set_location_assignment PIN_70 -to DATA[17]
	set_location_assignment PIN_132 -to DATA[16]
	set_location_assignment PIN_120 -to DATA[15]
	set_location_assignment PIN_44 -to DATA[14]
	set_location_assignment PIN_143 -to DATA[13]
	set_location_assignment PIN_126 -to DATA[12]
	set_location_assignment PIN_142 -to DATA[11]
	set_location_assignment PIN_125 -to DATA[10]
	set_location_assignment PIN_141 -to DATA[9]
	set_location_assignment PIN_122 -to DATA[8]
	set_location_assignment PIN_139 -to DATA[7]
	set_location_assignment PIN_121 -to DATA[6]
	set_location_assignment PIN_137 -to DATA[5]
	set_location_assignment PIN_119 -to DATA[4]
	set_location_assignment PIN_136 -to DATA[3]
	set_location_assignment PIN_118 -to DATA[2]
	set_location_assignment PIN_135 -to DATA[1]
	set_location_assignment PIN_115 -to DATA[0]
	set_location_assignment PIN_69 -to DATA_OE_
	set_location_assignment PIN_31 -to INTA
	set_location_assignment PIN_45 -to OWN_
	set_location_assignment PIN_25 -to PD_PORT[7]
	set_location_assignment PIN_51 -to PD_PORT[6]
	set_location_assignment PIN_24 -to PD_PORT[5]
	set_location_assignment PIN_8 -to PD_PORT[4]
	set_location_assignment PIN_4 -to PD_PORT[3]
	set_location_assignment PIN_47 -to PD_PORT[2]
	set_location_assignment PIN_99 -to PD_PORT[1]
	set_location_assignment PIN_79 -to PD_PORT[0]
	set_location_assignment PIN_129 -to R_W
	set_location_assignment PIN_90 -to SCLK
	set_location_assignment PIN_112 -to SIZ1
	set_location_assignment PIN_113 -to _AS
	set_location_assignment PIN_32 -to _BERR
	set_location_assignment PIN_88 -to _BG
	set_location_assignment PIN_104 -to _BGACK
	set_location_assignment PIN_59 -to _BR
	set_location_assignment PIN_18 -to _CS
	set_location_assignment PIN_43 -to _CSS
	set_location_assignment PIN_60 -to _DACK
	set_location_assignment PIN_41 -to _DMAEN
	set_location_assignment PIN_89 -to _DREQ
	set_location_assignment PIN_133 -to _DS
	set_location_assignment PIN_134 -to _DSACK[1]
	set_location_assignment PIN_114 -to _DSACK[0]
	set_location_assignment PIN_40 -to _INT
	set_location_assignment PIN_42 -to _IOR
	set_location_assignment PIN_64 -to _IOW
	set_location_assignment PIN_3 -to _LED_DMA
	set_location_assignment PIN_7 -to _LED_RD
	set_location_assignment PIN_9 -to _LED_WR
	set_location_assignment PIN_28 -to _RST
	set_location_assignment PIN_48 -to _STERM
	set_location_assignment PIN_55 -to PDATA_OE_
	set_instance_assignment -name PARTITION_HIERARCHY root_partition -to | -section_id Top

	# Commit assignments
	export_assignments

	# Close project
	if {$need_to_close_project} {
		project_close
	}
}
