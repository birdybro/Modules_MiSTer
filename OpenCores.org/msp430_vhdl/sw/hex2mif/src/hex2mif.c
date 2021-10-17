//#include <windows.h>
#include <stdio.h>
#include <stdlib.h>

void usage(void);
void error(int errorcode);
unsigned int hex2bin(char c);

FILE* ihex = NULL;
FILE* amif = NULL;

int main(int argc, char *argv[])
{
  char ihex_filename[256];
  char amif_filename[256];
  int words;
  int bits;
  unsigned char data[65536];
  unsigned int address = 0;
  unsigned int byte_count = 0;
  unsigned int start_address = 0;
  int first_data_rec = 1;
  unsigned int index;
  unsigned int pos_h;
  unsigned int pos_l;
  char line[512];
  int i;

//////////////////////////////////////////////////////////////////
// Read arguments
//////////////////////////////////////////////////////////////////
  if (argc < 5)
  {
    usage(); error(1);
  }

  strcpy(ihex_filename, &argv[1][0]);
  strcpy(amif_filename, &argv[2][0]);

  if (sscanf(argv[3], "%d", &words) != 1)
  {
    usage(); error(2);
  }

  if (words > 32768)
  {
    printf("Word count too large (max = 32768)\n"); error(3);
  }

  if (sscanf(argv[4], "%d", &bits) != 1)
  {
    usage(); error(4);
  }

//////////////////////////////////////////////////////////////////  
// Open files
//////////////////////////////////////////////////////////////////  
  if ((ihex = fopen(ihex_filename, "rt")) == NULL)
  {
    printf("Missing %s", ihex_filename); error(5);
  }
  if ((amif = fopen(amif_filename, "wt")) == NULL)
  {
    printf("Cannot open %s", amif_filename); error(6);
  }

//////////////////////////////////////////////////////////////////  
// Read input file
//////////////////////////////////////////////////////////////////  
  printf("%s -> %s\n", ihex_filename, amif_filename);
  printf("Converting...");

for (i=0; i<65536; i++) data[i] = 0xFF;

  fscanf(ihex, "%s", line);
  while(!feof(ihex))
  {
    if (line[0] != ':')
    {
      printf("hex file error\n"); error(7);
    }
    
    if ((line[7] == '0') && (line[8] == '0')) // data record
    {
       byte_count = (hex2bin(line[1]) << 4) + hex2bin(line[2]);
       address = (hex2bin(line[3]) << 12) + (hex2bin(line[4]) << 8) + (hex2bin(line[5]) << 4) + hex2bin(line[6]);
       if (first_data_rec == 1) 
       {
          start_address = address;
          first_data_rec = 0;
       }

       for (i=0; i<byte_count; i++)
       {
           index = address - start_address + i;
           pos_h = 2*i + 9;
           pos_l = 2*i + 10;
           if ((index <= 65536) && (pos_l < strlen(line)))
              data[index] = (hex2bin(line[pos_h]) << 4) + hex2bin(line[pos_l]);
           else
              error(8);
       }
    }
    fscanf(ihex, "%s", line);
  }

//////////////////////////////////////////////////////////////////  
// Generate output file
//////////////////////////////////////////////////////////////////  
  //fprintf(amif, "\n-- Clearbox generated Memory Initialization File (.mif)\n");
  fprintf(amif, "\nWIDTH=%d;\n", bits);
  fprintf(amif, "DEPTH=%d;\n\n", words);
  fprintf(amif, "ADDRESS_RADIX=HEX;\n");
  fprintf(amif, "DATA_RADIX=HEX;\n\n");
  fprintf(amif, "CONTENT BEGIN\n");
  for (address=0; address<words; address++)
  {
    fprintf(amif, "\t%04x  :   %04X;\n", address, (data[2*address+1] << 8) + data[2*address]);
  }
  fprintf(amif, "END;\n");

//////////////////////////////////////////////////////////////////  
// Close files
//////////////////////////////////////////////////////////////////  
  if (ihex != NULL) fclose(ihex);
  if (amif != NULL) fclose(amif);
  printf("finished\n");
  return 0;
}

void usage(void)
{
  printf("Usage: hex2mif.exe <intel.hex> <altera.mif> <words> <bits>\n");
  printf(" e.g.: hex2mif.exe intel.hex altera.mif 4096 16\n");
}

void error(int error_code)
{
  if (ihex != NULL) fclose(ihex);
  if (amif != NULL) fclose(amif);
  printf("\nError %d\n", error_code);
  exit(1);
}

unsigned int hex2bin(char c)
{
  if ((c >= '0') && (c <= '9')) 
    return(c - 0x30);
  else if ((c >= 'A') && (c <= 'F'))
    return(c - 'A' + 10);
  else
    return(0);
}
