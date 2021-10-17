transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {c:/PDP8L/Top.vhd}
vcom -93 -work work {c:/PDP8L/MegaRam.vhd}
vcom -93 -work work {c:/PDP8L/Divider.vhd}
vcom -93 -work work {c:/PDP8L/DF32.vhd}
vcom -93 -work work {c:/PDP8L/Cpu.vhd}
vcom -93 -work work {c:/PDP8L/uart.vhd}

