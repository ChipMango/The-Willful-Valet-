module limbo_register #(
  parameter TAG_WIDTH = 16,
  parameter DEPTH = 8
)(
  input  logic clk,
  input  logic rst,
  input  logic insert_limbo,       // FSM asserts when a tag fails lookup
  input  logic [TAG_WIDTH-1:0] tag_in,
  output logic in_limbo,           // High if tag is already in limbo
  output logic expired,            // Tag has overstayed and must be purged
  output logic [TAG_WIDTH-1:0] tag_out
);

if (!match_lifo && !match_fifo && !match_cam) begin
  insert_limbo = 1;
  tag_in = request_tag;
end

if (valid[i] && (current_cycle - entry_cycle[i]) > LIMBO_TIMEOUT) begin
  valid[i] = 0;
  expired = 1;
end

if (!match_lifo && !match_fifo && !match_cam && !in_limbo) begin
  ghost_event = 1;
  refund_tip = BASE_TIP;
  log_event("Tag retrieval failed: ghost state entered.");
end

for (int i = 0; i < DEPTH; i++) begin
  if (valid[i] && tag_store[i] == tag_to_purge) begin
    valid[i] = 0;
    purge_count++;
  end
end

if (valid[i] && (current_cycle - entry_cycle[i]) > CAM_MAX_AGE) begin
  log_event("CAM auto-clean: tag expired");
  valid[i] = 0;
end

