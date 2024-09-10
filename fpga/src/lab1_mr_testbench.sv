/*
	Marina Ring, mring@hmc.edu, 9/1/24
	Module to test larger module controlling FPGA
*/

module lab1_mr_testbench();
	logic clk, reset;
	logic [3:0] s;
	logic [9:0] y, y_expected;
	logic [31:0] vectornum, errors;
	logic [13:0] testvectors[10000:0];
	
	lab1_mr lab1_mr_test(clk, reset, s, y[7], y[0]);

	always 
		begin
			clk = 1; #5; clk = 0; #5;
		end
	 
	
	initial 
		begin
			$readmemb("lab1_mr_test.txt", testvectors);
			vectornum = 0; errors = 0;
			reset = 1; #22; reset = 0;
		end
	
	always @(posedge clk)
		begin
			#1; {s, y_expected} = testvectors[vectornum];
		end
		
	always @(negedge clk)
		if (~reset) begin // skip during reset
			if (y != y_expected) begin // check result
				$display("Error: input = %b", {s});
				$display(" outputs = %b (%b expected)", y, y_expected);
				errors = errors + 1;
			end
			vectornum = vectornum + 1;
			if (testvectors[vectornum] === 14'bx) begin
				$display("%d tests completed with %d errors", vectornum, errors);
				$stop;
			end
		end
endmodule