#!/bin/sh


#=======================================================================
# Project Monophony
#   Wire-Frame 3D Graphics Accelerator IP Core
#
# File:
#   run_icarus.sh
#
# Abstract:
#   Icarus Verilog simulation script
#
# Author:
#   Kenji Ishimaru (info.info.wf3d@gmail.com)
#
#======================================================================
#
# Copyright (c) 2015, Kenji Ishimaru
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
#  -Redistributions of source code must retain the above copyright notice,
#   this list of conditions and the following disclaimer.
#  -Redistributions in binary form must reproduce the above copyright notice,
#   this list of conditions and the following disclaimer in the documentation
#   and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
# THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
# OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
# OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
# EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# Revision History

RTL_DIR="../rtl"
TOP_MODULE=top

sim_file=$1
echo "FILE=" $sim_file

iverilog \
    -c ../bin/icarus.cmd \
    -D VSIM \
    -D RTL_DEBUG \
    -y . \
    -y ${RTL_DIR} \
    -y ${RTL_DIR}/core \
    -y ../behavior \
    -y ../scenario/3d \
    -o ${TOP_MODULE} \
    timescale.v \
    ${sim_file}

if [ $? -gt 0 ]; then
  echo "iverilog compile error!"
  exit 1
fi

if [ ! -e ./vpi.vpi ]; then
iverilog-vpi ../bin/vpi/vpi.c
fi

if [ $? -gt 0 ]; then
  echo "iverilog-vpi compile error!"
  exit 1
fi

vvp -m ./vpi.vpi top
