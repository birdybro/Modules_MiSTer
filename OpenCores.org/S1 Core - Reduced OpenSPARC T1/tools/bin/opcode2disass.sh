#!/bin/bash -e

# Read input argument
opcode=$1

# File names
tmp_src="tmp$$.s"
tmp_out="tmp$$.o"
rm -f $tmp_src $tmp_out

# Create temporary source file
echo "
.text
.word $opcode
" > $tmp_src

# Compile and dump
sparc64-linux-gcc -c $tmp_src
sparc64-linux-objdump -d $tmp_out | tail -n 1 | cut -b 20-

# Final cleanup
rm -f $tmp_src $tmp_out

