//Textual Log
if (LOG_STYLE == "Theatrical") begin
  $display("[🎭 %0d] %s performed %s on %s.", cycle, alias, action, queue_name);
end else if (LOG_STYLE == "Basic") begin
  $display("[%0d] %s %s %s", cycle, alias, action, queue_name);
end

//Transcript Tag
$display("[INFO] Cycle %0d: Car 0x%h parked in FIFO.", cycle, c.plate_id);
$display("[⚠️ STALL] Lot full. Cannot park car 0x%h.", c.plate_id);
$display("[🚨 DROP] Car 0x%h retrieval delayed too long!", c.plate_id);


//Assertions
assert property (
  @(posedge clk)
  disable iff (reset)
  (write_enable && cooldown_active) |-> ##1 $error("❌ Violation: Write during cooldown!")
);

//Log to File
integer logfile;
initial logfile = $fopen("valet_run.log", "w");

$fdisplay(logfile, "Cycle %0d: Car 0x%h parked in CAM.", cycle, c.plate_id);
