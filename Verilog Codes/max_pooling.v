`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/06/2020 11:56:13 AM
// Design Name: 
// Module Name: max_pooling
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


module max_pooling #(parameter In_W=18, R=3, C=3, R_P=2, C_P=2, P=0, S=1, Timeperiod=10) (
    input clk,
    input rst,
    input clr,
    input en_pool,
    input en_pool_out,
    input [(In_W*R*C)-1:0] N, //[161:0] N
    output reg [((In_W)*(((R+(2*P)-R_P)/S)+1)*(((C+(2*P)-C_P)/S)+1))-1:0] Y //[71:0] Y
    );
    
    wire [(In_W*(((R+(2*P)-R_P)/S)+1))-1:0] Z [0:(((((R+(2*P)-R_P)/S)+1)*C)-1)];  // [35:0] Z [0:5]
    wire [(In_W*R_P*C_P)-1:0] X [0:((((((R+(2*P)-R_P)/S)+1)*(((C+(2*P)-C_P)/S)+1)))-1)];  // [71:0] X [0:3]
    //wire [In_W-1:0] W1 [0:((((((R+(2*P)-R_P)/S)+1)*(((C+(2*P)-C_P)/S)+1)))-1)];  // [17:0] W1 [0:3]
    wire [((((R+(2*P)-R_P)/S)+1)*(((C+(2*P)-C_P)/S)+1)*In_W)-1:0] W;  // [71:0] W    
    reg [((((R+(2*P)-R_P)/S)+1)*(((C+(2*P)-C_P)/S)+1)*In_W)-1:0] temp;
        
    generate
    genvar i,j;
    for(i=0;i<C;i=i+1)  //i<3
        begin
            for(j=((((R+(2*P)-R_P)/S)+1)*i) ; j<((((R+(2*P)-R_P)/S)+1)+((((R+(2*P)-R_P)/S)+1)*i)) ; j=j+1) // j=2*i;  j<2+2i; j=j+1
            begin
                assign Z[j] = N[((((((R+(2*P)-R_P)/S)+1)*In_W)+(In_W*(j+(i*(R_P-1)))))-1):(In_W*(j+(i*(R_P-1))))]; // N[(2*18)+(18*(j+(i*1)))-1 : 18*(j+(i*1))]
            end    
        end
    endgenerate
    
    generate 
    genvar n,p;
    for(n=0 ; n<(((((R+(2*P)-R_P)/S)+1)*(((C+(2*P)-C_P)/S)+1))) ; n=n+1) // n<4
        begin
            for(p=0; p<(R_P*C_P*In_W); p=p+(R_P*In_W)) // p<72; p=p+36
            begin
                assign X[n][(p+(R_P*In_W)-1):p]=Z[n+( ((((R+(2*P)-R_P)/S)+1)*p) / (R_P*In_W))]; //  X[n][p+36-1:p]=Z[n+(2*p/36)] 
            end
        end
    endgenerate    
           
    generate
    genvar r;
        for(r=0; r<((((R+(2*P)-R_P)/S)+1)*(((C+(2*P)-C_P)/S)+1)); r=r+1)    // r<4
        begin
            max_data #(In_W,R_P,C_P) find_max(.A(X[r]),.Y(W[(In_W+(r*In_W)-1):(r*In_W)]));
        end
    endgenerate
    
    /*generate
    genvar t;
        for(t=0; t<((((R+(2*P)-R_P)/S)+1)*(((C+(2*P)-C_P)/S)+1)); t=t+1) //t<4 
        begin
            assign W[(In_W+(t*In_W)-1):(t*In_W)] = W1[t]; // Y[18+(t*18)-1:(t*18)]=W[t] 
        end
    endgenerate
    */

    always@(posedge clk)
    begin
        if(rst==0) begin temp<=0; Y<=0; end
        
        else if(clr==1) begin temp<=0; Y<=0; end
        
        else if(rst==1 & clr==0) 
        begin
            case({en_pool,en_pool_out})
                2'b00: begin temp<=0; Y<=0;     end
                2'b01: begin temp<=0; Y<=temp;  end
                2'b10: begin temp<=W; Y<=0;     end
                2'b11: begin temp<=W; Y<=temp;  end
            endcase
        end
    end

endmodule