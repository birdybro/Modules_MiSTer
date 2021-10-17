`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:  BMSTU
// Engineer:    Odintsov Oleg
// 
// Create Date:    11:15:41 02/24/2012 
// Design Name: 
// Module Name:     ag_ram 
// Project Name:    Agat Hardware Project
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

// Enable the following define to use synchronous memory instead of
//		asynchronous (which has been used in real Agats).
// The use of the synchronous memory will improve hardware design on FPGA
`define AG_RAM_SYNCHRONOUS


`ifdef AG_RAM_SYNCHRONOUS

module RAM16Kx1(input CLK1, input[13:0] AB1, input CS1, input READ,
					 output DO1, input DI1,
				    input CLK2, input[13:0] AB2, input CS2, output DO2);
	parameter
      D_00 = 256'h33333333333333333333333333333333CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC,
      D_01 = 256'h33333333333333333333333333333333CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC,
      D_02 = 256'h33333333333333333333333333333333CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC,
      D_03 = 256'h33333333333333333333333333333333CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC,
      D_04 = 256'h33333333333333333333333333333333CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC,
      D_05 = 256'h33333333333333333333333333333333CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC,
      D_06 = 256'h33333333333333333333333333333333CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC,
      D_07 = 256'h33333333333333333333333333333333CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC,
      D_08 = 256'h33333333333333333333333333333333CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC,
      D_09 = 256'h33333333333333333333333333333333CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC,
      D_0A = 256'h33333333333333333333333333333333CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC,
      D_0B = 256'h33333333333333333333333333333333CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC,
      D_0C = 256'h33333333333333333333333333333333CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC,
      D_0D = 256'h33333333333333333333333333333333CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC,
      D_0E = 256'h33333333333333333333333333333333CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC,
      D_0F = 256'h33333333333333333333333333333333CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC,
      // Address 4096 to 8191
      D_10 = 256'h33333333333333333333333333333333CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC,
      D_11 = 256'h33333333333333333333333333333333CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC,
      D_12 = 256'h33333333333333333333333333333333CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC,
      D_13 = 256'h33333333333333333333333333333333CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC,
      D_14 = 256'h33333333333333333333333333333333CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC,
      D_15 = 256'h33333333333333333333333333333333CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC,
      D_16 = 256'h33333333333333333333333333333333CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC,
      D_17 = 256'h33333333333333333333333333333333CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC,
      D_18 = 256'h33333333333333333333333333333333CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC,
      D_19 = 256'h33333333333333333333333333333333CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC,
      D_1A = 256'h33333333333333333333333333333333CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC,
      D_1B = 256'h33333333333333333333333333333333CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC,
      D_1C = 256'h33333333333333333333333333333333CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC,
      D_1D = 256'h33333333333333333333333333333333CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC,
      D_1E = 256'h33333333333333333333333333333333CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC,
      D_1F = 256'h33333333333333333333333333333333CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC,
      // Address 8192 to 12287
      D_20 = 256'h33333333333333333333333333333333CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC,
      D_21 = 256'h33333333333333333333333333333333CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC,
      D_22 = 256'h33333333333333333333333333333333CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC,
      D_23 = 256'h33333333333333333333333333333333CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC,
      D_24 = 256'h33333333333333333333333333333333CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC,
      D_25 = 256'h33333333333333333333333333333333CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC,
      D_26 = 256'h33333333333333333333333333333333CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC,
      D_27 = 256'h33333333333333333333333333333333CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC,
      D_28 = 256'h33333333333333333333333333333333CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC,
      D_29 = 256'h33333333333333333333333333333333CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC,
      D_2A = 256'h33333333333333333333333333333333CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC,
      D_2B = 256'h33333333333333333333333333333333CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC,
      D_2C = 256'h33333333333333333333333333333333CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC,
      D_2D = 256'h33333333333333333333333333333333CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC,
      D_2E = 256'h33333333333333333333333333333333CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC,
      D_2F = 256'h33333333333333333333333333333333CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC,
      // Address 12288 to 16383
      D_30 = 256'h33333333333333333333333333333333CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC,
      D_31 = 256'h33333333333333333333333333333333CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC,
      D_32 = 256'h33333333333333333333333333333333CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC,
      D_33 = 256'h33333333333333333333333333333333CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC,
      D_34 = 256'h33333333333333333333333333333333CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC,
      D_35 = 256'h33333333333333333333333333333333CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC,
      D_36 = 256'h33333333333333333333333333333333CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC,
      D_37 = 256'h33333333333333333333333333333333CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC,
      D_38 = 256'h33333333333333333333333333333333CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC,
      D_39 = 256'h33333333333333333333333333333333CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC,
      D_3A = 256'h33333333333333333333333333333333CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC,
      D_3B = 256'h33333333333333333333333333333333CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC,
      D_3C = 256'h33333333333333333333333333333333CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC,
      D_3D = 256'h33333333333333333333333333333333CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC,
      D_3E = 256'h33333333333333333333333333333333CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC,
      D_3F = 256'h33333333333333333333333333333333CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC;
	
	wire DO1x, DO2x;
	assign DO1 = CS1? DO1x: 1'bZ;
	assign DO2 = CS2? DO2x: 1'bZ;
   // RAMB16_S1_S1: 16k x 1 Dual-Port RAM
   //               Spartan-3E
   // Xilinx HDL Language Template, version 13.3

   RAMB16_S1_S1 #(
      .INIT_A(1'b0),  // Value of output RAM registers on Port A at startup
      .INIT_B(1'b0),  // Value of output RAM registers on Port B at startup
      .SRVAL_A(1'b0), // Port A output value upon SSR assertion
      .SRVAL_B(1'b0), // Port B output value upon SSR assertion
      .WRITE_MODE_A("WRITE_FIRST"), // WRITE_FIRST, READ_FIRST or NO_CHANGE
      .WRITE_MODE_B("WRITE_FIRST"), // WRITE_FIRST, READ_FIRST or NO_CHANGE
      .SIM_COLLISION_CHECK("ALL"),  // "NONE", "WARNING_ONLY", "GENERATE_X_ONLY", "ALL" 

      // The following INIT_xx declarations specify the initial contents of the RAM
      // Address 0 to 4095
      .INIT_00(D_00), .INIT_01(D_01), .INIT_02(D_02), .INIT_03(D_03),
      .INIT_04(D_04), .INIT_05(D_05), .INIT_06(D_06), .INIT_07(D_07),
      .INIT_08(D_08), .INIT_09(D_09), .INIT_0A(D_0A), .INIT_0B(D_0B),
      .INIT_0C(D_0C), .INIT_0D(D_0D), .INIT_0E(D_0E), .INIT_0F(D_0F),
      // Address 4096 to 8191
      .INIT_10(D_10), .INIT_11(D_11), .INIT_12(D_12), .INIT_13(D_13),
      .INIT_14(D_14), .INIT_15(D_15), .INIT_16(D_16), .INIT_17(D_17),
      .INIT_18(D_18), .INIT_19(D_19), .INIT_1A(D_1A), .INIT_1B(D_1B),
      .INIT_1C(D_1C), .INIT_1D(D_1D), .INIT_1E(D_1E), .INIT_1F(D_1F),
      // Address 8192 to 12287
      .INIT_20(D_20), .INIT_21(D_21), .INIT_22(D_22), .INIT_23(D_23),
      .INIT_24(D_24), .INIT_25(D_25), .INIT_26(D_26), .INIT_27(D_27),
      .INIT_28(D_28), .INIT_29(D_29), .INIT_2A(D_2A), .INIT_2B(D_2B),
      .INIT_2C(D_2C), .INIT_2D(D_2D), .INIT_2E(D_2E), .INIT_2F(D_2F),
      // Address 12288 to 16383
      .INIT_30(D_30), .INIT_31(D_31), .INIT_32(D_32), .INIT_33(D_33),
      .INIT_34(D_34), .INIT_35(D_35), .INIT_36(D_36), .INIT_37(D_37),
      .INIT_38(D_38), .INIT_39(D_39), .INIT_3A(D_3A), .INIT_3B(D_3B),
      .INIT_3C(D_3C), .INIT_3D(D_3D), .INIT_3E(D_3E), .INIT_3F(D_3F)
   ) RAMB16_S1_S1_inst (
      .DOA(DO1x),     // Port A 1-bit Data Output
      .DOB(DO2x),     // Port B 1-bit Data Output
      .ADDRA(AB1),    // Port A 14-bit Address Input
      .ADDRB(AB2),    // Port B 14-bit Address Input
      .CLKA(CLK1),    // Port A Clock
      .CLKB(CLK2),    // Port B Clock
      .DIA(DI1),      // Port A 1-bit Data Input
      .DIB(1'bZ),     // Port B 1-bit Data Input
      .ENA(CS1),      // Port A RAM Enable Input
      .ENB(CS2),      // Port B RAM Enable Input
      .SSRA(1'b0),    // Port A Synchronous Set/Reset Input
      .SSRB(1'b0),    // Port B Synchronous Set/Reset Input
      .WEA(~READ),    // Port A Write Enable Input
      .WEB(1'b0)      // Port B Write Enable Input
   );
endmodule


`else


module RAM1Kx1(input CLK1, input[9:0] AB1, input CS1, input READ,
					 output DO1, input DI1,
				    input CLK2, input[9:0] AB2, input CS2, output DO2);
	parameter FILL = 256'h33333333333333333333333333333333CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC;
	reg mem[0:'h3FF];
	integer i;

	initial
		for (i = 0; i < 'h400; i = i + 1) 
			mem[i] = (FILL&(256'b01<<(i&'hFF)))?1'b1:1'b0;

	assign DO1 = (CS1 && READ)? mem[AB1]: 1'bZ;
	assign DO2 = CS2? mem[AB2]: 1'bZ;
	always @(posedge CLK1) if (CS1 && !READ) mem[AB1] <= DI1;
endmodule



module RAM16Kx1(input CLK1, input[13:0] AB1, input CS1, input READ,
					 output DO1, input DI1,
				    input CLK2, input[13:0] AB2, input CS2, output DO2);
	wire[3:0] SEL1 = AB1[13:10];
	wire[3:0] SEL2 = AB2[13:10];

	RAM1Kx1 ram0(CLK1, AB1[9:0], CS1 && (SEL1 == 4'h0), READ, DO1, DI1,
					CLK2, AB2[9:0],  CS2 && (SEL2 == 4'h0), DO2);
	RAM1Kx1 ram1(CLK1, AB1[9:0], CS1 && (SEL1 == 4'h1), READ, DO1, DI1,
					CLK2, AB2[9:0],  CS2 && (SEL2 == 4'h1), DO2);
	RAM1Kx1 ram2(CLK1, AB1[9:0], CS1 && (SEL1 == 4'h2), READ, DO1, DI1,
					CLK2, AB2[9:0],  CS2 && (SEL2 == 4'h2), DO2);
	RAM1Kx1 ram3(CLK1, AB1[9:0], CS1 && (SEL1 == 4'h3), READ, DO1, DI1,
					CLK2, AB2[9:0],  CS2 && (SEL2 == 4'h3), DO2);
	RAM1Kx1 ram4(CLK1, AB1[9:0], CS1 && (SEL1 == 4'h4), READ, DO1, DI1,
					CLK2, AB2[9:0],  CS2 && (SEL2 == 4'h4), DO2);
	RAM1Kx1 ram5(CLK1, AB1[9:0], CS1 && (SEL1 == 4'h5), READ, DO1, DI1,
					CLK2, AB2[9:0],  CS2 && (SEL2 == 4'h5), DO2);
	RAM1Kx1 ram6(CLK1, AB1[9:0], CS1 && (SEL1 == 4'h6), READ, DO1, DI1,
					CLK2, AB2[9:0],  CS2 && (SEL2 == 4'h6), DO2);
	RAM1Kx1 ram7(CLK1, AB1[9:0], CS1 && (SEL1 == 4'h7), READ, DO1, DI1,
					CLK2, AB2[9:0],  CS2 && (SEL2 == 4'h7), DO2);
	RAM1Kx1 ram8(CLK1, AB1[9:0], CS1 && (SEL1 == 4'h8), READ, DO1, DI1,
					CLK2, AB2[9:0],  CS2 && (SEL2 == 4'h8), DO2);
	RAM1Kx1 ram9(CLK1, AB1[9:0], CS1 && (SEL1 == 4'h9), READ, DO1, DI1,
					CLK2, AB2[9:0],  CS2 && (SEL2 == 4'h9), DO2);
	RAM1Kx1 ramA(CLK1, AB1[9:0], CS1 && (SEL1 == 4'hA), READ, DO1, DI1,
					CLK2, AB2[9:0],  CS2 && (SEL2 == 4'hA), DO2);
	RAM1Kx1 ramB(CLK1, AB1[9:0], CS1 && (SEL1 == 4'hB), READ, DO1, DI1,
					CLK2, AB2[9:0],  CS2 && (SEL2 == 4'hB), DO2);
	RAM1Kx1 ramC(CLK1, AB1[9:0], CS1 && (SEL1 == 4'hC), READ, DO1, DI1,
					CLK2, AB2[9:0],  CS2 && (SEL2 == 4'hC), DO2);
	RAM1Kx1 ramD(CLK1, AB1[9:0], CS1 && (SEL1 == 4'hD), READ, DO1, DI1,
					CLK2, AB2[9:0],  CS2 && (SEL2 == 4'hD), DO2);
	RAM1Kx1 ramE(CLK1, AB1[9:0], CS1 && (SEL1 == 4'hE), READ, DO1, DI1,
					CLK2, AB2[9:0],  CS2 && (SEL2 == 4'hE), DO2);
	RAM1Kx1 ramF(CLK1, AB1[9:0], CS1 && (SEL1 == 4'hF), READ, DO1, DI1,
					CLK2, AB2[9:0],  CS2 && (SEL2 == 4'hF), DO2);
endmodule

`endif // synchronous


/*
	Data bus for video controller:
	A0=0, DO2:               A0=1, DO2:
	15 14 13 12 11 10 09 08  07 06 05 04 03 02 01 00
	Data bus for processor:
	A0=0, DO1/DI1:           A0=1, DO1/DI1:
	07 06 05 04 03 02 01 00  07 06 05 04 03 02 01 00
*/
module RAM32Kx8x16(input CLK1, input[14:0] AB1, input CS1, 
					 input READ, output[7:0] DO1, input[7:0] DI1,
				    input CLK2, input[13:0] AB2, input CS2, output[15:0] DO2);
	wire[1:0] CSM = {(~AB1[0]) & CS1, AB1[0] & CS1}; // CS for modules
	wire[13:0] AB1x = AB1[14:1];
`include "juke-box.v"
/*	RAM16Kx1 ram0(CLK1, AB1x, CSM[0], READ, DO1[0], DI1[0], CLK2, AB2, CS2, DO2[0]);
	RAM16Kx1 ram1(CLK1, AB1x, CSM[0], READ, DO1[1], DI1[1], CLK2, AB2, CS2, DO2[1]);
	RAM16Kx1 ram2(CLK1, AB1x, CSM[0], READ, DO1[2], DI1[2], CLK2, AB2, CS2, DO2[2]);
	RAM16Kx1 ram3(CLK1, AB1x, CSM[0], READ, DO1[3], DI1[3], CLK2, AB2, CS2, DO2[3]);
	RAM16Kx1 ram4(CLK1, AB1x, CSM[0], READ, DO1[4], DI1[4], CLK2, AB2, CS2, DO2[4]);
	RAM16Kx1 ram5(CLK1, AB1x, CSM[0], READ, DO1[5], DI1[5], CLK2, AB2, CS2, DO2[5]);
	RAM16Kx1 ram6(CLK1, AB1x, CSM[0], READ, DO1[6], DI1[6], CLK2, AB2, CS2, DO2[6]);
	RAM16Kx1 ram7(CLK1, AB1x, CSM[0], READ, DO1[7], DI1[7], CLK2, AB2, CS2, DO2[7]);
	                                                                        
	RAM16Kx1 ram8(CLK1, AB1x, CSM[1], READ, DO1[0], DI1[0], CLK2, AB2, CS2, DO2[8]);
	RAM16Kx1 ram9(CLK1, AB1x, CSM[1], READ, DO1[1], DI1[1], CLK2, AB2, CS2, DO2[9]);
	RAM16Kx1 ramA(CLK1, AB1x, CSM[1], READ, DO1[2], DI1[2], CLK2, AB2, CS2, DO2[10]);
	RAM16Kx1 ramB(CLK1, AB1x, CSM[1], READ, DO1[3], DI1[3], CLK2, AB2, CS2, DO2[11]);
	RAM16Kx1 ramC(CLK1, AB1x, CSM[1], READ, DO1[4], DI1[4], CLK2, AB2, CS2, DO2[12]);
	RAM16Kx1 ramD(CLK1, AB1x, CSM[1], READ, DO1[5], DI1[5], CLK2, AB2, CS2, DO2[13]);
	RAM16Kx1 ramE(CLK1, AB1x, CSM[1], READ, DO1[6], DI1[6], CLK2, AB2, CS2, DO2[14]);
	RAM16Kx1 ramF(CLK1, AB1x, CSM[1], READ, DO1[7], DI1[7], CLK2, AB2, CS2, DO2[15]);*/
endmodule
