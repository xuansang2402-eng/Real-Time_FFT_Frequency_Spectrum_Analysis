`timescale 1ns / 1ps

module tb_fft_mixed();

    reg clk = 0;
    reg rst_n;
    reg start;
    reg signed [15:0] real_in;
    reg signed [15:0] imag_in;
    
    wire done;
    wire signed [15:0] real_out;
    wire signed [15:0] imag_out;

    // Kh?i t?o module FFT 16 ?i?m
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

    // T?o xung nh?p Clock (chu k? 10ns)
    always #5 clk = ~clk;

    integer i;
    reg signed [15:0] test_samples [0:15];

    initial begin
        // Kh?i t?o giá tr? ban ??u
        clk = 0;
        rst_n = 0;
        start = 0;
        real_in = 0;
        imag_in = 0;

        // D? li?u m?u 16 ?i?m
        test_samples[0]  = 16'd0;     
        test_samples[1]  = 16'd2317;  
        test_samples[2]  = 16'd3276;  
        test_samples[3]  = 16'd2317;  
        test_samples[4]  = 16'd0;     
        test_samples[5]  = -16'd2317; 
        test_samples[6]  = -16'd3276; 
        test_samples[7]  = -16'd2317; 
        test_samples[8]  = 16'd0;     
        test_samples[9]  = 16'd2317;  
        test_samples[10] = 16'd3276;  
        test_samples[11] = 16'd2317;  
        test_samples[12] = 16'd0;     
        test_samples[13] = -16'd2317; 
        test_samples[14] = -16'd3276; 
        test_samples[15] = -16'd2317; 

        // Gi? reset trong 20ns
        #20;
        rst_n = 1;
        #20;

        // B?t ??u truy?n d? li?u vào
        @(posedge clk);
        start = 1;

        for (i = 0; i < 16; i = i + 1) begin
            real_in = test_samples[i];
            imag_in = 16'd0;
            @(posedge clk);
        end

        start = 0;
        real_in = 16'd0;

        // Thay vì ??i tín hi?u done b? k?t, ta cho ch?y thêm 500ns ?? xem k?t qu? xu?t ra
        #500;
        
        $display("Mô ph?ng hoàn t?t!");
        $stop;
    end

endmodule