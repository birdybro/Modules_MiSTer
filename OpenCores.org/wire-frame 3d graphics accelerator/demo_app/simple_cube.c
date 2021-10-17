//=======================================================================
// Project Monophony
//   Wire-Frame 3D Graphics Accelerator IP Core
//
// File:
//   simple_cube.c
//
// Abstract:
//   simple rendering sample
//
// Author:
//   Kenji Ishimaru (info.info.wf3d@gmail.com)
//
//======================================================================
//
// Copyright (c) 2015, Kenji Ishimaru
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
//  -Redistributions of source code must retain the above copyright notice,
//   this list of conditions and the following disclaimer.
//  -Redistributions in binary form must reproduce the above copyright notice,
//   this list of conditions and the following disclaimer in the documentation
//   and/or other materials provided with the distribution.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
// THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
// PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
// CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
// EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
// PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
// OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
// WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
// OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
// EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// Revision History

#include "mp_hwdep.h"
#include "mp_lib.h"
#include <stdio.h>

float triangle[] = {
  // front
  0.25,  0.25, 0.25,  // triangle0
  -0.25,  0.25, 0.25,
  -0.25, -0.25, 0.25,
   0.25,  0.25, 0.25,  // triangle1
  -0.25, -0.25, 0.25,
   0.25, -0.25, 0.25,
  // top
   0.25,  0.25, 0.0,      // triangle0
  -0.25,  0.25, 0.0,
  -0.25,  0.25, 0.25,
   0.25,  0.25, 0.0,      // triangle1
  -0.25,  0.25, 0.25,
   0.25,  0.25, 0.25,
  // bottom
   0.25, -0.25, 0.25,  // triangle0
  -0.25, -0.25, 0.25,
  -0.25, -0.25, 0,
  0.25, -0.25, 0.25,  // triangle1
  -0.25, -0.25, 0,
  0.25, -0.25, 0,
  // left
  -0.25, 0.25, 0.25,  // triangle0
  -0.25, 0.25, 0,
  -0.25, -0.25, 0,
  -0.25, 0.25, 0.25,  // triangle1
  -0.25, -0.25, 0,
  -0.25, -0.25, 0.25,
  // right
  0.25, 0.25, 0,  // triangle0
  0.25, 0.25, 0.25,
  0.25, -0.25, 0.25,
  0.25, 0.25, 0,  // triangle1
  0.25, -0.25, 0.25,
  0.25, -0.25, 0,
  // back
  -0.25, 0.25, 0,  // triangle0
  0.25, 0.25, 0,
  0.25, -0.25, 0,
  -0.25, 0.25, 0,  // triangle1
  0.25, -0.25, 0,
  -0.25, -0.25, 0
};

void mp_loop() {
  int i;
  int frame  = 0;
  mpClearColor(0.1, 0.1, 0.1);
  mpViewport(640, 480);
  mpMatrixMode(MP_PROJECTION);
  mpPerspective(30.0, 4.0 / 3.0, 1, 100);
  mpVertexPointer(triangle);
  while(1) {
    for (i = 0; i <360; i++) {
      //printf("frame %d\n",frame++);

      mpClear();
      mpMatrixMode(MP_MODELVIEW);
      mpLoadIdentity();
      mpLookAt(0, 0, 1, 0, 0, 0, 0, 1, 0);
      mpTranslate(0, 0, -2);
      mpRotate(i, 1, 0, 0);
      mpRotate(i, 0, 0, 1);
      mpDrawArrays(36);//12 triangles
      //printf("drawarray done.\n");

      mpSwapBuffers();
    }
  }
}

int main()
{

  printf("Simple Cube\n");
  mpInit();
  buffer_clear(0x00000000,0);
  buffer_clear(0x00000000,1);
  mp_loop();
  return 0;
}
