open_hw
connect_hw_server
open_hw_target

set_property PROGRAM.FILE {zed_base_wrapper.bit} [lindex [get_hw_devices] 1]
current_hw_device [lindex [get_hw_devices] 1]
refresh_hw_device [lindex [get_hw_devices] 1]
program_hw_devices -verbose [lindex [get_hw_devices] 1]

close_hw_target
disconnect_hw_server
close_hw
