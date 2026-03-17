---
description: Smart brainstorming. Routes to BMAD guided session or structured exploration.
---

# /brainstorm — Smart Brainstorming

$ARGUMENTS

---

## Routing

1. **Check BMAD installed:** Does `_bmad/_config/` exist?
   - YES → Use `bmad-brainstorming` skill (guided, CSV techniques, 4 modes, 100+ ideas target)
   - NO → Fallback below

2. **Fallback: Structured Exploration**

   Use `sp-brainstorming` Socratic questioning protocol:

   ### Step 1: Understand the Goal
   - What problem are we solving?
   - Who is the user?
   - What constraints exist?

   ### Step 2: Generate Options
   - Provide at least 3 different approaches
   - Each with pros, cons, and effort estimate
   - Consider unconventional solutions

   ### Step 3: Compare and Recommend
   - Summarize tradeoffs in a table
   - Give recommendation with reasoning
   - Ask which direction to explore
