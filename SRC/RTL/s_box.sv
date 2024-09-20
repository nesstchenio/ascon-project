`timescale 1 ns / 1 ps


module s_box import ascon_pack::*;
(
input logic [4:0] sbox_i,
output logic [4:0] sbox_o
);

assign sbox_o = sbox_c[sbox_i];
endmodule : s_box

