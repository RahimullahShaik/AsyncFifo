//verilog code for FIFO EMPTY condition 
module FIFO_Empty #(parameter address_Size=5)(
		output [address_Size-1:0]r_Addr,		//Address to which the FIFO output should be read, Read pointer 
								//always points to the address to be read next 
		input r_Clk,					//Read Clock domain clock
		input r_Inc, 					//Used to increment the Read pointer 
		output reg [address_Size:0]r_Ptr, 			//Read pointer which points to the address to be read 
		input r_Rst, 					//Reset in Read clock domain 
		output reg fifo_Empty, 				//Gets asserted when FIFO is emptyy
		input [address_Size:0]rsync_Wptr);		//read pointer synched with write pointer in Read clock domain 

		reg [address_Size:0] r_Bin;			//To store Binary value
		wire [address_Size:0] r_BinNext, r_GrayNext;	//To store next binary and gray values 
		wire r_empty;
//Assigning gray value to FIFO read pointer which always points the next address to be written 
//Updating the binary value which is the address of the FIFO to be written 
always @(posedge r_Clk, negedge r_Rst)begin 
	if(!r_Rst)begin 
		r_Bin <= 0;
		r_Ptr  <= 0;
	end
	else begin
		r_Bin <= r_BinNext;
		r_Ptr <= r_GrayNext;
	end

end

//The current Binary value is the address to be written hence assigning it to the address
assign r_Addr = r_Bin;

//Calculating next address value basing on rin and fifo Empty conditions, if FIFO is empty then we dont increment the address 
assign r_BinNext = r_Bin + (r_Inc & ~fifo_Empty);

//Converting binary to gray value to calculate the next read pointer value as the tendency to get errors in gray values is less 
//coz there is a change only in one bit at a time even if the transitor switching is problem the errors would be less 
assign r_GrayNext = (r_BinNext>>1) ^ r_BinNext;

//comparing the read clock domain synchronized write pointer and calcuated gray value of the read pointer to see if they match 
//if they are same then FIFO is empty
assign r_empty = (r_GrayNext == rsync_Wptr); 

//asserting FIFO empty output after comapring the read and write pointers 
always@(posedge r_Clk, negedge r_Rst) begin 
	if(!r_Rst)
		fifo_Empty <= 1'b1;
	else 
		fifo_Empty <= r_empty;
end 
endmodule
