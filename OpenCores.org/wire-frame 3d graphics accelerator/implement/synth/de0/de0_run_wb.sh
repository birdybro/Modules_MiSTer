#!/bin/sh

cd qtproject_wb

quartus_map --read_settings_files=on --write_settings_files=off d3d -c d3d
quartus_fit --read_settings_files=off --write_settings_files=off d3d -c d3d
quartus_asm --read_settings_files=off --write_settings_files=off d3d -c d3d
quartus_sta d3d -c d3d
