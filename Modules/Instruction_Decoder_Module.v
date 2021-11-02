
module Instruction_Decoder_Module(
	//inputs
	input CLK,
	input RESET,
	input [2:0] Opcode,
	input [2:0] Operand_1_address,
	input Operand_2_type,
	input Operand_number,
	//outputs
	output [2:0]Opcode_out,
	output Enable_RegALU_mul,
	output Enable_ALU,
	output Enable_Write_Data,
	output Enable_Read_Data_A,
	output Enable_Read_Data_B,
	output [2:0]Operand_1_address_to_write,
	output [2:0]Operand_1_address_to_A,
	output [2:0]Operand_1_address_to_B,
	output check
    );
	 
	 //inside
	 reg[2:0] clock;
	 reg[4:0] Enable_control;
	 reg[2:0] Opcode_register;
	 reg[2:0] Operand_1_address_register_to_write;
	 reg[2:0] Operand_1_address_register_to_A;
	 reg[2:0] Operand_1_address_register_to_B;
	 reg CHECK;
	 assign check = CHECK;
	 
	 //paramters
	 parameter
		MOV = 3'b000,
		ADD = 3'b001,
		SUB = 3'b010,
		ABS = 3'b011,
		NOT = 3'b100,
		AND = 3'b101,
		NEG = 3'b110,
		HLT = 3'b111;
		
	parameter
		CLK1 = 3'd0,
		CLK2 = 3'd1,
		CLK3 = 3'd2,
		CLK4 = 3'd3,
		CLK5 = 3'd4,
		CLK6 = 3'd5,
		CLK7 = 3'd6,
		CLK8 = 3'd7;
		
	 //control the process of the CPU
	 //time diagram control
	 //Core of the CPU!
	always@(posedge CLK or negedge RESET)
		begin
			if(!RESET) 
				begin
					clock <= 3'd0;
					Enable_control[4:1] <= 4'b0000;
					Opcode_register <= HLT;
					CHECK <= 1'b1;
				end
			else
				begin
					case(clock)
						CLK1: clock <= clock + 1'b1;//wait the first 8 code to load
						CLK2:	begin Opcode_register <= Opcode; clock <= clock + 1'b1;end
						CLK3:	
							begin
								clock <= clock + 1'b1;
								//MOV ADD SUB 
								if((Opcode_register == MOV)||(Opcode_register == ADD)||(Opcode_register == SUB))
									Enable_control[0] <= 1; //select mul
								//ABS
								else if(Opcode_register == ABS)
									Enable_control[0] <= 0; //select mul	
							end
						CLK4:
							begin
								clock <= clock + 1'b1;
								//MOV 
									//wait
								//ADD SUB
								if((Opcode_register == ADD)||(Opcode_register == SUB))
									begin
										Operand_1_address_register_to_B <= Operand_1_address;//give address to B
										Enable_control[4] <= 1;//enable read B
									end
								//ABS
								else if(Opcode_register == ABS)
									begin
										Enable_control[3] <= 1;//enable read A
										Operand_1_address_register_to_A <= Operand_1_address;//give address to A
									end
								
							end
						CLK5:
							begin
								clock <= clock + 1'b1;
								Enable_control[1] <= 1;//enable ALU
						
							end
						CLK6:
							begin
								clock <= clock + 1'b1;
								//MOV
								if(Opcode_register == MOV)
									begin
										Enable_control[1] <= 0; // disable ALU  
										Enable_control[2] <= 1; // enable write
										Operand_1_address_register_to_write <= Operand_1_address; //give the address to write
									end
								//ADD
								else if((Opcode_register == ADD)||(Opcode_register == SUB))
									begin
										Enable_control[1] <= 0;//disable ALU
										Enable_control[4] <= 0;//disable read B
									end
								//SUB
								else if(Opcode_register == ABS)
									begin
										Enable_control[1] <= 0;//disable ALU
										Enable_control[3] <= 0;//disable read A
									end
							end
						CLK7:
							begin
								clock <= clock + 1'b1;
								//MOV
									//wait
								//ADD SUB ABS
								if((Opcode_register == ADD)||(Opcode_register == SUB)||(Opcode_register == ABS))
									begin
										Enable_control[2] <= 1;//enable write
										Operand_1_address_register_to_write <= Operand_1_address;//give the address to write
									end
							end
						CLK8:
							begin
								clock <= 3'd0;
								Enable_control[2] <= 0;//disable data write
								Enable_control[0] <= 1'bz;
							end
						default:begin CHECK <= 1'b1; clock <= 3'd0;Enable_control[4:1] <= 4'b0000;Enable_control[0] <= 1'bz; end
					endcase
				end
		end
		
		//combinational logic circuit
		assign Enable_RegALU_mul = Enable_control[0];
		assign Enable_ALU = Enable_control[1];
		assign Enable_Write_Data = Enable_control[2];
		assign Enable_Read_Data_A = Enable_control[3];
		assign Enable_Read_Data_B = Enable_control[4];
		assign Opcode_out = Opcode_register;
		assign Operand_1_address_to_write = Operand_1_address_register_to_write;
		assign Operand_1_address_to_A = Operand_1_address_register_to_A;
		assign Operand_1_address_to_B = Operand_1_address_register_to_B;


endmodule