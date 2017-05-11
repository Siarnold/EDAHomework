`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/05/11 16:27:17
// Design Name: 
// Module Name: fm_top_tb
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


module fm_top_tb;
//variables
reg clk, in;
wire [3:0] seg_sel;
wire [6:0] seg_out;

//call fm_top
fm_top FM0(clk, in, seg_sel, seg_out);

//set initials
initial
begin
    clk = 1'b0;
    in = 1'b0;
end

always #5 clk = ~clk;//100MHz
always #25000000 in = ~in;//20Hz

//initial monitor
initial $monitor("clk=%b in=%b seg_sel=%b seg_out=%b", clk, in, seg_sel, seg_out);

endmodule
