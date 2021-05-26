module IOInterface(clk,Din,Dout,decompressorInput,Results,load);
    input [15:0] Din;
    output reg [3:0] Dout;
    output reg  [15:0] decompressorInput;
    input [3:0] Results;
    input load;
    input clk;
    always @(posedge clk) begin
        if(load)begin
            decompressorInput = Din;
        end
        else begin
            Dout = Results;
        end
    end
endmodule
