---
name: crew-plan
description: Send the current plan to Codex for critique before implementing
---

Before invoking the `crew-plan` agent, you MUST extract the plan from the current conversation context and pass it explicitly in the agent's prompt. The agent runs as a subagent with NO access to this conversation — if you don't pass the plan, it has nothing to review.

**Steps:**

1. **Find the plan** — look for the most recent implementation plan you proposed in this conversation. This is typically a numbered list of steps, a file-by-file breakdown, or an architecture description.

2. **Find the goal** — what was the user's original request that this plan addresses?

3. **Find project guidelines** — if a CLAUDE.md exists, extract the relevant conventions.

4. **Invoke the agent** with ALL of the above embedded in the prompt:

```
Agent(
  description: "Codex plan review",
  subagent_type: "crew-plan",
  prompt: "Review this plan:\n\n## Plan\n[THE FULL PLAN TEXT]\n\n## Goal\n[WHAT THE USER ASKED FOR]\n\n## Project Guidelines\n[RELEVANT CLAUDE.md RULES]"
)
```

**Do NOT invoke the agent with a vague prompt like "review the current plan" — the agent cannot see this conversation.**
