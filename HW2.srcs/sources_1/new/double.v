`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2016/12/13 21:44:22
// Design Name: 
// Module Name: double
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


module double(
    in,
    out
    );
input [7:0] in;
output wire [7:0] out;

wire [3:0] in_h, in_l;
wire [3:0] out_h, out_l;
wire [5:0] value, double;

assign in_h = in[7:4];
assign in_l = in[3:0];
assign out = {out_h, out_l};

assign value = 10 * in_h + in_l;
assign double = value * 2;
assign out_h = double/10;
assign out_l = double%10;

endmodule
