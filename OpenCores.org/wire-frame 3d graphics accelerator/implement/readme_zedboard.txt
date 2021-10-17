Wire-Frame 3D Graphics Accelerator IP Core
Project Monophony
================================================
Author: Kenji Ishimaru <info.info.wf3d@gmail.com>

System Setup:
------------------------------------------
  ZedBoard
   Configuration Modes: JTAG(JP7-JP11 are all GND).
   Connect Display device to D-sub25 pin VGA output.

Directories:
------------------------------------------
rtl:
  zedboard:  Dedicated RTL for ZedBoard system implementation.
  axi_cmn:   AXI bridges
  fm_hvc:    VGA Controller

synth/zedboard:
  Vivado project data.
  The data is tested on the following Vivado versions,
     v2015.4(64-bit) Windows
     v2016.1(64-bit) Windows
     v2015.2(64-bit) Windows
     v2015.3(64-bit) Windows

How to Build FPGA Data
------------------------------------------
1. Run Vivado Console
   (For example, run the Windows command prompt, then execute settings64.bat
    in the Vivado installation directory.)

2. Chenge direcroty to implement/synth/zedboard

3. Run run.bat

zed_base_wrapper.bit will be generated.

How to build Xilinx SDK Project
------------------------------------------
The following steps import existing demo application projects to Xilinx SDK.

1. run launch_sdk.tcl. This tcl script imports hardware Specification.
 for Vivado 2015.4
 $vivado -m64 -mode batch -source launch_sdk_2015.4.tcl
 for Vivado 2016.x
 $vivado -m64 -mode batch -source launch_sdk_2016.x.tcl

2. On the Xilnx SDK Workspace Launcher, set Workspace to 
   "(your wf3d directry)/implement/synth/zedboard/sdk"

3. Generate BSP by default settings
   Xilnx SDK->File->New->Board Support Package,

     Project name:  standalone_bsp_0
     Use default location: ON
     Target Hardware:
       Hardware Platform: zed_base_wrapper_hw_platform_0
       CPU: ps7_cortexa9_0
     Board Support Package OS:
       standalone

   Finally, standalone_bsp_0 will be generated.
4. Import existing projects
   Xilnx SDK->File->Import...
    General->Existing Projects into Workspace
      Select root directory:"(your wf3d directry)/implement/synth/zedboard/sdk"

   After the projects are imported, the Project Explorer looks as follows:
    ----------
    bear
    cubes
    hand
    space_ship
    simple_cube
    ----------

5. Build projects
   For all projects, set active configuration as Rlease:
     Build Configurations->Set Active->Release
   then, build all projects.
     Project->Build All

   **VERY IMPORTANT**
   Debug configuration is NOT implemented.
Run the demos
------------------------------------------
1. Run load_fpga.tcl. This tcl script downloads zed_base_wrapper.bit to ZedBoard
 $vivado -m64 -mode batch -source load_fpga.tcl

2. On the Xilinx SDK, selsect one project and run the demo.
   for example, select simple_cube->right click->
   Run as->Launch on Hardware(System Debugger)
