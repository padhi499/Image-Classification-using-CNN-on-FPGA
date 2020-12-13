`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/16/2020 01:03:24 PM
// Design Name: 
// Module Name: mux_g
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


module mux_g #(parameter In_d_W=16*8, S_W=4)( //Over here, this mux works like, I have 128 bit as I/P and I need 8 bit O/P. So, 128/8=16
//Therefore, S=4 as 2^4=16 
input [In_d_W-1:0] A, 
input [S_W-1:0] S,
output [(In_d_W/(2**S_W))-1:0] Y 
);
parameter Out_d_W=In_d_W/(2**S_W);
wire [Out_d_W-1:0] W [0:(2**S_W)-1];
generate
genvar i;
for(i=0; i<(2**S_W); i=i+1)
begin
    assign W[i]=A[ (i*Out_d_W)+Out_d_W-1 : i*Out_d_W ];
end
endgenerate

assign Y=W[S];

endmodule
