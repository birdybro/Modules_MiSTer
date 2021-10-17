Wire-Frame 3D Graphics Accelerator IP Core
Project Monophony
================================================
Author: Kenji Ishimaru <info.info.wf3d@gmail.com>

implementation/ directory contains sample FPGA system.

Directories:
------------------------------------------
rtl:
  de0:     Dedicated RTL for DE0 system implementation.
  fm_hvc:  VGA Controller for sample system implementation

synth/de0:
  Quartus II project data.
  The data is tested on Quartus II Version 13.1

How to Build FPGA Data
------------------------------------------
1. Run Nios II Command Shell

2. Chenge direcroty to implement/synth/de0

3. Run de0_run_wb.sh script
  $./de0_run_wb.sh

If you try native(original) bus version, run de0_run_nb.sh.
In the case of run de0_run_nb.sh,
remove D3D_WISHBONE definition in rtl/include/fm_3d_define.v.

Nios II Eclipse Project
------------------------------------------
Nios II Eclipse project is available at
implement/synth/de0/qtproject_wb/software.

The following steps import existing demo application projects.
1. run Eclipse Nios II
 $eclipse-nios2

2. In Workspace Launcher, set Workspace to 
   "*/implement/synth/de0/qtproject_wb/software"

3. Generate new project named "test"
   File->New->Nios II Appication and BSP from Template,

     SOPC Information File name: 
       "*/implement/synth/de0/qtproject_wb/d3d_system.sopcinfo"
     Application project name:
       test
     Project template:
       Hello World

4. Import existing projects
   File->Import...
    General->Existing Projects into Workspace
      Select root directory:"*/implement/synth/de0/qtproject_wb/software"

   After the projects are imported, the Project Explorer looks as follows:
    ----------
    bear
    cubes
    hand
    simple_cube
    test
    test_bsp
    ----------
    test project is not used.(test_bsp is important for prepared projects)

5. Build projects
   Project->Build All
