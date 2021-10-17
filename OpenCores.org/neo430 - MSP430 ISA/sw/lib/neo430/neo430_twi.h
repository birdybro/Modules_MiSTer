// #################################################################################################
// #  < neo430_twi.h - Internal Two Wire Serial interface functions >                              #
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

#ifndef neo430_twi_h
#define neo430_twi_h

// prototypes
void    neo430_twi_enable(uint8_t prsc);   // configure and activate TWI module
void    neo430_twi_disable(void);          // deactivate TWI module
uint8_t neo430_twi_start_trans(uint8_t a); // start transmission (START) and send address and r/w bit
uint8_t neo430_twi_trans(uint8_t d);       // send byte to active slave
uint8_t neo430_twi_get_data(void);         // get last received data byte
void    neo430_twi_stop_trans(void);       // stop transmission (STOP)
void    neo430_twi_generate_start(void);   // generate start condition


/* ------------------------------------------------------------
 * INFO Activate (and reset) TWI module
 * PARAM clock prescaler
 * ------------------------------------------------------------ */
void neo430_twi_enable(uint8_t prsc) {

  TWI_CT = 0;
  TWI_CT = (1 << TWI_CT_ENABLE) | (prsc << TWI_CT_PRSC0);
}


/* ------------------------------------------------------------
 * INFO Deactivate TWI module
 * ------------------------------------------------------------ */
void neo430_twi_disable(void) {

  TWI_CT = 0;
}


/* ------------------------------------------------------------
 * INFO Generate START condition and send first byte (address & R/W)
 * PARAM 8-bit including 7-bit address and read/write bit
 * RETURN 0 if ACK received, 0xff if no valid ACK was received
 * ------------------------------------------------------------ */
uint8_t neo430_twi_start_trans(uint8_t a) {

  neo430_twi_generate_start(); // generate START condition

  TWI_DATA = (uint16_t)a; // send data
  while(TWI_CT & (1 << TWI_CT_BUSY)); // wait until idle again

  // check for ACK/NACK
  if (TWI_DATA & (1 << TWI_DT_ACK))
    return 0x00; // ACK received
  else
    return 0xff; // NACK received
}


/* ------------------------------------------------------------
 * INFO Send data and also sample input data
 * PARAM Data byte to be sent
 * RETURN 0 if ACK received, 0xff if no valid ACK was received
 * ------------------------------------------------------------ */
uint8_t neo430_twi_trans(uint8_t d) {

  TWI_DATA = (uint16_t)d; // send data
  while(TWI_CT & (1 << TWI_CT_BUSY)); // wait until idle again

  // check for ACK/NACK
  if (TWI_DATA & (1 << TWI_DT_ACK))
    return 0x00; // ACK received
  else
    return 0xff; // NACK received
}


/* ------------------------------------------------------------
 * INFO Get receive data from previous transmission
 * RETURN Last received data byte
 * ------------------------------------------------------------ */
uint8_t neo430_twi_get_data(void) {

  return (uint8_t)TWI_DATA; // get RX data from previous transmission
}


/* ------------------------------------------------------------
 * INFO Generate STOP condition
 * ------------------------------------------------------------ */
void neo430_twi_stop_trans(void) {

  TWI_CT |= (1 << TWI_CT_STOP); // generate STOP condition
  while(TWI_CT & (1 << TWI_CT_BUSY)); // wait until idle again
}


/* ------------------------------------------------------------
 * INFO Generate START condition
 * ------------------------------------------------------------ */
void neo430_twi_generate_start(void) {

  TWI_CT |= (1 << TWI_CT_START); // generate START condition
  while(TWI_CT & (1 << TWI_CT_BUSY)); // wait until idle again
}


#endif // neo430_twi_h
