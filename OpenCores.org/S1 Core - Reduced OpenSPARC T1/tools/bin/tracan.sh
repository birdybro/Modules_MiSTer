#!/bin/bash -e

# Take from the trace.vcd file (passed as argument)
# only the lines of outgoing and incoming packets
# (read README.txt for details).

if [ $# != 1 ]; then
  echo "Tracan - Trace Analyzer"
  echo "Usage:"
  echo "      tracan <VCDFILE>"
  echo ""
  exit 1
fi

# VCD symbols as defined in tracan.h
#const char VCD_ID_PCX_REQ   = '!';
#const char VCD_ID_PCX_ATOM  = '^';
#const char VCD_ID_PCX_DATA  = '"';
#const char VCD_ID_PCX_GRANT = 'f';
#const char VCD_ID_CPX_READY = '#';
#const char VCD_ID_CPX_DATA  = '$';
egrep ' \!$|^1\^$| "$| f$| #$| \$$' $1 | egrep -v "x|b00000 " | sed -e 's/^b//g' | sed -e 's/1^/1 ^/g' | tracan.bin

