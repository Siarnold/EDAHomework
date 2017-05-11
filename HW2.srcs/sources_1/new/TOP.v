`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2016/12/21 21:25:42
// Design Name: 
// Module Name: TOP
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


module TOP(
    clk,
    rst,
    row,
    col,
    seg_sel,
    seg_out
    );
input clk;//100MHz
input rst;
input [3:0] row;
output wire [3:0] col;
output wire [3:0] seg_sel;
output wire [6:0] seg_out;

//other variables
wire [3:0] val;//key_value
wire shutdown;
wire [3:0] d3, d2, d1, d0;
wire clk_key;
wire clk_ctrl;
wire clk_seg;

timedivider
div_key(clk, 500000, clk_key ),//1000Hz
div_ctrl(clk, 100000, clk_ctrl),//500Hz
div_seg(clk, 250000, clk_seg );//200Hz

//call keyboard
keyboard KEY0( clk_key, rst, row, col, val );
//call control
control CTRL0( clk_ctrl, rst, val, shutdown, d3, d2, d1, d0 );
//call segments
segments SEG0( clk_seg, shutdown, d3, d2, d1, d0, seg_sel, seg_out ); 

endmodule
