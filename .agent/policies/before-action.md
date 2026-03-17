# Before Action Policy

> Loaded when System 2 thinking is needed (complex/uncertain requests)

## Classify Request

| Type | Signal | Action |
|------|--------|--------|
| Question | "what is", "explain", "how" | Answer directly. No tools needed. |
| Simple Code | Single file, clear fix | Act immediately. Verify after. |
| Complex Code | Multi-file, architecture | Think first. Confirm scope. Plan. |
| Design/UI | Visual, layout, UX | Load agent design rules first. |
| Deploy | Production, release | Load security + checklist policies. |

## Route to Skill Source

Detect intent → select source:
- **Planning/Lifecycle** (brief, PRD, architecture, sprint, stories) → `bmad-*`
- **Coding/Execution** (implement, build, fix, test, debug) → `sp-*`
- **Tech-Specific** (React, Python, security, DevOps) → `agkit-*`
- **Creative/Game** (brainstorm, narrative, game design) → `bmad-cis-*` / `gds-*`

## Gate (only when confidence < 50%)

When genuinely uncertain:
1. Ask max 2 strategic questions (not 3 generic ones)
2. Focus on: scope, constraints, edge cases
3. Once answered → proceed without further delay

When user provides full spec → do NOT re-ask. Validate edge cases only.
