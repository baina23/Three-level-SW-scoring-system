`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/13 16:16:40
// Design Name: 
// Module Name: tst_example
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tst_example(    );
reg clk;
reg rst;
wire [9:0] score;

example A (.clk(clk),.rst(rst),.score(score));

always #1 clk = ~clk;

always@(score)
if(score>0) $display("%d",score);


initial
begin
clk = 0;
rst = 0;
#4
rst = 1;
#70000
rst = 0;
#10;
$finish;
end

endmodule
