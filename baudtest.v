`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:46:18 05/29/2015
// Design Name:   BaudGen
// Module Name:   /home/sadique/Work/Verilog/Spartan6/USB-uart/baudtest.v
// Project Name:  USB-uart
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: BaudGen
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module baudtest;

	// Inputs
	reg sys_clk;

	// Outputs
	wire BaudTick;
	wire Baud8Tick;

	// Instantiate the Unit Under Test (UUT)
	BaudGen uut (
		.sys_clk(sys_clk), 
		.BaudTick(BaudTick)
	);
	
	Baud8Gen uut8 (
		.sys_clk(sys_clk), 
		.Baud8Tick(Baud8Tick)
	);

	initial begin
		// Initialize Inputs
		sys_clk = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
	
	always begin
		#18.5 sys_clk <= !sys_clk;
	end
      
endmodule

