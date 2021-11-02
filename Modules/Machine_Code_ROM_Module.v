
module Machine_Code_ROM_Module(
	input CLK,
	input RESET,
	output [7:0] half_instruction
    );
	 
	 //inside all instructions 
	 reg[63:0] ALL_instruction;
	 //output instructions 
	 reg[7:0] output_instruction;
	 //clock counter
	 reg [2:0] clock;
	 //instruction counter
	 reg [1:0] instruction_counter;
	 //
	 assign half_instruction = output_instruction;
	 
	 //parameters
	 parameter
		CLK1 = 3'd0,
		CLK2 = 3'd1,
		CLK3 = 3'd2,
		CLK4 = 3'd3,
		CLK5 = 3'd4,
		CLK6 = 3'd5,
		CLK7 = 3'd6,
		CLK8 = 3'd7;
	 //sequential output
	 always@(posedge CLK or negedge RESET )
		if(!RESET)
			begin
				clock <= 3'd0;
				output_instruction <= 8'b0000_0000;
				instruction_counter <= 2'b00;
				//the real mannul instructions!
				//Example_1_:|32+16-64|
				//MOV AL, 32
				//ALL_instruction[63:48] <= 16'b000_1_1_000_00100000;
				//ADD AL, 16
				//ALL_instruction[47:32] <= 16'b001_1_1_000_00010000;
				//SUB AL, 64
				//ALL_instruction[31:16] <= 16'b010_1_1_000_01000000;
				//ABS AL
				//ALL_instruction[15:0] <= 16'b011_0_z_000_zzzzzzzz;
				//Example_2_:|28+54-91|
				//MOV AL, 28
				ALL_instruction[63:48] <= 16'b000_1_1_000_00011100;
				//ADD AL, 54
				ALL_instruction[47:32] <= 16'b001_1_1_000_00110110;
				//SUB AL, 91
				ALL_instruction[31:16] <= 16'b010_1_1_000_01011011;
				//ABS AL
				ALL_instruction[15:0] <= 16'b011_0_z_000_zzzzzzzz;
			end
		else
			case(clock)
				CLK1: 
					begin
						clock <= clock + 1'b1;
						if(instruction_counter == 2'b00)
							output_instruction <= ALL_instruction[63:56];
						else if(instruction_counter == 2'b01)
							output_instruction <= ALL_instruction[47:40];
						else if(instruction_counter == 2'b10)
							output_instruction <= ALL_instruction[31:24];
						else if(instruction_counter == 2'b11)
							output_instruction <= ALL_instruction[15:8];
					end
				CLK2:
					begin
						clock <= clock + 1'b1;
						if(instruction_counter == 2'b00)
							output_instruction <= ALL_instruction[55:48];
						else if(instruction_counter == 2'b01)
							output_instruction <= ALL_instruction[39:32];
						else if(instruction_counter == 2'b10)
							output_instruction <= ALL_instruction[23:16];
						else if(instruction_counter == 2'b11)
							output_instruction <= ALL_instruction[7:0];
						
					end
				CLK3:	clock <= clock + 1'b1;
				CLK4: clock <= clock + 1'b1;
				CLK5: clock <= clock + 1'b1;
				CLK6: clock <= clock + 1'b1;
				CLK7: clock <= clock + 1'b1;
				CLK8:
					begin
						clock <= 3'd0;
						instruction_counter <= instruction_counter + 1'b1;
					end
				default: 
					begin
						clock <= 3'd0;
						//the real mannul instructions!
						//Example_1_:|10+10-(-7)|
						//MOV AL, 10
						//ALL_instruction[63:48] <= 16'b000_1_1_000_00100000;
						//ADD AL, 10
						//ALL_instruction[47:32] <= 16'b001_1_1_000_00010000;
						//SUB AL, -7
						//ALL_instruction[31:16] <= 16'b010_1_1_000_01000000;
						//ABS AL
						//ALL_instruction[15:0] <= 16'b011_0_z_000_zzzzzzzz;
						//Example_2_:|28+54-91|
						//MOV AL, 28
						ALL_instruction[63:48] <= 16'b000_1_1_000_00011100;
						//ADD AL, 54
						ALL_instruction[47:32] <= 16'b001_1_1_000_00110110;
						//SUB AL, 91
						ALL_instruction[31:16] <= 16'b010_1_1_000_01011011;
						//ABS AL
						ALL_instruction[15:0] <= 16'b011_0_z_000_zzzzzzzz;
						output_instruction <= 8'bzzzz_zzzz;
						instruction_counter <= 2'b00;
					end
			endcase
			
		
	 


endmodule
