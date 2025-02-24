`timescale 1ns / 1ps

module C_DP(
    input clk,
    input [15:0] co,
    input st,
    output [15:0] x,
    output reg [19:0] k,
    output reg r,
    input Mx, Rx, Ik, Pk, Sk, Mr,Pr,Ir
    );
    reg [15:0] i;
    wire [15:0] nexti;
    wire [19:0] nextk;
    wire [1:0] nextr;
    wire [15:0] rti;
    wire [15:0] rtp;
    //Registro i
    always@(posedge clk) begin
        i <= nexti;
    end
    assign nexti = Rx ? 0:( Mx ? i+1:i );
    assign x = i;
    
    //Registro k
    always@(posedge clk) begin
        k <= nextk;
    end
    assign nextk = Sk ? co:( Pk ? k/2:( Ik ? (3*k+1) : k));
    
    //Registro r
    always@(posedge clk) begin
        r <= nextr;
    end
    assign rti = 3*nextk+1;
    assign rtp = nextk/2; 
    assign nextr = Mr ? rti[0]==0:(Pr ? rtp[0]==0:(Ir ? co%2 : r));
endmodule
