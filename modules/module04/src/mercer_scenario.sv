initial begin
  #200;
  $display("[Scenario] GhostDrop before FSM lookup.");
  cam[3].tag = 16'hABCD; // Inject fake tag
  cam[3].valid = 1;

  #10;
  $display("[Scenario] Forcing FSM to search CAM[3]");
  fsm_request_tag = 16'hABCD;

  #20;
  assert(fsm_error_flag) else $fatal("FSM failed to detect fake tag.");
end
