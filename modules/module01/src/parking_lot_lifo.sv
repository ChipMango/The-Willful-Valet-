/*
Valet Strategy Reflection – Module 1 Start
Alias: Nova_Byte
Preferred Queue: CAM – Vault logic is thrilling
Anticipated Risk: Multi-match bug in match tree
Debug Focus: Match index logging + waveform match visualization
*/

module parking_lot_lifo #(
  parameter DATA_WIDTH = 16,
  parameter DEPTH = 8,
  parameter COOLDOWN_CYCLES = 1;  // Override per module

)(
  input logic clk,
  input logic reset,

  input logic write_enable,
  input logic read_enable,
  input logic [DATA_WIDTH-1:0] data_in,
  input logic [DATA_WIDTH-1:0] match_tag,     // Only used in CAM

  output logic [DATA_WIDTH-1:0] data_out,
  output logic full,
  output logic empty,
  output logic match_found,                   // Only for CAM
  output logic cooldown_active
);

logic [DATA_WIDTH-1:0] memory [DEPTH-1:0];
logic [$clog2(DEPTH):0] stack_pointer;
logic [$clog2(DEPTH):0] cooldown_counter;

assign full  = (stack_pointer == DEPTH);
assign empty = (stack_pointer == 0);

always_ff @(posedge clk or posedge reset) begin
  if (reset) begin
    stack_pointer <= 0;
    cooldown_counter <= 0;
    cooldown_active <= 0;
  end else begin
    // Cooldown logic
    if (cooldown_counter > 0) begin
      cooldown_counter <= cooldown_counter - 1;
      cooldown_active <= 1;
    end else begin
      cooldown_active <= 0;
    end

    // Write (PUSH)
    if (write_enable && !full && !cooldown_active) begin
      memory[stack_pointer] <= data_in;
      stack_pointer <= stack_pointer + 1;
      cooldown_counter <= COOLDOWN_CYCLES;
      cooldown_active <= 1;
    end

    // Read (POP)
    if (read_enable && !empty) begin
      stack_pointer <= stack_pointer - 1;
      data_out <= memory[stack_pointer - 1];
      start_cooldown(COOLDOWN_CYCLES)
    end
  end
end

task start_cooldown(input int cycles);
  cooldown_counter <= cycles;
  cooldown_active <= 1;
endtask


endmodule

