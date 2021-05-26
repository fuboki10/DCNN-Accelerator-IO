module GPU(clk, rst, interrupt, load, cnn, done, data); 
integer file, r;
output reg clk; 
output reg rst;
output reg interrupt;
output reg load;
output reg cnn;
input done;
output reg [15:0] data; 

integer stage = 0; // 0 => CNN, 1 => Image, 2 => Done
integer commandSent = 0; 
  
parameter CLOCK_PERIOD = 20;

// chnage clock every CLOCK_PERIOD/2
always #(CLOCK_PERIOD/2) clk = ~clk;

initial begin 
  // send reset signal
  rst = 1;
  #CLOCK_PERIOD;
  rst = 0;

  // send load signal
  load = 1;
  
end // initial 
  
always @(negedge clk) begin
  // CNN Stage
  if (stage == 0) begin
    if (!commandSent) begin
      cnn = 1; // send cnn signal
      interrupt = 1; // send interrupt signal
      commandSent = 1; // command sent

      // read compressed file as binary
      file = $fopen("compressedCNN", "rb"); 

      if (!file) // If error opening file 
          $finish; // Just quit 
    end else begin
      interrupt = 0; // disable interrupt
    end
      
     // if IO sent done signal send more data
    if (done == 1) begin
      if (! $feof(file)) begin
      // read 16 bit data
      r = $fread(data,file); 

      end else begin
        stage = 2; // go to the next stage
        commandSent = 0;
        // close the file
        $fclose(file); 
      end
    end 
  end


  
  // Image Stage 
  else if (stage == 1) begin
    if (!commandSent) begin
      cnn = 0; // send image signal
      interrupt = 1; // send interrupt signal
      commandSent = 1; // command sent

      // read compressed file as binary
      file = $fopen("compressedImage", "rb"); 

      if (!file) // If error opening file 
          $finish; // Just quit 
    end else begin
      interrupt = 0; // disable interrupt
    end

    // if IO sent done signal send more data
    if (done == 1) begin
      if (! $feof(file)) begin
      // read 16 bit data
      r = $fread(data,file); 

      end else begin
        stage = 2; // go to the next stage
        commandSent = 0;
        // close the file
        $fclose(file); 
      end
    end 
  end


  // last stage
  else if (stage == 2) begin
    if (!commandSent) begin
      load = 0; // send process signal
      interrupt = 1; // send interrupt signal
      commandSent = 1; // command sent
    end else begin
      interrupt = 0; // disable interrupt
    end
  end

end

endmodule