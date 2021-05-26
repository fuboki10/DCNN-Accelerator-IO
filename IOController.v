module IOController (clk, rst, interrupt, load, cnn, done, Din, Dout, memAdress, memData);
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

  reg [3: 0] Results; // Change this later

  wire DMA_en;

  wire [15: 0] decompressorInput;
  wire [15: 0] decompressorOutput;

  IOInterface io_inter(clk, Din, Dout, decompressorInput, Results, load);

  Decompressor decom(clk, rst, decompressorInput, decompressorOutput, load, interrupt, done, DMA_en);

  DMA dma(clk, rst, DMA_en, decompressorOutput, memData,0,memAdress);  

endmodule