// Quartus II Verilog Template
// Binary up/down counter

module clock_all
(
	  clk, 
	  clock_1MHz,
	  clock_100kHz,
	  clock_10kHz,
	  clock_1kHz,
	  clock_100Hz,
	  clock_10Hz,
	  clock_1Hz,
	  clock_01Hz,
	  clock_1s, 
	  clock_100ms, 
	  clock_10ms, 
	  clock_1ms, 
	  clock_100us, 
	  clock_10us, 
	  clock_1us
);

	input clk;
	output  clock_1MHz;
	output  clock_100kHz;
	output  clock_10kHz;
	output  clock_1kHz;
	output  clock_100Hz;
	output  clock_10Hz;
	output  clock_1Hz;
	output  clock_01Hz;
	output  clock_1s, clock_100ms, clock_10ms, clock_1ms, clock_100us, clock_10us, clock_1us;
	
	assign clock_1s = clock_1Hz;
	assign clock_100ms = clock_10Hz;
	assign clock_10ms = clock_100Hz;
	assign clock_1ms = clock_1kHz;
	assign clock_100us = clock_10kHz;
	assign clock_10us = clock_100kHz;
	assign clock_1us = clock_1MHz;
	

divider_50 clk0( .clk(clk), .clk_div50(clock_1MHz));
divider_10 clk1( .clk(clock_1MHz),  .clk_div10(clock_100kHz));
divider_10 clk2( .clk(clock_100kHz),  .clk_div10(clock_10kHz));
divider_10 clk3( .clk(clock_10kHz),  .clk_div10(clock_1kHz));
divider_10 clk4( .clk(clock_1kHz),  .clk_div10(clock_100Hz));
divider_10 clk5( .clk(clock_100Hz),  .clk_div10(clock_10Hz));
divider_10 clk6( .clk(clock_10Hz),  .clk_div10(clock_1Hz));	
divider_10 clk7( .clk(clock_1Hz),  .clk_div10(clock_01Hz));
		
	
endmodule

module divider_10
(
	input clk, 
	output reg clk_div10,
	output reg [3:0] count_10
);


	always @ (posedge clk)
	begin
		if (count_10==4)
			begin
				count_10 <= 0;
				clk_div10<=~clk_div10;
			end
		else
				count_10 <= count_10 + 1;
	end	
endmodule

module divider_50
(
	input clk, 
	output reg clk_div50,
	output reg [5:0] count_50
);


	always @ (posedge clk)
	begin
		if (count_50==24)
		begin
			count_50 <= 0;
			clk_div50<=~clk_div50;
		end
		else
			count_50 <= count_50 + 1;
	end
	
endmodule