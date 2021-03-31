`timescale 1ns / 10ps
module div(out, in1, in2, dbz);
parameter width = 8;
input  	[width-1:0] in1; // Dividend
input  	[width-1:0] in2; // Divisor
output  [width-1:0] out; // Quotient
output dbz;

reg [width-1:0]      out;
reg [width-1:0]     did ;
reg dbz;

integer i;

always@(*) 
begin
    did =  (in1>>(width - 1));
    out = 8'b0; 
    if(in2 == 8'b0) 
        dbz = 1; 
    else if( in1<in2) begin
        out = 8'b0;
    end
    else if(in1==in2)
        out = 8'b1;
    else begin
        for(i=7 ; i>=0; i=i-1) begin
            if(in2 > did) begin   
                        out = out + (0<<i); 
            end
            else begin
                        out = out + (1<<i);
                        did = did - in2;
            end
            did = ( did <<1 )       +      (   (  in1 << (  7 - i + 1)   )     >> 7 );
        end
    
    end

end

endmodule