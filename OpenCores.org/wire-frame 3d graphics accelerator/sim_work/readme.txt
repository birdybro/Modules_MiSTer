
Wire-Frame 3D Graphics Accelerator IP Core
Project Monophony
================================================
Author: Kenji Ishimaru <info.info.wf3d@gmail.com>

How to run the simulation
----------------------------
cd sim_work
 ../bin/run_icarus.sh ../scenario/3d/simple_triangle.v

frame buffer image will be output to frame_buffer.dat file.

To generate bitmap image:
cd bin/a2bmp
make
(a2bmp is generated.)

cd ../sim_work
(if screen size is VGA)
../bin/a2bmp/a2bmp framebuffer.dat result.bmp 640 480

Screen Size
----------------------------
The screen size is defined in scenario/3d/simple_triangle.v
Default size is VGA.
// VGA
localparam P_SCREEN_WIDTH=640;
localparam P_SCREEN_HEIGHT=480;
// SVGA
//localparam P_SCREEN_WIDTH=800;
//localparam P_SCREEN_HEIGHT=600;
// XGA
//localparam P_SCREEN_WIDTH=1024;
//localparam P_SCREEN_HEIGHT=768;
// SXGA
//localparam P_SCREEN_WIDTH=1280;
//localparam P_SCREEN_HEIGHT=1024;
// UXGA
//localparam P_SCREEN_WIDTH=1600;
//localparam P_SCREEN_HEIGHT=1200;
// QXGA
//localparam P_SCREEN_WIDTH=2048;
//localparam P_SCREEN_HEIGHT=1536;

