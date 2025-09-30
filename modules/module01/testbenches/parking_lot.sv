initial begin
  reset = 1; #5;
  reset = 0;

  write_enable = 1;
  data_in = 16'h00AA;
  #10;
  write_enable = 0;

  read_enable = 1;
  #10;
  read_enable = 0;

  $display("Car retrieved: %h", data_out);
end
