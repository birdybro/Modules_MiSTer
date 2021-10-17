transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {/home/mongoq/projects/fpga/tm1637-opencores/tm1637-gama/testing-17.2.21/tm1637-decimal-counter-testing/tm1637_external_connect.vhd}
vcom -93 -work work {/home/mongoq/projects/fpga/tm1637-opencores/tm1637-gama/testing-17.2.21/tm1637-decimal-counter-testing/tm1637_toplevel.vhd}
vcom -93 -work work {/home/mongoq/projects/fpga/tm1637-opencores/tm1637-gama/testing-17.2.21/tm1637-decimal-counter-testing/tm1637_decimal_count.vhd}

