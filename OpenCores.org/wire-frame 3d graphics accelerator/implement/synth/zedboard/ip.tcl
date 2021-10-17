# project configuration
set PROJ_NAME polyphony
set BD_NAME zed_base
set BD_DIR ./${PROJ_NAME}.srcs/sources_1/bd/${BD_NAME}
create_project -verbose -force -part xc7z020clg484-1 ${PROJ_NAME}
set_property board_part em.avnet.com:zed:part0:1.3 [current_project]
create_bd_design -verbose ${BD_NAME}
puts [get_property DIRECTORY [current_project]]
#set_property ip_repo_paths G:/Xilinx/Vivado/2015.4/data/ip [current_fileset]
#update_ip_catalog

startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7_0
endgroup
startgroup
set_property -dict [list CONFIG.preset {ZedBoard}] [get_bd_cells processing_system7_0]
endgroup

startgroup
set_property -dict [list CONFIG.PCW_FPGA0_PERIPHERAL_FREQMHZ {50.000000}] [get_bd_cells processing_system7_0]
endgroup

startgroup
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddrx_rtl:1.0 DDR
connect_bd_intf_net [get_bd_intf_pins processing_system7_0/DDR] [get_bd_intf_ports DDR]
endgroup
startgroup
create_bd_intf_port -mode Master -vlnv xilinx.com:display_processing_system7:fixedio_rtl:1.0 FIXED_IO
connect_bd_intf_net [get_bd_intf_pins processing_system7_0/FIXED_IO] [get_bd_intf_ports FIXED_IO]
endgroup
startgroup

set_property -dict [list CONFIG.PCW_USE_M_AXI_GP1 {1} CONFIG.PCW_USE_S_AXI_ACP {1} CONFIG.PCW_USE_FABRIC_INTERRUPT {1} CONFIG.PCW_IRQ_F2P_INTR {1}] [get_bd_cells processing_system7_0]
endgroup
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_0
endgroup
startgroup
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config {Master "/processing_system7_0/M_AXI_GP1" Clk "Auto" }  [get_bd_intf_pins axi_gpio_0/S_AXI]
apply_bd_automation -rule xilinx.com:bd_rule:board -config {Board_Interface "btns_5bits ( Push buttons ) " }  [get_bd_intf_pins axi_gpio_0/GPIO]
endgroup
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_1
endgroup
startgroup
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config {Master "/processing_system7_0/M_AXI_GP1" Clk "Auto" }  [get_bd_intf_pins axi_gpio_1/S_AXI]
apply_bd_automation -rule xilinx.com:bd_rule:board -config {Board_Interface "leds_8bits ( LED ) " }  [get_bd_intf_pins axi_gpio_1/GPIO]
endgroup
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_2
endgroup
startgroup
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config {Master "/processing_system7_0/M_AXI_GP1" Clk "Auto" }  [get_bd_intf_pins axi_gpio_2/S_AXI]
apply_bd_automation -rule xilinx.com:bd_rule:board -config {Board_Interface "sws_8bits ( DIP switches ) " }  [get_bd_intf_pins axi_gpio_2/GPIO]
endgroup
startgroup
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI_GP0
set_property -dict [list CONFIG.PROTOCOL [get_property CONFIG.PROTOCOL [get_bd_intf_pins processing_system7_0/M_AXI_GP0]] CONFIG.HAS_REGION [get_property CONFIG.HAS_REGION [get_bd_intf_pins processing_system7_0/M_AXI_GP0]] CONFIG.NUM_READ_OUTSTANDING [get_property CONFIG.NUM_READ_OUTSTANDING [get_bd_intf_pins processing_system7_0/M_AXI_GP0]] CONFIG.NUM_WRITE_OUTSTANDING [get_property CONFIG.NUM_WRITE_OUTSTANDING [get_bd_intf_pins processing_system7_0/M_AXI_GP0]]] [get_bd_intf_ports M_AXI_GP0]
connect_bd_intf_net [get_bd_intf_pins processing_system7_0/M_AXI_GP0] [get_bd_intf_ports M_AXI_GP0]
endgroup
set_property name M_AXI [get_bd_intf_ports M_AXI_GP0]
startgroup
create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_ACP
set_property -dict [list CONFIG.DATA_WIDTH [get_property CONFIG.DATA_WIDTH [get_bd_intf_pins processing_system7_0/S_AXI_ACP]] CONFIG.PROTOCOL [get_property CONFIG.PROTOCOL [get_bd_intf_pins processing_system7_0/S_AXI_ACP]] CONFIG.ID_WIDTH [get_property CONFIG.ID_WIDTH [get_bd_intf_pins processing_system7_0/S_AXI_ACP]] CONFIG.AWUSER_WIDTH [get_property CONFIG.AWUSER_WIDTH [get_bd_intf_pins processing_system7_0/S_AXI_ACP]] CONFIG.ARUSER_WIDTH [get_property CONFIG.ARUSER_WIDTH [get_bd_intf_pins processing_system7_0/S_AXI_ACP]] CONFIG.HAS_REGION [get_property CONFIG.HAS_REGION [get_bd_intf_pins processing_system7_0/S_AXI_ACP]] CONFIG.NUM_READ_OUTSTANDING [get_property CONFIG.NUM_READ_OUTSTANDING [get_bd_intf_pins processing_system7_0/S_AXI_ACP]] CONFIG.NUM_WRITE_OUTSTANDING [get_property CONFIG.NUM_WRITE_OUTSTANDING [get_bd_intf_pins processing_system7_0/S_AXI_ACP]] CONFIG.MAX_BURST_LENGTH [get_property CONFIG.MAX_BURST_LENGTH [get_bd_intf_pins processing_system7_0/S_AXI_ACP]]] [get_bd_intf_ports S_AXI_ACP]
connect_bd_intf_net [get_bd_intf_pins processing_system7_0/S_AXI_ACP] [get_bd_intf_ports S_AXI_ACP]
endgroup
set_property name S_AXI [get_bd_intf_ports S_AXI_ACP]
connect_bd_net [get_bd_pins processing_system7_0/M_AXI_GP0_ACLK] [get_bd_pins processing_system7_0/M_AXI_GP1_ACLK]
connect_bd_net [get_bd_pins processing_system7_0/S_AXI_ACP_ACLK] [get_bd_pins processing_system7_0/FCLK_CLK0]
startgroup
create_bd_port -dir O -type clk FCLK_CLK0
connect_bd_net [get_bd_pins /processing_system7_0/FCLK_CLK0] [get_bd_ports FCLK_CLK0]
endgroup
startgroup
create_bd_port -dir O -type rst FCLK_RESET0_N
connect_bd_net [get_bd_pins /processing_system7_0/FCLK_RESET0_N] [get_bd_ports FCLK_RESET0_N]
endgroup
set_property CONFIG.ASSOCIATED_BUSIF {M_AXI} [get_bd_ports /FCLK_CLK0]
set_property CONFIG.ASSOCIATED_BUSIF {M_AXI:S_AXI} [get_bd_ports /FCLK_CLK0]
startgroup
create_bd_port -dir I -from 0 -to 0 -type intr IRQ_F2P
connect_bd_net [get_bd_pins /processing_system7_0/IRQ_F2P] [get_bd_ports IRQ_F2P]
endgroup
assign_bd_address
validate_bd_design
save_bd_design

# version check
if {[expr [version -short]] >= 2016.3} {
set_property synth_checkpoint_mode None [get_files ${BD_DIR}/${BD_NAME}.bd]
}
generate_target -force all [get_files ${BD_DIR}/${BD_NAME}.bd]
export_ip_user_files -of_objects [get_files ${BD_DIR}/${BD_NAME}.bd] -no_script -force -quiet

close_project

#write_checkpoint -force -file bd_checkpoint.dcp
#synth
#source zed_base_wrapper.tcl
