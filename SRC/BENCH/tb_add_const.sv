`timescale 1 ns/ 1 ps
module tb_add_const import ascon_pack::*;
    (
    );
    type_state add_i_s;
    logic[3:0] round_i_s;
    type_state add_o_s;
    add_const DUT (
        .add_i(add_i_s),
        .round_i(round_i_s),
	.add_o(add_o_s)
        );
    initial begin
        add_i_s[0] = 64'h80400c0600000000;
	add_i_s[1] = 64'h8a55114d1cb6a9a2;
	add_i_s[2] = 64'hbe263d4d7aecaaff;
	add_i_s[3] = 64'h4ed0ec0b98c529b7;
	add_i_s[4] = 64'hc8cddf37bcd0284a;
	round_i_s=4'h6;
	#10;
	add_i_s[0] = 64'ha71b22fa2d0f5150;   
	add_i_s[1] = 64'hb11e0a9a608e0016;
	add_i_s[2] = 64'h076f27ad4d99d5e7;
	add_i_s[3] = 64'ha72ac1ad8440b0b7;
	add_i_s[4] = 64'h0657b0d6eaf9c1c4;
	round_i_s=4'h7;
	#10;
	add_i_s[0] = 64'h95bd2279b9a6ca67;
	add_i_s[1] = 64'h98a6c708314c3ef7;
	add_i_s[2] = 64'h50117c5d8e989bd6;
	add_i_s[3] = 64'h5bfb95dcdede2f1e;
	add_i_s[4] = 64'ha6aaffa224f4a42f;
	round_i_s=4'h8;
	#10;
	add_i_s[0] = 64'h162901ce5722b2fe;
	add_i_s[1] = 64'h236c1fca1153d660;
	add_i_s[2] = 64'heca11976718e1853;
	add_i_s[3] = 64'ha305993b667e5222;
	add_i_s[4] = 64'h467799e3e4a82e05;
	round_i_s=4'h9;
	#10;
	add_i_s[0] = 64'h77deb0974ab83049;
	add_i_s[1] = 64'hc3a306f2f4f2a478;
	add_i_s[2] = 64'h67b186a49c0d9bfb;
	add_i_s[3] = 64'ha37fb6b86c37a156;
	add_i_s[4] = 64'h049fe08ba4611958;
	round_i_s=4'ha;
	#10;
	add_i_s[0] = 64'h9bdd69cc4f812537;
	add_i_s[1] = 64'haf4cae7efa39989a;
	add_i_s[2] = 64'h71a61481b4bdb7c3;
	add_i_s[3] = 64'h4e44a40a2119d619;
	add_i_s[4] = 64'h83e0ee6e48d77536;
	round_i_s=4'hb;
	#10;
    end
endmodule: tb_add_const
