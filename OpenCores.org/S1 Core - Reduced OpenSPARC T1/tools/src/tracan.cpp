
#include "tracan.h"

// Useful functions
void reverse_string(char *s) {
  char t, *e = s + strlen(s);
  while (--e > s) { t = *s;*s++=*e;*e=t; }
}
unsigned long long bitsToInt(char *bit_vector, int bit_pos_max, int bit_pos_min) {
  unsigned long long value = 0;
  unsigned int len = strlen(bit_vector);
  if (bit_pos_min < 0 || bit_pos_min > bit_pos_max || bit_pos_max >= len) {
    printf("*** ERROR *** Invalid substring boundaries MIN=%d MAX=%d LEN=%d", bit_pos_min, bit_pos_max, len);
    exit(1);
  }
  for(unsigned long long i = 0; i <= bit_pos_max-bit_pos_min; i++) {
    if (bit_vector[bit_pos_min+i]=='1')
      value += (1ULL<<i);
  }
  return value;
}

// Print functions
void print_pcx_req(char *buf) {
  if    (!strcmp(buf, "10000")) printf("PCX_REQ RAM_DDR_0 ");
  else if (!strcmp(buf, "01000")) printf("PCX_REQ RAM_DDR_1 ");
  else if (!strcmp(buf, "00100")) printf("PCX_REQ RAM_DDR_2 ");
  else if (!strcmp(buf, "00010")) printf("PCX_REQ RAM_DDR_3 ");
  else if (!strcmp(buf, "00001")) printf("PCX_REQ ROM_IOBridge ");
  else printf("PCX_REQ Unknown_%s ", buf);
}
void print_pcx_atom(char *buf) {
  if (!strcmp(buf, "1"))
    printf("ATOMIC_");
}
void print_pcx_data(char *buf) {
  char str_type[20], str_size[20];
  if (!bitsToInt(buf, PCX_VLD,PCX_VLD)) return;
  switch(bitsToInt(buf, PCX_RQ_HI,PCX_RQ_LO)) {
    case LOAD_RQ:    strcpy(str_type, "LOAD_RQ");    break;
    case IMISS_RQ:   strcpy(str_type, "IMISS_RQ");   break;
    case STORE_RQ:   strcpy(str_type, "STORE_RQ");   break;
    case CAS1_RQ:    strcpy(str_type, "CAS1_RQ");    break;
    case CAS2_RQ:    strcpy(str_type, "CAS2_RQ");    break;
    case SWAP_RQ:    strcpy(str_type, "SWAP_RQ");    break;
    case STRLOAD_RQ: strcpy(str_type, "STRLOAD_RQ"); break;
    case STRST_RQ:   strcpy(str_type, "STRST_RQ");   break;
    case STQ_RQ:     strcpy(str_type, "STQ_RQ");     break;
    case INT_RQ:     strcpy(str_type, "INT_RQ");     break;
    case FWD_RQ:     strcpy(str_type, "FWD_RQ");     break;
    case FWD_RPY:    strcpy(str_type, "FWD_RPY");    break;
    case RSVD_RQ:    strcpy(str_type, "RSVD_RQ");    break;
    case ATOM_REQ_A: strcpy(str_type, "ATOM_REQ_A"); break;  // Added for S1 Core
    case ATOM_REQ_B: strcpy(str_type, "ATOM_REQ_B"); break;  // Added for S1 Core
    default:         sprintf(str_type, "Unknown_0x%02llX", bitsToInt(buf, PCX_RQ_HI,PCX_RQ_LO));
  }
  switch(bitsToInt(buf, PCX_SZ_HI,PCX_SZ_LO)) {
    case PCX_SZ_1B:  strcpy(str_size, "1B");  break;
    case PCX_SZ_2B:  strcpy(str_size, "2B");  break;
    case PCX_SZ_4B:  strcpy(str_size, "4B");  break;
    case PCX_SZ_8B:  strcpy(str_size, "8B");  break;
    case PCX_SZ_16B: strcpy(str_size, "16B"); break;
    default:         sprintf(str_size, "Unknown_0x%02llX", bitsToInt(buf, PCX_SZ_HI,PCX_SZ_LO));
  }
  printf("PCX_DATA Valid=%llu Type=%s NonCache_RnW=%llu PE=%llu.%llu Buffer=%llu L1Way_Packet=%llu Size=%s Address=0x%010llX Store_Data=0x%016llX\n",
         bitsToInt(buf, PCX_VLD,PCX_VLD), str_type, bitsToInt(buf, PCX_R,PCX_R), bitsToInt(buf, PCX_CP_HI,PCX_CP_LO), bitsToInt(buf, PCX_TH_HI,PCX_TH_LO),
         bitsToInt(buf, PCX_BF_HI,PCX_BF_LO), bitsToInt(buf, PCX_WY_HI,PCX_WY_LO), str_size,
         bitsToInt(buf, PCX_AD_HI,PCX_AD_LO), bitsToInt(buf, PCX_DA_HI,PCX_DA_LO));
}
void print_pcx_grant(char *buf) {
  if    (!strcmp(buf, "10000")) printf("PCX_GRANT RAM_DDR_0\n");
  else if (!strcmp(buf, "01000")) printf("PCX_GRANT RAM_DDR_1\n");
  else if (!strcmp(buf, "00100")) printf("PCX_GRANT RAM_DDR_2\n");
  else if (!strcmp(buf, "00010")) printf("PCX_GRANT RAM_DDR_3\n");
  else if (!strcmp(buf, "00001")) printf("PCX_GRANT ROM_IOBridge\n");
  else printf("PCX_GRANT Unknown_%s\n", buf);
}
void print_cpx_ready(char *buf) {
  printf("CPX_READY %s\n", buf);
}
void print_cpx_data(char *buf) {
  char str_type[20];
  if (!bitsToInt(buf, CPX_VLD,CPX_VLD)) return;
  switch(bitsToInt(buf, CPX_RQ_HI,CPX_RQ_LO)) {
    case LOAD_RET:    strcpy(str_type, "LOAD_RET");    break;
    case INV_RET:     strcpy(str_type, "INV_RET__AT_ACK__EVICT_REQ"); break;
    case ST_ACK:      strcpy(str_type, "ST_ACK");      break;
    case INT_RET:     strcpy(str_type, "INT_RET");     break;
    case TEST_RET:    strcpy(str_type, "TEST_RET");    break;
    case FP_RET:      strcpy(str_type, "FP_RET");      break;
    case IFILL_RET:   strcpy(str_type, "IFILL_RET");   break;
    case ERR_RET:     strcpy(str_type, "ERR_RET");     break;
    case STRLOAD_RET: strcpy(str_type, "STRLOAD_RET"); break;
    case STRST_ACK:   strcpy(str_type, "STRST_ACK");   break;
    case FWD_RQ_RET:  strcpy(str_type, "FWD_RQ_RET");  break;
    case FWD_RPY_RET: strcpy(str_type, "FWD_RPY_RET"); break;
    case RSVD_RET:    strcpy(str_type, "RSVD_RET");    break;
    default:          sprintf(str_type, "Unknown_0x%02llX", bitsToInt(buf, CPX_RQ_HI,CPX_RQ_LO));
  }
  printf("CPX_DATA Valid=%llu Type=%s Error=%llu NonCache_RnW=%llu Thread=%llu IntSrc_etc=0x%04llX Load_Data=0x%016llX%016llX\n",
         bitsToInt(buf, CPX_VLD,CPX_VLD), str_type, bitsToInt(buf, CPX_ERR_HI-1,CPX_ERR_LO), bitsToInt(buf, CPX_R,CPX_R), bitsToInt(buf, CPX_TH_HI,CPX_TH_LO),
         bitsToInt(buf, CPX_IN_HI,CPX_IN_LO), bitsToInt(buf, CPX_DA_HI,CPX_DA_LO+64), bitsToInt(buf, CPX_DA_LO+63,CPX_DA_LO));
}

// Main function
int main() {
  char bit_vector[200];
  char signal_type;
  while(!feof(stdin)) {
    fscanf(stdin, "%s %c\n", bit_vector, &signal_type);
    reverse_string(bit_vector);
    switch (signal_type) {
    case VCD_ID_PCX_REQ:   print_pcx_req(bit_vector);    break;
    case VCD_ID_PCX_ATOM:  print_pcx_atom(bit_vector);   break;
    case VCD_ID_PCX_DATA:  print_pcx_data(bit_vector);   break;
    case VCD_ID_PCX_GRANT: print_pcx_grant(bit_vector);  break;
    case VCD_ID_CPX_READY: print_cpx_ready(bit_vector);  break;
    case VCD_ID_CPX_DATA:  print_cpx_data(bit_vector);   break;
    }
  }
}

