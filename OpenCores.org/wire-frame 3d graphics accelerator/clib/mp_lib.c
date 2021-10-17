//=======================================================================
// Project Monophony
//   Wire-Frame 3D Graphics Accelerator IP Core
//
// File:
//   mp_lib.c
//
// Abstract:
//   C library implementation
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

#include <math.h>
#include "mp_lib.h"
#include "mp_vector4.h"
#include "mp_matrix3.h"
#include "mp_matrix4.h"

extern volatile int fb_front;

#define MP_CONFIG_MAX_MSTACK 8

// static objects
mp_matrix4                    cur_pm;    // current projection matrix
mp_matrix4                    cur_mm;    // current model matrix
mp_matrix4                    cur_vm;    // current view matrix

mp_matrix4*                   cur_matrix;  // current matrix stack
mp_matrix4                    matrix_stack[MP_CONFIG_MAX_MSTACK];
int                           matrix_stack_ptr;

int m_vertex_array_en;

float*	p_vertex_array;

// clear
unsigned char clear_color[3];
unsigned char render_color;
// conversion function
unsigned int wb[16];

t_fui u_fui;

void ftoui(int n, float bi[]) {
    int i;
    for (i = 0; i < n; i++) {
        u_fui.f = bi[i];
        wb[i] = u_fui.ui;
    }
    if (n <4) {
        u_fui.f = 1.0;
        wb[i] = u_fui.ui;
    }
}


void mpInit() {
  hw_init();
  video_init();
  mp_matrix4_identity(&cur_pm);
  mp_matrix4_identity(&cur_mm);
  mp_matrix4_identity(&cur_vm);
  matrix_stack_ptr = 0;
  cur_matrix = &cur_mm;  // initial matrix mode is model-view

  // vertex processor state init
  m_vertex_array_en = 1;
  p_vertex_array = 0;
  render_color = 0xff;
}


void mpViewport(int width, int height ) {
  // screen width/height
  u_fui.f = (float)width;
  D3D_FSCR_W = u_fui.ui;
  u_fui.f = (float)height;
  D3D_FSCR_H = u_fui.ui;
  D3D_ISCR_W_M1 = (width-1);
  D3D_ISCR_H_M1 = (height-1);
  D3D_ISCR_W    = (width);
}

void mpFrustum ( float left, float right, float bottom, float top, float near_val, float far_val ) {
  // | a[0]  a[1]  a[2]  a[3] |
  // | a[4]  a[5]  a[6]  a[7] |
  // | a[8]  a[9]  a[10] a[11]|
  // | a[12] a[13] a[14] a[15]|
  mp_matrix4 m;  
  float a[16];
  int i;
  for (i=0; i<16; i++)
     a[i] = 0.0;
  a[0]  = 2.0F*near_val/(right - left);
  a[2]  = (right + left)/(right - left);
  a[5]  = 2.0F*near_val/(top -bottom);
  a[6]  = (top + bottom)/(top - bottom);
  a[10] = -(far_val + near_val)/(far_val - near_val);
  a[11] = -2.0F*near_val*far_val/(far_val - near_val);
  a[14] = -1.0F;

  mp_matrix4_set0(&m, a);
  mp_matrix4_multiply_matrix4i(cur_matrix, cur_matrix, &m);
}


void mpOrtho( float left, float right, float bottom, float top, float near_val, float far_val ) {
  // | a[0]  a[1]  a[2]  a[3] |
  // | a[4]  a[5]  a[6]  a[7] |
  // | a[8]  a[9]  a[10] a[11]|
  // | a[12] a[13] a[14] a[15]|
  mp_matrix4 m;
  float a[16];
  int i;
  for (i=0; i<16; i++)
      a[i] = 0.0;
  a[0]  = 2.0F/(right - left);
  a[3]  = -(right + left)/(right - left);
  a[5]  = 2.0F/(top -bottom);
  a[7]  = -(top + bottom)/(top - bottom);
  a[10] = -2.0F/(far_val - near_val);
  a[11] = -(near_val+far_val)/(far_val - near_val);
  a[15] = 1.0F;

  mp_matrix4_set0(&m, a);
  mp_matrix4_multiply_matrix4i(cur_matrix, cur_matrix, &m);
}

void mpMatrixMode( int mode ) {
  switch (mode) {
    case MP_MODELVIEW:
      cur_matrix = &cur_mm;
      break;
    case MP_PROJECTION:
      cur_matrix = &cur_pm;
      break;
    default:
      break;
  }
}

void mpLoadIdentity( void ) {
  mp_matrix4_identity(cur_matrix);
}

void mpTranslate( float x, float y, float z ) {
  mp_vector4 v;
  v.x = x; v.y = y; v.z = z; v.w = 1.0;
  mp_matrix4_multiply_vector4(&v, cur_matrix, &v);
  cur_matrix->a[3] =  v.x;
  cur_matrix->a[7] =  v.y;
  cur_matrix->a[11] = v.z;
}

void mpScale( float x, float y, float z ) {
  // | a[0]  a[1]  a[2]  a[3] |
  // | a[4]  a[5]  a[6]  a[7] |
  // | a[8]  a[9]  a[10] a[11]|
  // | a[12] a[13] a[14] a[15]|
  mp_matrix4 m;
  mp_matrix4_identity(&m);
  m.a[0] = x;
  m.a[5] = y;
  m.a[10] = z;
  mp_matrix4_multiply_matrix4i(cur_matrix, cur_matrix, &m);
}

void mpRotate( float angle, float x, float y, float z ){
  float theta = angle /180.0 * M_PI;
  mp_vector3 v;
  mp_vector3_set0(&v, x,y,z);
  mp_matrix4 m2;
  mp_matrix4_rotate(&m2, &v, theta);
  mp_matrix4_multiply_matrix4i(cur_matrix, cur_matrix, &m2);
}

void mpClearColor( float red, float green, float blue) {
  clear_color[0] = (int)(red*255.0);
  clear_color[1] = (int)(green*255.0);
  clear_color[2] = (int)(blue*255.0);
}

void mpRenderColor (float red, float green, float blue) {
  unsigned char r,g,b;
  r = (int)(red*255.0);
  g = (int)(green*255.0);
  b = (int)(blue*255.0);
  render_color = ((r & 0x3) << 6) |
                 ((g & 0x7) << 3)|
                 (b & 0x7);// rgb = 233
}
void mpRenderColorU (unsigned char c) {
  render_color = c;
}

void mpClear() {
  unsigned char c;
  unsigned int c4;
  c = ((clear_color[0] & 0x3) << 6) |
      ((clear_color[1] & 0x7) << 3)|
      (clear_color[2] & 0x7);// rgb = 233
  c4 = (c << 24)|(c << 16)|(c << 8)|c;
  buffer_clear(c4,fb_front ? 0 : 1);
}

void mpVertexPointer (const float *pointer) {
  p_vertex_array = (float*)pointer;
}

void mpDrawArrays(int count) {
  unsigned int d[3];
  int i;
  unsigned int a;
  static int load = 0;
  mp_matrix4 mv,mvp;
  // generate model-view matrix
  mp_matrix4_multiply_matrix4(&mv, &cur_mm, &cur_vm);
  // generate model-view-projection matrix
  mp_matrix4_multiply_matrix4(&mvp, &mv, &cur_pm);
  ftoui(16, mvp.a);

  D3D_COL_ADRS  = fb_front ?FRAME_BUFFER_0 : FRAME_BUFFER_1;
  D3D_COL_VAL = render_color | 0x100;  // y flip
  //alt_dcache_flush(a,count*3*4);
  // set matrix
  D3D_MATRIX_M00 = wb[0];
  D3D_MATRIX_M01 = wb[1];
  D3D_MATRIX_M02 = wb[2];
  D3D_MATRIX_M03 = wb[3];
  D3D_MATRIX_M10 = wb[4];
  D3D_MATRIX_M11 = wb[5];
  D3D_MATRIX_M12 = wb[6];
  D3D_MATRIX_M13 = wb[7];
  D3D_MATRIX_M20 = wb[8];
  D3D_MATRIX_M21 = wb[9];
  D3D_MATRIX_M22 = wb[10];
  D3D_MATRIX_M23 = wb[11];
  D3D_MATRIX_M30 = wb[12];
  D3D_MATRIX_M31 = wb[13];
  D3D_MATRIX_M32 = wb[14];
  D3D_MATRIX_M33 = wb[15];
  D3D_DMA_SIZE = count*3;   // num vertex * x,y,z

  if (count*3 > 0xffff) {
    printf("draw array size over!!\n");
    while(1);
  }
#ifdef __DE0_NANO_SOC__
  D3D_DMA_ADRS = ((unsigned int)p_vertex_array | 0x80000000);  //ACP offset
  //  D3D_DMA_ADRS = p_vertex_array;
#else
  D3D_DMA_ADRS = p_vertex_array;
#endif
  D3D_DMA_STATUS  = 0;  // int mask clear
  D3D_DMA_START  = 0x00010101;  // default CCW
  while(1) {
    if (D3D_DMA_STATUS & 1) {
      D3D_DMA_STATUS = 0;
      break;
    }
  }

}

void mpPopMatrix () {
  if (matrix_stack_ptr == 0) {
    printf("Empty matrix stack is poped\n");
  } else {
    matrix_stack_ptr--;
    *cur_matrix = matrix_stack[matrix_stack_ptr];
  }
}

void mpPushMatrix () {
  if (matrix_stack_ptr >= MP_CONFIG_MAX_MSTACK-1)
    printf("Stack over\n");

  matrix_stack[matrix_stack_ptr] = *cur_matrix;
  matrix_stack_ptr++;
}

void mpLookAt (float eyeX, float eyeY, float eyeZ,
                float centerX, float centerY, float centerZ,
                float upX, float upY, float upZ) {
  // the result is stored in view matrix
  float a[16];
  int i;
  mp_vector3 forward, side, up;
  mp_matrix4 m;

  forward.x = (float)(centerX - eyeX);
  forward.y = (float)(centerY - eyeY);
  forward.z = (float)(centerZ - eyeZ);

  up.x = (float)upX;
  up.y = (float)upY;
  up.z = (float)upZ;

  mp_vector3_normalize(&forward);

  mp_vector3_cross_product0(&side, &forward, &up);
  mp_vector3_normalize(&side);

  mp_vector3_cross_product0(&up, &side, &forward);

  for (i=0; i<16; i++)
    a[i] = 0.0;
  a[0] /*m[0][0]*/ = side.x;
  a[4] /*m[1][0]*/ = side.y;
  a[8] /*m[2][0]*/ = side.z;

  a[1] /*m[0][1]*/ = up.x;
  a[5] /*m[1][1]*/ = up.y;
  a[9] /*m[2][1]*/ = up.z;

  a[2]  /*m[0][2]*/ = -forward.x;
  a[6]  /*m[1][2]*/ = -forward.y;
  a[10] /*m[2][2]*/ = -forward.z;
  a[15] = 1.0;
  mp_matrix4_set0(&m, a);
  mp_matrix4_multiply_matrix4i(cur_matrix, cur_matrix, &m);
  mpTranslate(-eyeX, -eyeY, -eyeZ);
}

void mpPerspective(float fovy, float aspect, float zNear, float zFar) {
  //    float ymax = zNear * tan( fovy * M_PI / 360.0 );
  float ymax = zNear * sin(fovy * M_PI / 360.0) / cos(fovy * M_PI / 360.0);
  float xmax = ymax * aspect;
  mpFrustum(-xmax, xmax, -ymax, ymax, zNear, zFar);
}


void mpMultMatrix (float *m) {
   // for skinning
   mp_matrix4 mat;
   mp_matrix4_set0_t(&mat,m);  // need matrix transpose
   mp_matrix4_multiply_matrix4i(cur_matrix, cur_matrix,&mat);
}

void mpSwapBuffers() {
   video_swap();
}
