m68k-elf-gcc -c -m68008 -mno-mac -mno-68881 -mno-68851 -mno-hwdiv --mri -o test.o test.s && m68k-elf-objdump -D test.o && m68k-elf-objcopy -O binary test.o test.bin && hexdump -f dump.fmt test.bin > test.rom && rm -f test.o && rm -f test.bin
