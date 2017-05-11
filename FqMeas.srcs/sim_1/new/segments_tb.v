`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/05/11 15:35:09
// Design Name: 
// Module Name: segments_tb
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


module segments_tb;
//variables
reg clk;
reg [3:0] d3, d2, d1, d0;
wire [3:0] sel;
wire [6:0] out;
parameter delay = 700;

//call segments
segments SEG0(clk, d3, d2, d1, d0, sel, out);

initial
begin
clk = 1'b0;
d3 = 4'h0; d2 = 4'h0; d1 = 4'h0; d0 = 4'h0;
#delay d3 = 4'h1; d2 = 4'h0; d1 = 4'h0; d0 = 4'h0;
#delay d3 = 4'h0; d2 = 4'h8; d1 = 4'h8; d0 = 4'h8;
end

//set clk
always #50 clk = ~clk;//period = 100ns

//initial monitor
initial $monitor( "clk=%b d3=%b d2=%b d1=%b d0=%b sel=%b out=%b",clk,d3,d2,d1,d0,sel,out );

endmodule
