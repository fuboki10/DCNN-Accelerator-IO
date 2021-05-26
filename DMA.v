
module DMA (clk, rst, enable, dataIn, dataOut, memAdress);
    input rst;
    input clk;
    input enable;
    input [15:0] dataIn;
    output reg [15:0] dataOut;   
    output reg [15:0] memAdress;


    always @(posedge rst) begin
        memAdress = 0;
    end

    always @(posedge clk ) begin
        if(enable ==1 )begin
            dataOut = dataIn;
            memAdress = memAdress + 1;
        end
      
    end
endmodule