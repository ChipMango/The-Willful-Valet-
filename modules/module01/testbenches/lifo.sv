initial begin
  reset = 1; #5; reset = 0;

  // Push car A
  write_enable = 1; data_in = 16'hA001; #10; write_enable = 0;

  // Push car B
  #10; write_enable = 1; data_in = 16'hA002; #10; write_enable = 0;

  // Pop (Should return B)
  #20; read_enable = 1; #10; read_enable = 0;

  // Pop (Should return A)
  #20; read_enable = 1; #10; read_enable = 0;
end

module lifo_tb;
  logic clk, reset;
  logic write_enable, read_enable;
  logic [15:0] data_in, data_out;
  logic full, empty, cooldown_active;

  parking_lot_lifo lifo_inst (
    .clk(clk), .reset(reset),
    .write_enable(write_enable), .read_enable(read_enable),
    .data_in(data_in), .data_out(data_out),
    .full(full), .empty(empty), .cooldown_active(cooldown_active)
  );

  // Clock generator
  always #5 clk = ~clk;

  initial begin
    $display("=== LIFO Queue Test Start ===");
    clk = 0;
    reset = 1; #10; reset = 0;

    // Push car A
    write_enable = 1; data_in = 16'hA100; #10; write_enable = 0;

    // Push car B
    #10; write_enable = 1; data_in = 16'hA200; #10; write_enable = 0;


    // Retrieve B
    #20; read_enable = 1; #10; read_enable = 0;

    // Retrieve A
    #20; read_enable = 1; #10; read_enable = 0;

    $display("=== LIFO Queue Test End ===");
    #20; $finish;
  end
endmodule
