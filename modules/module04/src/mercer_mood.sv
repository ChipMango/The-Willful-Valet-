typedef enum logic [2:0] {
  CURIOUS, MISCHIEVOUS, AGGRESSIVE, VINDICTIVE, CHAOTIC
} mercer_mood_t;

mercer_mood_t mood;

// Example behavior
always_ff @(posedge clk) begin
  case (mood)
    CURIOUS:      if (rand_chance < 5) inject_log_only();
    MISCHIEVOUS:  if (rand_chance < 20) ghost_drop_random_tag();
    AGGRESSIVE:   target_last_successful_queue();
    VINDICTIVE:   reinject_recently_purged_tag();
    default:      entropy_burst();
  endcase
end

$display("[Mercer] Mood Shift → AGGRESSIVE | Targeting FSM return logic.");
logic [3:0] mercer_action_history [0:15]; // 16-cycle rolling buffer
int pattern_index;

typedef struct {
  logic [15:0] tag;
  int seen_count;
  logic was_stolen;
  logic was_returned;
} tag_profile_t;
