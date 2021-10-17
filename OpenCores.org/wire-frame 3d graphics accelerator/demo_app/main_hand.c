//=======================================================================
// Project Monophony
//   Wire-Frame 3D Graphics Accelerator IP Core
//
// File:
//   main_hand.c
//
// Abstract:
//   Hand animation sample (without skinning).
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

#include "hand_full.h"

void mp_loop() {
  static float transY = 0.0f;
  static int cframe = 1;
  static float cScale = 4.0;
  int i,j;
  int frame  = 0;
  int mat_index = 0;
  mpClearColor(0.0, 0.25, 0.5);
  mpViewport(640, 480);
  mpMatrixMode(MP_PROJECTION);
  mpLoadIdentity();
  mpPerspective(30.0, 4.0 / 3.0, 1, 100);
  mpMatrixMode(MP_MODELVIEW);
  mpLoadIdentity();
  mpLookAt(0, 0, 1, 0, 0, -100, 0, 1, 0);
  mpTranslate(0.0,0.0,-10);
  mpTranslate(-1.0,2.0,0.0);
  mpScale(10.0,10.0,10.0);
  //mpRotatef(180.0,1,0,0);
  while(1) {
    printf("frame %d\n",frame++);
    mpClear();
    mpRenderColor(1.0,0.85,0.85);
    for (j=0; j<num_of_draws;j++) {
      mpMatrixMode(MP_MODELVIEW);
      mpPushMatrix();
      mat_index = weight_matrix_reference[j][0];
      mpMultMatrix ((matrix_index[mat_index])[cframe]);
      mpVertexPointer(vtx_array_index[j]);
      mpDrawArrays(num_of_tri_array_index[j]*3);
      mpPopMatrix();
    }
    cframe++;
    if (cframe >= num_of_frames) cframe = 1;
    mpSwapBuffers();
  }
}

int main()
{

  printf("Hand Demo\n");
  mpInit();
  buffer_clear(0x00000000,0);
  buffer_clear(0x00000000,1);
  mp_loop();
  return 0;
}
