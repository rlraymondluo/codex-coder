---
name: crew-plan
description: Send the current plan to Codex for critique before implementing
---

Send the current implementation plan to Codex for independent review using the `crew-plan` agent.

The crew-plan agent will:
1. Extract the plan from conversation context (the plan you just proposed)
2. Send it to Codex via CLI for critique
3. Return a structured verdict: APPROVE, REVISE, or REJECT with specific feedback
