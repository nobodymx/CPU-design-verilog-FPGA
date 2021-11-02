
module ALU_Module(
	//inputs
	input CLK,
	input Enable_cal,
	input [2:0]FS,
	input [7:0] Data_in_A,
	input [7:0] Data_in_B,
	//output
	output [7:0]Result_out,
	output check
    );
	 
	 //inside registers
	 reg[7:0] temp_result;
	 reg CHECK;
	 assign check = CHECK;
	 initial
	  begin
		CHECK = 1'b1;
	  end
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
	//combinational logic circuit
	assign Result_out = temp_result;
	
	//calculation sequential circuit
	always@(posedge CLK)
		begin
			if(Enable_cal)
				case (FS)
					MOV: temp_result <= Data_in_A;
					ADD: temp_result <= Data_in_A + Data_in_B;
					SUB: temp_result <= Data_in_B - Data_in_A;
					ABS: 
						begin
							if(Data_in_A[7] == 1)
								temp_result <= ~Data_in_A + 1'b1;
							else if(Data_in_A[7] == 0)
								temp_result <= Data_in_A;
						end
					NOT: temp_result <= ~Data_in_A;
					AND: temp_result <= Data_in_A & Data_in_B;
					NEG: temp_result <= ~Data_in_A + 1'b1;
					HLT: temp_result <= 8'bzzzz_zzzz;
				endcase
		end
	 
	 
	 


endmodule
