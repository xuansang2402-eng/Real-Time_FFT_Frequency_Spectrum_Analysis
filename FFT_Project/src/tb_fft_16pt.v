`timescale 1ns / 1ps

module tb_fft_16pt;

    reg clk;
    reg rst_n;
    reg start;
    reg signed [15:0] real_in;
    reg signed [15:0] imag_in;
    wire done;
    wire signed [15:0] real_out;
    wire signed [15:0] imag_out;

    // Kh?i t?o Unit Under Test (UUT)
    fft_16pt uut (
        .clk(clk),
        .rst_n(rst_n),
        .start(start),
        .real_in(real_in),
        .imag_in(imag_in),
        .done(done),
        .real_out(real_out),
        .imag_out(imag_out)
    );

    // T?o xung Clock 50MHz (chu k? 20ns)
    always #10 clk = ~clk;

    initial begin
        // Kh?i t?o tín hi?u ban ??u
        clk = 0;
        rst_n = 0;
        start = 0;
        real_in = 0;
        imag_in = 0;

        #40;
        rst_n = 1; // Th? reset

        #20;
        // C?p d? li?u m?u ??u vào (gi? l?p tín hi?u mi?n th?i gian)
        start = 1;
        real_in = 16'sd100;
        imag_in = 16'sd50;

        #20;
        real_in = 16'sd200;
        imag_in = 16'sd100;

        #40;
        start = 0;
        
        #100;
        $stop;
    end

endmodule