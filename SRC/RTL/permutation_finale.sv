`timescale 1ns / 1ps
import ascon_pack::*;

module permutation_finale (
	input type_state state_i,
	input logic[63:0] data_i,
	input logic[127:0] key_i,
	input logic data_sel_i,
	input logic[3:0] counter_i,
	input logic en_cipher_i,
	input logic en_tag_i,
	input logic clock_i,
	input logic resetb_i,
	input logic en_xor_key_i,
	input logic en_xor_data_i,
	input logic en_xor_key_end_i,
	input logic en_xor_lsb_i,
	input logic en_reg_state_i,
	output logic[127:0] tag_o,
	output logic[63:0] cipher_o
);


type_state reg_to_mux_s;
type_state mux_to_xor_b_s;
type_state xor_b_to_add_s;
type_state diff_to_xor_e_s;
type_state xor_e_to_reg_s;
type_state add_to_sub_s;
type_state sub_to_diff_s;



mux_state mux_(
	.sel_i(data_sel_i),
	.data1_i(state_i),
	.data2_i(reg_to_mux_s),
	.data_o(mux_to_xor_b_s)

);

xor_begin_perm xor_begin_(
	.en_xor_data_i(en_xor_data_i),
	.en_xor_key_i(en_xor_key_i),
	.key_i(key_i),
	.data_i(data_i),
	.state_i(mux_to_xor_b_s),
	.state_o(xor_b_to_add_s)
);


xor_end_perm xor_end_ (
	.en_xor_lsb_i(en_xor_lsb_i),
	.en_xor_key_i(en_xor_key_end_i),
	.key_i(key_i),
	.state_i(diff_to_xor_e_s),
	.state_o(xor_e_to_reg_s)
);


register_w_en #(.nb_bits_g(64)) register_cipher( 
	.clock_i(clock_i),
	.resetb_i(resetb_i),
	.en_i(en_cipher_i), 
	.data_i(xor_b_to_add_s[0]),
	.data_o(cipher_o)
);

register_w_en #(.nb_bits_g(128)) register_tag( 
	.clock_i(clock_i),
	.resetb_i(resetb_i),
	.en_i(en_tag_i), 
	.data_i({xor_e_to_reg_s[4],xor_e_to_reg_s[3]}),
	.data_o(tag_o)
);


state_register_w_en SR_(
	.clock_i(clock_i),
	.resetb_i(resetb_i),
	.en_i(en_reg_state_i),
	.data_i(xor_e_to_reg_s),
	.data_o(reg_to_mux_s)
);

add_const add_const(
	.add_i(xor_b_to_add_s),
	.round_i(counter_i),
	.add_o(add_to_sub_s)
);

couche_substitution couche_sub(
	.sub_i(add_to_sub_s),
	.sub_o(sub_to_diff_s)	
);

couche_diffusion couche_diff(
	.diff_i(sub_to_diff_s),
	.diff_o(diff_to_xor_e_s)
);

endmodule : permutation_finale	
	
	


