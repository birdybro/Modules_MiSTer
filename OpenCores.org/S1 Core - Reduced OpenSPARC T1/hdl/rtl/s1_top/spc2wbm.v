/*
 * Bridge from SPARC Core to Wishbone Master
 *
 * (C) 2006-2007 Fabrizio Fazzino
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
 * This block implements a bridge from one SPARC Core of the
 * OpenSPARC T1 to a master interface that makes use of the
 * Wishbone interconnect protocol.
 * For informations about Sun Microsystems' OpenSPARC T1
 * refer to the web site http://www.opensparc.net
 * For informations about OpenCores' Wishbone interconnect
 * please refer to the web site http://www.opencores.org
 */

`include "s1_defs.h"
`define SPC_REGION_HI 4
`define SPC_REGION_LO 0
`define SPC_REGION_WIDTH (`SPC_REGION_HI-`SPC_REGION_LO+1)
`define SPC_INFO_WIDTH (`SPC_REGION_WIDTH+1)

module spc2wbm (

    /*
     * Inputs
     */

    // System inputs
    input sys_clock_i,                            // System Clock
    input sys_reset_i,                            // System Reset
    input[5:0] sys_interrupt_source_i,            // Encoded Interrupt Source

    // SPARC-side inputs connected to the PCX (Processor-to-Cache Xbar) outputs of the SPARC Core
    input[`SPC_REGION_WIDTH-1:0] spc_req_i,       // Request Region
    input spc_atom_i,                             // Atomic Request
    input[(`PCX_WIDTH-1):0] spc_packetout_i,      // Outgoing Packet

    // Wishbone Master interface inputs
    input wbm_ack_i,                              // Ack
    input[(`WB_DATA_WIDTH-1):0] wbm_data_i,       // Data In

    /*
     * Outputs
     */

    // SPARC-side outputs connected to the CPX (Cache-to-Processor Xbar) inputs of the SPARC Core
    output logic[4:0] spc_grant_o,                // Grant
    output reg spc_ready_o,                       // Ready
    output reg[`CPX_WIDTH-1:0] spc_packetin_o,    // Incoming Packet

    // Wishbone Master interface outputs
    output reg wbm_cycle_o,                       // Cycle Start
    output reg wbm_strobe_o,                      // Strobe Request
    output reg wbm_we_o,                          // Write Enable
    output reg[`WB_ADDR_WIDTH-1:0] wbm_addr_o,    // Address Bus
    output reg[`WB_DATA_WIDTH-1:0] wbm_data_o,    // Data Out
    output reg[`WB_DATA_WIDTH/8-1:0] wbm_sel_o    // Select Output

  );

  /*
   * Packet Structures
   */

  // Processor-to-Cache Xbar request region and atomic info
  typedef struct packed {
    logic [`SPC_REGION_WIDTH-1:0] region;         // info[5:1] Region
    logic                         atomic;         // info[0]   Atomicity
  } pcx_info_t;

  // Processor-to-Cache Xbar request packet type (PCX payload 124-bit)
  typedef struct packed {
    logic	                          valid;         // pcx[123]       Packet Valid
    logic [`PCX_RQ_HI-`PCX_RQ_LO:0] request_type;  // pcx[122:118]   Request Type (LOAD_/IMISS_/STORE_/CAS1_/CAS2_/SWAP_/STRLOAD_/STRST_/STQ_/INT_/FWD_/RSVD_RQ FWD_RPY)
    logic                           noncache_rnw;  // pcx[117]       Non-Cacheable, or ReadNotWrite
    logic [`PCX_CP_HI-`PCX_CP_LO:0] cpu_id;        // pcx[116:114]   CPU ID
    logic [`PCX_TH_HI-`PCX_TH_LO:0] thread_id;     // pcx[113:112]   Thread ID
    logic [`PCX_BF_HI-`PCX_BF_LO:0] buffer_id;     // pcx[111:109]   Buffer ID
    logic [`PCX_WY_HI-`PCX_WY_LO:0] l1way_packetid;// pcx[108:107]   L1 Way Replaced, or Packet ID
    logic [`PCX_SZ_HI-`PCX_SZ_LO:0] access_size;   // pcx{106:104]   Access Size (PCX_SZ_1B/_2B/_4B/_8B/16B), or Error Field
    logic [`PCX_AD_HI-`PCX_AD_LO:0] address;       // pcx[103:64]    Address
    logic [`PCX_DA_HI-`PCX_DA_LO:0] store_data;    // pcx[63:0]      Store Data
  } pcx_packet_t;

  // Cache-to-Processor Xbar return packet type (CPX payload 145-bit)
  typedef struct packed {
    logic                             valid;       // cpx[144]     Packet Valid
    logic [`CPX_RQ_HI-`CPX_RQ_LO:0]   return_type; // cpx[143:140] Return Type (LOAD_/INV_/INT_/TEST_/FP_/IFILL_/ERR_/STRLOAD_/FWD_RQ_/FWD_RPY_/RSVD_RET ST_/AT_/STRST_ACK EVICT_REQ)
    logic [`CPX_ERR_HI-`CPX_ERR_LO:0] error;       // cpx[139:137] Error
    logic                             noncache_rnw;// cpx[136]     Non-Cacheable, or ReadNotWrite
    logic [`CPX_TH_HI-`CPX_TH_LO:0]   thread_id;   // cpx[135:134] Thread ID
    logic [`CPX_IN_HI-`CPX_IN_LO:0]   intsrc_etc;  // cpx[133:128] Interrupt Source, or Way Replaced, or Buffer ID, or Packet ID, or Invalidates, etc.
    logic [`CPX_DA_HI-`CPX_DA_LO:0]   load_data;   // cpx[127:0]   Load Data
  } cpx_packet_t;

  /*
   * Useful Function
   */

   function automatic logic[`WB_DATA_WIDTH/8-1:0] pcxsize2wbmsel(logic [`PCX_SZ_HI-`PCX_SZ_LO:0] access_size, logic [`PCX_AD_HI-`PCX_AD_LO:0] address);
     case(access_size)
       `PCX_SZ_1B: return (1'b1    << address[2:0]);
       `PCX_SZ_2B: return (2'b11   << (address[2:1] << 1));
       `PCX_SZ_4B: return (4'b1111 << (address[2] << 2));
       `PCX_SZ_8B: return 8'b11111111;
       `PCX_SZ_16B: return 8'b11111111;  // Requires a 2nd access
       default: return 8'b00000000;
     endcase // case (access_size)
   endfunction

// synopsys translate_off
`ifdef SIMPLY_RISC_DEBUG

  task automatic print_pcx_packet(pcx_info_t _pcx_info, pcx_packet_t _pcx_packet);
    string str_region, str_type, str_size;
    case(_pcx_info.region)
      5'b00001: str_region = "RAM_Bank_0";
      5'b00010: str_region = "RAM_Bank_1";
      5'b00100: str_region = "RAM_Bank_2";
      5'b01000: str_region = "RAM Bank_3";
      5'b10000: str_region = "IO_Block";
      default:  str_region = "Unknown";
    endcase
    case(_pcx_packet.request_type)
      `LOAD_RQ:    str_type = "LOAD_RQ";
      `IMISS_RQ:   str_type = "IMISS_RQ";
      `STORE_RQ:   str_type = "STORE_RQ";
      `CAS1_RQ:    str_type = "CAS1_RQ";
      `CAS2_RQ:    str_type = "CAS2_RQ";
      `SWAP_RQ:    str_type = "SWAP_RQ";
      `STRLOAD_RQ: str_type = "STRLOAD_RQ";
      `STRST_RQ:   str_type = "STRST_RQ";
      `STQ_RQ:     str_type = "STQ_RQ";
      `INT_RQ:     str_type = "INT_RQ";
      `FWD_RQ:     str_type = "FWD_RQ";
      `FWD_RPY:    str_type = "FWD_RPY";
      `RSVD_RQ:    str_type = "RSVD_RQ";
      default:     str_type = "Unknown";
	  endcase
    case(_pcx_packet.access_size)
      `PCX_SZ_1B:  str_size = "1B";
      `PCX_SZ_2B:  str_size = "2B";
      `PCX_SZ_4B:  str_size = "4B";
      `PCX_SZ_8B:  str_size = "8B";
      `PCX_SZ_16B: str_size = "16B";
      default:     str_size = "Unknown";
    endcase
    $display("INFO: PCX: REQUEST Region=%s Atomic=%0d Valid=%0d Type=%s NonCache_RnW=%0d PE=%0d.%0d Buffer=%0d L1Way_Packet=%0d Size=%s Address=0x%016X Store_Data=0x%016X", str_region, _pcx_info.atomic, _pcx_packet.valid, str_type, _pcx_packet.noncache_rnw, _pcx_packet.cpu_id, _pcx_packet.thread_id, _pcx_packet.buffer_id, _pcx_packet.l1way_packetid, str_size, _pcx_packet.address, _pcx_packet.store_data);
  endtask

  task automatic print_cpx_packet(cpx_packet_t _cpx_packet);
    string str_type;
    case(_cpx_packet.return_type)
      `IFILL_RET: str_type = "IFILL_RET";
      `LOAD_RET:  str_type = "LOAD_RET";
      `ST_ACK:    str_type = "ST_ACK";
      default:    str_type = "Unknown";
    endcase
    $display("INFO: CPX: RETURN Valid=%0d Type=%s Error=%0d NonCache_RnW=%0d Thread=%0d IntSrc_etc=0x%0X Load_Data=%016X", _cpx_packet.valid, str_type, _cpx_packet.error, _cpx_packet.noncache_rnw, _cpx_packet.thread_id, _cpx_packet.intsrc_etc, _cpx_packet.load_data);
  endtask

`endif
// synopsys translate_on

   /*
    * Signal declarations
    */
   
   // Delayed signals
   logic [`SPC_REGION_WIDTH-1:0] spc_req_dly1;
   logic [`SPC_REGION_WIDTH-1:0] spc_req_dly2;
   logic                         spc_atom_dly1;
   logic                         spc_atom_dly2;

   // PCX FIFO
   logic [`PCX_WIDTH+`SPC_INFO_WIDTH-1:0] pcx_fifo_data_in;
   logic [`PCX_WIDTH+`SPC_INFO_WIDTH-1:0] pcx_fifo_data_out;
   logic                                  pcx_fifo_read;
   logic                                  pcx_fifo_write;
   logic                                  pcx_fifo_empty;
   logic                                  pcx_fifo_full;

   // CPX FIFO
   logic [`CPX_WIDTH-1:0]                 cpx_fifo_data_in;
   logic [`CPX_WIDTH-1:0]                 cpx_fifo_data_out;
   logic                                  cpx_fifo_read;
   logic                                  cpx_fifo_write;
   logic                                  cpx_fifo_empty;
   logic                                  cpx_fifo_full;

   /*
    * Tasks
    */

   // wbm_clean
   task wbm_clean();
     wbm_cycle_o = 1'b0;
     wbm_strobe_o = 1'b0;
     wbm_we_o     = 1'b0;
     wbm_addr_o   = 'h0;
     wbm_data_o   = 'h0;
     wbm_sel_o    = 'h0;
   endtask // wbm_clean

   /*
    * FIFO instances
    */

  simple_fifo #(
    .name("pcx_fifo"),
    .fifo_depth(4),
    .data_width(`PCX_WIDTH+`SPC_INFO_WIDTH)
  ) pcx_fifo (
    // System inputs
    .sys_clock_i(sys_clock_i),
    .sys_reset_i(sys_reset_i),

    // FIFO inputs
    .read(pcx_fifo_read),
    .write(pcx_fifo_write),
    .data_in(pcx_fifo_data_in),

    // FIFO outputs
    .empty(pcx_fifo_empty),
    .full(pcx_fifo_full),  // With the depth defined properly there is no need to handle the full condition - And an assertion in the FIFO would fire anyway on overflow
    .data_out(pcx_fifo_data_out)
  );

  simple_fifo #(
    .name("cpx_fifo"),
    .fifo_depth(4),
    .data_width(`CPX_WIDTH)
  ) cpx_fifo (
    // System inputs
    .sys_clock_i(sys_clock_i),
    .sys_reset_i(sys_reset_i),

    // FIFO inputs
    .read(cpx_fifo_read),
    .write(cpx_fifo_write),
    .data_in(cpx_fifo_data_in),

    // FIFO outputs
    .empty(cpx_fifo_empty),
    .full(cpx_fifo_full),
    .data_out(cpx_fifo_data_out)
  );

  /*
   * PCX sampling logic:
   * - SPC Logic: Drives SPARC Cores signals related with the PCX interface
   * - PCX FIFO Write Logic: Drives pcx_fifo_write and pcx_fifo_data_in
   */

  always @(posedge sys_clock_i) begin

    // Create delayed version of request and atom
    if (sys_reset_i == 1) begin
      spc_req_dly1 <= 'h0;
      spc_req_dly2 <= 'h0;
      spc_atom_dly1 <= 1'b0;
      spc_atom_dly2 <= 1'b0;
    end else begin
      spc_req_dly1 <= spc_req_i;
      spc_req_dly2 <= spc_req_dly1;
      spc_atom_dly1 <= spc_atom_i;
      spc_atom_dly2 <= spc_atom_dly1;
    end

    // One cycle delay required to sample into the PCX FIFO
    if (sys_reset_i == 1'b1 || |spc_req_dly1 == 1'b0) begin
      pcx_fifo_write <= 1'b0;
      pcx_fifo_data_in <= 'h0;
    end else if (|spc_req_dly1 == 1'b1) begin
      pcx_fifo_write <= 1'b1;
      pcx_fifo_data_in <= {spc_req_dly1, spc_atom_dly1, spc_packetout_i};
// synopsys translate_off
`ifdef SIMPLY_RISC_DEBUG
      // Print details of SPARC Core request
      print_pcx_packet({spc_req_dly1, spc_atom_dly1}, spc_packetout_i);
`endif
// synopsys translate_on
    end

  end // always @ (posedge sys_clock_i)
   
   // Two cycles delay required to return the grant
   assign spc_grant_o = spc_req_dly2;

  /*
   * PCX-to-WBM-to-CPX:
   * - PCX FIFO Read Logic: Drives pcx_fifo_read and reads pcx_fifo_data_out
   * - WBM Logic: Drives all Wishbone signals
   * - CPX FIFO Write Logic: Drives cpx_fifo_write and cpx_data_in
   */

   typedef enum logic[3:0] {FSM_WAKEUP, FSM_IDLE, FSM_WBM_BEGIN1, FSM_WBM_END1, FSM_WBM_BEGIN2, FSM_WBM_END2, FSM_WBM_BEGIN3, FSM_WBM_END3, FSM_WBM_BEGIN4, FSM_WBM_END4, FSM_CPX_FIFO_WRITE} fsm_state_t;
   fsm_state_t fsm_state;
   pcx_info_t   pcx_info;
   pcx_packet_t pcx_packet;
   cpx_packet_t cpx_packet;

   always @(posedge sys_clock_i) begin
     if (sys_reset_i == 1) begin
       // Clear outputs connected to FIFOs
       pcx_fifo_read <= 1'b0;
       cpx_fifo_write <= 1'b0;
       cpx_fifo_data_in <= 'h0;
       // Clear Wishbone outputs
       wbm_clean();
       // Initialize the first FSM state
       fsm_state <= FSM_WAKEUP;
       // Prepare the wakeup packet for SPARC Core: `CPX_WIDTH'h1700000000000000000000000000000010001;
       cpx_packet.valid        <= 1;
       cpx_packet.return_type  <= `INT_RET;
       cpx_packet.error        <= 0;
       cpx_packet.noncache_rnw <= 0;
       cpx_packet.thread_id    <= 0;
       cpx_packet.intsrc_etc   <= 7'h0;
       cpx_packet.load_data    <= 128'h10001;
     end else begin
       case(fsm_state)
         // Send the wakeup packet to the SPARC Core
         FSM_WAKEUP: begin
           cpx_fifo_write <= 1'b1;
           cpx_fifo_data_in <= cpx_packet;
           fsm_state <= FSM_IDLE;
         end
         // Wait for a new request to be available in the PCX FIFO and read it
         FSM_IDLE: begin
           cpx_fifo_write <= 1'b0;
           cpx_fifo_data_in <= 'h0;
           if (pcx_fifo_empty != 1'b1) begin
             pcx_fifo_read <= 1'b1;
             { pcx_info, pcx_packet } <= pcx_fifo_data_out;
             fsm_state <= FSM_WBM_BEGIN1;
           end
         end
         // Start a request on the Wishbone bus
         FSM_WBM_BEGIN1: begin
           if (pcx_info.region == 5'b10000)
             pcx_packet.address[3] = 0;  // Smells fishy, I may just load half (64b / 8B / 2instr)
           pcx_fifo_read <= 1'b0;
           wbm_cycle_o <= 1;
           wbm_strobe_o <= 1;
           wbm_addr_o <= { pcx_info.region, 19'b0, pcx_packet.address[`PCX_AD_HI-`PCX_AD_LO:3], 3'b000 };
           wbm_data_o <= pcx_packet.store_data;
           case(pcx_packet.request_type)
             `IMISS_RQ: begin
               // For instruction miss always read memory
               wbm_we_o <= 0;
               wbm_sel_o <= 8'b11111111;
             end // case: `IMISS_RQ
             `LOAD_RQ: begin
               // For data load use the provided data
               wbm_we_o <= 0;
               wbm_sel_o <= pcxsize2wbmsel(pcx_packet.access_size, pcx_packet.address);
             end // case: `LOAD_RQ
             `STORE_RQ: begin
               // For data store use the provided data
               wbm_we_o <= 1;
               wbm_sel_o <= pcxsize2wbmsel(pcx_packet.access_size, pcx_packet.address);
             end // case: `STORE_RQ
             default: begin
               $fatal(1, "Entered default condition of PCX FSM as request_type=0x%02X", pcx_packet.request_type);
               wbm_we_o <= 1;
               wbm_sel_o <= 8'b00000000;
             end
           endcase
           fsm_state <= FSM_WBM_END1;
         end // case: FSM_WBM_BEGIN1
         // Wait for the ack from the Wishbone bus and latch the incoming data
         FSM_WBM_END1: begin
           if (wbm_ack_i == 1) begin
             if (pcx_info.atomic == 0) wbm_cycle_o <= 0;
             wbm_strobe_o <= 0;
             wbm_we_o <= 0;
             wbm_addr_o <= 64'b0;
             wbm_data_o <= 64'b0;
             wbm_sel_o <= 8'b0;

            // Encode the CPX return packet and store it in the second FIFO
            cpx_packet.valid = 1;
            case(pcx_packet.request_type)
              `IMISS_RQ: begin
                cpx_packet.return_type = `IFILL_RET; // I-Cache Miss
              end
              `LOAD_RQ: begin
                cpx_packet.return_type = `LOAD_RET;  // Load
              end
              `STORE_RQ: begin
                cpx_packet.return_type = `ST_ACK;    // Store
              end
            endcase
            cpx_packet.error = 0;
            cpx_packet.noncache_rnw = pcx_packet.noncache_rnw;
            cpx_packet.thread_id = pcx_packet.thread_id;
            cpx_packet.intsrc_etc = 6'b000100;
            if (pcx_packet.address[3] == 0)
              cpx_packet.load_data = { wbm_data_i, 64'b0 };
            else
              cpx_packet.load_data = { 64'b0, wbm_data_i };

            // See if other 64-bit Wishbone accesses are required
            if ( (pcx_packet.request_type == `IMISS_RQ) ||
               // Instruction miss directed to RAM expects 256 bits
               ( (pcx_packet.request_type == `LOAD_RQ) && (pcx_packet.access_size == `PCX_SZ_16B) )
               // Data access of 128 bits
               ) begin
              fsm_state <= FSM_WBM_BEGIN2;
            end else begin
              fsm_state <= FSM_CPX_FIFO_WRITE;
            end

          end
        end // case: FSM_WBM_END1
        // If needed start a second read access to the Wishbone bus
        FSM_WBM_BEGIN2: begin

          // Issue a second request on the Wishbone bus
          wbm_cycle_o <= 1;
          wbm_strobe_o <= 1;
          wbm_we_o <= 0;
          wbm_addr_o <= { pcx_info.region, 19'b0, pcx_packet.address[`PCX_AD_HI-`PCX_AD_LO:4], 4'b1000 };  // 2nd doubleword inside the same quadword
          wbm_data_o <= 64'b0;
          wbm_sel_o <= 8'b11111111;

          // Unconditional state change
          fsm_state <= FSM_WBM_END2;

        end // case: FSM_WBM_BEGIN2

        // Latch the second data returning from Wishbone when ready
        FSM_WBM_END2: begin

          // Wait until Wishbone access completes
          if (wbm_ack_i == 1) begin

            // Clear previously modified outputs
            if (pcx_info.atomic == 0) wbm_cycle_o <= 0;
            wbm_strobe_o <= 0;
            wbm_we_o <= 0;
            wbm_addr_o <= 64'b0;
            wbm_data_o <= 64'b0;
            wbm_sel_o <= 8'b0;

            // Latch the data and set up the return packet for the SPARC Core (this is the second half)
            if (pcx_packet.address[3] == 1)
              cpx_packet.load_data = { wbm_data_i, cpx_packet.load_data[63:0] };
            else
              cpx_packet.load_data = { cpx_packet.load_data[127:64], wbm_data_i };

// synopsys translate_off
`ifdef SIMPLY_RISC_DEBUG
            // Print details of return packet
            print_cpx_packet(cpx_packet);
`endif
// synopsys translate_on

            // See if two return packets are required or just one - TODO checkme
//            if (pcx_packet.request_type == `IMISS_RQ && pcx_info.region == 5'b10000)
              fsm_state <= FSM_CPX_FIFO_WRITE;
//            else
//              fsm_state <= FSM_WBM_BEGIN3;

          end // else fsm_state <= FSM_WBM_END2;
        end // case: FSM_WBM_END2

        // If needed start a third read access to the Wishbone bus
        // In the meanwhile we can return the first 128-bit packet
        FSM_WBM_BEGIN3: begin

          // Issue a third request on the Wishbone bus
          wbm_cycle_o <= 1;
          wbm_strobe_o <= 1;
          wbm_we_o <= 0;
          wbm_addr_o <= { pcx_info.region, 19'b0, pcx_packet.address[`PCX_AD_HI-`PCX_AD_LO:5], 5'b10000 };  // 3nd doubleword inside the same 256-bit data
          wbm_data_o <= 64'b0;
          wbm_sel_o <= 8'b11111111;

          // Unconditional state change
          fsm_state <= FSM_WBM_END3;

        end // case: FSM_WBM_BEGIN3

        // Latch the second data returning from Wishbone when ready
        FSM_WBM_END3: begin

          // Wait until Wishbone access completes
          if (wbm_ack_i == 1) begin

            // Clear previously modified outputs
            if (pcx_info.atomic == 0) wbm_cycle_o <= 0;
            wbm_strobe_o <= 0;
            wbm_we_o <= 0;
            wbm_addr_o <= 64'b0;
            wbm_data_o <= 64'b0;
            wbm_sel_o <= 8'b0;

            // Latch the data and set up the return packet for the SPARC Core - TODO CHECKME
//            cpx_packet.load_data = { wbm_data_i, 64'b0 };

            // Jump to next state
            fsm_state <= FSM_WBM_BEGIN4;

          end // else fsm_state <= FSM_WBM_END3; // if (wbm_ack_i == 1)
        end // case: FSM_WBM_END3

        // If needed start a second read access to the Wishbone bus
        FSM_WBM_BEGIN4: begin

          // Issue a fourth request on the Wishbone bus
          wbm_cycle_o <= 1;
          wbm_strobe_o <= 1;
          wbm_we_o <= 0;
          wbm_addr_o <= { pcx_info.region, 19'b0, pcx_packet.address[`PCX_AD_HI-`PCX_AD_LO:5], 5'b11000 };  // 4th doubleword inside the same 256-bit data
          wbm_data_o <= 64'b0;
          wbm_sel_o <= 8'b11111111;

          // Unconditional state change
          fsm_state <= FSM_WBM_END4;
        end // case: FSM_WBM_BEGIN4

        // Latch the second data returning from Wishbone when ready
        FSM_WBM_END4: begin

          // Wait until Wishbone access completes
          if (wbm_ack_i == 1) begin

            // Clear previously modified outputs
            if (pcx_info.atomic == 0) wbm_cycle_o <= 0;
            wbm_strobe_o <= 0;
            wbm_we_o <= 0;
            wbm_addr_o <= 64'b0;
            wbm_data_o <= 64'b0;
            wbm_sel_o <= 8'b0;

            // Latch the data and set up the return packet for the SPARC Core
//            cpx_packet.load_data = { 64'h0, wbm_data_i};

            // Jump to next state
            fsm_state <= FSM_CPX_FIFO_WRITE;

          end // else fsm_state <= FSM_WBM_END4; // if (wbm_ack_i == 1)
        end // case: FSM_WBM_END4

        // We can start returning the packet to the SPARC Core
        FSM_CPX_FIFO_WRITE: begin

          // Write the packet to the CPX FIFO
          cpx_fifo_write <= 1'b1;
          cpx_fifo_data_in <= cpx_packet;

          // Unconditional state change
          fsm_state <= FSM_IDLE;

// synopsys translate_off
`ifdef SIMPLY_RISC_DEBUG
          // Print details of return packet
          print_cpx_packet(cpx_packet);
`endif
// synopsys translate_on
        end // case: FSM_CPX_FIFO_WRITE

       endcase // case (fsm_state)
     end
   end

   /*
    * CPX FIFO handler
    * - SPARC Core Logic: Drives SPARC Core signals related with the CPX interface
    * - CPX FIFO Read Logic: Drives cpx_fifo_read and reads cpx_data_out
    */

   typedef enum logic[2:0] {CPX_IDLE, CPX_DRIVE_CORE} cpx_state_t;
   cpx_state_t cpx_state;
   cpx_packet_t cpx_packet_2;

   always @(posedge sys_clock_i) begin
     if (sys_reset_i == 1) begin
       spc_ready_o    <= 0;
       spc_packetin_o <= 0;
       cpx_fifo_read  <= 1'b0;
       cpx_state      <= CPX_IDLE;
     end else begin
       case (cpx_state)
         CPX_IDLE: begin
           spc_ready_o <= 0;
           spc_packetin_o <= 'h0;
           if (cpx_fifo_empty) begin
             cpx_fifo_read <= 1'b0;
           end else begin
             cpx_fifo_read <= 1'b1;
             cpx_packet_2 <= cpx_fifo_data_out;
             cpx_state <= CPX_DRIVE_CORE;
           end
         end
         CPX_DRIVE_CORE: begin
           cpx_fifo_read <= 1'b0;
           spc_ready_o <= 1;
           spc_packetin_o <= cpx_packet_2;
           cpx_state <= CPX_IDLE;
         end
       endcase // case (cpx_state)
     end // else: !if (sys_reset_i == 1)
   end // always @ (posedge sys_clock_i)

endmodule

