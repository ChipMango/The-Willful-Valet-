typedef struct packed {
  logic [15:0] tag_id;         // Unique identifier
  logic        is_vip;         // VIP flag (1 = CAM lot preferred)
  logic [2:0]  preferred_lot;  // 0 = LIFO, 1 = FIFO, 2 = CAM, 3 = Any
  logic [3:0]  size_class;     // Optional: car size/complexity
  logic [15:0] arrival_time;   // Simulation timestamp
} CarPacket;

typedef struct packed {
  logic [15:0] tag_id;
  logic        is_vip;
} RetrievalRequest;
