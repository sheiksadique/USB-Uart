`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:32:32 06/02/2015 
// Design Name: 
// Module Name:    Baud8Gen 
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
module Baud8Gen(
    input sys_clk, //200MHZ
    output Baud8Tick     //~115200*8
    );
	 reg [25:0] count=0;
	 
	 // 200e6/115200 ~ 2**28/154619
	 // 27e6/115200 ~ 2**19/2237
	 
	 always @(posedge sys_clk)
	 begin
		count <= count[24:0] + 154619;
	 end
	
	 assign Baud8Tick = count[25];

endmodule
