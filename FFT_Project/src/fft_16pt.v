// Module mô ph?ng c?u trúc FFT 16 ?i?m (Radix-2 DIT) ph?c v? nghiên c?u
module fft_16pt (
    input clk,
    input rst_n,
    input start,
    input signed [15:0] real_in,
    input signed [15:0] imag_in,
    output reg done,
    output reg signed [15:0] real_out,
    output reg signed [15:0] imag_out
);

    // Tr?ng thái ??n gi?n cho kh?i ?i?u khi?n (FSM)
    reg [3:0] state;
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= 4'd0;
            done <= 1'b0;
            real_out <= 16'd0;
            imag_out <= 16'd0;
        end else begin
            if (start) begin
                // Mô ph?ng quá trình x? lý ???ng ?ng (pipeline) c?a kh?i FFT
                // Trong paper, ?ây là ph?n trình bày v? "Butterfly Processing Unit"
                real_out <= real_in + imag_in; // Mô ph?ng phép c?ng cánh b??m ??n gi?n
                imag_out <= real_in - imag_in;
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end
        end
    end

endmodule