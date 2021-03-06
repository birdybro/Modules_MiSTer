//
// Copyright (c) 2014-2015 by 1801BM1@gmail.com
//
// Vectored interrupt controller
//______________________________________________________________________________
//
module vic_wb #(parameter N=1)
(
	input						clk_sys,
	input						ce,
	input						wb_rst_i,	// peripheral reset
	output reg				wb_irq_o,	// vectored interrupt request
	output reg 	[15:0]	wb_dat_o,	// interrupt vector output
	input						wb_stb_i,	// interrupt vector strobe
	output reg				wb_ack_o,	// interrupt vector acknowledgement
												//
	input	   [N*16-1:0] 	ivec,			// interrupt vector values
	input		   [N-1:0]	ireq,			// interrupt request lines
	output reg	[N-1:0]	iack			// interrupt acknowledgements
);
localparam W = log2(N);
//
// Contains the current interrupt number with highest priority or 1's if no any
//
reg	[W-1:0] nvec;
integer i;

always @(posedge clk_sys or posedge wb_rst_i) begin
	if (wb_rst_i) begin
		wb_ack_o <= 1'b0;
		wb_dat_o <= 16'O000000;
		iack     <= 0;
		nvec 		<= {(W){1'b1}};
	end 
	else if(ce) begin
		wb_ack_o <= wb_stb_i & wb_irq_o & ~wb_ack_o;
		wb_irq_o <= ~(&nvec) & ~wb_ack_o;

		for (i=N-1; i>=0; i=i-1)
			iack[i] <= (nvec == i) & ireq[i] & wb_stb_i & wb_irq_o & ~iack[i];

		if (wb_stb_i & ~wb_ack_o & wb_irq_o)
			wb_dat_o <= trunc_w16(ivec >> (nvec*16));

		if (~wb_stb_i)
		begin
			nvec <= {(W){1'b1}};
			for (i=N-1; i>=0; i=i-1)
				if (ireq[i]) nvec <= trunc_int(i);
		end
		else
			if (wb_ack_o)
				nvec <= {(W){1'b1}};
	end
end

function integer log2(input integer value);
	for (log2=0; value>0; log2=log2+1) 
		value = value >> 1;
endfunction

function [15:0] trunc_w16(input [N*16-1:0] value);
	trunc_w16 = value[15:0];
endfunction

function [W-1:0] trunc_int(input integer value);
	trunc_int = value[W-1:0];
endfunction
endmodule
