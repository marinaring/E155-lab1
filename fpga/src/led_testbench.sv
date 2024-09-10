/*
	Marina Ring, mring@hmc.edu, 9/1/24
	Module to test the signals for the seven segment generator
	
*/

module led_testbench();
	logic clk, reset;
	logic [3:0] s;
	logic [2:0] led, led_expected;
	logic [31:0] vectornum, errors;
	logic [6:0] testvectors[10000:0];
	
	led_logic led_test(clk, reset, s, led);

	always 
		begin
			clk = 1; #5; clk = 0; #5;
		end
	 
	
	initial 
		begin
			$readmemb("led_test.txt", testvectors);
			vectornum = 0; errors = 0;
			reset = 1; #22; reset = 0;
		end
	
	always @(posedge clk)
		begin
			#1; {s, led_expected} = testvectors[vectornum];
		end
		
	always @(negedge clk)
		if (~reset) begin // skip during reset
			if (led != led_expected) begin // check result
				$display("Error: input = %b", {s});
				$display(" outputs = %b (%b expected)", led, led_expected);
				errors = errors + 1;
			end
			vectornum = vectornum + 1;
			if (testvectors[vectornum] === 7'bx) begin
				$display("%d tests completed with %d errors", vectornum, errors);
				$stop;
			end
		end
endmodule
