## Memory That Thinks Back – Reflection

- Describe CAM in your own words.
- List 2 benefits and 2 dangers of identity-based access in hardware systems.
- Can you think of a real-world system where something is retrieved based on identity rather than order? How does that system handle ambiguity?

## CAM Vault Implementation – Section 3.1

- What is the CAM depth and tag width in your design?
- How did you structure tag comparisons and write logic?
- What happens if two tags match at once?
- How is your FSM informed of match success or failure?

## Duplicate Detection and Priority Logic – Section 3.2

- What is your policy for tag duplication in CAM?
- How do you decide which match to retrieve?
- What flags or logs help you detect phantom tags?
- What would happen if a tag was never properly cleared?

## Limbo Register – Section 3.3

- How does your system detect and enter Limbo state?
- What structure do you use to store Limbo-tagged entries?
- What is the timeout duration, and what happens upon expiration?
- How do you handle tags that reappear while still in Limbo?

## Ghost Retrievals – Section 3.4

- How does your FSM detect a ghost retrieval?
- What is your refund or penalty logic?
- How does the FSM behave after a ghost event?
- How are these events reported to the simulation logs?

## CAM Purge and Recovery – Section 3.5

- How does your system detect when to purge a tag?
- What strategy do you use to prioritize tag versions (CAM vs. Limbo)?
- How does your system recover from corrupted or ghost tags?
- What are your logs reporting during exorcism events?

## CAM vs. Limbo Arbitration – Section 3.6

- How does your system decide between CAM and Limbo when both contain a tag?
- What priority model do you use: CAM-first, age-based, or value-based?
- How do you prevent duplicate retrievals or scoring errors?
- What logs does your FSM output when arbitration occurs?

## Optional HashCAM Challenge – Section 3.7

- What hash function did you implement? Why?
- How does your HashCAM handle collisions?
- What’s your fallback behavior if prediction fails?
- Compare your HashCAM’s performance with the traditional CAM.

## The Fade Test – Section 3.8

- What sequence of events did you simulate?
- What were your arbitration outcomes in CAM–Limbo conflicts?
- What did your final tip/penalty score reveal?
- What improvements would you make to your FSM after this test?
