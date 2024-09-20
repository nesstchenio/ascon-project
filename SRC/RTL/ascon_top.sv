`timescale 1ns/1ps

module ascon_top import ascon_pack::*;
	(
	 	input logic clock_i,
	 	input logic resetb_i,
		input logic[63:0] data_i,
		input logic data_valid_i,
		input logic[127:0] key_i,
		input logic[127:0] nonce_i,
		input logic start_i,

		output logic[63:0] cipher_o,
		output logic cipher_valid_o,
		output logic[127:0] tag_o,  	
		output logic end_o	
	);

//déclaration
		type_state state_i_s;
		logic[3:0] counter_i_s;
		logic en_cipher_i_s;
		logic en_tag_i_s;

		logic en_reg_state_i_s;

		logic data_select_o;
		logic en_xor_key_beg_o_s;
		logic en_xor_d_beg_o_s;
		logic en_xor_key_end_o_s;
		logic en_xor_lsb_end_o_s;

		logic en_cpt_round_o_s;
		logic init_a_o_s;
		logic init_b_o_s;




//définition
	assign state_i_s[0] = 64'h80400C0600000000;
	assign state_i_s[1] = key_i[127:64];
	assign state_i_s[2] = key_i[63:0];
	assign state_i_s[3] = nonce_i[127:64];
	assign state_i_s[4] = nonce_i[63:0];



	permutation_finale permutation_finale_inst
	(
		.state_i(state_i_s),
		.data_i(data_i),
		.key_i(key_i),
		.data_sel_i(data_select_o),
		.counter_i(counter_i_s),
		.en_cipher_i(en_cipher_i_s),
		.en_tag_i(en_tag_i_s),
		.clock_i(clock_i),
		.resetb_i(resetb_i),
		.en_xor_key_i(en_xor_key_beg_o_s),
		.en_xor_data_i(en_xor_d_beg_o_s),
		.en_xor_key_end_i(en_xor_key_end_o_s),
		.en_xor_lsb_i(en_xor_lsb_end_o_s),
		.en_reg_state_i(en_reg_state_i_s),
		.tag_o(tag_o),
		.cipher_o(cipher_o)
	);

	compteur_double_init compteur_double_init_inst
	(
		.clock_i(clock_i),
    		.resetb_i(resetb_i),
    		.en_i(en_reg_state_i_s),
    		.init_a_i(init_a_o_s),
    		.init_b_i(init_b_o_s),
    		.cpt_o(counter_i_s)      
	);

	FSM_moore FSM_moore_inst
	(	.start_i(start_i),
		.clock_i(clock_i),
	 	.resetb_i(resetb_i),
		.data_valid_i(data_valid_i),
		.round_i(counter_i_s),
	
		.data_select_o(data_select_o),
		.en_xor_key_beg_o(en_xor_key_beg_o_s),
		.en_xor_d_beg_o(en_xor_d_beg_o_s),
		.en_xor_key_end_o(en_xor_key_end_o_s),
		.en_xor_lsb_end_o(en_xor_lsb_end_o_s),

		.en_reg_state_o(en_reg_state_i_s),
		.cipher_valid_o(cipher_valid_o),
		.end_o(end_o),

		.en_cpt_round_o(en_cpt_round_o_s),
		.init_a_o(init_a_o_s),
		.init_b_o(init_b_o_s)

	);


endmodule : ascon_top

