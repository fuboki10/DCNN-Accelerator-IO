
module DMA (rst,enable,clk,dataIn,dataOut,startAdress,memAdress);
input rst;
input clk;
input enable;
input [15:0] dataIn;
output [15:0] dataOut;   
output reg [15:0] memAdress;
input [15:0] startAdress;
always @(posedge clk ) begin
    if(rst == 1)begin
        memAdress = startAdress;
    end
    if(enable ==1 )begin
        dataOut = DataIn;
        memAdress = memAdress +1 ;
        
    end
end
endmodule