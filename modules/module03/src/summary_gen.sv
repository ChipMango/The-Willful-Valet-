initial begin
  // Insert initial tags
  insert_tag(16'hC0DE); insert_tag(16'hFADE); insert_tag(16'hBEEF);
  // Trigger duplicates
  insert_tag(16'hFADE); insert_tag(16'hBEEF);
  // Retrieve normal
  retrieve_tag(16'hC0DE);
  // Ghost event
  retrieve_tag(16'hDEAD);
  // Re-insert ghost
  insert_tag(16'hDEAD);
  // Force age expiry
  wait_cycles(25); 
  check_expired_tags();
end
