`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/10/23 15:21:30
// Design Name: 
// Module Name: maindec
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


module maindec(
	input wire[5:0] op,

	output wire memtoreg,memwrite,
	output wire branch,alusrc,
	output wire regdst,regwrite,
	output wire jump,
	output wire[3:0] aluop,
	output wire[1:0] hilo_we
    );
	reg[12:0] controls;
	assign {regwrite,regdst,alusrc,branch,memwrite,memtoreg,jump,aluop,hilo_we} = controls;
	always @(*) begin
		case (op)
		default:  controls <= 13'b0000_000_1111_00;
//{regwrite,regdst,alusrc,branch}_{memwrite,memtoreg,jump}_{aluop}_{hilo_we}

			6'b000000 :controls <= 13'b1100_000_1000_00;//R-TYRE
			6'b100011 :controls <= 13'b1010_010_0100_00;//LW
			6'b101011 :controls <= 13'b0010_100_0100_00;//SW
			6'b000100 :controls <= 13'b0001_000_1011_00;//BEQ
			
			6'b001000 :controls <= 13'b1010_000_0100_00;//ADDI 
			6'b001001 :controls <= 13'b1010_000_0101_00;//ADDIU
			6'b001010 :controls <= 13'b1010_000_0110_00;//SLTI
			6'b001011 :controls <= 13'b1010_000_0111_00;//SLTIU  
			
			6'b001100 :controls <= 13'b1010_000_0000_00;//andi 
			6'b001110 :controls <= 13'b1010_000_0001_00;//xori 
			6'b001111 :controls <= 13'b1010_000_0010_00;//lui 
			6'b001101 :controls <= 13'b1010_000_0011_00;//ori 
			
			6'b000010 :controls <= 13'b0000_001_0100_00;//J

			//乘除
			6'b011000:controls <= 13'b0000_000_1000_11; //MULT
			6'b011001:controls <= 13'b0000_000_1000_11; //MULTU
			6'b011010:controls <= 13'b0000_000_1000_11; //DIV
			6'b011011:controls <= 13'b0000_000_1000_11; //DIVU

			//数据移动指令
			6'b010000:controls <= 13'b1100_000_1000_00; //MFHI
			6'b010001:controls <= 13'b1100_000_1000_00; //MTHI
			6'b010010:controls <= 13'b0000_000_1000_10; //MFLO
			6'b010011:controls <= 13'b0000_000_1000_01; //MTLO
		endcase
	end
endmodule
