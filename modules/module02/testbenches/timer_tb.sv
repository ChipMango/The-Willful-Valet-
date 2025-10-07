`timescale 1ns/1ps

module timer_tb;
    logic clk;
    logic rst_n;
    logic enable;
    logic done;

    //Instantiate DUT (Device Under Test)
    timer #(.LIMIT(5)) uut(
        .clk(clk),
        .rst_n(rst_n),
        .enable(enable),
        .done(done)
    );

    //Clock generator: 10ns period
    initial clk = 0;
    always #5 clk = ~clk;

    // Stimulus
    initial begin
        $display("=== TIMER TEST START ===");
        rst_n = 0; enable = 0;
        #12 rst_n = 1; //release reset

        // Test 1: Timer runs to completion
        enable = 1;
        $display("[%0t] Timer started", $time);

        wait(done); //wait until done goes high
        $display("[0t] Timer DONE signal asserted", $time);

        //Test 2: Disable mid-count and restart
        enable = 0;
        #20 enable = 1;
        $display("[%0t] Timer restarted", $time);

        wait(done);
        $display("[%0t] Timer DONE again", $time);

        #10;
        $display("===TIMER TEST END ===");
        $finish;
    end

    // Optional: Monitor signals
  initial begin
    $monitor("[%0t] clk=%b rst_n=%b enable=%b count_done=%b", $time, clk, rst_n, enable, done);
  end
endmodule