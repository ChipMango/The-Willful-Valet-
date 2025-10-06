always_ff @(posedge clk) begin
  if (cycle_count % merc_freq == 0 && in_merc_window) begin
    case (merc_mode)
      0: passive_interference();
      1: burst_mode_interference();
      2: target_based_interference(fsm_state);
    endcase
  end
end
