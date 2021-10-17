//=======================================================================
// Project Monophony
//   Wire-Frame 3D Graphics Accelerator IP Core
//
// File:
//   mp_hwdep.h
//
// Abstract:
//   Hardware dependent function header for ZedBoard
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

#ifndef __HW_DEP_H__
#define __HW_DEP_H__

#define __ZEDBOARD__
#include "platform.h"

// from lscript.ld
//   DDR is mapped to 0010_0000 to 1fff_ffff, 512MB(0-1fff_ffff)
//   (Accessible to all interconnect masters)
//   Monophony uses upper-half 256MB 1000_0000-1fff_ffff

#define VERTEX_BUFFER   0x10000000
#define FRAME_BUFFER_0  0x11000000
#define FRAME_BUFFER_1  0x12000000

// from system.hdf
#define M_AXI_BASE 0x43c00000
#define MP_SYSTEM_BASE M_AXI_BASE
#define MP_RASTER_BASE M_AXI_BASE+0x100
// System
#define MP_AXI_MASTER_CONFIG

#define SYS_VIDEO_START  (*(volatile unsigned int  *)(MP_SYSTEM_BASE))
#define SYS_FB0_OFFSET   (*(volatile unsigned int  *)(MP_SYSTEM_BASE+0x04))
#define SYS_FB1_OFFSET   (*(volatile unsigned int  *)(MP_SYSTEM_BASE+0x08))
#define SYS_COLOR_MODE   (*(volatile unsigned int  *)(MP_SYSTEM_BASE+0x14))
#define SYS_AXI_CONFIG   (*(volatile unsigned int  *)(MP_SYSTEM_BASE+0x18))
#define SYS_VIDEO_STATUS (*(volatile unsigned int  *)(MP_SYSTEM_BASE+0x20))
#define SYS_VIDEO_INT_CLEAR (*(volatile unsigned int  *)(MP_SYSTEM_BASE+0x24))
#define SYS_VIDEO_INT_MASK  (*(volatile unsigned int  *)(MP_SYSTEM_BASE+0x28))
#define SYS_FRONT_BUFFER    (*(volatile unsigned int  *)(MP_SYSTEM_BASE+0x2c))

#define D3D_DMA_START  (*(volatile unsigned int  *)(MP_RASTER_BASE))
#define D3D_DMA_STATUS (*(volatile unsigned int  *)(MP_RASTER_BASE+0x4))
#define D3D_DMA_ADRS   (*(volatile unsigned int  *)(MP_RASTER_BASE+0x8))
#define D3D_DMA_SIZE   (*(volatile unsigned int  *)(MP_RASTER_BASE+0xc))
#define D3D_MATRIX_M00 (*(volatile unsigned int  *)(MP_RASTER_BASE+0x10))
#define D3D_MATRIX_M01 (*(volatile unsigned int  *)(MP_RASTER_BASE+0x14))
#define D3D_MATRIX_M02 (*(volatile unsigned int  *)(MP_RASTER_BASE+0x18))
#define D3D_MATRIX_M03 (*(volatile unsigned int  *)(MP_RASTER_BASE+0x1c))
#define D3D_MATRIX_M10 (*(volatile unsigned int  *)(MP_RASTER_BASE+0x20))
#define D3D_MATRIX_M11 (*(volatile unsigned int  *)(MP_RASTER_BASE+0x24))
#define D3D_MATRIX_M12 (*(volatile unsigned int  *)(MP_RASTER_BASE+0x28))
#define D3D_MATRIX_M13 (*(volatile unsigned int  *)(MP_RASTER_BASE+0x2c))
#define D3D_MATRIX_M20 (*(volatile unsigned int  *)(MP_RASTER_BASE+0x30))
#define D3D_MATRIX_M21 (*(volatile unsigned int  *)(MP_RASTER_BASE+0x34))
#define D3D_MATRIX_M22 (*(volatile unsigned int  *)(MP_RASTER_BASE+0x38))
#define D3D_MATRIX_M23 (*(volatile unsigned int  *)(MP_RASTER_BASE+0x3c))
#define D3D_MATRIX_M30 (*(volatile unsigned int  *)(MP_RASTER_BASE+0x40))
#define D3D_MATRIX_M31 (*(volatile unsigned int  *)(MP_RASTER_BASE+0x44))
#define D3D_MATRIX_M32 (*(volatile unsigned int  *)(MP_RASTER_BASE+0x48))
#define D3D_MATRIX_M33 (*(volatile unsigned int  *)(MP_RASTER_BASE+0x4c))
#define D3D_FSCR_W (*(volatile unsigned int  *)(MP_RASTER_BASE+0x50))
#define D3D_FSCR_H (*(volatile unsigned int  *)(MP_RASTER_BASE+0x54))
#define D3D_ISCR_W_M1 (*(volatile unsigned int  *)(MP_RASTER_BASE+0x58))
#define D3D_ISCR_H_M1 (*(volatile unsigned int  *)(MP_RASTER_BASE+0x5c))
#define D3D_ISCR_W (*(volatile unsigned int  *)(MP_RASTER_BASE+0x60))
#define D3D_COL_ADRS    (*(volatile unsigned int  *)(MP_RASTER_BASE+0x64))
#define D3D_COL_VAL    (*(volatile unsigned int  *)(MP_RASTER_BASE+0x68))

void buffer_clear(unsigned int c,int bank);
void video_init();
void video_swap();
void hw_init();
#endif
