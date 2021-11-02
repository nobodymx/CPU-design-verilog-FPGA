
module Mul_Reg_to_ALU_Module(
	input selection,
	input [7:0] Immediate_data,
	input [7:0] Register_data,
	output [7:0] Data_out,
	output check
    );
	 
	 reg [7:0] data_out;
	 assign Data_out = data_out;
	 reg CHECK;
	 assign check = CHECK;
	 initial
	  begin
		CHECK = 1'b1;
	  end

	//combinational logic circuit
	always@(selection or Register_data or Immediate_data )
		if(selection == 0)
			data_out <= Register_data;
		else if(selection == 1)
			data_out <= Immediate_data;
endmodule
