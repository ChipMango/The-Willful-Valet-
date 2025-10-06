property no_vip_drop;
  @(posedge clk)
    (vip_active && drop_event) |-> ##0 $fatal("VIP drop violation detected!");
endproperty

assert property (no_vip_drop);
