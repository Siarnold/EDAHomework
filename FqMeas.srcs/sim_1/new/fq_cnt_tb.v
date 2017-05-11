`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/05/11 16:07:27
// Design Name: 
// Module Name: fq_cnt_tb
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


module fq_cnt_tb;
//variables
reg clk;
reg in;
wire [3:0] d2, d1, d0;
parameter dl1 = 200, dl2 = 10;

//call fq_cnt
fq_cnt FC0(clk, in, d2, d1, d0);
initial
begin
    clk = 1'b0; in = 1'b0;
end

//set clk and in
always #dl1 clk = ~clk;
always #dl2 in = ~in;

//initial monitor
initial $monitor("clk=%b in=%b d2=%b d1=%b d0=%b",clk,in,d2,d1,d0);

endmodule
