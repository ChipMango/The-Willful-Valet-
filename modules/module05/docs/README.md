## Section 5.1 – Arena RTL Port and Signal Planning

- [ ] FSM, queues, earnings, and interference modules instantiated
- [ ] Clean top-level I/O defined
- [ ] Signal plan documented in block diagram or table
- [ ] Each module communicates via clearly defined, cycle-accurate signals
- [ ] All outputs usable for waveform review and scoreboard logging

## Section 5.2 – Valet Flow Engine

- [ ] Flow controller implements complete valet event lifecycle
- [ ] FSM decisions validated against queue state and cooldown
- [ ] Parking and retrieval timings recorded for scoring
- [ ] Errors/stalls logged with descriptive codes
- [ ] Sim runs produce observable lifecycle traces in waveform

## Section 5.3 – Tip Tracker

- [ ] Queue type-based multipliers implemented
- [ ] Latency detection and bonus/penalty logic integrated
- [ ] Resilience bonus applied for chaos recovery
- [ ] Earnings engine logs cycle-level scoring events
- [ ] `tip_total` output visible in simulation and scoreboard

## Section 5.4 – Drop and Stall Penalties

- [ ] Timeout tracking implemented for both stall and drop events
- [ ] Penalty values applied based on user-defined thresholds
- [ ] Stall and drop events log car ID and timestamp
- [ ] Simulation shows earnings reduced by penalties in real-time
- [ ] All penalties summarized in final report or leaderboard submission

## Section 5.5 – Interference Layer

- [ ] Mercer chaos engine integrated at top level
- [ ] Interference signals routed to all critical subsystems
- [ ] FSM behavior validated under corrupted/chaotic conditions
- [ ] Logs and waveform output visibly track Mercer’s impact
- [ ] Score modifiers reflect chaos resilience or failure

## Section 5.6 – Scoreboard and Leaderboard Output

- [ ] Score module tracks all required metrics (tips, stalls, drops, chaos)
- [ ] Logging system emits summary stats at end of simulation
- [ ] Output formatted for plain-text and CSV leaderboard entry
- [ ] Chaos recovery and average latency included in final score
- [ ] Design includes team name or unique tag for leaderboard ranking

## Section 5.7 – Waveform Review

- [ ] Full-system simulation runs with waveform enabled
- [ ] Viewer groups signals by subsystem (FSM, queues, tips, chaos)
- [ ] Key events (stall, drop, chaos, tips) traceable in time
- [ ] Tags/cycle numbers included for major milestones
- [ ] Screenshots or waveform exports optional for leaderboard submission

## Section 5.8 – Tournament Mode

- [ ] Full design compiles and runs with +TOURNAMENT_MODE
- [ ] Random events simulate all major FSM and queue behaviors
- [ ] Scoreboard tracks all required metrics
- [ ] CSV and summary log correctly output results
- [ ] Design tag included and unique per student/team
- [ ] Optional: Include waveform and learning reflection

## Section 5.9 – Submission Protocol

- [ ] All RTL modules and testbenches included and runnable
- [ ] Tournament Mode output files present and validated
- [ ] Scoreboard CSV and final logs included
- [ ] Final report written and stored in `/doc`
- [ ] README updated with simulation instructions
- [ ] GitHub repo or zip package submitted to instructor portal

## Section 5.10 – Dynamic Pricing Engine (Hard Mode)

- [ ] Tip system reacts to latency, queue depth, and VIP status
- [ ] Mercer effects influence tip outcomes
- [ ] All pricing decisions logged with breakdown
- [ ] Scoring system tunable based on runtime context
- [ ] Optional: Implement surge pricing or time-of-day modifiers

## Section 5.11 – Valet Reputation Memory

- [ ] Each car interaction tracked with performance fields
- [ ] Structured memory used to store and summarize
- [ ] Optional: Rank or categorize client outcomes
- [ ] Optional: FSM behavior adjusts based on historical data
- [ ] Simulation logs showcase memorable service records
