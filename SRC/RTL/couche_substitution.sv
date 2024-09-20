`timescale 1 ns / 1 ps

module couche_substitution import ascon_pack::*;
(
input type_state sub_i,
output type_state sub_o
);

genvar i;
generate
for(i=0;i<64;i++) begin : sub //on repete l'operation 64 fois pour les 64 lignes
s_box s_box_inst(  
		.sbox_i({sub_i[0][i],sub_i[1][i],sub_i[2][i],sub_i[3][i],sub_i[4][i]}),//on transforme grace a la sbox definie dans le module ascon_pack le nombre donne par les 5 bits de chaque colonne
		.sbox_o({sub_o[0][i],sub_o[1][i],sub_o[2][i],sub_o[3][i],sub_o[4][i]})
	);
end : sub
endgenerate

endmodule : couche_substitution
