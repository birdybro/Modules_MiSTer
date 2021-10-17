//=======================================================================
// Project Monophony
//   Wire-Frame 3D Graphics Accelerator IP Core
//
// File:
//   mp_hwdep.c
//
// Abstract:
//   Hardware dependent function for ZedBoard
//
// Author:
//   Kenji Ishimaru (kenji.ishimaru@gmail.com)
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
#include <stdio.h>

volatile int fb_front = 0;

void buffer_clear(unsigned int c,int bank) {
  unsigned int i;
  unsigned int a,ae;
  if (bank==1) a = FRAME_BUFFER_1;
  else a = FRAME_BUFFER_0;
  ae = a+0x4b000;  // 640x480x8
  for (i = a; i < ae; i += 4 ) {
    (*(volatile unsigned int  *)i) = c;
  }
}

void video_init() {
  SYS_FB0_OFFSET = FRAME_BUFFER_0;
  SYS_FB1_OFFSET = FRAME_BUFFER_1;
  printf("FB0: %x\n",SYS_FB0_OFFSET);
  printf("FB1: %x\n",SYS_FB1_OFFSET);
  SYS_FRONT_BUFFER = 0;
  SYS_VIDEO_INT_MASK = 3;
  SYS_COLOR_MODE = 2;  // 8bit color
  fb_front = 0;    // BANK0 is displayed
  // clear screen
  printf("COLOR MODE %d\n",SYS_COLOR_MODE);
  // Video Start
  SYS_VIDEO_START = 0x00000001;
}

void video_swap() {
  int video_status;
  //VIDEO_INT_CLEAR = 0;
  video_status = SYS_VIDEO_STATUS;
  while (!(video_status & 0x1))  {
    video_status = SYS_VIDEO_STATUS;
  }
  if (fb_front == 0) fb_front = 1;
  else fb_front = 0;
  SYS_FRONT_BUFFER = fb_front;
}

void hw_init() {
  init_platform();
  SYS_AXI_CONFIG = 0xffffffff;
}

