//Verilog module to sync read pointer in write domain 
module sync_r2w #(parameter address_Size=3)(output reg [address_Size:0]wsync_Rptr, input w_Clk, input w_Rst, input [address_Size:0]r_Ptr);

//register to store output of flop 1
	reg [address_Size:0]rq1_ptr;

//synchronizing block
always@(posedge w_Clk, negedge w_Rst)begin
	if(!w_Rst)
		begin 
			rq1_ptr    <= 0;
			wsync_Rptr <= 0;
		end
	else 
		begin 
			rq1_ptr    <= r_Ptr;
			wsync_Rptr <= rq1_ptr;
		end
end
endmodule

