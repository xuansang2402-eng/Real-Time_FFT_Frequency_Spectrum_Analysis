`timescale 1ns / 1ps

module tb_simple_fft;

    reg clk;
    reg rst_n;
    reg signed [15:0] sample_in;
    wire signed [15:0] freq_out_magnitude;

    // Kh?i t?o module FFT c?n test
    simple_fft_simulation uut (
        .clk(clk),
        .rst_n(rst_n),
        .sample_in(sample_in),
        .freq_out_magnitude(freq_out_magnitude)
    );

    // T?o xung Clock (chu k? 10ns)
    always #5 clk = ~clk;

    initial begin
        // Kh?i t?o ban ??u
        clk = 0;
        rst_n = 0;
        sample_in = 0;
        
        #20;
        rst_n = 1; // Th? reset

        // C?p các m?u tín hi?u gi? l?p (mi?n th?i gian) ?? ki?m tra ph?
        #10 sample_in = 16'sd100;   // Tín hi?u biên ?? nh?
        #10 sample_in = 16'sd500;   // Tín hi?u t?ng lên
        #10 sample_in = -16'sd300;  // Tín hi?u âm (sóng hình sin ?i xu?ng)
        #10 sample_in = 16'sd800;   // ??nh tín hi?u cao
        #10 sample_in = 16'sd200;
        
        #50;
        $stop; // D?ng mô ph?ng
    end

endmodule