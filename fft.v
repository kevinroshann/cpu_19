module fft (
    input wire [18:0] a,
    input wire fft_en,
    output reg [18:0] fft_result
);


always @(*) begin
    fft_result=19'd1;
    if(fft_en) begin
        fft_result=a;
    end
    
end


endmodule //fft