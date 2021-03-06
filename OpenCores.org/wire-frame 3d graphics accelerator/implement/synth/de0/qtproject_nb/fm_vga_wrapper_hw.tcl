# TCL File Generated by Component Editor 13.0sp1
# Tue Sep 09 10:31:06 JST 2014
# DO NOT MODIFY


# 
# fm_vga_wrapper "VGA Wrapper" v1.0
#  2014.09.09.10:31:06
# 
# 

# 
# request TCL package from ACDS 13.1
# 
package require -exact qsys 13.1


# 
# module fm_vga_wrapper
# 
set_module_property DESCRIPTION ""
set_module_property NAME fm_vga_wrapper
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property GROUP MyLib
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME "VGA Wrapper"
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property ANALYZE_HDL AUTO
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL fm_vga_wrapper
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
add_fileset_file fm_vga_wrapper.v VERILOG PATH ../../../rtl/de0/fm_vga_wrapper.v TOP_LEVEL_FILE

add_fileset SIM_VERILOG SIM_VERILOG "" ""
set_fileset_property SIM_VERILOG ENABLE_RELATIVE_INCLUDE_PATHS false
add_fileset_file fm_avalon.v VERILOG PATH ../../../rtl/de0/fm_avalon.v
add_fileset_file fm_hsys.v VERILOG PATH ../../../rtl/de0/fm_hsys.v
add_fileset_file fm_afifo.v VERILOG PATH ../../../rtl/fm_hvc/fm_afifo.v
add_fileset_file fm_hvc.v VERILOG PATH ../../../rtl/fm_hvc/fm_hvc.v
add_fileset_file fm_cmn_ram.v VERILOG PATH ../../../rtl/fm_hvc/fm_cmn_ram.v
add_fileset_file fm_hvc_core.v VERILOG PATH ../../../rtl/fm_hvc/fm_hvc_core.v
add_fileset_file fm_hvc_data.v VERILOG PATH ../../../rtl/fm_hvc/fm_hvc_data.v
add_fileset_file fm_hvc_dma.v VERILOG PATH ../../../rtl/fm_hvc/fm_hvc_dma.v
add_fileset_file fm_vga_wrapper.v VERILOG PATH ../../../rtl/de0/fm_vga_wrapper.v


# 
# parameters
# 


# 
# display items
# 


# 
# connection point clock_sink
# 
add_interface clock_sink clock end
set_interface_property clock_sink clockRate 0
set_interface_property clock_sink ENABLED true
set_interface_property clock_sink EXPORT_OF ""
set_interface_property clock_sink PORT_NAME_MAP ""
set_interface_property clock_sink SVD_ADDRESS_GROUP ""

add_interface_port clock_sink clk_core clk Input 1


# 
# connection point reset_sink
# 
add_interface reset_sink reset end
set_interface_property reset_sink associatedClock clock_sink
set_interface_property reset_sink synchronousEdges DEASSERT
set_interface_property reset_sink ENABLED true
set_interface_property reset_sink EXPORT_OF ""
set_interface_property reset_sink PORT_NAME_MAP ""
set_interface_property reset_sink SVD_ADDRESS_GROUP ""

add_interface_port reset_sink rst_x reset_n Input 1


# 
# connection point avalon_master
# 
add_interface avalon_master avalon start
set_interface_property avalon_master addressUnits SYMBOLS
set_interface_property avalon_master associatedClock clock_sink
set_interface_property avalon_master associatedReset reset_sink
set_interface_property avalon_master bitsPerSymbol 8
set_interface_property avalon_master burstOnBurstBoundariesOnly false
set_interface_property avalon_master burstcountUnits WORDS
set_interface_property avalon_master doStreamReads false
set_interface_property avalon_master doStreamWrites false
set_interface_property avalon_master holdTime 0
set_interface_property avalon_master linewrapBursts false
set_interface_property avalon_master maximumPendingReadTransactions 0
set_interface_property avalon_master readLatency 0
set_interface_property avalon_master readWaitTime 1
set_interface_property avalon_master setupTime 0
set_interface_property avalon_master timingUnits Cycles
set_interface_property avalon_master writeWaitTime 0
set_interface_property avalon_master ENABLED true
set_interface_property avalon_master EXPORT_OF ""
set_interface_property avalon_master PORT_NAME_MAP ""
set_interface_property avalon_master SVD_ADDRESS_GROUP ""

add_interface_port avalon_master o_avm_be byteenable Output 4
add_interface_port avalon_master o_avm_blen burstcount Output 6
add_interface_port avalon_master o_avm_r read Output 1
add_interface_port avalon_master i_avm_wait waitrequest Input 1
add_interface_port avalon_master i_avm_rd readdata Input 32
add_interface_port avalon_master o_avm_adr address Output 26
add_interface_port avalon_master i_avm_rvalid readdatavalid Input 1


# 
# connection point avalon_slave
# 
add_interface avalon_slave avalon end
set_interface_property avalon_slave addressUnits WORDS
set_interface_property avalon_slave associatedClock clock_sink
set_interface_property avalon_slave associatedReset reset_sink
set_interface_property avalon_slave bitsPerSymbol 8
set_interface_property avalon_slave burstOnBurstBoundariesOnly false
set_interface_property avalon_slave burstcountUnits WORDS
set_interface_property avalon_slave explicitAddressSpan 0
set_interface_property avalon_slave holdTime 0
set_interface_property avalon_slave linewrapBursts false
set_interface_property avalon_slave maximumPendingReadTransactions 0
set_interface_property avalon_slave readLatency 0
set_interface_property avalon_slave readWaitTime 1
set_interface_property avalon_slave setupTime 0
set_interface_property avalon_slave timingUnits Cycles
set_interface_property avalon_slave writeWaitTime 0
set_interface_property avalon_slave ENABLED true
set_interface_property avalon_slave EXPORT_OF ""
set_interface_property avalon_slave PORT_NAME_MAP ""
set_interface_property avalon_slave SVD_ADDRESS_GROUP ""

add_interface_port avalon_slave i_avs_adr address Input 4
add_interface_port avalon_slave i_avs_be byteenable Input 4
add_interface_port avalon_slave i_avs_r read Input 1
add_interface_port avalon_slave o_avs_rd readdata Output 32
add_interface_port avalon_slave i_avs_w write Input 1
add_interface_port avalon_slave i_avs_wd writedata Input 32
add_interface_port avalon_slave o_avs_wait waitrequest Output 1
set_interface_assignment avalon_slave embeddedsw.configuration.isFlash 0
set_interface_assignment avalon_slave embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment avalon_slave embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment avalon_slave embeddedsw.configuration.isPrintableDevice 0


# 
# connection point clock_sink_1
# 
add_interface clock_sink_1 clock end
set_interface_property clock_sink_1 clockRate 0
set_interface_property clock_sink_1 ENABLED true
set_interface_property clock_sink_1 EXPORT_OF ""
set_interface_property clock_sink_1 PORT_NAME_MAP ""
set_interface_property clock_sink_1 SVD_ADDRESS_GROUP ""

add_interface_port clock_sink_1 clk25m clk Input 1


# 
# connection point conduit_end
# 
add_interface conduit_end conduit end
set_interface_property conduit_end associatedClock clock_sink_1
set_interface_property conduit_end associatedReset reset_sink
set_interface_property conduit_end ENABLED true
set_interface_property conduit_end EXPORT_OF ""
set_interface_property conduit_end PORT_NAME_MAP ""
set_interface_property conduit_end SVD_ADDRESS_GROUP ""

add_interface_port conduit_end o_cr export Output 4
add_interface_port conduit_end o_cb export Output 4
add_interface_port conduit_end o_vsync_x export Output 1
add_interface_port conduit_end o_hsync_x export Output 1
add_interface_port conduit_end o_cg export Output 4


# 
# connection point interrupt_sender
# 
add_interface interrupt_sender interrupt end
set_interface_property interrupt_sender associatedAddressablePoint avalon_slave
set_interface_property interrupt_sender associatedClock clock_sink
set_interface_property interrupt_sender associatedReset reset_sink
set_interface_property interrupt_sender ENABLED true
set_interface_property interrupt_sender EXPORT_OF ""
set_interface_property interrupt_sender PORT_NAME_MAP ""
set_interface_property interrupt_sender SVD_ADDRESS_GROUP ""

add_interface_port interrupt_sender o_int irq Output 1

