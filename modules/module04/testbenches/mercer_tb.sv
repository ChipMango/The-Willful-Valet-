if (MERCER_MODE && $urandom_range(0,100) < mercer_probability) begin
  force cam[tag_index] = 16'hBAD0;
end

logic [31:0] entropy_seed = 32'hFACEFEED;
logic [7:0] chaos_level = 25; // 0-100 scale
logic mercer_mode = 1;

initial begin
  $urandom(seed = entropy_seed);
end

always_ff @(posedge clk) begin
  if (mercer_mode && $urandom_range(0, 100) < chaos_level) begin
    case ($urandom_range(0, 3))
      0: begin // GhostDrop
        cam[3].tag = 16'hBADA;
        $display("[Mercer] GhostDrop: Injected 0xBADA at index 3");
      end
      1: begin // Tag Theft
        cam[1].valid = 0;
        $display("[Mercer] Tag Theft: Wiped index 1");
      end
      2: begin // Identity Swap
        cam[5].tag = cam[6].tag;
        $display("[Mercer] Identity Swap: Copied tag from 6 → 5");
      end
      3: begin // DoubleBind
        limbo[2].tag = cam[2].tag;
        $display("[Mercer] DoubleBind: Duped tag into Limbo");
      end
    endcase
  end
end

task automatic inject_mercer_event();
  if (!$test$plusargs("mercer_mode")) return;

  if ($urandom_range(0, 100) < chaos_level) begin
    // ... insert event logic here ...
  end
endtask

typedef struct {
  logic [15:0] tag;
  logic [2:0] origin_queue;
  logic [31:0] insert_cycle;
  logic [31:0] last_seen_cycle;
  logic valid;
} tag_trace_entry_t;

resilience_score = 
  (stall_recovery_rate * 0.25) +
  (tag_survivability_rate * 0.25) +
  ((1.0 - fail_recovery_ratio) * 0.20) +
  (log_accuracy * 0.15) +
  (score_penalty_recovery * 0.15);
