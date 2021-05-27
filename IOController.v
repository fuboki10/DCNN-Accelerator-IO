module IOController (clk, rst, interrupt, load, cnn, done, Din, Dout, memAdress, memData,DMA_en);
  input clk;
  input rst;
  input interrupt;
  input load;
  input cnn;
  output wire done;
  input [15: 0] Din;
  output wire [3: 0] Dout;
  output wire [15: 0] memAdress;
  output wire [15: 0] memData;

  output  DMA_en;

  reg [3: 0] Results; // Change this later

  wire [15: 0] decompressorOutput;

  Decompressor decom(clk, rst, Din, decompressorOutput, load, interrupt, done, DMA_en);

  DMA dma(clk, rst, DMA_en, decompressorOutput, memData,memAdress);  

endmodule