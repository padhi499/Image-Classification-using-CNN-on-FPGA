`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/16/2019 01:03:43 PM
// Design Name: 
// Module Name: slide_window_conv
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

module slide_window_conv #(parameter In_d_W=8, In_Add_W=4, R_N=5, C_N=5, R_F=3, C_F=3, P=0, S=1, Timeperiod=10) (
    input clk,clk_en,rst,clr,en_wr,en_rd,wr,en_MAC,en_MAC_out,   //wr=1 (Write), wr=0 (Read)
    input [(C_N*R_N*In_d_W)-1:0] N, // [199:0] N
    input [(C_F*R_F*In_d_W)-1:0] F, // [71:0] F
    output [(((2*In_d_W)+2)*(((R_N+(2*P)-R_F)/S)+1)*(((C_N+(2*P)-C_F)/S)+1))-1:0] Y   // [161:0] Y
    );
    parameter R_O=(((R_N+(2*P)-R_F)/S)+1); //3
    parameter C_O=(((C_N+(2*P)-C_F)/S)+1); //3
    parameter Out_d_W=((2*In_d_W)+2); //18
    //wire [(In_d_W*R_N)-1:0] X [0:(C_N-1)];  // [39:0] X [0:4]
    wire [(In_d_W*R_O)-1:0] Z [0:((R_O*C_N)-1)];  // [23:0] Z [0:14]
    wire [(In_d_W*R_F*C_F)-1:0] A [0:(R_O*C_O)-1];  // [71:0] A [0:8]
    wire [Out_d_W-1:0] W [0:(R_O*C_O)-1];  // [17:0] W [0:8]
    
    generate
    genvar i,j;
    for(i=0;i<C_N;i=i+1)  //i<5
        begin
            for(j=(R_O*i) ; j<(R_O+(R_O*i)) ; j=j+1) // j=3*i;  j<3+3i; j=j+1
            begin
                assign Z[j] = N[((R_O*In_d_W)+(In_d_W*(j+(i*(R_F-1))))-1):(In_d_W*(j+(i*(R_F-1))))]; //  N[(3*8)+(8*(j+(i*2)))-1 : 8*(j+(i*2))]
            end    
        end
    endgenerate
    
    
    generate 
    genvar n,p;
    for(n=0 ; n<(R_O*C_O) ; n=n+1) // n<9
    begin
        for(p=0; p<(R_F*C_F*In_d_W); p=p+(R_F*In_d_W)) // p<72; p=p+24
        begin
            assign A[n][(p+(R_F*In_d_W)-1):p]=Z[n+(R_O*p/(R_F*In_d_W))]; //  A[n][p+24-1:p]=Z[n+(3*p/24)] 
        end
    end
    endgenerate
    
    
    generate
    genvar t;
    for(t=0; t<(R_O*C_O); t=t+1) //t<9
    begin
        assign Y[(Out_d_W+(t*Out_d_W))-1 :(t*Out_d_W)] = W[t]; // Y[18+(t*18)-1:(t*18)]=W[t] 
    end
    endgenerate
    
        
    generate
    genvar r;
    for(r=0; r<(R_O*C_O); r=r+1)    // r<9
    begin
        conv #(In_d_W, R_F, C_F, In_Add_W, Timeperiod) CV 
        (.clk(clk),.clk_en(clk_en),.rst(rst),.clr(clr),.en_wr(en_wr),.en_rd(en_rd),.wr(wr),.en_MAC(en_MAC),
        .en_MAC_out(en_MAC_out),.A(A[r]),.B(F),.Y(W[r]));
    end
    endgenerate
 
    
endmodule
