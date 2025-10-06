typedef struct packed {
    logic [7:0]  car_id;
    logic [15:0] arrival_cycle;
    logic [15:0] return_cycle;
    logic [1:0]  queue_type;
    logic        vip;
    logic        chaos;
    logic        stalled;
    logic        dropped;
    logic [7:0]  tip_final;
} valet_reputation_entry;

valet_reputation_entry rep_mem [0:255];
