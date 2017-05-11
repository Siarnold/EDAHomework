`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2016/12/13 00:34:17
// Design Name: 
// Module Name: timedivider_tb
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

module timedivider_tb;

reg clk;
wire clk_out;

timedivider U1(
    .clk(clk),.times(3),.clk_out(clk_out)
);

parameter dely = 50;

initial begin

    begin
        #dely clk = 0;
        #dely clk = 1;
        #dely clk = 0;
        #dely clk = 1;
        #dely clk = 0;
        #dely clk = 1;
        #dely clk = 0;
        #dely clk = 1;
        #dely clk = 0;
        #dely clk = 1;
        #dely clk = 0;
        #dely clk = 1;
        #dely clk = 0;
        #dely clk = 1;
        #dely clk = 0;
        #dely clk = 1;
    end
end

initial $monitor($time,,,"clk=%b clk_out=%b", clk, clk_out);

endmodule
