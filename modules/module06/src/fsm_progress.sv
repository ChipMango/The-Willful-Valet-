property fsm_progresses;
  @(posedge clk)
    fsm_state == INTERMEDIATE |-> ##[1:3] fsm_state != INTERMEDIATE;
endproperty

assert property (fsm_progresses);
