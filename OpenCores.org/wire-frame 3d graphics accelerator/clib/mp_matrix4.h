//=======================================================================
// Project Monophony
//   Wire-Frame 3D Graphics Accelerator IP Core
//
// File:
//   mp_matrix4.h
//
// Abstract:
//   4x4 matrix header
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

#ifndef __MP_MATRIX4_H__
#define __MP_MATRIX4_H__

#include "mp_vector3.h"
#include "mp_vector4.h"
#include "mp_matrix3.h"

typedef struct _mp_matrix4 {
    float a[16];

} mp_matrix4;

// functions
void mp_matrix4_init(mp_matrix4 *dst);
void mp_matrix4_set0(mp_matrix4 *dst, float b[]);
void mp_matrix4_set0_t(mp_matrix4 *dst, float b[]);
void mp_matrix4_set1(mp_matrix4 *dst, unsigned int b[]);
void mp_matrix4_set2(mp_matrix4 *dst, mp_matrix4 *t);

void mp_matrix4_identity(mp_matrix4 *dst);
void mp_matrix4_assign(mp_matrix4 *dst, mp_matrix4 *v);
void mp_matrix4_multiply_vector4(mp_vector4 *dst, mp_matrix4 *m, mp_vector4 *v);
void mp_matrix4_multiply_f(mp_matrix4 *m, float *v);
void mp_matrix4_multiply_f2(mp_matrix4 *m, float *dst ,float *src);

void mp_matrix4_multiply_matrix4(mp_matrix4 *dst, mp_matrix4 *mm, mp_matrix4 *b);
void mp_matrix4_multiply_matrix4i(mp_matrix4 *dst, mp_matrix4 *mm, mp_matrix4 *b);
void mp_matrix4_transpose(mp_matrix4 *dst,mp_matrix4 *src);
void mp_matrix4_inverse(mp_matrix4 *dst,mp_matrix4 *src);
void mp_matrix4_rotate(mp_matrix4 *dst, mp_vector3 *v,  float theta);
void mp_matrix4_get_elements(mp_matrix4 *dst, unsigned int *b);

#endif
