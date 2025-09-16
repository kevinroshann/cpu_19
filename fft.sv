`timescale 1ns/1ps
module fft (
    input wire [18:0] a,
    input wire fft_en,
    output reg [18:0] fft_result
);

reg signed [18:0] real_part;
reg signed [18:0] temp_calc;
reg [2:0] freq_bin;


always @(*) begin
    fft_result = 19'd0;
    real_part = 19'd0;
    temp_calc = 19'd0;
    freq_bin = 3'd0;

    if(fft_en) begin
        real_part = $signed(a);
        freq_bin = real_part[2:0];

        case (freq_bin)
            3'b000: begin
                fft_result = real_part;
            end
            3'b001: begin
                temp_calc = (real_part * 707) / 1000;
                fft_result = temp_calc[18:0];
            end
            3'b010: begin
                fft_result = real_part;
            end
            3'b011: begin
                temp_calc = (real_part * 707) / 1000;
                fft_result = temp_calc[18:0];
            end
            3'b100: begin
                fft_result = ~real_part;
            end
            3'b101: begin
                temp_calc = (real_part * 707) / 1000;
                fft_result = ~temp_calc[18:0];
            end
            3'b110: begin
                fft_result = real_part;
            end
            3'b111: begin
                temp_calc = (real_part * 707) / 1000;
                fft_result = ~temp_calc[18:0];
            end
            default: begin
                fft_result = real_part;
            end
        endcase

        if(fft_result[18] == 1'b1) begin
            fft_result = ~fft_result + 1'b1;
        end
    end
    else begin
        fft_result = 19'd1;
    end
end


endmodule //fft
