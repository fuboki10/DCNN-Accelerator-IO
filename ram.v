
module RAM(input clk,input enable, input [15:0]data_in,   input [15:0]memory_address);
    reg signed [15:0] ram [255:0];
    always @(posedge clk ) begin
        if (enable) begin
            ram[memory_address] = data_in;     
        end
    end
endmodule
    
