//=======================================================================
// Project Monophony
//   Wire-Frame 3D Graphics Accelerator IP Core
//
// File:
//   mp_vector3.c
//
// Abstract:
//   vector3 implementation
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
#include "mp_vector3.h"

void mp_vector3_mp_vector3(mp_vector3 *dst) {
    dst->x = 0.0;
    dst->y = 0.0;
    dst->z = 0.0;
}

void mp_vector3_set0(mp_vector3 *dst, float lx,  float ly,  float lz) {
    dst->x = lx;
    dst->y = ly;
    dst->z = lz;
}

void mp_vector3_set2(mp_vector3 *dst, mp_vector3 *v) {
    dst->x = v->x; 
    dst->y = v->y; 
    dst->z = v->z; 
}

int mp_vector3_is_zero_vector(mp_vector3 *dst) {
    if (dst->x < 0 &&
        dst->y < 0 &&
        dst->z < 0) return 1;

    return 0;
}

float mp_vector3_size(mp_vector3 *dst) {
    float t = dst->x*dst->x + dst->y*dst->y + dst->z*dst->z;
    t = sqrt(t);
    return t;
}

float mp_vector3_size2(mp_vector3 *dst) {
    float t = dst->x*dst->x + dst->y*dst->y + dst->z*dst->z;
    return t;
}

void mp_vector3_normalize(mp_vector3 *dst) {
    float t = mp_vector3_size(dst);
    if (t <= 0) {

        dst->x = 0;
        dst->y = 0;
        dst->z = 0;
    } else {
      t = 1.0F/t;
      dst->x *= t;
      dst->y *= t;
      dst->z *= t;
    }
}

void mp_vector3_cross_product0(mp_vector3 *dst, mp_vector3 *a,  mp_vector3 *b){
    dst->x = a->y*b->z - b->y*a->z;
    dst->y = a->z*b->x - b->z*a->x;
    dst->z = a->x*b->y - b->x*a->y;
}

void mp_vector3_cross_product1(mp_vector3 *dst, mp_vector3 *b) {
    dst->x = dst->y*b->z - b->y*dst->z;
    dst->y = dst->z*b->x - b->z*dst->x;
    dst->z = dst->x*b->y - b->x*dst->y;
}

float mp_vector3_inner_product0(mp_vector3 *dst, mp_vector3 *a) {
    float t = dst->x*a->x + dst->y*a->y + dst->z*a->z;
    return t;
}

float mp_vector3_inner_product1(float x,  float y,  float z){
    float t = x*x + y*y + z*z;
    return t;
}

float mp_vector3_inner_product3( mp_vector3 *a,  mp_vector3 *b) {
    float t = a->x*b->x+a->y*b->y+a->z*b->z;
    return t;
}

void mp_vector3_scale(mp_vector3 *dst, float t) {
    dst->x *= t;
    dst->y *= t;
    dst->z *= t;
}

void mp_vector3_add0(mp_vector3 *dst, mp_vector3 *v) {
    dst->x += v->x;
    dst->y += v->y;
    dst->z += v->z;
}

void mp_vector3_subtract0(mp_vector3 *dst, mp_vector3 *v) {
    dst->x -= v->x;
    dst->y -= v->y;
    dst->z -= v->z;
}

void mp_vector3_assign0(mp_vector3 *dst, mp_vector3 *v) {
    dst->x = v->x;
    dst->y = v->y;
    dst->z = v->z;
}

