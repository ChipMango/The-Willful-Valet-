class Car;
  rand bit [15:0] plate_id;
  bit vip_status;
  int arrival_cycle;
  string color;
  string origin_story;

  function void display();
    $display("🚗 Car [%0h] | VIP: %b | Arrived: %0d | %s", 
              plate_id, vip_status, arrival_cycle, origin_story);
  endfunction
endclass


virtual class ParkingLot;
  string name;
  int cooldown_delay;
  bit cooldown_active;

  pure virtual function void park(Car c);
  pure virtual function Car retrieve();
  pure virtual function void tick();  // advance internal cooldown
endclass

class Valet;
  string alias;
  string style;
  int total_earnings;
  int tips_earned;
  int cars_parked;
  int cars_dropped;
  int cars_in_limbo;

  function void log_action(string msg);
    $display("[%0s] %s", alias, msg);
  endfunction
endclass

class TransactionLog;
  typedef struct {
    int cycle;
    string action;
    string queue_name;
    bit success;
    int reward;
    string meta;
  } Entry;

  Entry entries[$];

  function void record(Entry e);
    entries.push_back(e);
    $display("[LOG] %s", e.meta);
  endfunction

  function void dump_all();
    foreach (entries[i]) $display("%p", entries[i]);
  endfunction
endclass

