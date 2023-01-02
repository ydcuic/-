`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/02 14:52:16
// Design Name: 
// Module Name: alu
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module alu(
	input wire[31:0] a,b,
	input wire[4:0] op,
	input wire [31:0] hi_in,lo_in,
	output reg[31:0] y,
	output reg overflow,
	output  reg[31:0] hi_alu_out,lo_alu_out,
	output wire zero
    );
    reg carry_bit;
	
	always @(*) begin
		case (op)
			5'b00111: y <= a & b;
			5'b00001: y <= a | b;
			5'b00010: y <= a ^ b;
			5'b00011: y <= ~( a | b );
			5'b00100: y <= {b[15:0], {16{1'b0}}};
			
			5'b10000: {carry_bit, y} <= {a[31], a} + {b[31], b};
			5'b10001: y <=  a+b;
            5'b10010: {carry_bit, y} <= {a[31], a} - {b[31], b};
            5'b10011: y <=  a-b;
            5'b10100: y <= $signed(a) < $signed(b);
            5'b10101: y <= a < b;
            
			//数据移动
            5'b11100:y <= hi_in[31:0];
			5'b11101:y <= lo_in[31:0];
			5'b11110:hi_alu_out <= a;
			5'b11111:lo_alu_out <= a;
			//乘法
			5'b11000:{hi_alu_out,lo_alu_out} <= $signed(a)*$signed(b);
			5'b11001:{hi_alu_out,lo_alu_out} <= a * b;
        
			default : y <= 32'b0;
		endcase	
	end
	assign zero = (y == 32'b0);

	always @(*) begin
		overflow = (op==5'b00101 || op==5'b00111) & (carry_bit ^ y[31]);
	end
endmodule
