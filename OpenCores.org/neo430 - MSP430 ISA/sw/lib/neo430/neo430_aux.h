// #################################################################################################
// #  < neo430_aux.h - Handy helper functions ;) >                                                 #
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
// # Stephan Nolting, Hannover, Germany                                                04.07.2018 #
// #################################################################################################

#ifndef neo430_aux_h
#define neo430_aux_h

// prototypes
uint8_t neo430_config_timer_period(uint32_t f_timer);


/* ------------------------------------------------------------
 * INFO Configure Timer period
 * PARAM Timer frequency in Hz (1Hz ... F_CPU/2)
 * RETURN 0 if successful, -1 if error
 * ------------------------------------------------------------ */
uint8_t neo430_config_timer_period(uint32_t f_timer) {

  uint32_t clock = CLOCKSPEED_32bit;
  uint32_t ticks = (clock / (f_timer*2)) >> 1; // divide by lowest prescaler (=2)

  uint8_t prsc = 0;

  if (ticks == 0)
    return -1; // frequency too high!

  // find prescaler
  while(prsc < 8) {
    if (ticks <= 0x0000ffff)
      break;
    else {
      if ((prsc == 2) || (prsc == 4))
        ticks >>= 3;
      else
        ticks >>= 1;
      prsc++;
    }
  }

  TMR_THRES = (uint16_t)ticks;
  TMR_CT &= ~(7<<TMR_CT_PRSC0);
  TMR_CT |= (prsc<<TMR_CT_PRSC0);
  TMR_CNT = 0;

  return 0;
}


#endif // neo430_aux_h
