`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/10/23 15:27:24
// Design Name: 
// Module Name: aludec
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


module aludec(
	input wire[5:0] funct,
	input wire[3:0] aluop,
	output reg[4:0] alucontrol
    );
	always @(*) begin
		case (aluop)
			4'b0100: alucontrol <= 5'b10000;//add (for lw/sw/addi)
			4'b1011: alucontrol <= 5'b10010;//sub (for beq)
			
			4'b0000: alucontrol <= 5'b00111;//andi
			4'b0001: alucontrol <= 5'b00010;//xori
			4'b0011: alucontrol <= 5'b00100;//lui
			4'b0010: alucontrol <= 5'b00001;//ori	
			
			4'b0100: alucontrol <= 5'b10000;//addi
			4'b0101: alucontrol <= 5'b10001;//addiu
			4'b0110: alucontrol <= 5'b10100;//slti
			4'b0111: alucontrol <= 5'b10101;//sltiu
				
			4'b1000 : case (funct)
				6'b100100:alucontrol <= 5'b00111; //and
				6'b100101:alucontrol <= 5'b00001; //or
				6'b100110:alucontrol <= 5'b00010;  //xor
				6'b100111:alucontrol <= 5'b00011;  //nor
				
				6'b100000:alucontrol <= 5'b10000; //add 
				6'b100001:alucontrol <= 5'b10001; //addu
				
				6'b100010:alucontrol <= 5'b10010; //sub
				6'b100011:alucontrol <= 5'b10011; //subu
				
				6'b101010:alucontrol <= 5'b10100; //slt
				6'b101011:alucontrol <= 5'b10101; //sltu
			
				default:  alucontrol <= 3'b00000;
			endcase
		endcase
	
	end
endmodule
