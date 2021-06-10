module ram(clk, enable, data_in, memory_address, data_out);
    input clk;
    input enable;
    input [15:0] data_in;
    input [15:0] memory_address;
    reg [15:0] mem [10:0];
    output reg [15:0] data_out;


    always @(posedge clk ) begin
        if (enable) 
            mem[memory_address] <= data_in;
            data_out <= mem[memory_address];
    end
endmodule