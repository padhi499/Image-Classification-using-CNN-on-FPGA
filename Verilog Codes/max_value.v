`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/03/2020 02:58:10 PM
// Design Name: 
// Module Name: max_value
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

module max_value #(parameter In_d_W=8) (
    input [In_d_W-1:0] A,
    input [In_d_W-1:0] B,
    output reg [In_d_W-1:0] Y
    );
    
    always@(*)
    begin
        if(A>B)
            Y<=A;
        else if(A<=B)
            Y<=B;
    end
endmodule
