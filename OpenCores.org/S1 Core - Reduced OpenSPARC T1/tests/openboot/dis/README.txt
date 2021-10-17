# Unofficial disassembly of the official OpenBoot PROMs obtained with:

# Step 1: from binary to SPARC ELF:
sparc64-linux-objcopy -Ibinary -Oelf64-sparc ../1c1t_obp_prom.bin 1c1t_obp_prom.elf
sparc64-linux-objcopy -Ibinary -Oelf64-sparc ../1c1t_prom.bin     1c1t_prom.elf 

# Step 2: from SPARC ELF to disassembly
sparc64-linux-objdump -D -m sparc:v9 1c1t_obp_prom.elf > 1c1t_obp_prom.dis
sparc64-linux-objdump -D -m sparc:v9 1c1t_prom.elf     > 1c1t_prom.dis

# Step 3: hand replace 1c1t_obp_prom with 1c1t_prom in the first of the two so that you can then easily diff them:

  $ diff 1c1t_obp_prom.dis.bis 1c1t_prom.dis 
  <    f84bc:	f0 08 00 00 	ldub  [ %g0 ], %i0
  >    f84bc:	f1 00 00 00 	ld  [ %g0 ], %f24
  <    f84cc:	00 07 00 00 	illtrap  0x70000
  >    f84cc:	00 40 00 00 	bn,pn   %icc, f84cc <_binary____1c1t_prom_bin_start+0xf84cc>
