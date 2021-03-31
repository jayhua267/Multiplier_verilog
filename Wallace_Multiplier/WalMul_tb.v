`timescale 1ns / 10ps
`define CYCLE 100 // can be modified
module WalMul;
parameter width = 16;
  
wire [((width<<1)-1):0] out;
wire dbz;
reg [width-1:0] in1;
reg [width-1:0] in2;

//reg unsigned [width-1:0] in1;
//reg unsigned [width-1:0] in2;
  
  
integer num = 1;
integer i;
integer j;
integer ans;
integer err = 0;
  

/*
  integer unsigned num = 1;
  integer unsigned i;
  integer unsigned j;
  integer unsigned ans;
  integer unsigned err = 0;
*/
Wallace16x16Multiplier Wallace16x16Multiplier(.out(out), .X(in1), .Y(in2));
// Wallace8x8Multiplier   Wallace8x8Multiplier(.out(out), .X(in1), .Y(in2));
// Wallace4x4Multiplier   Wallace4x4Multiplier(.out(out), .X(in1), .Y(in2));
  
initial begin
  //4x4
  // for(i = 0; i < 1<<width ; i = i+1) begin
  //   for(j = 0; j < 1<<width ; j = j+1) begin
  // bigger 4x4
  for(i = 0; i < 1<<(width>>1) ; i = i+1) begin
    for(j = 0; j < 1<<(width>>1) ; j = j+1) begin
      in1 = i;
      in2 = j;
      #`CYCLE;
      ans = i * j;
      // if(in2 == 0 && dbz == 1'b1)
      //   $display("%d data is divided by zero", num);
      // else 
      if(out == ans[(width<<1)-1:0])
        $display("%d data is correct", num);
      else begin
        $display("%d data is error %b, correct is %b, in1=%d, in2=%d", num, out, ans[(width<<1)-1:0], in1, in2);
        err = err + 1;
      end
      num = num + 1;
    end
  end
    
  if(err == 0) begin
    $display("-------------------PASS-------------------");
    $display("All data have been generated successfully!");    
  end 
  else begin
    $display("-------------------ERROR-------------------");
    $display("There are %d errors!", err);
  end
    
  #10 $stop;
end 

always@(err) begin
	if (err == 20) begin
	$display("============================================================================");
     	$display("\n (>_<) FAIL!! The simulation FAIL result is too many ! Please check your code @@ \n");
	$display("============================================================================");
	$finish;
	end
end
endmodule