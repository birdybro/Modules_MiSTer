// Copyright Jamie Iles, 2017
//
// This file is part of s80x86.
//
// s80x86 is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// s80x86 is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with s80x86.  If not, see <http://www.gnu.org/licenses/>.

module Top(input logic clk,
	   input logic rst_in_n,
           output logic s_ras_n,
           output logic s_cas_n,
           output logic s_wr_en,
           output logic [1:0] s_bytesel,
           output logic [12:0] s_addr,
           output logic s_cs_n,
           output logic s_clken,
           inout [15:0] s_data,
           output logic [1:0] s_banksel,
           output logic sdr_clk,
           output logic [`CONFIG_NUM_LEDS-1:0] leds,
`ifdef CONFIG_VGA
	   output logic vga_hsync,
	   output logic vga_vsync,
	   output logic [3:0] vga_r,
	   output logic [3:0] vga_g,
	   output logic [3:0] vga_b,
`endif // CONFIG_VGA
`ifdef CONFIG_PS2
           inout ps2_clk,
           inout ps2_dat,
`endif // CONFIG_PS2
           input logic uart_rx,
           output logic uart_tx,
           output logic spi_sclk,
           output logic spi_mosi,
           input logic spi_miso,
           output logic spi_ncs);

reg poweron_reset = 1'b1;
wire sys_clk;
wire reset_n;
wire reset = ~reset_n | debug_reset | poweron_reset;

`ifdef CONFIG_VGA
wire vga_clk;

wire vga_reg_access;
wire vga_reg_ack;
wire [15:0] vga_reg_data;

wire vga_access;
wire vga_ack;
wire [15:0] vga_data;
`endif

wire [1:0] ir;
wire tdo;
wire tck;
wire tdi;
wire sdr;
wire cdr;
wire udr;
wire debug_stopped;
wire debug_seize;
wire debug_reset;
wire debug_run;
wire [7:0] debug_addr;
wire [15:0] debug_wr_val;
wire [15:0] debug_val;
wire debug_wr_en;

wire [15:0] io_data = sdram_config_data |
    uart_data |
    spi_data |
    timer_data |
    irq_control_data |
    pic_data |
`ifdef CONFIG_VGA
    vga_reg_data |
`endif // CONFIG_VGA
`ifdef CONFIG_PS2
    ps2_data |
`endif // CONFIG_PS2
    bios_control_data;
wire [15:0] mem_data;

// Data bus
wire [19:1] data_m_addr;
wire [15:0] data_m_data_in = d_io ? io_data : mem_data;
wire [15:0] data_m_data_out;
wire data_m_access;
wire data_m_ack = data_mem_ack | io_ack;
wire data_m_wr_en;
wire [1:0] data_m_bytesel;

// Instruction bus
wire [19:1] instr_m_addr;
wire [15:0] instr_m_data_in;
wire instr_m_access;
wire instr_m_ack;

// Multiplexed I/D bus.
wire [19:1] q_m_addr;
wire [15:0] q_m_data_out;
wire [15:0] q_m_data_in = sdram_data |
`ifdef CONFIG_VGA
    vga_data |
`endif // CONFIG_VGA
    bios_data;
wire q_m_ack = sdram_ack |
`ifdef CONFIG_VGA
    vga_ack |
`endif // CONFIG_VGA
    bios_ack;
wire q_m_access;
wire q_m_wr_en;
wire [1:0] q_m_bytesel;

wire d_io;

wire sdram_access;
wire sdram_ack;
wire [15:0] sdram_data;

wire leds_access;
wire leds_ack;

wire bios_access;
wire bios_ack;
wire [15:0] bios_data;

wire bios_control_access;
wire bios_control_ack;
wire bios_enabled;
wire [15:0] bios_control_data;

wire sdram_config_access;
wire sdram_config_ack;
wire sdram_config_done;
wire [15:0] sdram_config_data;

`ifdef CONFIG_PS2
wire ps2_access;
wire ps2_ack;
wire [15:0] ps2_data;
wire ps2_intr;
`else
wire ps2_intr = 1'b0;
`endif // CONFIG_PS2

wire uart_access;
wire uart_ack;
wire [15:0] uart_data;

wire spi_access;
wire spi_ack;
wire [15:0] spi_data;

wire nmi;
wire [6:0] intr_test;
wire intr;
wire inta;
wire [7:0] irq;
wire irq_control_access;
wire irq_control_ack;
wire [15:0] irq_control_data;
wire pic_access;
wire pic_ack;
wire [15:0] pic_data;

wire [7:0] irqs = {6'b0, ps2_intr, timer_intr} | {1'b0, intr_test};

// Timer
wire pit_clk;
wire timer_intr;
wire timer_access;
wire timer_ack;
wire [15:0] timer_data;

wire default_io_access;
wire default_io_ack;

wire io_ack = sdram_config_ack |
              default_io_ack |
              uart_ack |
              leds_ack |
              spi_ack |
              irq_control_ack |
              pic_ack |
              timer_ack |
`ifdef CONFIG_VGA
              vga_reg_ack |
`endif // CONFIG_VGA
`ifdef CONFIG_PS2
              ps2_ack |
`endif // CONFIG_PS2
              bios_control_ack;

always_ff @(posedge clk)
    default_io_ack <= default_io_access;

always_comb begin
    leds_access = 1'b0;
    sdram_config_access = 1'b0;
    default_io_access = 1'b0;
    uart_access = 1'b0;
    spi_access = 1'b0;
    irq_control_access = 1'b0;
    pic_access = 1'b0;
    timer_access = 1'b0;
    bios_control_access = 1'b0;
`ifdef CONFIG_VGA
    vga_reg_access = 1'b0;
`endif // CONFIG_VGA
`ifdef CONFIG_PS2
    ps2_access = 1'b0;
`endif // CONFIG_PS2

    if (d_io && data_m_access) begin
        casez ({data_m_addr[15:1], 1'b0})
        16'b1111_1111_1111_1110: leds_access = 1'b1;
        16'b1111_1111_1111_1100: sdram_config_access = 1'b1;
        16'b1111_1111_1111_1010: uart_access = 1'b1;
        16'b1111_1111_1111_00z0: spi_access = 1'b1;
        16'b1111_1111_1111_0110: irq_control_access = 1'b1;
        16'b1111_1111_1110_1100: bios_control_access = 1'b1;
        16'b0000_0000_0100_00z0: timer_access = 1'b1;
        16'b0000_0000_0010_0000: pic_access = 1'b1;
`ifdef CONFIG_VGA
        16'b0000_0011_1101_zzzz: vga_reg_access = 1'b1;
`endif // CONFIG_VGA
`ifdef CONFIG_PS2
        16'b0000_0000_0110_0000: ps2_access = 1'b1;
`endif // CONFIG_PS2
        default:  default_io_access = 1'b1;
        endcase
    end
end

always_comb begin
    sdram_access = 1'b0;
    bios_access = 1'b0;
`ifdef CONFIG_VGA
    vga_access = 1'b0;
`endif // CONFIG_VGA

    if (q_m_access) begin
        casez ({bios_enabled, q_m_addr, 1'b0})
        {1'b1, 20'b1111_11??_????_????_????}: bios_access = 1'b1;
`ifdef CONFIG_VGA
        {1'b?, 20'b1011_1000_????_????_????}: vga_access = 1'b1;
`endif // CONFIG_VGA
        default: sdram_access = 1'b1;
        endcase
    end
end

wire data_mem_ack;

BitSync         ResetSync(.clk(sys_clk),
                          .d(rst_in_n),
                          .q(reset_n));

// verilator lint_off PINMISSING
VirtualJTAG VirtualJTAG(.ir_out(),
                        .tdo(tdo),
                        .ir_in(ir),
                        .tck(tck),
                        .tdi(tdi),
                        .virtual_state_sdr(sdr),
                        .virtual_state_e1dr(),
                        .virtual_state_cdr(cdr),
                        .virtual_state_udr(udr));

// verilator lint_on PINMISSING
JTAGBridge      JTAGBridge(.cpu_clk(sys_clk),
                           .*);

MemArbiter MemArbiter(.clk(sys_clk),
                      .data_m_data_in(mem_data),
                      .data_m_access(data_m_access & ~d_io),
                      .data_m_ack(data_mem_ack),
                      .*);

SDRAMController #(.size(`CONFIG_SDRAM_SIZE),
                  .clkf(50000000))
                SDRAMController(.clk(sys_clk),
                                .reset(reset),
                                .data_m_access(q_m_access),
                                .cs(sdram_access),
                                .h_addr({6'b0, q_m_addr}),
                                .h_wdata(q_m_data_out),
                                .h_rdata(sdram_data),
                                .h_wr_en(q_m_wr_en),
                                .h_bytesel(q_m_bytesel),
                                .h_compl(sdram_ack),
                                .h_config_done(sdram_config_done),
                                .*);

BIOS #(.depth(8192))
     BIOS(.clk(sys_clk),
          .cs(bios_access),
          .data_m_access(q_m_access),
          .data_m_ack(bios_ack),
          .data_m_addr(q_m_addr),
          .data_m_data_out(bios_data),
          .data_m_bytesel(q_m_bytesel));

BIOSControlRegister BIOSControlRegister(.clk(sys_clk),
                                        .cs(bios_control_access),
                                        .data_m_ack(bios_control_ack),
                                        .data_m_data_out(bios_control_data),
                                        .bios_enabled(bios_enabled),
                                        .*);

SDRAMConfigRegister SDRAMConfigRegister(.clk(sys_clk),
                                        .cs(sdram_config_access),
                                        .data_m_ack(sdram_config_ack),
                                        .data_m_data_out(sdram_config_data),
                                        .config_done(sdram_config_done),
                                        .*);

LEDSRegister     LEDSRegister(.clk(sys_clk),
                              .cs(leds_access),
                              .leds_val(leds),
                              .data_m_data_in(data_m_data_out),
                              .data_m_ack(leds_ack),
                              .*);

UartPorts #(.clk_freq(50000000))
          UartPorts(.clk(sys_clk),
                    .rx(uart_rx),
                    .tx(uart_tx),
                    .cs(uart_access),
                    .data_m_ack(uart_ack),
                    .data_m_data_out(uart_data),
                    .data_m_data_in(data_m_data_out),
                    .*);

SPIPorts SPIPorts(.clk(sys_clk),
                  .cs(spi_access),
                  .data_m_ack(spi_ack),
                  .data_m_data_out(spi_data),
                  .data_m_data_in(data_m_data_out),
                  .data_m_addr(data_m_addr[1]),
                  .miso(spi_miso),
                  .mosi(spi_mosi),
                  .sclk(spi_sclk),
                  .ncs(spi_ncs),
                  .*);

`ifndef verilator
SysPLL	SysPLL(.refclk(clk),
	       .rst(1'b0),
               .locked(),
               .*);
`endif // verilator

Core Core(.clk(sys_clk),
	  .lock(),
          .*);

IRQController IRQController(.clk(sys_clk),
                            .cs(irq_control_access),
                            .data_m_ack(irq_control_ack),
                            .data_m_data_out(irq_control_data),
                            .data_m_data_in(data_m_data_out),
                            .*);

PIC PIC(.clk(sys_clk),
        .cs(pic_access),
        .data_m_ack(pic_ack),
        .data_m_data_out(pic_data),
        .data_m_data_in(data_m_data_out),
        .intr_in(irqs),
        .*);

Timer Timer(.clk(sys_clk),
            .pit_clk(pit_clk),
            .cs(timer_access),
            .data_m_ack(timer_ack),
            .data_m_data_out(timer_data),
            .data_m_data_in(data_m_data_out),
            .data_m_addr(data_m_addr[1]),
            .intr(timer_intr),
            .*);

`ifdef CONFIG_VGA
wire cursor_enabled;
wire [14:0] cursor_pos;
wire [2:0] cursor_scan_start;
wire [2:0] cursor_scan_end;

VGAController VGAController(.clk(vga_clk),
                            .cs(vga_access),
                            .data_m_access(q_m_access),
                            .data_m_ack(vga_ack),
                            .data_m_addr(q_m_addr),
                            .data_m_data_out(vga_data),
                            .data_m_data_in(q_m_data_out),
                            .data_m_bytesel(q_m_bytesel),
                            .*);

VGARegisters VGARegisters(.clk(sys_clk),
                          .cs(vga_reg_access),
                          .data_m_ack(vga_reg_ack),
                          .data_m_data_out(vga_reg_data),
                          .data_m_data_in(data_m_data_out),
                          .*);
`endif

`ifdef CONFIG_PS2
PS2Controller #(.clkf(50000000))
              PS2Controller(.clk(sys_clk),
                            .cs(ps2_access),
                            .data_m_ack(ps2_ack),
                            .data_m_data_out(ps2_data),
                            .data_m_data_in(data_m_data_out),
                            .*);
`endif

always_ff @(posedge clk)
    poweron_reset <= 1'b0;

endmodule
