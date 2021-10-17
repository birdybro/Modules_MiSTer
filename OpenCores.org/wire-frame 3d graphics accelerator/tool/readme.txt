Wire-Frame 3D Graphics Accelerator IP Core
Project Monophony
================================================
Author: Kenji Ishimaru <info.info.wf3d@gmail.com>

3D Object Data Converter
------------------------------------------------
tool/objcnv.pl is a perl script which generates C header file from .obj data.
The generated C header file contains 3D object as a float array.
The float array will be used as a pointer for mlDrawArrays API.

How to Use:
1) generate .obj by blender
 open a blender file (sample is available in blender_example)
 File->Export->Wavefront(.obj)

  Check this option:
    Triangulate Faces
  NOT check these options:
    Write Normals
    Include UVs
    Write Materials

all polygons must be triangle.

2) generate header file
The following command generates obj_bear.h from bear_sample.obj.

$objcnv.pl ./blender_example/bear_sample.obj obj_bear.h

