`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:55:15 05/29/2015 
// Design Name: 
// Module Name:    UART_IP 
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
module UART_IP(
	 // UART USB ports
	 input sys_clk, // 27 MHZ on SP605
    output CTS,// I am ready to receive data (active low)
    input RTS, // USB Clear to send (active low)
    output TX, // Output to USB
    input RX,  // Input to USB
	 
	 // FPGA
	 output [7:0] TxD_par,
	 output TxD_ready,
	 input [7:0] RxD_par,
	 input RxD_start
    );
	 
	 wire BaudTick;
	 wire Baud16Tick;
	 
	 assign CTS = ~NCTS;

	 
	 // Generate baud clock 115200
	 BaudGen baudgen(
    .sys_clk(sys_clk),
    .BaudTick(BaudTick)
    );
	 
	 Baud16Gen baud16gen(
    .sys_clk(sys_clk),
    .Baud16Tick(Baud16Tick)
    );
	 
	 
	 // Transmit data to USB
	 UART_TX uart_tx(
    .RxD_par(RxD_par), // 8 bit data Input from FPGA
    .RxD_start(RxD_start), // start input from FPGA
	 .RTS(~RTS), // USB clear to send
    .sys_clk(sys_clk),
	 .BaudTick(BaudTick),
    .TxD_ser(TX)
    );
	 
	 
	 // Receive data from USB
	 UART_RX uart_rx (
		.RxD_ser(RX), 
		.CTS(NCTS), // I am clear to receive
		.sys_clk(sys_clk), 
		.Baud16Tick(Baud16Tick), 
		.TxD_par(TxD_par), //8 bit Output data to fpga
		.TxD_ready(TxD_ready) // Ready data to FPGA
	 );
	 	 
	 

endmodule
