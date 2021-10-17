/*
 * PCX FIFO
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
 * Replica of the 'pcx_fifo' module used by Dmitry for his advanced
 * bridge, the original one was from an Altera SCFIFO Megafunction.
 */

`timescale 1ns/100ps

`define PCX_FIFO_DATA_WIDTH 130

module pcx_fifo(
  // System
  input aclr,   // Async Clear (resets the FIFO to empty)
  input clock,  // Clock

  // FIFO
  input rdreq,                               // Read Request (when not empty)
  input wrreq,                               // Write Request (when not full)
  input [(`PCX_FIFO_DATA_WIDTH-1):0] data,   // Data Input
  output empty,                              // FIFO is empty
  output full,                               // FIFO is full
  output reg [(`PCX_FIFO_DATA_WIDTH-1):0] q  // Data Output (oldest data when Read Request)
);

  // Local Params TODO CHECKME
  localparam fifo_depth = 32;    // TODO Dmitry says this should be enough, put an assertion to detect overflow
  localparam pointer_width = 6;  // 5 bits to address 32 elements + 1 to detect wrapping

  // Read/Write Pointers
  logic [(pointer_width-1):0] rd_ptr;
  logic [(pointer_width-1):0] wr_ptr;

  // Memory Array
  logic [(`PCX_FIFO_DATA_WIDTH-1):0] mem[fifo_depth];

`ifdef SIMPLY_RISC_DEBUG
  // For debugging
  logic printed_once = 0;
`endif

  // One-process style for reset/read/write
  always @(posedge clock) begin
    // Reset
    if (aclr) begin
`ifdef SIMPLY_RISC_DEBUG
      if (!printed_once) begin
        $display("PCX FIFO Asynchronous Clear");
        printed_once = 1;
      end
`endif
      rd_ptr = {pointer_width{1'b0}};
      wr_ptr = {pointer_width{1'b0}};
    end else begin
      // Read
      if (rdreq) begin
`ifdef SIMPLY_RISC_DEBUG
        if (empty) $fatal(1, "*** ERROR *** Attempt to read PCX FIFO whilst empty");
        $display("PCX FIFO Read Request: rd_ptr=%0d, data=0x%032X", rd_ptr, mem[rd_ptr]);
`endif
        q <= mem[rd_ptr];
        rd_ptr <= rd_ptr + 1;
      end
      // Write
      if (wrreq) begin
`ifdef SIMPLY_RISC_DEBUG
        if (full) $fatal(1, "*** ERROR *** Attempt to write PCX FIFO whilst full");
        $display("PCX FIFO Write Request: wr_ptr=%0d, data=0x%032X", wr_ptr, data);
`endif
        mem[wr_ptr] <= data;
        wr_ptr <= wr_ptr + 1;
      end
    end
  end // always @ (posedge clock)

  // FIFO status flags
  assign empty = (rd_ptr == wr_ptr);
  assign full = ((rd_ptr[pointer_width-2:0] == wr_ptr[pointer_width-2:0]) && (rd_ptr[pointer_width-1] != wr_ptr[pointer_width-1]));

endmodule // pcx_fifo

