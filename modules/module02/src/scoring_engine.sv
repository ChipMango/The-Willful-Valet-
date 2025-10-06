module scoring_engine #(
  parameter DEBUG_LEVEL = 2; // 0 = off, 1 = events only, 2 = full trace

)(
  input logic clk,
  input logic [7:0] tip_delta,
  input logic tip_event_valid,
  output logic signed [15:0] running_score
);


typedef enum logic [1:0] {
    TIP_NONE       = 2'b00,   // No reward event
    TIP_REWARD     = 2'b01,   // Positive tip/reward
    TIP_PENALTY    = 2'b10,   // Negative tip/penalty
    TIP_BONUS      = 2'b11    // Special bonus event
} tip_event_t;

module valet_score_tracker (
    input  logic              clk,
    input  logic              rst_n,
    input  logic [15:0]       tip_delta_in,
    input  tip_event_t        tip_event_type_in,
    input  logic [31:0]       retrieval_time_in,
    input  logic              valid_in,
    output logic [31:0]       score_reg
);

    // Main total score
    logic [31:0] score_reg_next;

    // Array of recent tip deltas (for logging/tracking)
    logic signed [15:0] tip_history [0:15];

    // Tip event type (enum defined above)
    tip_event_t tip_event_type;

    // Time spent for each retrieval request (mapped by index)
    logic [31:0] tip_time_map [0:15];

    // Index tracker for circular buffer
    logic [3:0] tip_idx;

    // Sequential logic
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            score_reg <= 32'd0;
            tip_idx   <= 4'd0;
        end else if (valid_in) begin
            // Update score
            score_reg <= score_reg + tip_delta_in;

            // Record history and metadata
            tip_history[tip_idx]  <= tip_delta_in;
            tip_time_map[tip_idx] <= retrieval_time_in;
            tip_event_type        <= tip_event_type_in;

            // Circular increment
            tip_idx <= tip_idx + 1;
        end
    end

endmodule
