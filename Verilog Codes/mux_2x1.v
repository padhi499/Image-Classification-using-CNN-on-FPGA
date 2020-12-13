`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/14/2020 04:51:34 PM
// Design Name: 
// Module Name: mux_2x1
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


module mux_2X1 #(parameter In_d_W=8)(
    input [In_d_W-1:0] I0,
    input [In_d_W-1:0] I1,
    input Sel,
    output [In_d_W-1:0] Y
    );
    
    assign Y=(Sel==0)?I0:I1;
endmodule
