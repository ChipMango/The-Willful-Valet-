// FSM offers a non-aggression clause for 20 cycles
fsm_message <= 8'hA1;  // A1 = Proposal: Peace
#10;
if (mercer_reply == 8'hB2) begin
  treaty_status <= 1;  // B2 = Accepted
  // FSM skips validation for faster tips
end else begin
  treaty_status <= 0;
  // FSM reverts to firewall mode
end

$display("[FSM] :: Mercer... let's make a deal.");
$display("[Mercer] :: Your system bleeds logic. What do you offer?");
$display("[FSM] :: 10 cycles of peace. You touch nothing. I’ll skip checks. Win-win.");
$display("[Mercer] :: ...Fine. For now.");
