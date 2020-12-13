`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/17/2020 01:18:19 PM
// Design Name: 
// Module Name: counter_g
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


module counter_g #(Add_W=4)(
    input CLK,RST,
    input CE,
    input SCLR,
    output reg [Add_W-1:0] Q
    );
    
    always@(posedge CLK)
    begin
    if(RST==0)
        Q<=0;
    else if(SCLR==1)
        Q<=0;
    else if(CE==0)
        Q<=Q;
    else if(CE==1)
        Q<=Q+1;
    end
endmodule
