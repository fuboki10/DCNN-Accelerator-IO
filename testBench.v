module tb_GPU;
wire clk;
wire rst;
wire load;
wire interrupt;
wire cnn;
wire done;
wire [15:0] data;
wire [3:0] datain;
GPU GPU1(rst,clk,interrupt, load, cnn, done, data,datain);
IOController IOcontroller(clk, rst, interrupt, load, cnn, done, data, datain, memAdress, memData);
endmodule
