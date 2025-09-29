module valet_loop_tb;

  import config_pkg::*;
  import classes_pkg::*;  // all class definitions
  import queue_interfaces_pkg::*;  // queue shells

  Valet v;
  TransactionLog tlog;

  initial begin
    v = new();
    v.alias = VALET_ALIAS;
    v.style = LOG_STYLE;

    tlog = new();

    $display("=== Simulation Start: Valet %s ===", v.alias);

    for (int cycle = 0; cycle < 200; cycle++) begin
      // 💡 Inject your per-cycle logic here
      automatic bit trigger_event = (cycle % 5 == 0);  // every 5 cycles

      if (cycle == 117) begin
        $display("👤 Shadow Trace: Mercer has entered the lot.");
        // Future logic will inject chaos here
      end

      logic mercer_active;
      assign mercer_active = (cycle >= 117);


      if (trigger_event) begin
        Car c = new();
        c.plate_id = cycle + 100;
        c.vip_status = ($urandom_range(0, 1));
        c.arrival_cycle = cycle;
        c.origin_story = "Sent by remote control from an orbital drop pod.";
        c.display();
        // Placeholder: park or queue decision (Module 2)
      end

      // Placeholder: simulate retrieval logic (Module 3)
      // Placeholder: antagonist chaos (Module 4)

      // 📊 Logging
      $display("[Cycle %0d] Simulation running...", cycle);

      #10;  // Wait 10ns = 1 simulation cycle
    end

    $display("=== Simulation End ===");
    tlog.dump_all();
    $finish;
  end

endmodule
