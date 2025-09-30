input logic arrival_valid;
input CarPacket arrival_info;

input logic retrieval_valid;
input RetrievalRequest retrieval_info;

case (1'b1)
  (is_vip && !cam_full && !cam_cooldown): selected_lot = CAM;
  (!fifo_full && !fifo_cooldown):         selected_lot = FIFO;
  (!lifo_full && !lifo_cooldown):         selected_lot = LIFO;
  default:                                selected_lot = LIMBO;
endcase
