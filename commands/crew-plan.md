---
name: crew-plan
description: Send the current plan to Codex for critique before implementing
---

Send the current implementation plan to Codex for critique using the `crew-plan` agent.

**Steps:**

1. **Find the plan** in the current conversation — the most recent implementation plan you proposed (numbered steps, file-by-file breakdown, approach description, etc.)

2. **Write it to a temp file** so the subagent can read it:

```bash
cat > /tmp/crew-plan-review.md << 'EOF'
[THE FULL PLAN TEXT]
EOF
```

3. **Invoke the agent** with the file path and goal:

```
Agent(
  description: "Codex plan review",
  subagent_type: "crew-plan",
  prompt: "Plan file: /tmp/crew-plan-review.md\nGoal: [what the user originally asked for]\nProject dir: [project root absolute path]"
)
```

**The agent has no access to this conversation. It reads the plan from the temp file.**
