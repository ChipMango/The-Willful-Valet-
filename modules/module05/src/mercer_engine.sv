module mercer_engine (
    input  logic clk,
    input  logic rst_n,
    input  logic [15:0] cycle_counter,
    output logic [3:0]  interference_opcode,
    output logic [1:0]  target_queue_id,
    output logic [15:0] injected_tag
);

module scoreboard (
    input  logic clk,
    input  logic rst_n,
    input  logic [15:0] tip_delta,
    input  logic stall_trigger,
    input  logic drop_trigger,
    input  logic chaos_event,
    input  logic chaos_recovered,
    input  logic [15:0] return_latency,
    output logic [15:0] tip_total,
    output logic [7:0]  stall_count,
    output logic [7:0]  drop_count,
    output logic [7:0]  chaos_score
);
    // Internally accumulate and compute leaderboard stats
endmodule
