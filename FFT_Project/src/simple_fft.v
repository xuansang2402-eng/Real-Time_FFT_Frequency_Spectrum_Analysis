module simple_fft_simulation (
    input clk,
    input rst_n,
    input signed [15:0] sample_in, // Tín hi?u ??u vào gi? l?p (mi?n th?i gian)
    output reg signed [15:0] freq_out_magnitude // Biên ?? t?n s? ??u ra
);

    // Mô ph?ng quá trình l?c và trích xu?t biên ?? t?n s?
    // ? m?c ??n gi?n, ta d?ch chuy?n và l?y giá tr? tuy?t ??i gi? l?p ph? t?n s?
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            freq_out_magnitude <= 16'd0;
        end else begin
            // Gi? l?p vi?c kh?i FFT bóc tách biên ?? tín hi?u
            if (sample_in < 0)
                freq_out_magnitude <= -sample_in;
            else
                freq_out_magnitude <= sample_in;
        end
    end

endmodule