/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module sumador_restador_bus (
    input wire [7:0] ui_in,   // Bus de entrada (8 bits)
    input wire [7:0] uio_in,  // Pines reconfigurables como entrada
    output wire [7:0] uo_out, // Bus de salida (8 bits)
    output wire [7:0] uio_out // Pines reconfigurables como salida
);

wire [3:0] A = ui_in[3:0];   // Operando A (4 bits)
wire [3:0] B = ui_in[7:4];   // Operando B (4 bits)
wire sel = uio_in[0];        // Selector de operación (suma/resta)

// Operación: Suma si sel=0, Resta si sel=1
assign uo_out = sel ? (A - B) : (A + B);

// Reflejar la salida en los pines configurables
assign uio_out = uo_out;

endmodule

