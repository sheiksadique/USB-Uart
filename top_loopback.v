`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:28:58 06/08/2015 
// Design Name: 
// Module Name:    top_loopback 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module top_loopback(
		// UART USB ports
		input sys_clk_p, // 200 MHZ on SP605
		input sys_clk_n, // 200 MHZ on SP605
		output CTS,// I am ready to receive data
		input RTS, // USB Clear to send
		output TX, // Output to USB
		input RX,  // Input to USB
		output [3:0] leds
    );
	 
	 wire bsys_clk; //Buffered clock
	 
	 UART_LOOPBACK loopback(
	 // UART USB ports
	 .sys_clk(bsys_clk), // 200 MHZ on SP605
    .CTS(CTS),// I am ready to receive data
    .RTS(RTS), // USB Clear to send
    .TX(TX), // Output to USB
    .RX(RX),  // Input to USB
	 .leds(leds)
    );
	 
	 /*
	 IBUFG ibufg(
	 .I(sys_clk),
	 .O(bsys_clk)
	 );
	 */
	 
	 IBUFGDS ibufgds(
	 .I(sys_clk_p),
	 .IB(sys_clk_n),
	 .O(bsys_clk)
	 );


endmodule
