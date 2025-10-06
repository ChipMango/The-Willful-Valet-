fsm_controller u_fsm (
  .arrival_req(arrival_req),
  .retrieval_req(retrieval_req),
  .lot_statuses(lot_statuses),
  .cooldowns(cooldowns),
  .mercer_flags(mercer_flags),
  .write_enable_lifo(write_en_lifo),
  .read_enable_lifo(read_en_lifo),
  ...
);
