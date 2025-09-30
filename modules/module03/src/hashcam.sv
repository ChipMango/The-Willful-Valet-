module hashcam_lot #(
  parameter TAG_WIDTH = 16,
  parameter DEPTH = 8
)(
  input  logic clk,
  input  logic rst,
  input  logic write_en,
  input  logic read_en,
  input  logic [TAG_WIDTH-1:0] tag_in,
  output logic match_found,
  output logic [$clog2(DEPTH)-1:0] match_index
);
