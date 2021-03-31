`timescale 1ns / 10ps
// module div(out, in1, in2, dbz);
module Multiplier(
    in1,
    in2,
    out
);
parameter width = 8;
input  	[width-1:0] in1; // Mulplicand
input  	[width-1:0] in2; // Multiplier
output reg [((width<<1'b1) -1'b1):0] out [((width<<1'b1) -1'b1):0]; // Output

integer i,j;
wire [15:0] ParPro [7:0];
// assign ParPro[0] = (in1 * in2[0])<<0;
// assign ParPro[1] = (in1 * in2[1])<<1;
// assign ParPro[2] = (in1 * in2[2])<<2;
// assign ParPro[3] = (in1 * in2[3])<<3;
// assign ParPro[4] = (in1 * in2[4])<<4;
// assign ParPro[5] = (in1 * in2[5])<<5;
// assign ParPro[6] = (in1 * in2[6])<<6;
// assign ParPro[7] = (in1 * in2[7])<<7;
generate 
    for(i=0;i<width;i=i+1) begin
        assign ParPro[i] = (in1 * in2[i])<<i;
    end
endgenerate


for(i=0;i<width;i=i+1) begin
    assign out = out + ParPro[i]:
end


endmodule