//Verilog module for FIFO full logic 
module FIFO_Full #(parameter address_Size = 3)(
	output [address_Size-1:0]w_Addr,	//next Address to be written 
	input 	w_Clk,				//write clock domain clock
	input	w_Inc,				//asserted when the current address is written so that write address and pointer gets updated
	output reg [address_Size:0]w_Ptr,	//Write pointer always points to the location to be written to
	input   w_Rst,				//Write clock domain Reset
	output reg fifo_Full,			//Assereted when FIFO is full
	input   [address_Size:0]wsync_Rptr);			//Write clock synchronized Read pointer 

	wire [address_Size:0]w_NextBin, w_NextGray;	//to store next address and pointer
	reg [address_Size:0] w_Bin;			//to store current address to be written
	wire w_full;
//Assigning next address and pointer of the write domain 
always@(posedge w_Clk, negedge w_Rst)begin 
	if(!w_Rst)begin 
		w_Bin <= 0;
		w_Ptr <= 0;
	end 
	else begin 
		w_Bin <= w_NextBin;
		w_Ptr <= w_NextGray;
	end
end 

//Assigning current adddress to be written to in the memory
assign w_Addr = w_Bin[address_Size-1:0];

///Calculating gray counter value for updating next pointer and updating next address 
assign w_NextBin = w_Bin + ( w_Inc & ~fifo_Full );
assign w_NextGray = ( w_NextBin >> 1) ^ w_NextBin;

//Comparing the pointers to see if the fifo full condition is met
assign w_full = (w_NextGray == {~wsync_Rptr[address_Size:address_Size-1],wsync_Rptr[address_Size-2:0]});

//Logic to assert fifo full condition 
always@(posedge w_Clk, negedge w_Rst)begin 
	if(!w_Rst) 
		fifo_Full <= 1'b0;
	else 
		fifo_Full <= w_full;
end
endmodule

