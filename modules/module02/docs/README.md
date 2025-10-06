### My FSM Design Strategy (Section 2.0)

- My FSM will prioritize CAM for VIPs, FIFO for general traffic, and LIFO as overflow.
- I'll detect Mercer interference using a missing tag + cooldown ready mismatch.
- I plan to keep cooldown state awareness in each state, not as a global pause.
- Logging will be color-coded by decision type.

### Traffic Strategy – Section 2.1

- How does my FSM prioritize between a new car and a pickup request?
- How do I detect when a retrieval is impossible (e.g., car is in limbo)?
- Do I delay arrivals or re-route them when all lots are full?
- Will I treat VIP clients differently in arbitration logic?

## Arbitration Strategy – Section 2.3

- What happens if all lots are in cooldown?
- Do you prioritize fastest cooldown or highest tip?
- How do you avoid starvation of one lot?
- How would you scale this to 5 or more lots in future versions?

## Timing Logic – Section 2.4

- What’s your queue selection behavior during cooldown?
- How long will your system wait before dropping or rerouting a request?
- How do you log timing-related decisions?
- How do your cooldowns interact with Mercer interference or Limbo logic?

## Mercer Interference – Section 2.5

- How does your FSM detect that a car has been stolen?
- How do you log and respond to such interference?
- What scoring penalty do you apply?
- Would you escalate or isolate lots that have frequent interference?

## Scoring Engine – Section 2.6

- What are your base parking and retrieval values?
- How do you scale tips based on performance or queue choice?
- How are timeouts, stalls, and interference handled financially?
- What optimizations did you discover during scoring test runs?

## Logging System – Section 2.7

- What kinds of events are logged and how often?
- What signals did you probe for waveform visibility?
- What files are generated? What do they each contain?
- Did you implement debug verbosity modes or filters?

## Section 2.8 – Integration Test

- What did your first full-system sim reveal about your design?
- Were there unexpected bugs during parking/retrieval?
- How well did your FSM handle Mercer and cooldown delays?
- How did you validate final score accuracy?
- What would you improve in a second run?
