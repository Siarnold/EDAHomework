`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/05/11 15:54:45
// Design Name: 
// Module Name: fq_cnt
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


module fq_cnt(
    clk, in,
    d2, d1, d0
);
input clk, in;//clk = 1Hz, in is the measured signal
output reg [3:0] d2, d1, d0;

//other variables
reg [1:0] clkc = 2'b0;//clock copy
reg [19:0] cnt = 0;//count max is 2^20

always@ (posedge in)
begin
    clkc[1:0] = {clkc[0], clk};
    if (clkc[0] > clkc[1])
    begin
        d0 = cnt % 10; cnt = cnt / 10;
        d1 = cnt % 10; cnt = cnt / 10;
        d2 = cnt % 10;
        cnt = 0;
    end
    cnt = cnt + 1;
end

endmodule
