`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:10:55 06/01/2015
// Design Name:   UART_TX
// Module Name:   /home/sadique/Work/Verilog/Spartan6/USB-uart/tx_test.v
// Project Name:  USB-uart
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: UART_TX
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tx_test;

	// Inputs
	reg [7:0] RxD_par;
	reg RxD_start;
	reg RTS;
	reg sys_clk;
	wire BaudTick;

	// Outputs
	wire TxD_ser;
	
	BaudGen baudgen (
		.sys_clk(sys_clk), 
		.BaudTick(BaudTick)
	);

	// Instantiate the Unit Under Test (UUT)
	UART_TX uut (
		.RxD_par(RxD_par), 
		.RxD_start(RxD_start), 
		.RTS(RTS), 
		.sys_clk(sys_clk), 
		.BaudTick(BaudTick), 
		.TxD_ser(TxD_ser)
	);

	initial begin
		// Initialize Inputs
		RxD_par = 8'b01010101;
		RxD_start = 0;
		RTS = 1;
		sys_clk = 0;

		// Wait 100 ns for global reset to finish
		#4000;
		#37 RxD_start = 1;
		#74 RxD_start = 0;
        
		// Add stimulus here

	end
	
	always begin
		#18.5 sys_clk <= !sys_clk;
	end
      
endmodule

