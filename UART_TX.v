`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:06:02 05/29/2015 
// Design Name: 
// Module Name:    UART_TX 
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

// Serializer
//1 start bit, 1 stop bit

module UART_TX(
    input [7:0] RxD_par, // 8 bit data
    input RxD_start,
	 input RTS, // USB clear to send (active high)
    input sys_clk,
	 input BaudTick,
    output reg TxD_ser
    );


	//State machine
	reg [3:0] state=0;
	reg [7:0] RxD_buff=0;
	
	always @(posedge sys_clk)
	begin
		if (RxD_start & state<2) begin
			RxD_buff <= RxD_par; // Buffer data received
		end else if (state[3] & BaudTick) begin
			RxD_buff <= (RxD_buff >> 1); // Shift a bit at every baud tick during transmission
		end
	
		case(state)
			4'b0000: if(RxD_start & RTS) state <= 4'b0010;//Initiate process when data is valied and USB is ready to receive
			4'b0010: if(BaudTick) state <= 4'b0011; // Synchronize to baudtick, 
			4'b0011: if(BaudTick) state <= 4'b1000; //start (state !< 2 , state[3]=0 ie TxD = 0)
			4'b1000: if(BaudTick) state <= 4'b1001; //bit 0
			4'b1001: if(BaudTick) state <= 4'b1010; //bit 1
			4'b1010: if(BaudTick) state <= 4'b1011; //bit 2 
			4'b1011: if(BaudTick) state <= 4'b1100; //bit 3
			4'b1100: if(BaudTick) state <= 4'b1101; //bit 4
			4'b1101: if(BaudTick) state <= 4'b1110; //bit 5
			4'b1110: if(BaudTick) state <= 4'b1111; //bit 6
			4'b1111: if(BaudTick) state <= 4'b0001; //bit 7
			4'b0001: if(BaudTick) begin //stop
							if(RxD_start & RTS) begin
								state <= 4'b0011; // Data already synchronized to baudtick
							end else begin
								state <= 4'b0000; //	(state < 2 ie TxD = 1)
							end
						end						
			default: if(BaudTick) state <= 4'b0000; 
		endcase
			
	end
	
	//reg TxD_ser;
	always @(posedge sys_clk)
	begin
		// Filter according to state
		TxD_ser <= (state < 3) | (state[3] & RxD_buff[0]); // Send it through a register
	end

endmodule
