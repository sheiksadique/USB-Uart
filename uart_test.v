`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   01:18:56 06/07/2015
// Design Name:   UART_IP
// Module Name:   /home/sadique/Work/Verilog/Spartan6/USB-uart/uart_test.v
// Project Name:  USB-uart
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: UART_IP
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module uart_test;

	// Inputs
	reg sys_clk;
	reg RTS;
	reg RX;
	wire [7:0] RxD_par;
	wire RxD_start;

	// Outputs
	wire CTS;
	wire TX;
	wire [7:0] TxD_par;
	wire TxD_ready;

	// Instantiate the Unit Under Test (UUT)
	UART_IP uut (
		.sys_clk(sys_clk),		 
		.CTS(CTS), 
		.RTS(RTS),
		.TX(TX), 
		.RX(RX), 
		.TxD_par(TxD_par), 
		.TxD_ready(TxD_ready), 
		.RxD_par(RxD_par), 
		.RxD_start(RxD_start)
	);
	
	
	// Loop parallel ouput as input
	assign RxD_par = TxD_par;
	assign RxD_start = TxD_ready;

	initial begin
		// Initialize Inputs
		sys_clk = 0;
		RTS = 0; // active low
		RX = 1;
		//RxD_par = 0;
		//RxD_start = 0;

		// Wait 100 ns for global reset to finish
		#5000;
      
		// Add stimulus here
		#0 RX = 0; //Start bit
		#8680 RX = 0; //bit 0 
		#8680 RX = 1; //bit 1
		#8680 RX = 0; //bit 2
		#8680 RX = 1; //bit 3
		#8680 RX = 0; //bit 4 
		#8680 RX = 1; //bit 5
		#8680 RX = 0; //bit 6
		#8680 RX = 0; //bit 7
		#8680 RX = 1; //Stop bit
		#8680 RX = 0; //Start bit
		#8680 RX = 1; //bit 0 
		#8680 RX = 1; //bit 1
		#8680 RX = 0; //bit 2
		#8680 RX = 1; //bit 3
		#8680 RX = 0; //bit 4 
		#8680 RX = 1; //bit 5
		#8680 RX = 0; //bit 6
		#8680 RX = 1; //bit 7
		#8680 RX = 1; //Stop bit
		#8680 RX = 0; //Start bit
		#8680 RX = 1; //bit 0 
		#8680 RX = 1; //bit 1
		#8680 RX = 0; //bit 2
		#8680 RX = 1; //bit 3
		#8680 RX = 0; //bit 4 
		#8680 RX = 1; //bit 5
		#8680 RX = 0; //bit 6
		#8680 RX = 1; //bit 7
		#8680 RX = 1; //Stop bit
		#8680 RX = 0; //Start bit
		#8680 RX = 1; //bit 0 
		#8680 RX = 1; //bit 1
		#8680 RX = 0; //bit 2
		#8680 RX = 1; //bit 3
		#8680 RX = 0; //bit 4 
		#8680 RX = 1; //bit 5
		#8680 RX = 0; //bit 6
		#8680 RX = 1; //bit 7
		#8680 RX = 1; //Stop bit
		#20000
		#8680 RX = 0; //Start bit
		#8680 RX = 1; //bit 0 
		#8680 RX = 1; //bit 1
		#8680 RX = 0; //bit 2
		#8680 RX = 1; //bit 3
		#8680 RX = 0; //bit 4 
		#8680 RX = 1; //bit 5
		#8680 RX = 0; //bit 6
		#8680 RX = 1; //bit 7
		#8680 RX = 1; //Stop bit

	end
	
	always begin
		#2.5 sys_clk <= !sys_clk;
	end
      
endmodule

