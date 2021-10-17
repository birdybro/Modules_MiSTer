#!/usr/bin/perl

#=======================================================================
# Project Monophony
#   Wire-Frame 3D Graphics Accelerator IP Core
#
# File:
#   objcnv.pl
#
# Abstract:
#    Wavefront OBJ converter
#    input isOBJ file, output C include header file
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

use strict;
#$, = '_';       #separater
$, = ' ';       #separater
$\ = "\n";

if (@ARGV < 1) {
  die "usage : objcnv.pl [input file.obj] [output file.h]\n";
}

# global registers

my $vcnt = 0;
my $fcnt = 0;

my @vertices_x;
my @vertices_y;
my @vertices_z;
my @faces_0;
my @faces_1;
my @faces_2;

# command analize
my $in_file;
my $out_file;
my $cc = 0;
while (defined(my $carg = shift @ARGV)) {
    if ($cc == 0) {
      $in_file = $carg;
    }
    if ($cc == 1) {
      $out_file = $carg;
    }
    $cc++;
}

print "OBJ file :" . $in_file;
print "output file :" . $out_file;
open(INFILE, $in_file);

# v: vertex
# f: face
# report number of vertices
# report number of faces

while (<INFILE>) {
  chop;
  my $in_str = $_;
  if ($in_str =~ m/^vn/) {
    die("vn:vertex normals not supported.");
  }
  if ($in_str =~ m/^vt/) {
    die("vt:texture vertices not supported.");
  }
  if ($in_str =~ m/^v/) {
    my @item = split(/ /);     # split
    @vertices_x = (@vertices_x, $item[1]);
    @vertices_y = (@vertices_y, $item[2]);
    @vertices_z = (@vertices_z, $item[3]);
    $vcnt++;
    print "processing vertex : " . $vcnt;
  }
    
}
print "Number of vertices : " . $vcnt;
seek(INFILE,0,0); # rewind
while (<INFILE>) {
  chop;
  my $in_str = $_;
  if ($in_str =~ m/^f/) {
    my @item = split(/ /);     # split
    @faces_0 = (@faces_0, $item[1]);
    @faces_1 = (@faces_1, $item[2]);
    @faces_2 = (@faces_2, $item[3]);
    &check_orientation($faces_0[$fcnt],
                       $faces_1[$fcnt],
                       $faces_2[$fcnt]
                       );
    $fcnt++;
    print "processing face : " . $fcnt;

  }
}
print "Number of faces: " . $fcnt;

close(INFILE);

print "Writing C header file: " . $out_file;
open(OUTFILE, ">$out_file");

print OUTFILE "//Number of faces: " . $fcnt;
print OUTFILE "int num_vtx = " . @faces_0 . ";";
print OUTFILE "float vtx_array[] = {";

for (my $i = 0; $i < @faces_0; $i++) {
  print OUTFILE "// face " . $i;
  # v0 face index starts from 1, not 0
  print OUTFILE "//   v0 ";
  print OUTFILE $vertices_x[$faces_0[$i]-1] . ",";
  print OUTFILE $vertices_y[$faces_0[$i]-1] . ",";
  print OUTFILE $vertices_z[$faces_0[$i]-1] . ",";
  # v1
  print OUTFILE "//   v1 ";
  print OUTFILE $vertices_x[$faces_1[$i]-1] . ",";
  print OUTFILE $vertices_y[$faces_1[$i]-1] . ",";
  print OUTFILE $vertices_z[$faces_1[$i]-1] . ",";
  # v2
  print OUTFILE "//   v2 ";
  print OUTFILE $vertices_x[$faces_2[$i]-1] . ",";
  print OUTFILE $vertices_y[$faces_2[$i]-1] . ",";
  if ($i == @faces_0 - 1) {
    print OUTFILE $vertices_z[$faces_2[$i]-1];
  } else {
    print OUTFILE $vertices_z[$faces_2[$i]-1] . ",";
  }

}
print OUTFILE "};";
close(OUTFILE);

print "done.";

sub check_orientation {
   my $vx = $_[0];
   my $vy = $_[1];
   my $vz = $_[2];
   # not implemented
   return 1;
}



