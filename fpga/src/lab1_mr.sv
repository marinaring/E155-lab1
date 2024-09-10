/*
	Marina Ring, mring@hmc.edu, 9/1/2024
	Module to control a seven segment display and LEDs using an FPGA.
*/

module lab1_mr(
	 input 	 logic clk,
	 input   logic reset,
     input   logic [3:0] s,
	 output  logic [2:0] led,
	 output  logic [6:0] seg
);

	logic int_osc;
	logic [6:0] not_seg;
	
	// Initialize high-speed oscillator to 24 MHz signal
      HSOSC #(.CLKHF_DIV(2'b01)) 
         hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));

	// output logic
	led_logic led_display(int_osc, reset, s, led);
	seg_logic segment_display(s, not_seg);

	// turning a pin on corresponds to turning a segment off, so we need to switch all bits.
	assign seg = ~not_seg;
  
endmodule





   