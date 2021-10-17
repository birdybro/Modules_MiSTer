hex2mif.exe "..\iar_test\Debug\Exe\test.a43" "..\..\fpga\quartus\ram_init.mif" 4096 16
rem mif file must be in quartus project folder, otherwise quartus II 8.1 will not find it, but will not generate error message
pause
