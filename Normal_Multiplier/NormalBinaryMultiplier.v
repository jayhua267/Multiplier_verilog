`timescale 1ns/10ps
module Normal16x16Multiplier (/*clk, reset, */out, X, Y);

input   [15:0] X;
input   [15:0] Y;
output 	[31:0] out;
wire [15:0]Result[3:0];

Normal8x8Multiplier Lowest(
    .out(Result[0]),
    .X(X[7:0]),
    .Y(Y[7:0])
);
Normal8x8Multiplier Middle1(
    .out(Result[1]),
    .X(X[15:8]),
    .Y(Y[ 7:0])
);
Normal8x8Multiplier Middle2(
    .out(Result[2]),
    .X(X[ 7:0]),
    .Y(Y[15:8])
);
Normal8x8Multiplier Highest(
    .out(Result[3]),
    .X(X[15:8]),
    .Y(Y[15:8])
);
assign out = {16'd0,Result[0]} + {8'd0,Result[1],8'd0} + {8'd0,Result[2],8'd0} + {Result[3],16'd0};

endmodule


module Normal8x8Multiplier (/*clk, reset, */out, X, Y);

input   [7:0] X;
input   [7:0] Y;
output 	[15:0] out;
wire [7:0]Result[3:0];

Normal4x4Multiplier Lowest(
    .out(Result[0]),
    .X(X[3:0]),
    .Y(Y[3:0])
);
Normal4x4Multiplier Middle1(
    .out(Result[1]),
    .X(X[7:4]),
    .Y(Y[3:0])
);
Normal4x4Multiplier Middle2(
    .out(Result[2]),
    .X(X[3:0]),
    .Y(Y[7:4])
);
Normal4x4Multiplier Highest(
    .out(Result[3]),
    .X(X[7:4]),
    .Y(Y[7:4])
);
assign out = {8'd0,Result[0]} + {4'd0,Result[1],4'd0} + {4'd0,Result[2],4'd0} + {Result[3],8'd0};

endmodule

module Normal4x4Multiplier(/*clk, reset, */out, X, Y);

// input clk, reset; 
input   [3:0] X;
input   [3:0] Y;
output 	[7:0] out;

//--------------------------------------
//  \^o^/   Write your code here~  \^o^/
//--------------------------------------

wire [3:0] S1, S2, S3;
wire [3:0] C1, C2, C3;
FullAdder x0y1 ( (X[0] & Y[1]), (X[1] & Y[0]), 1'b0 , S1[0], C1[0] );
FullAdder x1y1 ( (X[1] & Y[1]), (X[2] & Y[0]), C1[0], S1[1], C1[1] );
FullAdder x2y1 ( (X[2] & Y[1]), (X[3] & Y[0]), C1[1], S1[2], C1[2] );
FullAdder x3y1 ( (X[3] & Y[1]),  1'b0        , C1[2], S1[3], C1[3] );

FullAdder x0y2 ( (X[0] & Y[2]),  S1[1]       , 1'b0 , S2[0], C2[0] );
FullAdder x1y2 ( (X[1] & Y[2]),  S1[2]       , C2[0], S2[1], C2[1] );
FullAdder x2y2 ( (X[2] & Y[2]),  S1[3]       , C2[1], S2[2], C2[2] );
FullAdder x3y2 ( (X[3] & Y[2]),  C1[3]       , C2[2], S2[3], C2[3] );

FullAdder x0y3 ( (X[0] & Y[3]),  S2[1]       , 1'b0 , S3[0], C3[0] );
FullAdder x1y3 ( (X[1] & Y[3]),  S2[2]       , C3[0], S3[1], C3[1] );
FullAdder x2y3 ( (X[2] & Y[3]),  S2[3]       , C3[1], S3[2], C3[2] );
FullAdder x3y3 ( (X[3] & Y[3]),  C2[3]       , C3[2], S3[3], C3[3] );

assign out[0] = X[0] & Y[0];
assign out[1] = S1[0];
assign out[2] = S2[0];
assign out[3] = S3[0];
assign out[4] = S3[1];
assign out[5] = S3[2];
assign out[6] = S3[3];
assign out[7] = C3[3];

endmodule


module FullAdder(
    input       A,
    input       B,
    input       Cin,
    output      Sum,
    output      Carry      
);
wire [1:0] Result;
assign Result   = (A + B + Cin);
assign Sum      = Result[0];
assign Carry    = Result[1];

endmodule