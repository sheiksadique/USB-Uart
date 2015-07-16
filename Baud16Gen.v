`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:03:04 06/12/2015 
// Design Name: 
// Module Name:    Baud16Gen 
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
module Baud16Gen(
    input sys_clk, //200MHZ
    output Baud16Tick     //~115200*16
    );
	 reg [24:0] count=0;
	 
	 // 200e6/115200 ~ 2**28/154619
	 // 27e6/115200 ~ 2**19/2237
	 
	 always @(posedge sys_clk)
	 begin
		count <= count[23:0] + 154619;
	 end
	
	 assign Baud16Tick = count[24];

endmodule
