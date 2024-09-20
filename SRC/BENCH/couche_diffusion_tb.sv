`timescale 1 ns/ 1 ps
module couche_diffusion_tb import ascon_pack::*;
    (
    );
	type_state diff_i_s;
	type_state diff_o_s;
    couche_diffusion DUT (
        .diff_i(diff_i_s),
	.diff_o(diff_o_s)
        );
    initial begin
        diff_i_s[0] = 64'h78e2cc41faabaa1a;   //on prend la valeur en sortie du module add_const pour r=0
	diff_i_s[1] = 64'hbc7a2e775aababf7;
	diff_i_s[2] = 64'h4b81c0cbbdb5fc1a;
	diff_i_s[3] = 64'hb22e133e424f0250;
	diff_i_s[4] = 64'h044d33702433805d;
	end

endmodule:couche_diffusion_tb
