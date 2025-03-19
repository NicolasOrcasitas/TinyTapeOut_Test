`timescale 1ns / 1ps
module tt_um_reg_universal (
    input [7:0] uio_in,
    input [7:0] ui_in,
    output [7:0] uo_out,
    output [7:0] uio_out,
    input clk,
    input ena,
    input rst_n,
    output [7:0] uio_oe
);

assign CLOCK = clk;
assign RESET = rst_n;
assign ENABLE = ena;

assign CTRL = uio_in[4:5];

assign S_IN = uio_in[7];

assign D = ui_in;


// DECLARACIÓN DE VARIABLES
reg [7:0] Q_INT = 0;
reg [7:0] Y;
wire [7:0] CON1, CON2;

    assign CON1 = {Q_INT[6:0], S_IN};
    assign CON2 = {S_IN, Q_INT[7:1]};
assign uio_oe = 0;
assign uio_out = 0;


// MUX 4:1
always @(*) 
    case (CTRL) //arreglar foto
    2'd0: Y = Q_INT; 
    2'd1: Y = CON1; 
    2'd2: Y = D; 
    2'd3: Y = CON2; 
    endcase
    

// flip flop tipo D
always@(posedge CLOCK)
  begin
    if (RESET)
        Q_INT <= 0;
    else if (ENABLE)
        Q_INT <= Y;
  end

assign uo_out = Q_INT;

endmodule

/* CTRL | funcion
   -----|---------
    00  | HOLD
    01  | SHIFT MSB<LSB
    10  | PARALLEL LOAD
    11  | SHIFT MSB>LSB
*/
