Wire-Frame 3D Graphics Accelerator IP Core
Project Monophony
================================================
Author: Kenji Ishimaru <info.wf3d@gmail.com>

2016/09/19
Sample implementation for ZedBoard is added.

2016/08/14
new demo appication is added.

2015/09/30

Overview
------------------------------------------
This IP Core is a wire-frame 3D hardware accelerator.

Features:
 - Hardware Geometry Engine and Rasterizer
   - Model-View-Projection matrix transformation
   - Clipping
   - Back-face culling
   - Viewport mapping
   - Wire-Frame rasterization with 8 bit color
   - DMAC for reading 3D object vertices
     - support triangle format only.
       (does NOT support triangle strip, point, line etc.)
  - Screen size: up to 2014 x 1536(QXGA)
  - Small logic consumption
  - Low bandwidth requirement
   
The IP Core does NOT support:
 - Memory clear DMAC
 - Filled triangle rasterization
 - Texture mapping
 - Lighting

Additional resources:
 - Sample FPGA system implementation (DE0/ZedBoard)
   - with original VGA controller
 - Demo applications
 - C API for controlling 3D scene
 - 3D model convert script

For more details, 
please see doc/3DGraphics_IPCore_Specification.pdf.


Directories
---------------------------------------

The directory structure looks as follows:
doc/            - Documentation
rtl/            - HDL source code
scenario/       - Simulation test benches
bin/            - Simulation scripts
sim_work/       - Simulation work directory
implement/      - FPGA implementation example (DE0/ZedBoard)
tool/           - 3D model convert tool and sample.
clib/           - C API source code
demo_app/       - Demo applications

IP Core Source Code
----------------------------
The IP Core is written by verilog-HDL. The source code is Vendor independent.
does not require any Vendor specific module.

Simulation
----------------------------
scenario directory contains simple rendering bench.
the rendering result  is converted to bmp file.

For more details, please see sim_work/readme.txt

FPGA Sample Implementation
----------------------------
FPGA system implementation sample is available.
The target board is DE0.
The project data is tested on Quartus II Version 13.1.
For more details, please see implement/readme_de0.txt

The other target board is Zedboard.
The project data is tested on Vivado v2015.6(64-bit) Windows.
For more details, please see implement/readme_zedboard.txt

Graphics C API
----------------------------
clib/ contains C API source code for this IP Core.
The API controls 3D scene, and controls IP Core by register configuration.

For more details,
please see doc/3DGraphics_C_Library_Specification.pdf.


Demo Application
----------------------------
demo_app/ contains demo applications.
simple_cube: rotating cube demo
main_cubes:  rotating cubes. matrix push/pop demo
main_bear:   bear characters
main_hand:   hand animation

Screen shots of these demos are available in screen_shot/

3D Data Tool
----------------------------
tool/objcnv.pl perl script convertes .obj format 3D data to
C float array format, and output as C header file.

For more details, please see tool/readme.txt
