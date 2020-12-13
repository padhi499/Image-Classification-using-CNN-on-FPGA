`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/02/2020 01:05:13 PM
// Design Name: 
// Module Name: max_data
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

module max_data #(parameter In_d_W=8, R=3, C=3)( 
    input [(In_d_W*R*C)-1:0] A,
    output [In_d_W-1:0] Y
    );
    
    wire [In_d_W-1:0] X [0:(R*C)-1];
    wire [In_d_W-1:0] Z [0:(R*C)-1];
    
    generate
    genvar i;
    for(i=0;i<(In_d_W*R*C);i=i+In_d_W)
    begin
        assign X[i/In_d_W]=A[i+In_d_W-1:i];
    end 
    endgenerate
    
    generate
    genvar j;
    assign Z[0]=X[0];
    for(j=0;j<(R*C)-1;j=j+1)
    begin
        max_value #(In_d_W) DUT(.A(Z[j]),.B(X[j+1]),.Y(Z[j+1]));    
    end
    assign Y=Z[(R*C)-1];
    endgenerate
endmodule
