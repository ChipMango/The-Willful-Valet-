module cam_lot #(
  parameter TAG_WIDTH = 16,
  parameter DEPTH = 8
)(
  input  logic clk,
  input  logic rst,
  input  logic write_en,
  input  logic read_en,
  input  logic [TAG_WIDTH-1:0] tag_in,
  output logic [TAG_WIDTH-1:0] tag_out,
  output logic match_found,
  output logic [$clog2(DEPTH)-1:0] match_index
);

for (int i = 0; i < DEPTH; i++) begin
  if (valid[i] && tag_store[i] == tag_in)
    match_found = 1;
end

for (int i = 0; i < DEPTH; i++) begin
  if (!valid[i]) begin
    tag_store[i] = tag_in;
    valid[i] = 1;
    break;
  end
end

for (int i = 0; i < DEPTH; i++) begin
  if (valid[i] && tag_store[i] == tag_in) begin
    valid[i] = 0;
    tag_out = tag_store[i];
    match_found = 1;
  end
end
