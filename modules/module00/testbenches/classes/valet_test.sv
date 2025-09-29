initial begin
  Car c = new();
  c.plate_id = 16'h0BAD;
  c.vip_status = 1;
  c.arrival_cycle = 42;
  c.origin_story = "Arrived via underground AI tunnel.";

  c.display();
end

