//=======================================================================
// Project Monophony
//   Wire-Frame 3D Graphics Accelerator IP Core
//
// File:
//   mp_vector4.h
//
// Abstract:
//   vector4 implementation
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
#include "mp_vector4.h"

void mp_vector4_init(mp_vector4 *dst) {
    dst->x = 0.0;
    dst->y = 0.0;
    dst->z = 0.0;
    dst->w = 0.0;
}

void mp_vector4_set0(mp_vector4 *dst, float lx,  float ly,  float lz) {
    dst->x = lx;
    dst->y = ly;
    dst->z = lz;
    dst->w = 1.0;
}

void mp_vector4_set1(mp_vector4 *dst, float lx,  float ly,
                                      float lz,  float lw) {
    dst->x = lx;
    dst->y = ly;
    dst->z = lz;
    dst->w = lw;
}

void mp_vector4_set2(mp_vector4 *dst, mp_vector4 *v) {
    dst->x = v->x;
    dst->y = v->y;
    dst->z = v->z;
    dst->w = v->w;
}

void mp_vector4_normalize(mp_vector4 *dst) {
    float t = dst->x*dst->x + dst->y*dst->y + dst->z*dst->z + dst->w*dst->w;
    t = sqrt(t);
    t = 1.0F/t;
    dst->x = dst->x * t;
    dst->y = dst->y * t;
    dst->z = dst->z * t;
    dst->w = dst->w * t;
}

