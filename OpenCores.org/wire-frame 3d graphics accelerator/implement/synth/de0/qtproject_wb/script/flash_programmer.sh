#!/bin/sh
#
# This file was automatically generated.
#
# It can be overwritten by nios2-flash-programmer-generate or nios2-flash-programmer-gui.
#

#
# Converting SOF File: F:\altera_project\usb_host_de0_rom\qtproject\output_files\usbhost.sof to: "..\flash/usbhost_epcs_flash_controller_0.flash"
#
sof2flash --input="F:/altera_project/usb_host_de0_rom/qtproject/output_files/usbhost.sof" --output="../flash/usbhost_epcs_flash_controller_0.flash" --epcs 

#
# Programming File: "..\flash/usbhost_epcs_flash_controller_0.flash" To Device: epcs_flash_controller_0
#
nios2-flash-programmer "../flash/usbhost_epcs_flash_controller_0.flash" --base=0x1800 --epcs --sidp=0x0 --id=0x0 --timestamp=1378277610 --device=1 --instance=0 '--cable=USB-Blaster on localhost [USB-0]' --program 

#
# Converting ELF File: F:\altera_project\usb_host_de0_rom\qtproject\software\usb_all\usb_all.elf to: "..\flash/usb_all_epcs_flash_controller_0.flash"
#
elf2flash --input="F:/altera_project/usb_host_de0_rom/qtproject/software/usb_all/usb_all.elf" --output="../flash/usb_all_epcs_flash_controller_0.flash" --epcs --after="../flash/usbhost_epcs_flash_controller_0.flash" 

#
# Programming File: "..\flash/usb_all_epcs_flash_controller_0.flash" To Device: epcs_flash_controller_0
#
nios2-flash-programmer "../flash/usb_all_epcs_flash_controller_0.flash" --base=0x1800 --epcs --sidp=0x0 --id=0x0 --timestamp=1378277610 --device=1 --instance=0 '--cable=USB-Blaster on localhost [USB-0]' --program 

