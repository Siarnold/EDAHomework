`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2016/12/13 00:29:05
// Design Name: 
// Module Name: timedivider
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

// Output freq is 2*times as much as the input freq.
module timedivider(
    clk, times, clk_out
);

input clk;
input[31:0] times;
output reg clk_out;

reg[31:0] cnt;//count
initial clk_out = 0;
initial cnt = 0;

always@(posedge clk)
begin
    if (cnt == times - 1 )
    begin
        clk_out <= ~ clk_out;
        cnt <= 0;
    end
    else cnt <= cnt + 1;
end 
endmodule
