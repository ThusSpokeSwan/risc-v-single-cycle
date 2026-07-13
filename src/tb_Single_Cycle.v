`timescale 1ns / 1ps

module tb_Single_Cycle();

    reg clk;
    reg rst;
    
    Single_Cycle_Top uut (
        .clk(clk),
        .rst(rst)
    );
    
    always #5 clk = ~clk;
    
    initial begin
        clk = 0;
        rst = 1;
        
        uut.Data_Memory.mem[0] = 32'd15;
        uut.Data_Memory.mem[1] = 32'd25;
        uut.Data_Memory.mem[2] = 32'd10;
        uut.Data_Memory.mem[3] = 32'd0;
        uut.Data_Memory.mem[4] = 32'd0;
        uut.Data_Memory.mem[5] = 32'd0;
        uut.Data_Memory.mem[6] = 32'd0;
        
        #10;
        rst = 0;
        
        #200;
        
        $display("Test Complete.");
        $display("x4 (ADD): %0d \t(Expected: 40)", uut.Register_File.Register[4]);
        $display("x5 (SUB): %0d \t(Expected: 10)", uut.Register_File.Register[5]);
        $display("x6 (AND): %0d \t(Expected: 10)", uut.Register_File.Register[6]);
        $display("x7 (OR): %0d \t(Expected: 31)", uut.Register_File.Register[7]);
        $display("x8 (SLT): %0d \t(Expected: 0)", uut.Register_File.Register[8]);
        $display("x4 (SLT): %0d \t(Expected: 1)", uut.Register_File.Register[9]);
        $display("mem[3] (sw ADD): %0d \t(Expected: 40)", uut.Data_Memory.mem[3]);
        $display("mem[4] (sw AND): %0d \t(Expected: 10)", uut.Data_Memory.mem[4]);
        $display("mem[5] (SKIPPED): %0d \t(Expected: 0)", uut.Data_Memory.mem[5]);
        $display("mem[6] (sw OR): %0d \t(Expected: 31)", uut.Data_Memory.mem[6]);
            
        $finish;
    end
    
endmodule
