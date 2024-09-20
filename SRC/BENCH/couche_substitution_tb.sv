`timescale 1 ns/ 1 ps
module couche_substitution_tb import ascon_pack::*;
    (
    );
	type_state sub_i_s;
	type_state sub_o_s;
    couche_substitution DUT (
        .sub_i(sub_i_s),
	.sub_o(sub_o_s)
        );
    initial begin
        sub_i_s[0] = 64'h80400c0600000000;    //on prend la valeur en sortie du module couche_diffusion pour r=0
	sub_i_s[1] = 64'h8a55114d1cb6a9a2;
	sub_i_s[2] = 64'hbe263d4d7aecaa0f;
	sub_i_s[3] = 64'h4ed0ec0b98c529b7;
	sub_i_s[4] = 64'hc8cddf37bcd0284a;
	end 

endmodule: couche_substitution_tb
