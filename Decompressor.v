module Decompressor (clk, rst, Din, Dout, load, interrupt, done, DMA_en);
  input clk;
  input rst;
  input [15: 0] Din;
  output reg [15 : 0] Dout;
  input load;
  input interrupt;
  output reg done;
  output reg DMA_en;

  integer counter; // bit counter (when 16 bit send)
  reg currentBit; // first bit value
  integer firstTime; 
  integer index;  // index in Dout

  always @(posedge rst or posedge interrupt) begin
    counter = 0;
    firstTime = 1;
    index = 0;
    done = 1;
    DMA_en = 0;
  end

  always @(posedge clk ) begin
    // reset signals
    done = 0;
    DMA_en = 0;
      
    if (load) begin
      if (firstTime) begin
        firstTime = 0;
        currentBit = Din[0];
        // TODO
        // send done signal
        done = 1;
      end else begin
        
        while (index < 16 && counter != Din) begin
          
          Dout[index] = currentBit;

          counter = counter + 1;
          index = index + 1;
        end

        if(counter == Din) begin
          done = 1; // get more data
          currentBit = !currentBit; // invert value
        end

        if(index == 16) begin
          DMA_en = 1; // enable DMA to read ouput
          index = 0; // fill Dout again
        end

      end
    end
  end

  
endmodule