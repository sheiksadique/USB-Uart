`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:51:56 05/29/2015 
// Design Name: 
// Module Name:    BaudGen 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: see for more on baud generation ->http://www.fpga4fun.com/SerialInterface2.html
//
//////////////////////////////////////////////////////////////////////////////////
module BaudGen(
    input sys_clk, //200 MHZ
    output BaudTick     //~115200
    );
	 reg [28:0] count=0;
	 
	 // 200e6/115200 ~ 2**28/154619
	 
	 always @(posedge sys_clk)
	 begin
		count <= count[27:0] + 154619;
	 end
	
	 assign BaudTick = count[28];

endmodule
