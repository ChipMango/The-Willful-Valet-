initial begin
  reset = 1; #5; reset = 0;

  // Park A, B, C
  foreach (int i in {16'h1001, 16'h1002, 16'h1003}) begin
    write_enable = 1; data_in = i; #10; write_enable = 0; #10;
  end

  // Retrieve all
  repeat (3) begin
    read_enable = 1; #10; read_enable = 0; #10;
  end
end
