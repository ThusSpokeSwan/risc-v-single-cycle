`timescale 1ns / 1ps

module Sign_Extend(
    input [31:0] Imm,
    output [31:0] ImmExt
    );
    
    assign ImmExt = Imm[31] == 1 ? {20'hFFFF, Imm[31:20]} : {20'h0000, Imm[31:20]};
    
endmodule
