always_ff @(posedge clk) begin
  if (firewall_mode) begin
    // Allow only reads, block writes
    cam_we <= 0;
    cam_re <= 1;
  end else begin
    cam_we <= user_we;
    cam_re <= user_re;
  end
end

if (tag_seen_without_log || multiple_inserts_same_tag) begin
  firewall_mode <= 1;
  $display("[FIREWALL] Activated due to ghost activity.");
end

  state <= FIREWALL_WAIT;
  recovery_counter <= 0;
end