package valet_assertions;
  property no_limbo_after_return;
    @(posedge clk) car_retrieved |-> limbo_state == 0;
  endproperty
  assert property (no_limbo_after_return);
endpackage
