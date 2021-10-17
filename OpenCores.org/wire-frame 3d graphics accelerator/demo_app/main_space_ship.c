//=======================================================================
// Project Monophony
//   Wire-Frame 3D Graphics Accelerator IP Core
//
// File:
//   main_space_ship.c
//
// Abstract:
//   3D model(space ship and landscape) rendering sample program.
//
// Author:
//   Kenji Ishimaru (info.info.wf3d@gmail.com)
//
//======================================================================
//
// Copyright (c) 2016, Kenji Ishimaru
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


#include "ship.h"
#include "landscape.h"

void mp_loop() {
  static float transY = 0.0f;
  static int cframe = 1;
  static float cScale = 4.0;
  float pos_z_l,pos_z_r;
  int pos_z_l_inc,pos_z_r_inc;
  unsigned char col;
  int i;
  int frame  = 0;
  int mat_index;
  mpClearColor(0.0, 0.0, 0.0);
  mpViewport(640, 480);
  mpMatrixMode(MP_PROJECTION);
  mpPerspective(30.0, 4.0 / 3.0, 1, 100);

  pos_z_l = 0.0;
  pos_z_r = 0.0;
  pos_z_l_inc = 0;
  pos_z_r_inc = 0;
  col = 0xff;
  int j;
  while(1){
	for (i=0;i<360;i++) {
      printf("frame %d\n",frame++);
      mpClear();
      mpMatrixMode(MP_MODELVIEW);
      mpLoadIdentity();
      mpLookAt(0, 0.5, 3.0, 0, 0, -50, 0, 1.0, 0);
      // ship
      mpPushMatrix();
      mpTranslate(0.0, 0.0, -8);
      mpTranslate(-1.3, 1.0, 0.0);
      mpRotate(i, 0, 1, 0);
      mpScale(0.2,0.2,0.2);
      mpVertexPointer(vtx_ship_array);
      mpRenderColor(1.0,0.5,1.0);
      mpDrawArrays(num_vtx_ship*3);
      mpPopMatrix();
      // landscape
      mpPushMatrix();
      mpTranslate(0.0, 0.0, -8/*+pos_z_l*/);
      mpTranslate(0.0, -1.0, 0.0);
      mpScale(3.0,3.0,3.0);
      mpVertexPointer(vtx_array);
      mpRenderColor(1.0,0.3,0.0);
      mpDrawArrays(num_vtx*3);
      mpPopMatrix();

      cframe++;
      mpSwapBuffers();
    }
  }
}

int main()
{

  printf("Space Ship Demo\n");
  mpInit();
  buffer_clear(0x00000000,0);
  buffer_clear(0x00000000,1);
  mp_loop();
  return 0;
}
