`timescale 1ns / 1ps

import ascon_pack::*;

module add_const(
input type_state add_i,
input logic[3:0] round_i,
output type_state add_o
);

assign add_o[0] = add_i[0];
assign add_o[1] = add_i[1];
assign add_o[2][7:0]=add_i[2][7:0]^round_constant[round_i]; //on applique au registre x2 l'addition de constante. round_constant etant defini dans ascon_pack
assign add_o[2][63:8] = add_i[2][63:8];
assign add_o[3] = add_i[3];
assign add_o[4] = add_i[4];

endmodule:add_const
