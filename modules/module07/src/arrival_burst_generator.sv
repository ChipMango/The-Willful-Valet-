initial begin
  int car_id = 0;
  forever begin
    repeat ($urandom_range(3, 6)) begin  // Mini-burst
      @(posedge clk);
      car_arrival_valid <= 1;
      car_tag <= car_id;
      client_type <= $urandom_range(0, 2); // 0: standard, 1: VIP, 2: impatient
      car_id++;
    end
    car_arrival_valid <= 0;

    repeat ($urandom_range(2, 8)) @(posedge clk); // Random gap
  end
end

latency_to_park = queue_entry_cycle - arrival_cycle;
latency_to_return = delivery_cycle - retrieval_request_cycle;

//Client Fairness Tracker
karma_score = base_tip - (stall_penalty + drop_penalty + late_penalty);

if (vip_client && used_lifo)
    karma_score -= 5; // bad valet logic!

if (wait_time > threshold)
    karma_score -= 2;

if (retrieved within 2 cycles)
    karma_score += 3;

$display("[TRACE][Car %0d] Arrived at %0t", car_id, $time);
$display("[TRACE][Car %0d] Routed to FIFO. Cooldown active: %b", car_id, fifo_cooldown);
$display("[TRACE][Car %0d] Retrieved. Tip: %0d. Wait time: %0d cycles", car_id, tip, wait_cycles);

// FSM Breadcrumb Logging
always_ff @(posedge clk) begin
  if (fsm_state != fsm_state_prev) begin
    $display("[FSM] Transition: %s → %s at %0t", state_name(fsm_state_prev), state_name(fsm_state), $time);
    fsm_state_prev <= fsm_state;
  end
end

//Event-Driven Monitors
$monitor("[MONITOR] Queue Depths: LIFO=%0d FIFO=%0d CAM=%0d", lifo_depth, fifo_depth, cam_depth);

if (stall_detected)
  $display("[ALERT] Stall detected on FSM at %0t", $time);

//Exporting to Logfiles
integer logfile;
initial logfile = $fopen("valet_debug.log", "w");

$fwrite(logfile, "[CAR %0d] CAM search started at %0t\n", car_id, $time);
$fclose(logfile);

$fwrite(csvlog, "%0d,%0t,%s\n", car_id, $time, event_type);

//Dynamic Recognition Inteface
logic [1:0] arb_mode;
logic       fast_response_mode;

always_ff @(posedge clk) begin
  if (entropy_detected_pattern_1) begin
    arb_mode <= 2'b10; // reroute priority
    fast_response_mode <= 1'b1;
  end
end

resilience_score = baseline_score_with_no_adaptation - actual_score_with_entropy;