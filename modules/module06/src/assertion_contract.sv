assert property (@(posedge clk)
    car_arrived |-> ##[1:12] car_returned
) else $fatal("Timeout: Car not returned in time");

always @(posedge clk) begin
  assert (stall_counter < 8) else $fatal("Stall limit breached!");
end

assert property (@(posedge clk)
    car_parked |-> ##[1:10] car_retrieved
);else $fatal("CAR RETRIEVAL FAILURE :: Car ID %0h never retrieved!", car_tag);
else begin
  $error("ASSERT FAIL: Tag %0h never retrieved [Cycle %0t]", car_tag, $time);
end


assert property (@(posedge clk)
    vip_arrived |=> ##[1:3] vip_parked
);

assert property (@(posedge clk)
    fsm_state == PROCESSING |-> ##1 fsm_state != PROCESSING
);

coverproperty (@(posedge clk)
    car_parked ##[1:10] car_retrieved
);

cover property (@(posedge clk)
    mercer_active ##1 mercer_target == CAM_QUEUE
);

  option.per_instance = 1;

  cp1: coverpoint car_type; // sedan, SUV, VIP
  cp2: coverpoint parked_latency { bins fast = {[1:3]}; bins slow = {[4:10]}; }

  x: cross cp1, cp2;
endgroup

covergroup cam_scenarios @(posedge clk);
  option.per_instance = 1;

  cam_full: coverpoint cam_queue_depth {
    bins full = {MAX_DEPTH};
  }

  cam_blocked: coverpoint cam_insert_allowed {
    bins denied = {0};
  }

  insert_on_full: cross cam_full, cam_blocked;
endgroup

//structural coverage pitfall
if (car_type == VIP)
   tip_bonus = 10;
else if (car_type == SUV)
   tip_bonus = 5;
else if (car_type == SEDAN)
   tip_bonus = 3;

//toggle coverage example
logic [3:0] cam_depth;
