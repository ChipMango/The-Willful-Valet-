// Stage 1: Determine decision
always_ff @(posedge clk) begin
  lifo_write_decision <= (state == PARK);
  car_tag_buffer      <= car_tag;
end

// Stage 2: Trigger action
always_ff @(posedge clk) begin
  lifo_write_en <= lifo_write_decision;
  lifo_data_in  <= car_tag_buffer;
end
