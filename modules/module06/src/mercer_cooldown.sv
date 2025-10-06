sequence mercer_gap;
  mercer_active ##[1:4] !mercer_active;
endsequence

property mercer_cooldown;
  @(posedge clk)
    mercer_active |-> mercer_gap;
endproperty

assert property (mercer_cooldown);
