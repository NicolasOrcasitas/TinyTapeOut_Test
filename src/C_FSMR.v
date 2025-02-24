`timescale 1ns / 1ps

module C_FSMR(
    input clk,
    input st,
    input [7:0] co,
    input r,
    input [19:0] k,
    output reg Mx, Rx, Ik, Pk, Sk, Mr, Pr, Ir
    );
    
    parameter H = 2'b00; //Hold
    parameter I = 2'b01; //In
    parameter O = 2'b10; //Odd
    parameter E = 2'b11; //Even
    
    reg [1:0] CS = 2'b00; //Current State 
    reg [1:0] NS;         //Next State
    
    always@(posedge clk)
        CS<= NS;
        
    always@(CS,st,co,r,k)
        case(CS)
            H:
                if(st)
                    NS<=I;
                else
                    NS<=H;
            I:
                if(co==1)
                    NS<=H;
                else if(r==1'd1)
                    NS<=O;
                else if(r==0)
                    NS<=E;
            O:
                if(r==1'd1)
                    NS<=O;
                else if(r==0)
                    NS<=E;
            E:
                if(k==2)
                    NS<=H;
                else if(r==1'd1)
                    NS<=O;
                else if(r==0)
                    NS<=E;
        endcase
        
    always@(CS) begin
        case(CS)
            H: begin
                   Mx <= 0;
                   Rx <= 0;
                   Ik <= 0;
                   Pk <= 0;
                   Sk <= 0;
                   Mr <= 0;
                   Pr <= 0;
                   Ir <= 1;
               end
            I:
               begin
                   Mx <= 0;
                   Rx <= 1;
                   Ik <= 1;
                   Pk <= 1;
                   Sk <= 1;
                   Mr <= 0;
                   Pr <= 0;
                   Ir <= 1;
               end
            E:
               begin
                   Mx <= 1;
                   Rx <= 0;
                   Ik <= 0;
                   Pk <= 1;
                   Sk <= 0;
                   Mr <= 0;
                   Pr <= 1;
                   Ir <= 0;
               end
            O:
               begin
                   Mx <= 1;
                   Rx <= 0;
                   Ik <= 1;
                   Pk <= 0;
                   Sk <= 0;
                   Mr <= 1;
                   Pr <= 0;
                   Ir <= 0;
               end
        endcase           
    end                   
                          
endmodule                 
                          
