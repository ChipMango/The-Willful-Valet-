module parking_lot_cam #(
  parameter DATA_WIDTH = 16,
  parameter DEPTH = 8,
  parameter COOLDOWN_CYCLES = 1;  // Override per module
)(
  input  logic clk,
  input  logic reset,

  input  logic write_enable,
  input  logic read_enable,
  input  logic [DATA_WIDTH-1:0] data_in,
  input  logic [DATA_WIDTH-1:0] match_tag,

  output logic [DATA_WIDTH-1:0] data_out,
  output logic full,
  output logic empty,
  output logic match_found,
  output logic cooldown_active
);

logic [DATA_WIDTH-1:0] memory [DEPTH-1:0];
logic [DEPTH-1:0]      valid_bits;
logic [DEPTH-1:0]      match_vector;
logic [$clog2(DEPTH):0] cooldown_counter;

assign full  = (&valid_bits);
assign empty = (~|valid_bits);

always_ff @(posedge clk or posedge reset) begin
  if (reset) begin
    valid_bits <= '0;
    cooldown_counter <= 0;
    cooldown_active <= 0;
  end else begin
    // Cooldown management
    if (cooldown_counter > 0) begin
      cooldown_counter <= cooldown_counter - 1;
      cooldown_active <= 1;
    end else begin
      cooldown_active <= 0;
    end

    // Write (park)
    if (write_enable && !full && !cooldown_active) begin
      for (int i = 0; i < DEPTH; i++) begin
        if (!valid_bits[i]) begin
          memory[i] <= data_in;
          valid_bits[i] <= 1;
          cooldown_counter <= COOLDOWN_CYCLES;
          cooldown_active <= 1;
          disable for;
        end
      end
    end

    // Read (retrieve by tag)
    if (read_enable && !empty && !cooldown_active) begin
      match_vector = '0;
      for (int i = 0; i < DEPTH; i++) begin
        if (valid_bits[i] && memory[i] == match_tag) begin
          match_vector[i] = 1;
        end
      end

      if (|match_vector) begin
        match_found = 1;
        for (int j = 0; j < DEPTH; j++) begin
          if (match_vector[j]) begin
            data_out <= memory[j];
            valid_bits[j] <= 0;
            start_cooldown(COOLDOWN_CYCLES)
              disable for;
            end
          end
        end else begin
          match_found = 0;
        end
      end
    end
  end

  //Conflict Logging
  if (match_vector.countones() > 1)
  $display("⚠️ CAM MULTI-MATCH WARNING: tag = %h", match_tag);

task start_cooldown(input int cycles);
  cooldown_counter <= cycles;
  cooldown_active <= 1;
endtask

endmodule


