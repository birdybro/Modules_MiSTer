/*
 * Simple FIFO
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
 * Simple FIFO with full and empty status flags (which require an
 * extra bit added to the pointers).
 */

`timescale 1ns/100ps

module simple_fifo #(
  parameter name = "simple_fifo",
  parameter fifo_depth = 8,
  parameter data_width = 64
) (
  // System inputs
  input                                   sys_clock_i,
  input                                   sys_reset_i,

  // FIFO inputs
  input                                   read,
  input                                   write,
  input [(data_width-1):0]                data_in,

  // FIFO outputs
  output                                  empty,
  output                                  full,
  output reg [(data_width-1):0]           data_out
);
  localparam pointer_width = $clog2(fifo_depth);

  // Read/Write Pointers
  logic [(pointer_width-1):0] rd_ptr;
  logic [(pointer_width-1):0] wr_ptr;

  // Memory Array
  logic [(data_width-1):0] mem[fifo_depth];

`ifdef SIMPLY_RISC_DEBUG
  // For debugging
  logic printed_once = 0;
`endif

  // One-process style for reset/read/write
  always @(posedge sys_clock_i) begin

    // Reset
    if (sys_reset_i) begin
`ifdef SIMPLY_RISC_DEBUG
      if (!printed_once) begin
        $display("FIFO %s Asynchronous Clear", name);
        printed_once = 1;
      end
`endif
      rd_ptr = {pointer_width{1'b0}};
      wr_ptr = {pointer_width{1'b0}};

    end else begin

      // Read
      if (read) begin
`ifdef SIMPLY_RISC_DEBUG
        if (empty) $fatal(1, "*** ERROR *** Attempt to read FIFO %s whilst empty", name);
        $display("FIFO %s Read Request: rd_ptr=%0d, data=0x%032X", name, rd_ptr, mem[rd_ptr]);
`endif
        rd_ptr <= rd_ptr + 1;
      end

      // Write
      if (write) begin
`ifdef SIMPLY_RISC_DEBUG
        if (full) $fatal(1, "*** ERROR *** Attempt to write FIFO %s whilst full", name);
        $display("FIFO %s Write Request: wr_ptr=%0d, data=0x%032X", name, wr_ptr, data_in);
`endif
        mem[wr_ptr] <= data_in;
        wr_ptr <= wr_ptr + 1;
      end
    end
  end // always @ (posedge clock)

  // Always output the next element
  assign data_out = mem[rd_ptr];

  // FIFO status flags
  assign empty = (rd_ptr == wr_ptr);
  assign full = ((rd_ptr[pointer_width-2:0] == wr_ptr[pointer_width-2:0]) && (rd_ptr[pointer_width-1] != wr_ptr[pointer_width-1]));

endmodule

