`timescale 1ns/1ps

module scoring_engine_tb;

    //DUT signals
    logic clk;
    logic rst_n;
    logic signed [7:0] tip_delta;
    logic tip_event_valid;
    logic signed [15:0] running_score;

    // Instantiate DUT
    scoring_engine dut (
        .clk(clk),
        .rst_n(rst_n),
        .tip_delta(tip_delta),
        .tip_event_valid(tip_event_valid),
        .running_score(running_score)
    );

    //Clock generation: 10 ns period
    always #5 clk = ~clk;


    //Task to send tip events
    task send_event(input signed [7:0] delta);
        begin 
            @(negedge clk);
            tip_delta = delta;
            tip_event_valid = 1;
            @(negedge clk);
            tip_event_valid = 0;
        end
    endtask

    //Test sequence
    initial begin
        //Initialize
        clk = 0;
        rst_n = 0;
        tip_delta = 0;
        tip_event_valid = 0;

        //Apply reset
        $display("Starting simulation...");
        repeat (2) @(negedge clk);
        rst_n = 1;


        //Simulated scoring events
        send_event(+100); //CAM park
        $display("[%0t] +100 (CAM park) -> Total: %0d", $time, running_score);
        
        send_event(+75);   // FIFO park
        $display("[%0t] +75 (FIFO park) -> Total: %0d", $time, running_score);

        send_event(+50);   // Retrieval in 2 cycles
        $display("[%0t] +50 (Retrieval 2-cycle) -> Total: %0d", $time, running_score);

        send_event(-100);  // Mercer theft
        $display("[%0t] -100 (Mercer theft) -> Total: %0d", $time, running_score);

        send_event(-50);   // Arrival dropped
        $display("[%0t] -50 (Arrival dropped) -> Total: %0d", $time, running_score);

        send_event(+25);   // Retrieval 3–5 cycles
        $display("[%0t] +25 (Retrieval 3–5 cycles) -> Total: %0d", $time, running_score);

        #20;
        $display("[%0t] Final Score: %0d", $time, running_score);
        $finish;
    end
endmodule
