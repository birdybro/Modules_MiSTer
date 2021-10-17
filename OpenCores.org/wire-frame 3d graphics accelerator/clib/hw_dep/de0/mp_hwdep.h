//=======================================================================
// Project Monophony
//   Wire-Frame 3D Graphics Accelerator IP Core
//
// File:
//   mp_hwdep.h
//
// Abstract:
//   Hardware dependent function header
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

#ifndef __HW_DEP_H__
#define __HW_DEP_H__
#include <unistd.h>
#include <system.h>
// 0 - 0x007FFFFF
#define FRAME_BUFFER_0  NEW_SDRAM_CONTROLLER_0_BASE+0x00580000
#define FRAME_BUFFER_1  NEW_SDRAM_CONTROLLER_0_BASE+0x00600000
#define VERTEX_BUFFER   NEW_SDRAM_CONTROLLER_0_BASE+0x00680000

#define VIDEO_START  (*(volatile unsigned int  *)(FM_VGA_WRAPPER_0_BASE| 0x80000000))
#define FB0_OFFSET   (*(volatile unsigned int  *)((FM_VGA_WRAPPER_0_BASE+0x04)|0x80000000))
#define FB1_OFFSET   (*(volatile unsigned int  *)((FM_VGA_WRAPPER_0_BASE+0x08)|0x80000000))
#define COLOR_MODE   (*(volatile unsigned int  *)((FM_VGA_WRAPPER_0_BASE+0x14)|0x80000000))
#define VIDEO_STATUS (*(volatile unsigned int  *)((FM_VGA_WRAPPER_0_BASE+0x20)|0x80000000))
#define VIDEO_INT_CLEAR (*(volatile unsigned int  *)((FM_VGA_WRAPPER_0_BASE+0x24)|0x80000000))
#define VIDEO_INT_MASK  (*(volatile unsigned int  *)((FM_VGA_WRAPPER_0_BASE+0x28)|0x80000000))
#define FRONT_BUFFER    (*(volatile unsigned int  *)((FM_VGA_WRAPPER_0_BASE+0x2c)|0x80000000))

#define D3D_DMA_START  (*(volatile unsigned int  *)(FM_3D_WRAPPER_0_BASE|0x80000000))
#define D3D_DMA_STATUS (*(volatile unsigned int  *)((FM_3D_WRAPPER_0_BASE+0x4)|0x80000000))
#define D3D_DMA_ADRS   (*(volatile unsigned int  *)((FM_3D_WRAPPER_0_BASE+0x8)|0x80000000))
#define D3D_DMA_SIZE   (*(volatile unsigned int  *)((FM_3D_WRAPPER_0_BASE+0xc)|0x80000000))
#define D3D_MATRIX_M00 (*(volatile unsigned int  *)((FM_3D_WRAPPER_0_BASE+0x10)|0x80000000))
#define D3D_MATRIX_M01 (*(volatile unsigned int  *)((FM_3D_WRAPPER_0_BASE+0x14)|0x80000000))
#define D3D_MATRIX_M02 (*(volatile unsigned int  *)((FM_3D_WRAPPER_0_BASE+0x18)|0x80000000))
#define D3D_MATRIX_M03 (*(volatile unsigned int  *)((FM_3D_WRAPPER_0_BASE+0x1c)|0x80000000))
#define D3D_MATRIX_M10 (*(volatile unsigned int  *)((FM_3D_WRAPPER_0_BASE+0x20)|0x80000000))
#define D3D_MATRIX_M11 (*(volatile unsigned int  *)((FM_3D_WRAPPER_0_BASE+0x24)|0x80000000))
#define D3D_MATRIX_M12 (*(volatile unsigned int  *)((FM_3D_WRAPPER_0_BASE+0x28)|0x80000000))
#define D3D_MATRIX_M13 (*(volatile unsigned int  *)((FM_3D_WRAPPER_0_BASE+0x2c)|0x80000000))
#define D3D_MATRIX_M20 (*(volatile unsigned int  *)((FM_3D_WRAPPER_0_BASE+0x30)|0x80000000))
#define D3D_MATRIX_M21 (*(volatile unsigned int  *)((FM_3D_WRAPPER_0_BASE+0x34)|0x80000000))
#define D3D_MATRIX_M22 (*(volatile unsigned int  *)((FM_3D_WRAPPER_0_BASE+0x38)|0x80000000))
#define D3D_MATRIX_M23 (*(volatile unsigned int  *)((FM_3D_WRAPPER_0_BASE+0x3c)|0x80000000))
#define D3D_MATRIX_M30 (*(volatile unsigned int  *)((FM_3D_WRAPPER_0_BASE+0x40)|0x80000000))
#define D3D_MATRIX_M31 (*(volatile unsigned int  *)((FM_3D_WRAPPER_0_BASE+0x44)|0x80000000))
#define D3D_MATRIX_M32 (*(volatile unsigned int  *)((FM_3D_WRAPPER_0_BASE+0x48)|0x80000000))
#define D3D_MATRIX_M33 (*(volatile unsigned int  *)((FM_3D_WRAPPER_0_BASE+0x4c)|0x80000000))
#define D3D_FSCR_W (*(volatile unsigned int  *)((FM_3D_WRAPPER_0_BASE+0x50)|0x80000000))
#define D3D_FSCR_H (*(volatile unsigned int  *)((FM_3D_WRAPPER_0_BASE+0x54)|0x80000000))
#define D3D_ISCR_W_M1 (*(volatile unsigned int  *)((FM_3D_WRAPPER_0_BASE+0x58)|0x80000000))
#define D3D_ISCR_H_M1 (*(volatile unsigned int  *)((FM_3D_WRAPPER_0_BASE+0x5c)|0x80000000))
#define D3D_ISCR_W (*(volatile unsigned int  *)((FM_3D_WRAPPER_0_BASE+0x60)|0x80000000))
#define D3D_COL_ADRS    (*(volatile unsigned int  *)((FM_3D_WRAPPER_0_BASE+0x64)|0x80000000))
#define D3D_COL_VAL    (*(volatile unsigned int  *)((FM_3D_WRAPPER_0_BASE+0x68)|0x80000000))

void buffer_clear(unsigned int c,int bank);
void video_init();
void video_swap();
void hw_init();
#endif
