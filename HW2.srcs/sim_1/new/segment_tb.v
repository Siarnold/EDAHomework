`timescale 1us / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2016/12/20 23:54:03
// Design Name: 
// Module Name: segment_tb
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


module segment_tb;
//variables
reg clk;
reg shutdown;
reg [3:0] d3, d2, d1, d0;
wire [3:0]sel_out;
wire [6:0] out;
//call segment module
segments U0( clk, shutdown, d3, d2, d1, d0, sel_out, out );
//set values
initial
begin
clk = 1'b0;
shutdown = 1'b1;
d3 = 4'h0; d2 = 4'h0; d1 = 4'h0; d0 = 4'h0;
#700 shutdown = 1'b0; d3 = 4'h1; d2 = 4'h0; d1 = 4'h0; d0 = 4'h0;
#700 d3 = 4'h0; d2 = 4'h8; d1 = 4'h8; d0 = 4'h8;
#700 shutdown = 1'b1;
end
//set clk
always #50 clk = ~clk; //period = 100us
//initial monitor
initial $monitor( "clk=%b shutdown=%b d3=%b d2=%b d1=%b d0=%b sel_out=%b out=%b",clk,shutdown,d3,d2,d1,d0,sel_out,out );

endmodule
