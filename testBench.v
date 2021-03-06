module tb_GPU;
wire clk;
wire rst;
wire load;
wire interrupt;
wire cnn;
wire done;
wire [15:0] data;
wire [3:0] datain;
wire [15:0] memAdress;
wire [15:0] memData;
wire RamEnable;
GPU GPU1(clk,rst,interrupt, load, cnn, done, data,datain);
IOController IOcontroller(clk, rst, interrupt, load, cnn, done, data, datain, memAdress, memData,RamEnable);
RAM ram(clk,RamEnable,memData,memAdress);
endmodule
    