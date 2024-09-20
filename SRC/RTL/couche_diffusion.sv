`timescale 1ns / 1ps

import ascon_pack::*;

module couche_diffusion (
input type_state diff_i,
output type_state diff_o
);

assign diff_o[0]=diff_i[0]^({diff_i[0][18:0],diff_i[0][63:19]})^({diff_i[0][27:0],diff_i[0][63:28]});
assign diff_o[1]=diff_i[1]^({diff_i[1][60:0],diff_i[1][63:61]})^({diff_i[1][38:0],diff_i[1][63:39]});
assign diff_o[2]=diff_i[2]^({diff_i[2][0],diff_i[2][63:1]})^({diff_i[2][5:0],diff_i[2][63:6]});
assign diff_o[3]=diff_i[3]^({diff_i[3][9:0],diff_i[3][63:10]})^({diff_i[3][16:0],diff_i[3][63:17]});
assign diff_o[4]=diff_i[4]^({diff_i[4][6:0],diff_i[4][63:7]})^({diff_i[4][40:0],diff_i[4][63:41]});

endmodule : couche_diffusion



