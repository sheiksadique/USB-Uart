`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:01:52 06/07/2015 
// Design Name: 
// Module Name:    UART_LOOPBACK 
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
module UART_LOOPBACK(
	 // UART USB ports
	 input sys_clk, // 27 MHZ on SP605
    output CTS,// I am ready to receive data
    input RTS, // USB Clear to send
    output TX, // Output to USB
    input RX,  // Input to USB
	 output [3:0] leds
    );

	// LOOPBACK WIRES
	wire [7:0] TxD_par;
	wire TxD_ready;
	
	
	
	assign leds = {CTS,RTS,TxD_par[1:0]};
	
	UART_IP uartip(
	 // UART USB ports
	 .sys_clk(sys_clk), // 27 MHZ on SP605
    .RTS(RTS),// I am ready to receive data
    .CTS(CTS), // USB Clear to send
    .TX(TX), // Output to USB
    .RX(RX),  // Input to USB
	 
	 // FPGA
	 .TxD_par(TxD_par),
	 .TxD_ready(TxD_ready),
	 .RxD_par(TxD_par),
	 .RxD_start(TxD_ready)
    );


endmodule
