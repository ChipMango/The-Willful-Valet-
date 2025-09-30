module parking_lot_fifo #(
  parameter DATA_WIDTH = 16,
  parameter DEPTH = 8,
  parameter COOLDOWN_CYCLES = 1;  // Override per module

)(
  input  logic clk,
  input  logic reset,

  input  logic write_enable,
  input  logic read_enable,
  input  logic [DATA_WIDTH-1:0] data_in,

  output logic [DATA_WIDTH-1:0] data_out,
  output logic full,
  output logic empty,
  output logic cooldown_active
);

  logic [DATA_WIDTH-1:0] memory [DEPTH-1:0];
  logic [$clog2(DEPTH)-1:0] head, tail;
  logic [$clog2(DEPTH):0] count;
  logic [$clog2(DEPTH):0] cooldown_counter;

  assign full  = (count == DEPTH);
  assign empty = (count == 0);

  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      head <= 0;
      tail <= 0;
      count <= 0;
      cooldown_active <= 0;
      cooldown_counter <= 0;
    end else begin
      // Cooldown countdown
      if (cooldown_counter > 0) begin
        cooldown_counter <= cooldown_counter - 1;
        cooldown_active <= 1;
      end else begin
        cooldown_active <= 0;
      end

      // Park (Write)
      if (write_enable && !full && !cooldown_active) begin
        memory[tail] <= data_in;
        tail <= (tail + 1) % DEPTH;
        count <= count + 1;
        cooldown_counter <= COOLDOWN_CYCLES;
        cooldown_active <= 1;
      end

      // Retrieve (Read)
      if (read_enable && !empty) begin
        data_out <= memory[head];
        head <= (head + 1) % DEPTH;
        count <= count - 1;
        start_cooldown(COOLDOWN_CYCLES)
      end
    end
  end

task start_cooldown(input int cycles);
  cooldown_counter <= cycles;
  cooldown_active <= 1;
endtask


endmodule

