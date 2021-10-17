//=======================================================================
// Project Monophony
//   Wire-Frame 3D Graphics Accelerator IP Core
//
// File:
//   mp_matrix4.c
//
// Abstract:
//   matrix4 class implementation
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
#include "mp_matrix4.h"
#include "mp_lib.h"

extern t_fui u_fui;

static int TR[16] = { 0,4,8,12,1,5,9,13,2,6,10,14,3,7,11,15 };
static int AA[16][16] = {
        /* aa00 */ {5,6,7,9,10,11,13,14,15},
        /* aa10 */ {1,2,3,9,10,11,13,14,15},
        /* aa20 */ {1,2,3,5,6,7,13,14,15},
        /* aa30 */ {1,2,3,5,6,7,9,10,11},
        /* aa01 */ {4,6,7,8,10,11,12,14,15},
        /* aa11 */ {0,2,3,8,10,11,12,14,15},
        /* aa21 */ {0,2,3,4,6,7,12,14,15},
        /* aa31 */ {0,2,3,4,6,7,8,10,11},
        /* aa02 */ {4,5,7,8,9,11,12,13,15},
        /* aa12 */ {0,1,3,8,9,11,12,13,15},
        /* aa22 */ {0,1,3,4,5,7,12,13,15},
        /* aa32 */ {0,1,3,4,5,7,8,9,11},
        /* aa03 */ {4,5,6,8,9,10,12,13,14},
        /* aa13 */ {0,1,2,8,9,10,12,13,14},
        /* aa23 */ {0,1,2,4,5,6,12,13,14},
        /* aa33 */ {0,1,2,4,5,6,8,9,10}};

void mp_matrix4_init(mp_matrix4 *dst) {
	int i;
    for (i=0;i<16;i++) dst->a[i] = 0.0;
    dst->a[0] = dst->a[5] = dst->a[10] = dst->a[15] = 1.0;
}

void mp_matrix4_set0(mp_matrix4 *dst, float b[]) {
	int i;
    for (i=0;i<16;i++) dst->a[i] = b[i];
}

void mp_matrix4_set0_t(mp_matrix4 *dst, float b[]) {
	int i;
    for (i=0;i<16;i++) dst->a[TR[i]] = b[i];
}

void mp_matrix4_set1(mp_matrix4 *dst, unsigned int b[]) {
	int i;
    for (i = 0; i <16; i++) {
        u_fui.ui= b[i];
        dst->a[i] = u_fui.f;
    }
}

void mp_matrix4_set2(mp_matrix4 *dst, mp_matrix4 *t) {
	int i;
    for (i=0;i<16;i++) dst->a[i] = t->a[i];
}

void mp_matrix4_identity(mp_matrix4 *dst) {
  mp_matrix4_init(dst);
}

void mp_matrix4_assign(mp_matrix4 *dst, mp_matrix4 *v) {
	int i;
    for (i=0 ; i < 16 ; i++ ) dst->a[i] = v->a[i];
}

void mp_matrix4_multiply_vector4(mp_vector4 *dst, mp_matrix4 *m, mp_vector4 *v) {
    mp_vector4 t;
    mp_vector4_set2(&t, v);
    dst->x = m->a[0]*t.x + m->a[1]*t.y + m->a[2]*t.z + m->a[3]*t.w;
    dst->y = m->a[4]*t.x + m->a[5]*t.y + m->a[6]*t.z + m->a[7]*t.w;
    dst->z = m->a[8]*t.x + m->a[9]*t.y + m->a[10]*t.z + m->a[11]*t.w;
    dst->w = m->a[12]*t.x + m->a[13]*t.y + m->a[14]*t.z + m->a[15]*t.w;
}

void mp_matrix4_multiply_f(mp_matrix4 *m, float *v) {
    float r[4];
    r[0] = m->a[0]*v[0] + m->a[1]*v[1] + m->a[2]*v[2] + m->a[3]*v[3];
    r[1] = m->a[4]*v[0] + m->a[5]*v[1] + m->a[6]*v[2] + m->a[7]*v[3];
    r[2] = m->a[8]*v[0] + m->a[9]*v[1] + m->a[10]*v[2] + m->a[11]*v[3];
    r[3] = m->a[12]*v[0] + m->a[13]*v[1] + m->a[14]*v[2] + m->a[15]*v[3];
    v[0] = r[0];
    v[1] = r[1];
    v[2] = r[2];
    v[3] = r[3];
}

void mp_matrix4_multiply_f2(mp_matrix4 *m, float *dst, float *src) {
    // w is always 1.0
    dst[0] = m->a[0]*src[0] + m->a[1]*src[1] + m->a[2]*src[2] + m->a[3];
    dst[1] = m->a[4]*src[0] + m->a[5]*src[1] + m->a[6]*src[2] + m->a[7];
    dst[2] = m->a[8]*src[0] + m->a[9]*src[1] + m->a[10]*src[2] + m->a[11];
    dst[3] = m->a[12]*src[0] + m->a[13]*src[1] + m->a[14]*src[2] + m->a[15];
}

void mp_matrix4_multiply_matrix4(mp_matrix4 *dst, mp_matrix4 *mm, mp_matrix4 *b) {
    int i,j,k,m,n,p,r,s;
    mp_matrix4 c;
    for ( i = r = 0 ; i < 4 ; i ++, r += 4 ) {
        for ( j = 0 ; j < 4 ; j ++ ) {
            m = r + j;
            c.a[m] = 0.0;
            for ( k = s = 0 ; k < 4 ; k++, s += 4 ){
                n = r + k;
                p = s + j;
                c.a[m] += b->a[n] * mm->a[p];
            }
        }
    }
    for ( k = 0 ; k < 16 ; k++ ) dst->a[k] = c.a[k];
}

void mp_matrix4_multiply_matrix4i(mp_matrix4 *dst, mp_matrix4 *mm, mp_matrix4 *b) {
    int i,j,k,m,n,p,r,s;
    mp_matrix4 c;
    for ( i = r = 0 ; i < 4 ; i ++, r += 4 ) {
        for ( j = 0 ; j < 4 ; j ++ ) {
            m = r + j;
            c.a[m] = 0.0;
            for ( k = s = 0 ; k < 4 ; k++, s += 4 ){
                n = r + k;
                p = s + j;
                c.a[m] += mm->a[n] * b->a[p];
            }
        }
    }
    for ( k = 0 ; k < 16 ; k++ ) dst->a[k] = c.a[k];
}

void mp_matrix4_transpose(mp_matrix4 *dst,mp_matrix4 *src) {
	int i;
    for (i = 0 ; i < 16 ; i++ ){
        dst->a[i] = src->a[TR[i]];
    }
}

void mp_matrix4_inverse(mp_matrix4 *dst,mp_matrix4 *src) {
    float determinant4, determinant3;
    float v[9];

    int m,n,sign;
    int i,j;
    mp_matrix3 w;
    for (i=0 ; i < 16 ; i++ ){
        m = (i+1)/4 + 1; n = (i+1)%4;
        if (n==0) { n = 4; m--; }
        if ((m+n)%2 == 1) sign = -1; else sign = 1;
        for (j=0 ; j < 9 ; j++ ) v[j] = src->a[AA[i][j]];
        mp_matrix3_set0(&w, v);
        determinant3 = mp_matrix3_determinant0(&w);
        dst->a[i] = sign * determinant3;
    }
    determinant4 = 
            src->a[0]*dst->a[0]
          + src->a[4]*dst->a[1]
          + src->a[8]*dst->a[2]
          + src->a[12]*dst->a[3];

    determinant4 = 1.0F / determinant4;
    for (i=0 ; i < 16 ; i++ ) dst->a[i] *= determinant4;
}

void mp_matrix4_rotate(mp_matrix4 *dst, mp_vector3 *v,  float theta) {
    mp_matrix3 m3a;
    mp_matrix3_init(&m3a);
    mp_matrix3_rotate0(&m3a, v, theta);
    mp_matrix4_init(dst);
    dst->a[0] = m3a.a[0];
    dst->a[1] = m3a.a[1];
    dst->a[2] = m3a.a[2];
    dst->a[4] = m3a.a[3];
    dst->a[5] = m3a.a[4];
    dst->a[6] = m3a.a[5];
    dst->a[8] = m3a.a[6];
    dst->a[9] = m3a.a[7];
    dst->a[10] = m3a.a[8];
}

void mp_matrix4_get_elements(mp_matrix4 *dst, unsigned int *b) {
    int i;
	for (i = 0; i <16; i++) {
        u_fui.f= dst->a[i];
        b[i] = u_fui.ui;
    }
}

