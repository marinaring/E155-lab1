/*
	Marina Ring, mring@hmc.edu, 9/1/2024
	Module to control LEDs. Implements a digitally controlled oscillator using N = 32 and p = 430 
	to produce a 2.4 Hz signal from a 24 MHz signal generated from the internal high speed oscillator
*/

module led_logic(
	input logic clk,
	input logic reset,
	input logic [3:0] s,
	output logic [2:0] led
);
   
   logic [31:0] counter;
  
   // Counter
   always_ff @(posedge clk) begin
     if(reset == 0)  counter <= 0;
     else            counter <= counter + 430;
   end
 
   // Assign LED output
   assign led[0] = s[0] ^ s[1];
   assign led[1] = s[2] & s[3];
   assign led[2] = counter[31]; 
endmodule