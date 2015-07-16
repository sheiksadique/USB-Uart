`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:08:14 05/29/2015 
// Design Name: 
// Module Name:    UART_RX 
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

//De-serializer
module UART_RX(
    input RxD_ser,
	 output CTS, // I am clear to receive (active high)
	 input sys_clk,
	 input Baud16Tick, // Oversampling by 16
    output reg [7:0] TxD_par, //8 bit data
    output TxD_ready
    );
	

	
	// Data synchronization ans stablization by passing it through 2 flip flops
	reg [1:0] RxD_sync;
	always @(posedge sys_clk) if(Baud16Tick) RxD_sync <= {RxD_sync[0], RxD_ser};
	
	
	// Filter data
	reg [2:0] RxD_cnt=7;
	reg RxD_bit;

	always @(posedge sys_clk)
	if(Baud16Tick)
	begin
		if(RxD_sync[1] && RxD_cnt!=3'b111) RxD_cnt <= RxD_cnt + 1; // Count up no of times line is high
		else if(~RxD_sync[1] && RxD_cnt!=3'b000) RxD_cnt <= RxD_cnt - 1; // Count down no of times line is low
		
		// Determine data
		if(RxD_cnt==3'b000) RxD_bit <= 0;
		else if(RxD_cnt==3'b111) RxD_bit <= 1;
	end
	
	// State machine
	reg [3:0] state=0;

	always @(posedge sys_clk)
	if(Baud16Tick)
	case(state)
		4'b0000: if(~RxD_bit) state <= 4'b1000; // start bit found?
		4'b1000: if(next_bit) state <= 4'b1001; // bit 0
		4'b1001: if(next_bit) state <= 4'b1010; // bit 1
		4'b1010: if(next_bit) state <= 4'b1011; // bit 2
		4'b1011: if(next_bit) state <= 4'b1100; // bit 3
		4'b1100: if(next_bit) state <= 4'b1101; // bit 4
		4'b1101: if(next_bit) state <= 4'b1110; // bit 5
		4'b1110: if(next_bit) state <= 4'b1111; // bit 6
		4'b1111: if(next_bit) state <= 4'b0001; // bit 7
		4'b0001: if(next_bit) state <= 4'b0000; // stop bit
		default: state <= 4'b0000;
	endcase
	
	// Ready to receive
	assign CTS = (state<2); //ready to receive
	
	// Measure bit spacing
	reg [3:0] bit_spacing;
	always @(posedge sys_clk)
	if(state==0)
		bit_spacing <= 0;
	else
	if(Baud16Tick) bit_spacing <= bit_spacing + 1;
	
	wire next_bit = (bit_spacing==15);
	
	assign TxD_ready = (state==1);
	
	// Collect data	
	//reg [7:0] TxD_par;
	always @(posedge sys_clk) if(Baud16Tick && next_bit && state[3]) TxD_par <= {RxD_bit, TxD_par[7:1]};
	
	
endmodule
