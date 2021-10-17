//=======================================================================
// Project Monophony
//   Wire-Frame 3D Graphics Accelerator IP Core
//
// File:
//   mp_vector3.h
//
// Abstract:
//   vector3 header
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

#ifndef __MP_VECTOR3_H__
#define __MP_VECTOR3_H__

typedef struct _mp_vector3 {
    float x, y, z;
} mp_vector3;

// functions
void mp_vector3_init(mp_vector3 *dst);
void mp_vector3_set0(mp_vector3 *dst,  float lx,  float ly,  float lz);
void mp_vector3_set1(mp_vector3 *dst,  mp_vector3 *v);

int mp_vector3_is_zero_vector(mp_vector3 *dst);
float mp_vector3_size(mp_vector3 *dst);
float mp_vector3_size2(mp_vector3 *dst);
void mp_vector3_normalize(mp_vector3 *dst);
void mp_vector3_cross_product0(mp_vector3 *dst, mp_vector3 *a,  mp_vector3 *b);
void mp_vector3_cross_product1(mp_vector3 *dst, mp_vector3 *b);
float mp_vector3_inner_product0(mp_vector3 *dst, mp_vector3 *a);
float mp_vector3_inner_product1(float x,  float y,  float z);
float mp_vector3_inner_product3( mp_vector3 *a,  mp_vector3 *b);
void mp_vector3_scale(mp_vector3 *dst, float t);
void mp_vector3_add0(mp_vector3 *dst, mp_vector3 *v);
void mp_vector3_subtract0(mp_vector3 *dst, mp_vector3 *v);
void mp_vector3_assign0(mp_vector3 *dst, mp_vector3 *v);

#endif
