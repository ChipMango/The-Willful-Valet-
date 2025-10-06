function [15:0] calculate_dynamic_tip;
    input logic [1:0] queue_type;
    input logic [7:0] latency;
    input logic [7:0] current_queue_depth;
    input logic is_vip;
    input logic mercer_active;

    logic [15:0] base;
    logic [15:0] urgency_bonus;
    logic [15:0] latency_decay;

    begin
        // Base tip by queue type
        case (queue_type)
            2'b00: base = 5;   // LIFO
            2'b01: base = 10;  // FIFO
            2'b10: base = 20;  // CAM
        endcase

        // Urgency bonus based on queue depth
        urgency_bonus = (current_queue_depth > 5) ? 5 : 0;

        // Latency decay (simple inverse)
        latency_decay = (latency < 10) ? 10 - latency : 0;

        // VIP and Mercer bonuses
        base = base + (is_vip ? 7 : 0);
        base = base + (mercer_active ? 3 : 0);

        return base + urgency_bonus + latency_decay;
    end
endfunction
