module agc(
			  input wire 			   clk,
			  input wire 			   rst,
			  input wire signed [15:0] x_in,
			  input wire [7:0] a_coef,
			  input wire [15:0] reference,
			  output wire signed [15:0] y_out
);
		
		wire [31:0] x_mod;		
		wire [31:0] ref_rms;	
		wire signed [32:0] tmp_level;
		wire signed [32:0] feedback_level;
		reg signed [32:0] zreg;	
		wire signed [8:0] a_coef_s;	
				
		assign a_coef_s = { 1'b0, a_coef};
	 	assign ref_rms = (reference[15:1] * reference[15:1]);
		assign x_mod = (y_out * y_out);
		assign tmp_level = ($signed(ref_rms - x_mod))>>>18;
		assign feedback_level = (tmp_level * a_coef_s) >>> 8;
		
		always @(posedge clk or negedge rst)
		if (!rst) zreg <= 'h0;
		else zreg <=  zreg + feedback_level;
		
		assign y_out = (zreg * x_in) >>>16;

endmodule
