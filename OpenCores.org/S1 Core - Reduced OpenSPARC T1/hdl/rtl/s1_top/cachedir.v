/*
 * CacheDir
 *
 * (C) Copyleft 2007 Fabrizio Fazzino
 *
 * LICENSE:
 * This is a Free Hardware Design; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * version 2 as published by the Free Software Foundation.
 * The above named program is distributed in the hope that it will
 * be useful, but WITHOUT ANY WARRANTY; without even the implied
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 * See the GNU General Public License for more details.
 *
 * DESCRIPTION:
 * Replica of the 'cachedir' module used by Dmitry for his advanced
 * bridge, the original one was from an Altera Memory Megafunction.
 */

`timescale 1ns/100ps

`define CACHEDIR_ADDR_WIDTH  9
`define CACHEDIR_DATA_WIDTH 29

module cachedir(
  // System
  input clock,
  input enable,

  // Port A
  input wren_a,
  input [(`CACHEDIR_ADDR_WIDTH-1):0] address_a,
  input [(`CACHEDIR_DATA_WIDTH-1):0] data_a,
  output [(`CACHEDIR_DATA_WIDTH-1):0] q_a,
   
  // Port B
  input wren_b,
  input [(`CACHEDIR_ADDR_WIDTH-1):0] address_b,
  input [(`CACHEDIR_DATA_WIDTH-1):0] data_b,
  output [(`CACHEDIR_DATA_WIDTH-1):0] q_b
);

  // Memory Array
  logic [(`CACHEDIR_DATA_WIDTH-1):0] mem[(1<<`CACHEDIR_ADDR_WIDTH)-1];

  // Read Logic (TODO: may be gate by enable to save power)
  assign q_a = mem[address_a];
  assign q_b = mem[address_b];

  // Write Process (TODO: may be gated by some reset)
  always @(posedge clock) begin
    if(wren_a) begin
`ifdef SIMPLY_RISC_DEBUG
      $display("CacheDir Write Enable Port A");
`endif
      mem[address_a] <= data_a;
    end
    if(wren_b) begin
`ifdef SIMPLY_RISC_DEBUG
      $display("CacheDir Write Enable Port B");
`endif
      mem[address_b] <= data_b;
    end
  end

endmodule // cachedir

