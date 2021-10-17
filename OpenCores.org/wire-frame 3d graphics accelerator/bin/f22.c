//=======================================================================
// Project Monophony
//   Wire-Frame 3D Graphics Accelerator IP Core
//
// File:
//   f22.c
//
// Abstract:
//   22-bit floating point number utility
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

#include <stdio.h>


union {
  unsigned int ui;
  float f;
} uif;

float cnv_f22_to_f32(unsigned int a) {
  // extract sign
  unsigned int tmp_s = (a >> 21) & 1;
  // extract exp
  unsigned int tmp_e = (a >> 16) & 0x1f;
  unsigned int tmp_oe = (a >> 16) & 0x1f;
  // extract fraction(with integer bit)
  unsigned int tmp_m = a  & 0xffff;
  if ((tmp_oe != 0)||(tmp_m != 0)) {
    tmp_e -= 15;
    tmp_e += 127;
  }
  // denormal
  if ((tmp_oe == 0)&&(tmp_m != 0)) {
    while (((tmp_m >> 15)&1) != 1) {
	tmp_m = tmp_m << 1;
	tmp_e--;
    }
  }
  tmp_m = (tmp_m << 1) & 0xfff; // remove integer bit
  unsigned int t =   (tmp_s << 31) | (tmp_e << 23) | (tmp_m << 7);
  uif.ui = t;
  return uif.f;
}

int main() {
  unsigned int x;
  while (1) {
    printf("f22 = ");
    scanf("%x", &x);
    printf("float value = %f\n",cnv_f22_to_f32(x));
  }

}
