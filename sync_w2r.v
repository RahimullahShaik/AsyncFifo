
//Verilog module to sync write pointer in read domain 
module sync_w2r #(parameter address_Size=3)(output reg [address_Size:0]rsync_Wptr, input r_Clk, input r_Rst, input [address_Size:0]w_Ptr);

//register to store output of flop 1
	reg [address_Size:0]wq1_ptr;

//synchronizing block
always@(posedge r_Clk, negedge r_Rst)begin
	if(!r_Rst)
		begin 
			wq1_ptr    <= 0;
			rsync_Wptr <= 0;
		end
	else 
		begin 
			wq1_ptr    <= w_Ptr;
			rsync_Wptr <= wq1_ptr;
		end
end
endmodule
