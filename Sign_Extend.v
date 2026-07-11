`timescale 1ns / 1ps

module Sign_Extend(
    input [31:0] Inst,
    input ImmSrc,
    output [31:0] ImmExt
    );
    
    assign ImmExt = (ImmSrc == 1) ? {{20{Inst[31]}}, Inst[31:25], Inst[11:7]} : {{20{Inst[31]}}, Inst[31:20]};
    
endmodule
