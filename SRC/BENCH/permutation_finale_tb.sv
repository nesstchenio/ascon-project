`timescale 1ns/1ps

module permutation_finale_tb import ascon_pack::*;
(
);
type_state state_i_s;
logic[63:0] data_i_s;
logic[127:0] key_i_s;
logic data_sel_i_s;
logic[3:0] counter_i_s;
logic en_cipher_i_s;
logic en_tag_i_s;
logic clock_i_s=1'b0;
logic resetb_i_s;
logic en_xor_key_i_s;
logic en_xor_data_i_s;
logic en_xor_key_end_i_s;
logic en_xor_lsb_i_s;
logic en_reg_state_i_s;
logic[127:0] tag_o_s;
logic[63:0] cipher_o_s;


permutation_finale DUT
(	.state_i(state_i_s),
	.data_i(data_i_s),
	.key_i(key_i_s),
	.data_sel_i(data_sel_i_s),
	.counter_i(counter_i_s),
	.en_cipher_i(en_cipher_i_s),
	.en_tag_i(en_tag_i_s),
	.clock_i(clock_i_s),
	.resetb_i(resetb_i_s),
	.en_xor_key_i(en_xor_key_i_s),
	.en_xor_data_i(en_xor_data_i_s),
	.en_xor_key_end_i(en_xor_key_end_i_s),
	.en_xor_lsb_i(en_xor_lsb_i_s),
	.en_reg_state_i(en_reg_state_i_s),
	.tag_o(tag_o_s),
	.cipher_o(cipher_o_s)
);

always  begin
       assign  clock_i_s = ~clock_i_s;
      #10;

   end

   initial begin
      data_i_s =64'h0;
      key_i_s = 128'h8A55114D1CB6A9A2BE263D4D7AECAAFF;

      state_i_s[0] = 64'h80400c0600000000; 
      state_i_s[1] = 64'h8a55114d1cb6a9a2; 
      state_i_s[2] = 64'hbe263d4d7aecaaff; 
      state_i_s[3] = 64'h4ed0ec0b98c529b7; 
      state_i_s[4] = 64'hc8cddf37bcd0284a;

      resetb_i_s = 1'b0;
      data_sel_i_s = 1'b0;
      en_xor_data_i_s = 1'b0;
      en_xor_key_i_s = 1'b0;
      en_xor_lsb_i_s = 1'b0;
      en_xor_key_end_i_s = 1'b0;
      en_reg_state_i_s = 1'b1;
      //en_tag_i_s=1'b1;
      //en_cipher_i_s=1'b1;
      
      counter_i_s = 4'b0000;
      #105;
      resetb_i_s = 1'b1;
      #20;
      data_sel_i_s = 1'b1;
      counter_i_s = 4'b0001;
      #20;
      counter_i_s = 4'b0010;

      #20;
      counter_i_s = 4'b0011;

      #20;
      counter_i_s = 4'b0100;

      #20;
      counter_i_s = 4'b0101;

      #20;
      counter_i_s = 4'b0110;

      #20;
      counter_i_s = 4'b0111;

      #20;
      counter_i_s = 4'b1000;

      #20;
      counter_i_s = 4'b1001;
 
      #20;
      counter_i_s = 4'b1010;

      #20;
      counter_i_s = 4'b1011;
      en_xor_key_end_i_s = 1'b1;
      #20;
      
      //en_reg_state_i_s = 1'b0;

   end
endmodule : permutation_finale_tb

