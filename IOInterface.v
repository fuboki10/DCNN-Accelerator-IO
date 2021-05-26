
module IOInterface(clk,DataIO,Decompressor,Results,read);
    inout  [15:0] DataIO;
    output  [15:0] Decompressor;
    input  [15:0] Results;
    input read;
    input clk;
    always @(posedge clk) begin
        if(read ==0)begin
             DataIO = Results;
        end
        else begin
             Decompressor =DataIO;
        end
    end
endmodule