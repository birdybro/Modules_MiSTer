set PROJ_NAME polyphony
set PROJ_DIR .
set RTL_3D_DIR ../../../rtl
set RTL_AXI_DIR ../../rtl/axi_cmn
set RTL_BD_DIR ../../rtl/zedboard
set RTL_HVC_DIR ../../rtl/fm_hvc
set TOP_NAME zed_base_wrapper

create_project -in_memory -part xc7z020clg484-1

#set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property parent.project_path ${PROJ_DIR}/${PROJ_NAME}.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property board_part em.avnet.com:zed:part0:1.3 [current_project]
set_property vhdl_version vhdl_2k [current_fileset]
add_files ${PROJ_DIR}/${PROJ_NAME}.srcs/sources_1/bd/zed_base/zed_base.bd

# version check
if {[expr [version -short]] >= 2016.3} {
  set PS7 ps7
} else {
  set PS7 processing_system7
}

set XDC_LIST "\
  ${PROJ_DIR}/${PROJ_NAME}.srcs/sources_1/bd/zed_base/ip/zed_base_axi_gpio_0_0/zed_base_axi_gpio_0_0_board.xdc \
  ${PROJ_DIR}/${PROJ_NAME}.srcs/sources_1/bd/zed_base/ip/zed_base_axi_gpio_0_0/zed_base_axi_gpio_0_0_ooc.xdc \
  ${PROJ_DIR}/${PROJ_NAME}.srcs/sources_1/bd/zed_base/ip/zed_base_axi_gpio_0_0/zed_base_axi_gpio_0_0.xdc \
  ${PROJ_DIR}/${PROJ_NAME}.srcs/sources_1/bd/zed_base/ip/zed_base_axi_gpio_1_0/zed_base_axi_gpio_1_0_board.xdc \
  ${PROJ_DIR}/${PROJ_NAME}.srcs/sources_1/bd/zed_base/ip/zed_base_axi_gpio_1_0/zed_base_axi_gpio_1_0_ooc.xdc \
  ${PROJ_DIR}/${PROJ_NAME}.srcs/sources_1/bd/zed_base/ip/zed_base_axi_gpio_1_0/zed_base_axi_gpio_1_0.xdc \
  ${PROJ_DIR}/${PROJ_NAME}.srcs/sources_1/bd/zed_base/ip/zed_base_axi_gpio_2_0/zed_base_axi_gpio_2_0_board.xdc \
  ${PROJ_DIR}/${PROJ_NAME}.srcs/sources_1/bd/zed_base/ip/zed_base_axi_gpio_2_0/zed_base_axi_gpio_2_0_ooc.xdc \
  ${PROJ_DIR}/${PROJ_NAME}.srcs/sources_1/bd/zed_base/ip/zed_base_axi_gpio_2_0/zed_base_axi_gpio_2_0.xdc \
  ${PROJ_DIR}/${PROJ_NAME}.srcs/sources_1/bd/zed_base/ip/zed_base_processing_system7_0_0/zed_base_processing_system7_0_0.xdc \
  ${PROJ_DIR}/${PROJ_NAME}.srcs/sources_1/bd/zed_base/ip/zed_base_rst_${PS7}_0_50M_0/zed_base_rst_${PS7}_0_50M_0_board.xdc \
  ${PROJ_DIR}/${PROJ_NAME}.srcs/sources_1/bd/zed_base/ip/zed_base_rst_${PS7}_0_50M_0/zed_base_rst_${PS7}_0_50M_0.xdc \
  ${PROJ_DIR}/${PROJ_NAME}.srcs/sources_1/bd/zed_base/ip/zed_base_xbar_0/zed_base_xbar_0_ooc.xdc \
  ${PROJ_DIR}/${PROJ_NAME}.srcs/sources_1/bd/zed_base/ip/zed_base_auto_pc_0/zed_base_auto_pc_0_ooc.xdc \
  ${PROJ_DIR}/${PROJ_NAME}.srcs/sources_1/bd/zed_base/zed_base_ooc.xdc \
"
foreach i $XDC_LIST {
  set_property used_in_implementation false [get_files -all ${i} ]
}

set V_LIST "\
  ${RTL_3D_DIR}/core/fm_geo_tri.v\
  ${RTL_3D_DIR}/core/fm_3d_f22_to_i.v\
  ${RTL_3D_DIR}/core/fm_geo_clip.v\
  ${RTL_3D_DIR}/core/fm_geo_cull.v\
  ${RTL_3D_DIR}/core/fm_3d_norm.v\
  ${RTL_3D_DIR}/core/fm_3d_fcnv.v\
  ${RTL_3D_DIR}/core/fm_3d_frcp_rom.v\
  ${RTL_3D_DIR}/core/fm_3d_frcp.v\
  ${RTL_3D_DIR}/core/fm_3d_fmul.v\
  ${RTL_3D_DIR}/core/fm_3d_fadd.v\
  ${RTL_3D_DIR}/core/fm_sys.v\
  ${RTL_3D_DIR}/core/fm_geo_viewport.v\
  ${RTL_3D_DIR}/core/fm_ras_state.v\
  ${RTL_3D_DIR}/core/fm_ras_mem.v\
  ${RTL_3D_DIR}/core/fm_ras_line.v\
  ${RTL_3D_DIR}/core/fm_ras.v\
  ${RTL_3D_DIR}/core/fm_geo_persdiv.v\
  ${RTL_3D_DIR}/core/fm_mem_arb.v\
  ${RTL_3D_DIR}/core/fm_geo_matrix.v\
  ${RTL_3D_DIR}/core/fm_geo_mem.v\
  ${RTL_3D_DIR}/core/fm_geo.v\
  ${RTL_3D_DIR}/core/fm_3d_core.v\
  ${RTL_BD_DIR}/polyphony_def.v\
  ${RTL_AXI_DIR}/fm_axi_s.v\
  ${RTL_AXI_DIR}/fm_4k_split.v\
  ${RTL_AXI_DIR}/fm_axi_m.v\
  ${RTL_AXI_DIR}/fm_fifo.v\
  ${RTL_AXI_DIR}/fm_dispatch.v\
  ${RTL_AXI_DIR}/fm_dispatch_dma.v\
  ${RTL_AXI_DIR}/fm_cmn_if_ff_out.v\
  ${RTL_AXI_DIR}/fm_asys.v\
  ${RTL_AXI_DIR}/fm_dma.v\
  ${RTL_AXI_DIR}/fm_mic.v\
  ${RTL_AXI_DIR}/fm_mic_cnv.v\
  ${RTL_AXI_DIR}/fm_cmn_bfifo.v\
  ${RTL_AXI_DIR}/fm_cmn_bram_01.v\
  ${RTL_AXI_DIR}/fm_cinterface.v\
  ${RTL_AXI_DIR}/fm_dinterface.v\
  ${RTL_AXI_DIR}/fm_ififo.v\
  ${RTL_AXI_DIR}/fm_port_unit.v\
  ${RTL_AXI_DIR}/fm_port_priority.v\
  ${RTL_AXI_DIR}/fm_raw_fifo.v\
  ${RTL_HVC_DIR}/fm_hvc.v\
  ${RTL_HVC_DIR}/fm_hvc_core.v\
  ${RTL_HVC_DIR}/fm_hvc_dma.v\
  ${RTL_HVC_DIR}/fm_hvc_data.v\
  ${RTL_HVC_DIR}/fm_cmn_ram.v\
  ${RTL_HVC_DIR}/fm_afifo.v\
  ${RTL_BD_DIR}/zq_top.v\
  ${RTL_BD_DIR}/${TOP_NAME}.v \
"
foreach i $V_LIST {
  read_verilog  -library xil_defaultlib ${i}
}

read_xdc user_const.xdc
set_property used_in_implementation false [get_files user_const.xdc]

read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]

synth_design -top ${TOP_NAME} -part xc7z020clg484-1 -verilog_define PP_BUSWIDTH_64=1 -include_dirs {../../rtl/zedboard ../../rtl/axi_cmn} -fanout_limit 10000 -flatten_hierarchy rebuilt
write_checkpoint -force ${TOP_NAME}.dcp
report_utilization -file ${TOP_NAME}_utilization_synth.rpt -pb ${TOP_NAME}_utilization_synth.pb
