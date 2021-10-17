/* Verilog netlist generated by SCUBA Diamond_2.2_Production (99) */
/* Module Version: 7.2 */
/* /usr/local/diamond/2.2_x64/ispfpga/bin/lin64/scuba -w -n textmem4k -lang verilog -synth synplify -bus_exp 7 -bb -arch xo2c00 -type bram -wp 11 -rp 1010 -data_width 8 -rdata_width 8 -num_rows 4096 -cascade -1 -memfile /home/pacito/02_Elektronik/020_V6809/6809/opencores/trunk/syn/lattice/textmem2k.mem -memformat orca -writemodeA NORMAL -writemodeB NORMAL -e  */
/* Fri Jan  3 10:41:37 2014 */


`timescale 1 ns / 1 ps
module textmem4k (DataInA, DataInB, AddressA, AddressB, ClockA, ClockB, 
    ClockEnA, ClockEnB, WrA, WrB, ResetA, ResetB, QA, QB)/* synthesis NGD_DRC_MASK=1 */;
    input wire [7:0] DataInA;
    input wire [7:0] DataInB;
    input wire [11:0] AddressA;
    input wire [11:0] AddressB;
    input wire ClockA;
    input wire ClockB;
    input wire ClockEnA;
    input wire ClockEnB;
    input wire WrA;
    input wire WrB;
    input wire ResetA;
    input wire ResetB;
    output wire [7:0] QA;
    output wire [7:0] QB;

    wire scuba_vhi;
    wire scuba_vlo;

    VHI scuba_vhi_inst (.Z(scuba_vhi));

    defparam textmem4k_0_0_3.INIT_DATA = "STATIC" ;
    defparam textmem4k_0_0_3.ASYNC_RESET_RELEASE = "SYNC" ;
    defparam textmem4k_0_0_3.INITVAL_1F = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_0_3.INITVAL_1E = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_0_3.INITVAL_1D = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_0_3.INITVAL_1C = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_0_3.INITVAL_1B = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_0_3.INITVAL_1A = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_0_3.INITVAL_19 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_0_3.INITVAL_18 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_0_3.INITVAL_17 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_0_3.INITVAL_16 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_0_3.INITVAL_15 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_0_3.INITVAL_14 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_0_3.INITVAL_13 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_0_3.INITVAL_12 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_0_3.INITVAL_11 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_0_3.INITVAL_10 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_0_3.INITVAL_0F = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_0_3.INITVAL_0E = "0x18000000000000000000000000000000000000000000000003100000000000000000000000000000" ;
    defparam textmem4k_0_0_3.INITVAL_0D = "0x000000000000000000020800000000000000000000000000000000000000000000000101C4E088E4" ;
    defparam textmem4k_0_0_3.INITVAL_0C = "0x1C84E09C441C8E409C4E088E41C84E09C441C8E40800000000000000000000000000000000000000" ;
    defparam textmem4k_0_0_3.INITVAL_0B = "0x00000000010000000000000000000000000000000000000000000000000018000000000000000000" ;
    defparam textmem4k_0_0_3.INITVAL_0A = "0x00000000000000000000000000000310000000000000000000000000000000000000000000000002" ;
    defparam textmem4k_0_0_3.INITVAL_09 = "0x08000000000000000000000000000000000000000000000001000000000000000000000000000000" ;
    defparam textmem4k_0_0_3.INITVAL_08 = "0x00000000000000000000180000000000000000000000000000000000000000000000031000000000" ;
    defparam textmem4k_0_0_3.INITVAL_07 = "0x00000000000000000000000000000000000000020800000000000000000000000000000000000000" ;
    defparam textmem4k_0_0_3.INITVAL_06 = "0x000000000101C4E088E41C84E09C441C8E409C4E088E41C84E09C441C8E408000000000000000000" ;
    defparam textmem4k_0_0_3.INITVAL_05 = "0x00000000000000000000000000000100000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_0_3.INITVAL_04 = "0x18000000000000000000000000000000000000000000000003100000000000000000000000000000" ;
    defparam textmem4k_0_0_3.INITVAL_03 = "0x00000000000000000002080000000000000000000000000000000000000000000000010000000000" ;
    defparam textmem4k_0_0_3.INITVAL_02 = "0x00000000000000000000000000000000000000001800000000000000000000000000000000000000" ;
    defparam textmem4k_0_0_3.INITVAL_01 = "0x00000000031000000000000000000000000000000000000000000000000208000000000000000000" ;
    defparam textmem4k_0_0_3.INITVAL_00 = "0x00000000000000000000000000000109C4E088E41C84E09C441C8E409C4E088E41C84E09C441C8E4" ;
    defparam textmem4k_0_0_3.CSDECODE_B = "0b000" ;
    defparam textmem4k_0_0_3.CSDECODE_A = "0b000" ;
    defparam textmem4k_0_0_3.WRITEMODE_B = "NORMAL" ;
    defparam textmem4k_0_0_3.WRITEMODE_A = "NORMAL" ;
    defparam textmem4k_0_0_3.GSR = "ENABLED" ;
    defparam textmem4k_0_0_3.RESETMODE = "ASYNC" ;
    defparam textmem4k_0_0_3.REGMODE_B = "NOREG" ;
    defparam textmem4k_0_0_3.REGMODE_A = "NOREG" ;
    defparam textmem4k_0_0_3.DATA_WIDTH_B = 2 ;
    defparam textmem4k_0_0_3.DATA_WIDTH_A = 2 ;
    DP8KC textmem4k_0_0_3 (.DIA8(scuba_vlo), .DIA7(scuba_vlo), .DIA6(scuba_vlo), 
        .DIA5(DataInA[1]), .DIA4(scuba_vlo), .DIA3(scuba_vlo), .DIA2(DataInA[0]), 
        .DIA1(scuba_vlo), .DIA0(scuba_vlo), .ADA12(AddressA[11]), .ADA11(AddressA[10]), 
        .ADA10(AddressA[9]), .ADA9(AddressA[8]), .ADA8(AddressA[7]), .ADA7(AddressA[6]), 
        .ADA6(AddressA[5]), .ADA5(AddressA[4]), .ADA4(AddressA[3]), .ADA3(AddressA[2]), 
        .ADA2(AddressA[1]), .ADA1(AddressA[0]), .ADA0(scuba_vlo), .CEA(ClockEnA), 
        .OCEA(ClockEnA), .CLKA(ClockA), .WEA(WrA), .CSA2(scuba_vlo), .CSA1(scuba_vlo), 
        .CSA0(scuba_vlo), .RSTA(ResetA), .DIB8(scuba_vlo), .DIB7(scuba_vlo), 
        .DIB6(scuba_vlo), .DIB5(DataInB[1]), .DIB4(scuba_vlo), .DIB3(scuba_vlo), 
        .DIB2(DataInB[0]), .DIB1(scuba_vlo), .DIB0(scuba_vlo), .ADB12(AddressB[11]), 
        .ADB11(AddressB[10]), .ADB10(AddressB[9]), .ADB9(AddressB[8]), .ADB8(AddressB[7]), 
        .ADB7(AddressB[6]), .ADB6(AddressB[5]), .ADB5(AddressB[4]), .ADB4(AddressB[3]), 
        .ADB3(AddressB[2]), .ADB2(AddressB[1]), .ADB1(AddressB[0]), .ADB0(scuba_vlo), 
        .CEB(ClockEnB), .OCEB(ClockEnB), .CLKB(ClockB), .WEB(WrB), .CSB2(scuba_vlo), 
        .CSB1(scuba_vlo), .CSB0(scuba_vlo), .RSTB(ResetB), .DOA8(), .DOA7(), 
        .DOA6(), .DOA5(), .DOA4(), .DOA3(), .DOA2(), .DOA1(QA[1]), .DOA0(QA[0]), 
        .DOB8(), .DOB7(), .DOB6(), .DOB5(), .DOB4(), .DOB3(), .DOB2(), .DOB1(QB[1]), 
        .DOB0(QB[0]))
             /* synthesis MEM_LPC_FILE="textmem4k.lpc" */
             /* synthesis MEM_INIT_FILE="textmem2k.mem" */;

    defparam textmem4k_0_1_2.INIT_DATA = "STATIC" ;
    defparam textmem4k_0_1_2.ASYNC_RESET_RELEASE = "SYNC" ;
    defparam textmem4k_0_1_2.INITVAL_1F = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_1_2.INITVAL_1E = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_1_2.INITVAL_1D = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_1_2.INITVAL_1C = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_1_2.INITVAL_1B = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_1_2.INITVAL_1A = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_1_2.INITVAL_19 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_1_2.INITVAL_18 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_1_2.INITVAL_17 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_1_2.INITVAL_16 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_1_2.INITVAL_15 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_1_2.INITVAL_14 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_1_2.INITVAL_13 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_1_2.INITVAL_12 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_1_2.INITVAL_11 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_1_2.INITVAL_10 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_1_2.INITVAL_0F = "0x00000000000000000000000000000008000000000000000000000000000000000000000000000001" ;
    defparam textmem4k_0_1_2.INITVAL_0E = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_1_2.INITVAL_0D = "0x000000000000000000000000000000000000000000000000000000000000000000000004A5001455" ;
    defparam textmem4k_0_1_2.INITVAL_0C = "0x000A50A00A0AA0014A5001455000A50A00A0AA001000000000000000000000000000000000000000" ;
    defparam textmem4k_0_1_2.INITVAL_0B = "0x00000000021000000000000000000000000000000000000000000000000208000000000000000000" ;
    defparam textmem4k_0_1_2.INITVAL_0A = "0x00000000000000000000000000000108000000000000000000000000000000000000000000000001" ;
    defparam textmem4k_0_1_2.INITVAL_09 = "0x08000000000000000000000000000000000000000000000001080000000000000000000000000000" ;
    defparam textmem4k_0_1_2.INITVAL_08 = "0x00000000000000000001000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_1_2.INITVAL_07 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_1_2.INITVAL_06 = "0x000000000004A5001455000A50A00A0AA0014A5001455000A50A00A0AA0010000000000000000000" ;
    defparam textmem4k_0_1_2.INITVAL_05 = "0x00000000000000000000000000000210000000000000000000000000000000000000000000000002" ;
    defparam textmem4k_0_1_2.INITVAL_04 = "0x08000000000000000000000000000000000000000000000001080000000000000000000000000000" ;
    defparam textmem4k_0_1_2.INITVAL_03 = "0x00000000000000000001080000000000000000000000000000000000000000000000010800000000" ;
    defparam textmem4k_0_1_2.INITVAL_02 = "0x00000000000000000000000000000000000000010000000000000000000000000000000000000000" ;
    defparam textmem4k_0_1_2.INITVAL_01 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_1_2.INITVAL_00 = "0x00000000000000000000000000000014A5001455000A50A00A0AA0014A5001455000A50A00A0AA00" ;
    defparam textmem4k_0_1_2.CSDECODE_B = "0b000" ;
    defparam textmem4k_0_1_2.CSDECODE_A = "0b000" ;
    defparam textmem4k_0_1_2.WRITEMODE_B = "NORMAL" ;
    defparam textmem4k_0_1_2.WRITEMODE_A = "NORMAL" ;
    defparam textmem4k_0_1_2.GSR = "ENABLED" ;
    defparam textmem4k_0_1_2.RESETMODE = "ASYNC" ;
    defparam textmem4k_0_1_2.REGMODE_B = "NOREG" ;
    defparam textmem4k_0_1_2.REGMODE_A = "NOREG" ;
    defparam textmem4k_0_1_2.DATA_WIDTH_B = 2 ;
    defparam textmem4k_0_1_2.DATA_WIDTH_A = 2 ;
    DP8KC textmem4k_0_1_2 (.DIA8(scuba_vlo), .DIA7(scuba_vlo), .DIA6(scuba_vlo), 
        .DIA5(DataInA[3]), .DIA4(scuba_vlo), .DIA3(scuba_vlo), .DIA2(DataInA[2]), 
        .DIA1(scuba_vlo), .DIA0(scuba_vlo), .ADA12(AddressA[11]), .ADA11(AddressA[10]), 
        .ADA10(AddressA[9]), .ADA9(AddressA[8]), .ADA8(AddressA[7]), .ADA7(AddressA[6]), 
        .ADA6(AddressA[5]), .ADA5(AddressA[4]), .ADA4(AddressA[3]), .ADA3(AddressA[2]), 
        .ADA2(AddressA[1]), .ADA1(AddressA[0]), .ADA0(scuba_vlo), .CEA(ClockEnA), 
        .OCEA(ClockEnA), .CLKA(ClockA), .WEA(WrA), .CSA2(scuba_vlo), .CSA1(scuba_vlo), 
        .CSA0(scuba_vlo), .RSTA(ResetA), .DIB8(scuba_vlo), .DIB7(scuba_vlo), 
        .DIB6(scuba_vlo), .DIB5(DataInB[3]), .DIB4(scuba_vlo), .DIB3(scuba_vlo), 
        .DIB2(DataInB[2]), .DIB1(scuba_vlo), .DIB0(scuba_vlo), .ADB12(AddressB[11]), 
        .ADB11(AddressB[10]), .ADB10(AddressB[9]), .ADB9(AddressB[8]), .ADB8(AddressB[7]), 
        .ADB7(AddressB[6]), .ADB6(AddressB[5]), .ADB5(AddressB[4]), .ADB4(AddressB[3]), 
        .ADB3(AddressB[2]), .ADB2(AddressB[1]), .ADB1(AddressB[0]), .ADB0(scuba_vlo), 
        .CEB(ClockEnB), .OCEB(ClockEnB), .CLKB(ClockB), .WEB(WrB), .CSB2(scuba_vlo), 
        .CSB1(scuba_vlo), .CSB0(scuba_vlo), .RSTB(ResetB), .DOA8(), .DOA7(), 
        .DOA6(), .DOA5(), .DOA4(), .DOA3(), .DOA2(), .DOA1(QA[3]), .DOA0(QA[2]), 
        .DOB8(), .DOB7(), .DOB6(), .DOB5(), .DOB4(), .DOB3(), .DOB2(), .DOB1(QB[3]), 
        .DOB0(QB[2]))
             /* synthesis MEM_LPC_FILE="textmem4k.lpc" */
             /* synthesis MEM_INIT_FILE="textmem2k.mem" */;

    defparam textmem4k_0_2_1.INIT_DATA = "STATIC" ;
    defparam textmem4k_0_2_1.ASYNC_RESET_RELEASE = "SYNC" ;
    defparam textmem4k_0_2_1.INITVAL_1F = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_2_1.INITVAL_1E = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_2_1.INITVAL_1D = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_2_1.INITVAL_1C = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_2_1.INITVAL_1B = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_2_1.INITVAL_1A = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_2_1.INITVAL_19 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_2_1.INITVAL_18 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_2_1.INITVAL_17 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_2_1.INITVAL_16 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_2_1.INITVAL_15 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_2_1.INITVAL_14 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_2_1.INITVAL_13 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_2_1.INITVAL_12 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_2_1.INITVAL_11 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_2_1.INITVAL_10 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_2_1.INITVAL_0F = "0x0000000000000000000000000000001D4AA154AA154AA154AA154AA154AA154AA154AA154AA154AB" ;
    defparam textmem4k_0_2_1.INITVAL_0E = "0x1D4AA154AA154AA154AA154AA154AA154AA154AA154AA154AB1D4AA154AA154AA154AA154AA154AA" ;
    defparam textmem4k_0_2_1.INITVAL_0D = "0x154AA154AA154AA154AB1D4AA154AA154AA154AA154AA154AA154AA154AA154AA154AB1FEFF1FEFF" ;
    defparam textmem4k_0_2_1.INITVAL_0C = "0x1FEFF1FEFF1FEFF1FEFF1FEFF1FEFF1FEFF1FEFF1D4AA154AA154AA154AA154AA154AA154AA154AA" ;
    defparam textmem4k_0_2_1.INITVAL_0B = "0x154AA154AB1D4AA154AA154AA154AA154AA154AA154AA154AA154AA154AB1D4AA154AA154AA154AA" ;
    defparam textmem4k_0_2_1.INITVAL_0A = "0x154AA154AA154AA154AA154AA154AB1D4AA154AA154AA154AA154AA154AA154AA154AA154AA154AB" ;
    defparam textmem4k_0_2_1.INITVAL_09 = "0x1D4AA154AA154AA154AA154AA154AA154AA154AA154AA154AB1D4AA154AA154AA154AA154AA154AA" ;
    defparam textmem4k_0_2_1.INITVAL_08 = "0x154AA154AA154AA154AB1D4AA154AA154AA154AA154AA154AA154AA154AA154AA154AB1D4AA154AA" ;
    defparam textmem4k_0_2_1.INITVAL_07 = "0x154AA154AA154AA154AA154AA154AA154AA154AB1D4AA154AA154AA154AA154AA154AA154AA154AA" ;
    defparam textmem4k_0_2_1.INITVAL_06 = "0x154AA154AB1FEFF1FEFF1FEFF1FEFF1FEFF1FEFF1FEFF1FEFF1FEFF1FEFF1D4AA154AA154AA154AA" ;
    defparam textmem4k_0_2_1.INITVAL_05 = "0x154AA154AA154AA154AA154AA154AB1D4AA154AA154AA154AA154AA154AA154AA154AA154AA154AB" ;
    defparam textmem4k_0_2_1.INITVAL_04 = "0x1D4AA154AA154AA154AA154AA154AA154AA154AA154AA154AB1D4AA154AA154AA154AA154AA154AA" ;
    defparam textmem4k_0_2_1.INITVAL_03 = "0x154AA154AA154AA154AB1D4AA154AA154AA154AA154AA154AA154AA154AA154AA154AB1D4AA154AA" ;
    defparam textmem4k_0_2_1.INITVAL_02 = "0x154AA154AA154AA154AA154AA154AA154AA154AB1D4AA154AA154AA154AA154AA154AA154AA154AA" ;
    defparam textmem4k_0_2_1.INITVAL_01 = "0x154AA154AB1D4AA154AA154AA154AA154AA154AA154AA154AA154AA154AB1D4AA154AA154AA154AA" ;
    defparam textmem4k_0_2_1.INITVAL_00 = "0x154AA154AA154AA154AA154AA154AB1FEFF1FEFF1FEFF1FEFF1FEFF1FEFF1FEFF1FEFF1FEFF1FEFF" ;
    defparam textmem4k_0_2_1.CSDECODE_B = "0b000" ;
    defparam textmem4k_0_2_1.CSDECODE_A = "0b000" ;
    defparam textmem4k_0_2_1.WRITEMODE_B = "NORMAL" ;
    defparam textmem4k_0_2_1.WRITEMODE_A = "NORMAL" ;
    defparam textmem4k_0_2_1.GSR = "ENABLED" ;
    defparam textmem4k_0_2_1.RESETMODE = "ASYNC" ;
    defparam textmem4k_0_2_1.REGMODE_B = "NOREG" ;
    defparam textmem4k_0_2_1.REGMODE_A = "NOREG" ;
    defparam textmem4k_0_2_1.DATA_WIDTH_B = 2 ;
    defparam textmem4k_0_2_1.DATA_WIDTH_A = 2 ;
    DP8KC textmem4k_0_2_1 (.DIA8(scuba_vlo), .DIA7(scuba_vlo), .DIA6(scuba_vlo), 
        .DIA5(DataInA[5]), .DIA4(scuba_vlo), .DIA3(scuba_vlo), .DIA2(DataInA[4]), 
        .DIA1(scuba_vlo), .DIA0(scuba_vlo), .ADA12(AddressA[11]), .ADA11(AddressA[10]), 
        .ADA10(AddressA[9]), .ADA9(AddressA[8]), .ADA8(AddressA[7]), .ADA7(AddressA[6]), 
        .ADA6(AddressA[5]), .ADA5(AddressA[4]), .ADA4(AddressA[3]), .ADA3(AddressA[2]), 
        .ADA2(AddressA[1]), .ADA1(AddressA[0]), .ADA0(scuba_vlo), .CEA(ClockEnA), 
        .OCEA(ClockEnA), .CLKA(ClockA), .WEA(WrA), .CSA2(scuba_vlo), .CSA1(scuba_vlo), 
        .CSA0(scuba_vlo), .RSTA(ResetA), .DIB8(scuba_vlo), .DIB7(scuba_vlo), 
        .DIB6(scuba_vlo), .DIB5(DataInB[5]), .DIB4(scuba_vlo), .DIB3(scuba_vlo), 
        .DIB2(DataInB[4]), .DIB1(scuba_vlo), .DIB0(scuba_vlo), .ADB12(AddressB[11]), 
        .ADB11(AddressB[10]), .ADB10(AddressB[9]), .ADB9(AddressB[8]), .ADB8(AddressB[7]), 
        .ADB7(AddressB[6]), .ADB6(AddressB[5]), .ADB5(AddressB[4]), .ADB4(AddressB[3]), 
        .ADB3(AddressB[2]), .ADB2(AddressB[1]), .ADB1(AddressB[0]), .ADB0(scuba_vlo), 
        .CEB(ClockEnB), .OCEB(ClockEnB), .CLKB(ClockB), .WEB(WrB), .CSB2(scuba_vlo), 
        .CSB1(scuba_vlo), .CSB0(scuba_vlo), .RSTB(ResetB), .DOA8(), .DOA7(), 
        .DOA6(), .DOA5(), .DOA4(), .DOA3(), .DOA2(), .DOA1(QA[5]), .DOA0(QA[4]), 
        .DOB8(), .DOB7(), .DOB6(), .DOB5(), .DOB4(), .DOB3(), .DOB2(), .DOB1(QB[5]), 
        .DOB0(QB[4]))
             /* synthesis MEM_LPC_FILE="textmem4k.lpc" */
             /* synthesis MEM_INIT_FILE="textmem2k.mem" */;

    VLO scuba_vlo_inst (.Z(scuba_vlo));

    defparam textmem4k_0_3_0.INIT_DATA = "STATIC" ;
    defparam textmem4k_0_3_0.ASYNC_RESET_RELEASE = "SYNC" ;
    defparam textmem4k_0_3_0.INITVAL_1F = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_3_0.INITVAL_1E = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_3_0.INITVAL_1D = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_3_0.INITVAL_1C = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_3_0.INITVAL_1B = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_3_0.INITVAL_1A = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_3_0.INITVAL_19 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_3_0.INITVAL_18 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_3_0.INITVAL_17 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_3_0.INITVAL_16 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_3_0.INITVAL_15 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_3_0.INITVAL_14 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_3_0.INITVAL_13 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_3_0.INITVAL_12 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_3_0.INITVAL_11 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_3_0.INITVAL_10 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_3_0.INITVAL_0F = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_3_0.INITVAL_0E = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_3_0.INITVAL_0D = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_3_0.INITVAL_0C = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_3_0.INITVAL_0B = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_3_0.INITVAL_0A = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_3_0.INITVAL_09 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_3_0.INITVAL_08 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_3_0.INITVAL_07 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_3_0.INITVAL_06 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_3_0.INITVAL_05 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_3_0.INITVAL_04 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_3_0.INITVAL_03 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_3_0.INITVAL_02 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_3_0.INITVAL_01 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_3_0.INITVAL_00 = "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
    defparam textmem4k_0_3_0.CSDECODE_B = "0b000" ;
    defparam textmem4k_0_3_0.CSDECODE_A = "0b000" ;
    defparam textmem4k_0_3_0.WRITEMODE_B = "NORMAL" ;
    defparam textmem4k_0_3_0.WRITEMODE_A = "NORMAL" ;
    defparam textmem4k_0_3_0.GSR = "ENABLED" ;
    defparam textmem4k_0_3_0.RESETMODE = "ASYNC" ;
    defparam textmem4k_0_3_0.REGMODE_B = "NOREG" ;
    defparam textmem4k_0_3_0.REGMODE_A = "NOREG" ;
    defparam textmem4k_0_3_0.DATA_WIDTH_B = 2 ;
    defparam textmem4k_0_3_0.DATA_WIDTH_A = 2 ;
    DP8KC textmem4k_0_3_0 (.DIA8(scuba_vlo), .DIA7(scuba_vlo), .DIA6(scuba_vlo), 
        .DIA5(DataInA[7]), .DIA4(scuba_vlo), .DIA3(scuba_vlo), .DIA2(DataInA[6]), 
        .DIA1(scuba_vlo), .DIA0(scuba_vlo), .ADA12(AddressA[11]), .ADA11(AddressA[10]), 
        .ADA10(AddressA[9]), .ADA9(AddressA[8]), .ADA8(AddressA[7]), .ADA7(AddressA[6]), 
        .ADA6(AddressA[5]), .ADA5(AddressA[4]), .ADA4(AddressA[3]), .ADA3(AddressA[2]), 
        .ADA2(AddressA[1]), .ADA1(AddressA[0]), .ADA0(scuba_vlo), .CEA(ClockEnA), 
        .OCEA(ClockEnA), .CLKA(ClockA), .WEA(WrA), .CSA2(scuba_vlo), .CSA1(scuba_vlo), 
        .CSA0(scuba_vlo), .RSTA(ResetA), .DIB8(scuba_vlo), .DIB7(scuba_vlo), 
        .DIB6(scuba_vlo), .DIB5(DataInB[7]), .DIB4(scuba_vlo), .DIB3(scuba_vlo), 
        .DIB2(DataInB[6]), .DIB1(scuba_vlo), .DIB0(scuba_vlo), .ADB12(AddressB[11]), 
        .ADB11(AddressB[10]), .ADB10(AddressB[9]), .ADB9(AddressB[8]), .ADB8(AddressB[7]), 
        .ADB7(AddressB[6]), .ADB6(AddressB[5]), .ADB5(AddressB[4]), .ADB4(AddressB[3]), 
        .ADB3(AddressB[2]), .ADB2(AddressB[1]), .ADB1(AddressB[0]), .ADB0(scuba_vlo), 
        .CEB(ClockEnB), .OCEB(ClockEnB), .CLKB(ClockB), .WEB(WrB), .CSB2(scuba_vlo), 
        .CSB1(scuba_vlo), .CSB0(scuba_vlo), .RSTB(ResetB), .DOA8(), .DOA7(), 
        .DOA6(), .DOA5(), .DOA4(), .DOA3(), .DOA2(), .DOA1(QA[7]), .DOA0(QA[6]), 
        .DOB8(), .DOB7(), .DOB6(), .DOB5(), .DOB4(), .DOB3(), .DOB2(), .DOB1(QB[7]), 
        .DOB0(QB[6]))
             /* synthesis MEM_LPC_FILE="textmem4k.lpc" */
             /* synthesis MEM_INIT_FILE="textmem2k.mem" */;



    // exemplar begin
    // exemplar attribute textmem4k_0_0_3 MEM_LPC_FILE textmem4k.lpc
    // exemplar attribute textmem4k_0_0_3 MEM_INIT_FILE textmem2k.mem
    // exemplar attribute textmem4k_0_1_2 MEM_LPC_FILE textmem4k.lpc
    // exemplar attribute textmem4k_0_1_2 MEM_INIT_FILE textmem2k.mem
    // exemplar attribute textmem4k_0_2_1 MEM_LPC_FILE textmem4k.lpc
    // exemplar attribute textmem4k_0_2_1 MEM_INIT_FILE textmem2k.mem
    // exemplar attribute textmem4k_0_3_0 MEM_LPC_FILE textmem4k.lpc
    // exemplar attribute textmem4k_0_3_0 MEM_INIT_FILE textmem2k.mem
    // exemplar end

endmodule
