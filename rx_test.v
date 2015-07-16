`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:56:14 06/06/2015
// Design Name:   UART_RX
// Module Name:   /home/sadique/Work/Verilog/Spartan6/USB-uart/rx_test.v
// Project Name:  USB-uart
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: UART_RX
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module rx_test;

	// Inputs
	reg RxD_ser;
	reg sys_clk;
	wire Baud8Tick;

	// Outputs
	wire CTS;
	wire [7:0] TxD_par;
	wire TxD_ready;
	
	Baud8Gen uut8 (
		.sys_clk(sys_clk), 
		.Baud8Tick(Baud8Tick)
	);

	// Instantiate the Unit Under Test (UUT)
	UART_RX uut (
		.RxD_ser(RxD_ser), 
		.CTS(CTS), 
		.sys_clk(sys_clk), 
		.Baud8Tick(Baud8Tick), 
		.TxD_par(TxD_par), 
		.TxD_ready(TxD_ready)
	);

	initial begin
		// Initialize Inputs
		RxD_ser = 1;
		sys_clk = 0;

		// Wait 100 ns for global reset to finish
		#5000;
        
		// Add stimulus here
		#0 RxD_ser = 0; //Start bit
		#8680 RxD_ser = 0; //bit 0 
		#8680 RxD_ser = 1; //bit 1
		#8680 RxD_ser = 0; //bit 2
		#8680 RxD_ser = 1; //bit 3
		#8680 RxD_ser = 0; //bit 4 
		#8680 RxD_ser = 1; //bit 5
		#8680 RxD_ser = 0; //bit 6
		#8680 RxD_ser = 0; //bit 7
		#8680 RxD_ser = 1; //Stop bit
		#8680 RxD_ser = 0; //Start bit
		#8680 RxD_ser = 1; //bit 0 
		#8680 RxD_ser = 1; //bit 1
		#8680 RxD_ser = 0; //bit 2
		#8680 RxD_ser = 1; //bit 3
		#8680 RxD_ser = 0; //bit 4 
		#8680 RxD_ser = 1; //bit 5
		#8680 RxD_ser = 0; //bit 6
		#8680 RxD_ser = 1; //bit 7
		#8680 RxD_ser = 1; //Stop bit
	end
	
	always begin
		#18.5 sys_clk <= !sys_clk;
	end
      
endmodule

