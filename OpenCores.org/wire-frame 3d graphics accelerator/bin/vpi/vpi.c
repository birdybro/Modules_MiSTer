//=======================================================================
// Project Monophony
//   Wire-Frame 3D Graphics Accelerator IP Core
//
// File:
//   vpi.c
//
// Abstract:
//   VPI source code for Icarus Verilog
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
#include <string.h>

#include "vpi_user.h"

#define TRUE 1
#define FALSE 0

/* local prototypes */
static int count_systf_args(vpiHandle);

/* global prototypes */
PLI_INT32 hello(void);
PLI_INT32 to_float32(void);
PLI_INT32 to_real32(void);
PLI_INT32 to_float22(void);
extern void register_my_systfs(void); 
extern void register_my_systfs(void);

/*
 * possible pattern for register vpi_ system tasks and functions
 */

/*
 * this is routine to implement registered systf call back
 *
 * notice vpi_user.h requires function return int so using dummy 0
 */
PLI_INT32 hello(void)
{
 vpiHandle href, iref;

 href = vpi_handle(vpiSysTfCall, NULL); 
 if (href == NULL) 
  {
   vpi_printf("** ERR: $hello PLI 2.0 can not access systf call handle\n");
   return(0);
  }
 if ((iref = vpi_iterate(vpiArgument, href)) != NULL)
  { 
   vpi_printf(
    "**ERR: $hello PLI 2.0 task called with %d arguments but none allowed\n",
    count_systf_args(iref));
   return(0);
  }
 vpi_printf("hello world\n");
 return(0);
}


PLI_INT32 to_float32(void)
{
  vpiHandle href, iref , ret_ref, in_ref;
  int numargs;
  s_vpi_value tmpval;
  union {
    float f;
    unsigned int u;
  } _uf;

 href = vpi_handle(vpiSysTfCall, NULL); 
 if (href == NULL) 
  {
   vpi_printf("** ERR: $to_float32 PLI 2.0 can not access systf call handle\n");
   return(0);
  }
 if ((iref = vpi_iterate(vpiArgument, href)) != NULL)
  { 
   numargs = vpi_get(vpiSize, iref);
   /* vpi_printf("numargs = %d\n",numargs); */
   ret_ref = vpi_scan(iref);

   in_ref = vpi_scan(iref);
   tmpval.format = vpiRealVal; 
   vpi_get_value(in_ref, &tmpval);
   /*
   vpi_printf(
    "$to_float32 float %f\n",tmpval.value.real);
   */
   _uf.f = tmpval.value.real;
   tmpval.format = vpiIntVal;
   tmpval.value.integer = _uf.u;
   vpi_put_value (ret_ref, &tmpval, NULL, vpiNoDelay);
   return(0);
  }
 return(0);
}

PLI_INT32 to_real32(void)
{
  vpiHandle href, iref , ret_ref, in_ref;
  int numargs;
  s_vpi_value tmpval;
  union {
    float f;
    unsigned int u;
  } _uf;

 href = vpi_handle(vpiSysTfCall, NULL); 
 if (href == NULL) 
  {
   vpi_printf("** ERR: $to_real32 PLI 2.0 can not access systf call handle\n");
   return(0);
  }
 if ((iref = vpi_iterate(vpiArgument, href)) != NULL)
  { 
   numargs = vpi_get(vpiSize, iref);
   /* vpi_printf("numargs = %d\n",numargs); */
   ret_ref = vpi_scan(iref);

   in_ref = vpi_scan(iref);
   tmpval.format = vpiIntVal; 
   vpi_get_value(in_ref, &tmpval);
   /*
   vpi_printf(
    "$to_float32 float %f\n",tmpval.value.real);
   */
   _uf.u = tmpval.value.integer;
   tmpval.format = vpiRealVal;
   tmpval.value.real = (double)_uf.f;
   vpi_put_value (ret_ref, &tmpval, NULL, vpiNoDelay);
   return(0);
  }
 return(0);
}


// float32 to float 22
//   float32 : s = 1bit, e = 8bit, m = 23bit (bias:127)
//   float22 : s = 1bit, e = 5bit, m = 16bit (bias:15)
unsigned int cnv_f32_to_f22(unsigned int a) {
  // extract sign
  unsigned int tmp_s = (a >> 31) & 1;
  // extract exp
  int tmp_e = (a >> 23) & 0xff;
  tmp_e -= 127;
  tmp_e += 15;
  if (tmp_e < 0) tmp_e = 0;
  // extract fraction
  unsigned int rbit = (a >> 7) & 1;// bit 7
  unsigned int tmp_m = (a >> 8)& 0x7fff;
  if (rbit) tmp_m++;
  if (tmp_e != 0) tmp_m |= 0x8000;
  return  (tmp_s << 21) | (tmp_e << 16) | tmp_m;
}


PLI_INT32 to_float22(void)
{
  vpiHandle href, iref , ret_ref, in_ref;
  int numargs;
  s_vpi_value tmpval;
  union {
    float f;
    unsigned int u;
  } _uf;

 href = vpi_handle(vpiSysTfCall, NULL); 
 if (href == NULL) 
  {
   vpi_printf("** ERR: $to_float22 PLI 2.0 can not access systf call handle\n");
   return(0);
  }
 if ((iref = vpi_iterate(vpiArgument, href)) != NULL)
  { 
   numargs = vpi_get(vpiSize, iref);
   /* vpi_printf("numargs = %d\n",numargs); */
   ret_ref = vpi_scan(iref);

   in_ref = vpi_scan(iref);
   tmpval.format = vpiRealVal; 
   vpi_get_value(in_ref, &tmpval);
   /*
   vpi_printf(
    "$to_float32 float %f\n",tmpval.value.real);
   */
   _uf.f = tmpval.value.real;
   tmpval.format = vpiIntVal;
   tmpval.value.integer =  cnv_f32_to_f22(_uf.u);
   vpi_put_value (ret_ref, &tmpval, NULL, vpiNoDelay);
   return(0);
  }
 return(0);
}


/*
 * count arguments
 */
static int count_systf_args(vpiHandle iref)
{
 int anum = 0;

 while (vpi_scan(iref) != NULL) anum++;
 return(anum);
}

/* Template functin table for added user systf tasks and functions.
   See file vpi_user.h for structure definition
   Note only vpi_register_systf and vpi_ or tf_ utility routines that 
   do not access the simulation data base may be called from these routines
*/ 

/* all routines are called to register system tasks */
/* called just after all PLI 1.0 tf_ veriusertfs table routines are set up */
/* before source is read */ 
void (*vlog_startup_routines[]) () =
{
 register_my_systfs, 
 0
};

/* routine to do the systf registering - probably should go in other file */
/* usually only vpi_ PLI 2.0 systf registering is done here */

/*
 * register all vpi_ PLI 2.0 style user system tasks and functions
 */
void register_my_systfs(void)
{
 p_vpi_systf_data systf_data_p;

 /* use predefined table form - could fill systf_data_list dynamically */
 static s_vpi_systf_data systf_data_list[] = {
  { vpiSysTask, 0, "$hello", hello, NULL, NULL, NULL },
  { vpiSysTask, 0, "$to_float32", to_float32, NULL, NULL, NULL },
  { vpiSysTask, 0, "$to_real32", to_real32, NULL, NULL, NULL },
  { vpiSysTask, 0, "$to_float22", to_float22, NULL, NULL, NULL },
  { 0, 0, NULL, NULL, NULL, NULL, NULL }
 };

 systf_data_p = &(systf_data_list[0]);
 while (systf_data_p->type != 0) vpi_register_systf(systf_data_p++);
}

void vpi_compat_bootstrap(void)
{
 int i;

 for (i = 0;; i++) 
  {
   if (vlog_startup_routines[i] == NULL) break; 
   vlog_startup_routines[i]();
  }
}
