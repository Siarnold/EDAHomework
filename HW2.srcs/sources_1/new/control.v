`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2016/12/13 11:50:45
// Design Name: 
// Module Name: control
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


module control(
    clk,
    rst,
    val,
    shutdown,
    d3, d2, d1, d0
    );

//declare inputs and outputs
input clk;
input rst;
input [3:0] val;
output reg shutdown;//1 for shutdown, 0 for start
output wire [3:0] d3, d2, d1, d0;

//other variables
reg [3:0] val_e;//value effective
reg [3:0] val_f;//value follow
reg [3:0] in;
reg [1:0] curr_state;
reg [20:0] cnt = 0;//count 10 s
reg [1:0] cnt_read = 0;//read in 0/1/2 digits
reg [7:0] out_m, out_t; //output_money, output_time, both with 2 decimal digits
reg [6:0] m_org;//money original, may be > 20
reg [6:0] m;//money
reg [6:0] t; //t = 2 * m;
reg [20:0] t_left;//count the seconds left

assign d3 = out_m[7:4], d2 = out_m[3:0];
assign d1 = out_t[7:4], d0 = out_t[3:0];

//parameter
parameter STT = 4'b1010, AFM = 4'b1011, CLR = 4'b1100;//parameter for in, A for STT, B for AFM, C for CLR
parameter SHUTDOWN = 2'b00, READ = 2'b01, COUNTDOWN = 2'b10;//parameter for state


//the change of states
always@ ( posedge clk or negedge rst )
begin

    if( !rst )//reset
        curr_state <= SHUTDOWN;
    else
    begin

//avoid long time
    if( val_f == val )
        in <= 15;
    else
    begin
        in <= val;//in is the valid output
        val_f <= val;//val_f follows val
        if( val != 15 )
            val_e <= val; 
    end
    
    case( curr_state )
    
    SHUTDOWN:
    begin
        if( in == STT ) begin cnt_read <= 0;cnt <= 0; curr_state <= READ; end//read in "start"
        else curr_state <= SHUTDOWN;
    end
    
    READ:
    begin
        if( in == CLR ) begin cnt_read <= 0; cnt<= 0; curr_state <= READ; end//continuous clr make the screen lighted
        else if( in == AFM ) begin cnt_read <= 0; t_left <= t * 500; curr_state <= COUNTDOWN; end//press affirm and start counting down
        else if( in >= 0 && in <= 9 )//press 0-9 valid
        begin
            if( cnt_read <= 1 )//if has read in less than 2 digits
            begin
                cnt_read <= cnt_read + 1;
                m_org <= 10 * out_m + val_e;
                curr_state <= READ;
             end
             else cnt_read <= 2;//maintain cnt_read to be 2, and avoid shutting down
        end
        else if( cnt_read == 0 )
            begin
            if( cnt == 5000 ) begin cnt <= 0; curr_state <= SHUTDOWN; end//10s no input then shutdown the screen
            else begin  cnt <= cnt + 1; curr_state <= READ; end//counting 10s
            end
    end
    
    COUNTDOWN:
    begin
        if( t_left == 0 ) curr_state <= READ;//return to zero
        else begin t_left <= t_left - 1; curr_state<= COUNTDOWN; end//counting the charging time
    end
    endcase
    
    end
end

//output module
always@ ( * )
begin
    case( curr_state )
    SHUTDOWN:
    begin
        shutdown <= 1'b1;//set shutdown to be true
        out_m <= 0; out_t <= 0;
    end
    
    READ:
    begin
        if( cnt_read == 0 )
        begin
            out_m <= 0; out_t <= 0;
            shutdown <= 1'b0;//light up the screen
        end
        else
        begin
            if( m_org > 20 ) m <= 20;//set to be max 20 if inputs are larger than 20
            else m <= m_org;
            t <= 2 * m;//time = 2 * money
            out_m[7:4] <= m / 10; out_m[3:0] <= m % 10;//save the output money
            out_t[7:4] <= t / 10; out_t[3:0] <= t % 10;//save the output time
        end
    end
    
    COUNTDOWN:
    begin
        t <= t_left / 500;//renew the time left
        out_m[7:4] <= m / 10; out_m[3:0] <= m % 10;//save the output money
        out_t[7:4] <= t / 10; out_t[3:0] <= t % 10;//save the output time
    end
    endcase           
end

//debug
//assign d3 = val_e;

endmodule
