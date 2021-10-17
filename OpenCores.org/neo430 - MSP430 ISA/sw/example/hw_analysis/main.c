// #################################################################################################
// #  < Processor hardware analysis tool >                                                         #
// # ********************************************************************************************* #
// #  Prints various information from the system.                                                  #
// # ********************************************************************************************* #
// # This file is part of the NEO430 Processor project: https://github.com/stnolting/neo430        #
// # Copyright by Stephan Nolting: stnolting@gmail.com                                             #
// #                                                                                               #
// # This source file may be used and distributed without restriction provided that this copyright #
// # statement is not removed from the file and that any derivative work contains the original     #
// # copyright notice and the associated disclaimer.                                               #
// #                                                                                               #
// # This source file is free software; you can redistribute it and/or modify it under the terms   #
// # of the GNU Lesser General Public License as published by the Free Software Foundation,        #
// # either version 3 of the License, or (at your option) any later version.                       #
// #                                                                                               #
// # This source is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;      #
// # without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.     #
// # See the GNU Lesser General Public License for more details.                                   #
// #                                                                                               #
// # You should have received a copy of the GNU Lesser General Public License along with this      #
// # source; if not, download it from https://www.gnu.org/licenses/lgpl-3.0.en.html                #
// # ********************************************************************************************* #
// # Stephan Nolting, Hannover, Germany                                                 17.11.2018 #
// #################################################################################################


// Libraries
#include <stdint.h>
#include <stdlib.h>
#include <neo430.h>

// Configuration
#define BAUD_RATE 19200

// Prototypes
void print_state(uint16_t d);


/* ------------------------------------------------------------
 * INFO Main function
 * ------------------------------------------------------------ */
int main(void) {

  // setup UART
  neo430_uart_setup(BAUD_RATE);

  // intro text
  neo430_printf("\nNEO430 Hardware Analysis Tool\n\n");

  // General information
  // --------------------------------------------
  // HW version
  neo430_printf("Hardware version: 0x%x\n", HW_VERSION);

  // HW user code
  neo430_printf("User code:        0x%x\n", USER_CODE);
  
  // Clock speed
  uint32_t clock = CLOCKSPEED_32bit;
  neo430_printf("Clock speed:      %n Hz\n", clock);

  // ROM/IMEM
  neo430_printf("IMEM/ROM:         %u bytes @ 0x0000\n", IMEM_SIZE);

  // RAM/DMEM
  neo430_printf("DMEM/RAM:         %u bytes @ 0x%x\n", DMEM_SIZE, DMEM_BASE);

  // UART baud rate
  uint16_t baud = UART_CT & 0x00FF;
  uint16_t prsc;
  switch ((UART_CT >> 8) & 0x0007) {
    case 0:  prsc = 2; break;
    case 1:  prsc = 4; break;
    case 2:  prsc = 8; break;
    case 3:  prsc = 64; break;
    case 4:  prsc = 128; break;
    case 5:  prsc = 1024; break;
    case 6:  prsc = 2048; break;
    case 7:  prsc = 4096; break;
    default: prsc = 0; break;
  }
  uint32_t baud_value = clock / (uint32_t)(prsc * baud);
  neo430_printf("UART Baud rate:   %n\n", baud_value);


  // System features
  // --------------------------------------------
  uint16_t ft = SYS_FEATURES;
  neo430_printf("\n\nSystem features\n");
  // CFU
  neo430_printf("- Multiplier/Divider:    ");
  print_state(ft & (1<<SYS_MULDIV_EN));
  // WB32
  neo430_printf("- Wishbone adapter:      ");
  print_state(ft & (1<<SYS_WB32_EN));
  // WDT
  neo430_printf("- Watchdog timer:        ");
  print_state(ft & (1<<SYS_WDT_EN));
  // GPIO
  neo430_printf("- GPIO unit:             ");
  print_state(ft & (1<<SYS_GPIO_EN));
  // TIMER
  neo430_printf("- High-precision timer:  ");
  print_state(ft & (1<<SYS_TIMER_EN));
  // UART
  neo430_printf("- UART:                  ");
  print_state(ft & (1<<SYS_UART_EN));
  // SPI
  neo430_printf("- SPI:                   ");
  print_state(ft & (1<<SYS_SPI_EN));
  // DADD
  neo430_printf("- DADD instruction:      ");
  print_state(ft & (1<<SYS_DADD_EN));
  // Bootloader installed
  neo430_printf("- Internal bootloader:   ");
  print_state(ft & (1<<SYS_BTLD_EN));
  // is IMEM true ROM?
  neo430_printf("- IMEM as true ROM:      ");
  print_state(ft & (1<<SYS_IROM_EN));
  // CRC
  neo430_printf("- CRC16/CRC32:           ");
  print_state(ft & (1<<SYS_CRC_EN));
  // CFU
  neo430_printf("- Custom Functions Unit: ");
  print_state(ft & (1<<SYS_CFU_EN));
  // PWM
  neo430_printf("- PWM Controller:        ");
  print_state(ft & (1<<SYS_PWM_EN));
  // TWI
  neo430_printf("- Two Wire Interface:    ");
  print_state(ft & (1<<SYS_TWI_EN));


  // Exit
  // --------------------------------------------
  neo430_printf("\n\nPress any key to return to bootloader.\n");
  while(!neo430_uart_char_received());

  if (!(SYS_FEATURES & (1<<SYS_BTLD_EN)))
    neo430_printf("No bootloader installed!\n");
  else
    asm volatile ("mov #0xF000, r0");

  return 0;
}


/* ------------------------------------------------------------
 * INFO print state
 * ------------------------------------------------------------ */
void print_state(uint16_t d) {

  if (d)
    neo430_printf("enabled\n");
  else
    neo430_printf("DISABLED\n");
}
