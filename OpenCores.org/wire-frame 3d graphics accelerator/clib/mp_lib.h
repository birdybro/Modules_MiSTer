//=======================================================================
// Project Monophony
//   Wire-Frame 3D Graphics Accelerator IP Core
//
// File:
//   mp_lib.h
//
// Abstract:
//   C library header file
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

#ifndef __MP_LIB_H__
#define __MP_LIB_H__

#include "mp_hwdep.h"

/* MatrixMode */
#define MP_MODELVIEW                      0x0
#define MP_PROJECTION                     0x1
void mpRenderColor (float red, float green, float blue);
void mpRenderColorU(unsigned char c);
void mpViewport (int width, int height);
void mpMatrixMode (int mode);
void mpPerspective(float fovy, float aspect, float zNear, float zFar);
void mpVertexPointer (const float *pointer);
void mpLoadIdentity();
void mpLookAt (float eyeX, float eyeY, float eyeZ,
                float centerX, float centerY, float centerZ,
                float upX, float upY, float upZ);
void mpTranslate( float x, float y, float z );
void mpRotate( float angle, float x, float y, float z );
void mpDrawArrays (int count);
void mpFrustum ( float left, float right, float bottom, float top, float near_val, float far_val );
void mpOrtho( float left, float right, float bottom, float top, float near_val, float far_val );
void mpScale( float x, float y, float z );
void mpPopMatrix ();
void mpPushMatrix ();
void mpMultMatrix (float *m);


void mpClear();
void mpClearColor (float red, float green, float blue);
void mpSwapBuffers();
#define M_PI  3.14159265358979323846

typedef union _fui {
    float f;
    unsigned int ui;
} t_fui;

void set_all_matrix();
void mpInit();

#endif
