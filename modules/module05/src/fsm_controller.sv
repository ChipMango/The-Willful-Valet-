module grand_arena_top #(
  parameter BASE_TIP          = 10;
  parameter LIFO_MULTIPLIER   = 1;
  parameter FIFO_MULTIPLIER   = 2;
  parameter CAM_MULTIPLIER    = 3;

  parameter FAST_THRESHOLD    = 5;
  parameter SLOW_THRESHOLD    = 20;

  parameter BONUS_FAST_RETURN = 5;
  parameter PENALTY_LATE      = 5;

  parameter CHAOS_BONUS       = 8;

  parameter STALL_LIMIT   = 10;   // Cycles to wait before a car is considered "unparkable"
  parameter DROP_LIMIT    = 20;   // Cycles to return car before owner walks
  parameter PENALTY_DROP  = 12;   // Points subtracted per drop event
  parameter PENALTY_STALL = 5;    // Optional penalty for stalls (can be 0)
)(
    input  logic clk,
    input  logic rst_n,
    input  logic [7:0] event_stream_in,
    output logic [15:0] tip_total_out
);

// Instantiate FSM
fsm_controller u_fsm (
    .clk(clk),
    .rst_n(rst_n),
    .event_in(event_stream_in),
    .cmd_out(fsm_cmd),
    .tag_out(client_tag)
);

// Instantiate LIFO, FIFO, CAM, Router, Tip Engine, etc.
// Wire status signals and control paths accordingly

endmodule


// FSM → Router
logic [7:0] fsm_cmd;
logic [15:0] client_tag;
logic [1:0] dest_queue_type; // 2’b00 = LIFO, 01 = FIFO, 10 = CAM

// Queue Status → FSM
logic queue_full_lifo, queue_full_fifo, queue_hit_cam;

// Tip Engine
logic [15:0] tip_calc;
logic [15:0] tip_total;


always_ff @(posedge clk) begin
    if (rst_n == 0) begin
        // reset states
    end else begin
        case (fsm_state)
            IDLE: if (new_car_arrival) fsm_state <= ROUTE_QUEUE;
            ROUTE_QUEUE: begin
                if (queue_ready & !cooldown_active)
                    issue_enqueue();
                else
                    trigger_stall_penalty();
            end
            WAIT_RETURN: if (return_event_detected)
                issue_lookup();
            COMPLETE: log_tip();
        endcase
    end
end

module earnings_engine (
    input  logic [15:0] arrival_cycle,
    input  logic [15:0] return_cycle,
    input  logic [1:0]  queue_type,
    input  logic        chaos_event_recovered,
    output logic [15:0] tip_value
);

tip_value = base_rate * queue_multiplier;

if (latency_cycles < FAST_THRESHOLD)
    tip_value += bonus_fast_return;

if (latency_cycles > SLOW_THRESHOLD)
    tip_value -= late_penalty;

if (interference_detected && car_recovered)
    tip_value += chaos_resilience_bonus

endmodule

module penalty_monitor (
    input  logic        stall_trigger,
    input  logic        drop_trigger,
    input  logic [7:0]  car_id,
    input  logic [15:0] current_cycle,
    output logic [15:0] penalty_out
);
    // Internal timers and violation detectors
endmodule

if (car_arrived && !queued_in_time) begin
    if (stall_timer > STALL_LIMIT) begin
        log_stall_event(car_id);
        tip_value = 0;
    end
end

if (return_requested && !car_found) begin
    if (drop_timer > DROP_LIMIT) begin
        log_drop_event(car_id);
        tip_total -= PENALTY_DROP;
    end
end
