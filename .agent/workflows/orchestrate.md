---
description: Coordinate multiple agents for complex tasks. Auto-detects expertise needed, combines BMAD + evo agents + SP discipline.
---

# /orchestrate — Smart Multi-Expert Coordination

$ARGUMENTS

---

## Step 1: Auto-Detect Required Expertise

Scan the task and check project context via `evo/evo-registry.yaml`:

```
□ Architecture/Design  → bmad-create-architecture + domain agent
□ Code Implementation  → domain agent from registry
□ Code Review          → bmad-code-review + domain checklist
□ Security             → security-auditor + agkit-vulnerability-scanner
□ Performance          → performance-optimizer + agkit-performance-profiling
□ Testing              → test-engineer/qa-automation-engineer + domain test patterns
□ Database             → database-architect + agkit-database-design
□ API Design           → domain agent + agkit-api-patterns
□ Process/Planning     → bmad-sprint-planning, bmad-create-story
□ UX/UI                → bmad-create-ux-design or frontend-specialist
□ Documentation        → documentation-writer + agkit-documentation-templates
□ Brainstorm           → bmad-brainstorming
```

**Select ALL that apply** → minimum 3 experts.

---

## Step 2: Route to Mode

### Mode A: BMAD Party (Multi-Perspective Review)

**When:** task is review, evaluation, or decision-making

```
Use bmad-party-mode skill
→ All BMAD agents join: Analyst + PM + Architect + UX + Dev + QA
→ Each provides perspective from their role
→ Consensus or structured disagreement
```

Best for: PRD review, architecture decision, sprint retrospective.

### Mode B: Expert Panel (Analysis/Audit)

**When:** task is analysis, audit, or quality check

Use `sp-dispatching-parallel-agents` to dispatch experts TRULY in parallel:

```
Phase 1 — Plan (sequential):
  Lead expert analyzes scope → proposes approach → user checkpoint

Phase 2 — Execute (PARALLEL via sp-dispatching-parallel-agents):
  Dispatch Expert 1: [domain] → [specific analysis task]
  Dispatch Expert 2: [domain] → [specific analysis task]
  Dispatch Expert 3: [domain] → [specific analysis task]
  Each expert works INDEPENDENTLY and SIMULTANEOUSLY

Phase 3 — Merge:
  Collect all expert reports
  Cross-reference findings
  Deduplicate
  Sort by severity: 🔴 HIGH → 🟡 MEDIUM → 🟢 LOW
```

### Mode C: Parallel Implementation (Independent Tasks)

**When:** task has 2+ independent sub-tasks that don't share state

```
Use sp-dispatching-parallel-agents:
  1. Split task into independent pieces
  2. Assign each piece to appropriate domain agent
  3. Execute ALL pieces in parallel
  4. 2-stage review of combined results (sp-subagent-driven-development)
```

---

## Step 3: Expert Selection (for Mode B)

Based on detected domains, select from 20 available AG Kit agents:

| Domain | Agent | Skills Loaded |
|--------|-------|--------------| 
| Java Architecture | `java-backend-specialist` | agkit-java-spring-boot (DDD, layers) |
| Frontend | `frontend-specialist` | agkit-nextjs-react-expert |
| Security | `security-auditor` | agkit-vulnerability-scanner (OWASP) |
| Performance | `performance-optimizer` | agkit-performance-profiling |
| Database | `database-architect` | agkit-database-design |
| Testing | `test-engineer` | testing-patterns, domain test patterns |
| DevOps | `devops-engineer` | agkit-deployment-procedures |
| API | `backend-specialist` | agkit-api-patterns |
| SEO | `seo-specialist` | agkit-seo-fundamentals |
| Penetration | `penetration-tester` | agkit-red-team-tactics |

---

## Step 4: Report Output

### For Audit mode (security, performance)

Use templates from `evo/templates/docs/`:

| Audit type | Template | Save to |
|-----------|----------|---------|
| Security audit | `security-audit-template.md` (OWASP) | `docs/06-reports/security-audits/YYYY-MM-DD.md` |
| Performance audit | (structured report) | `docs/06-reports/performance-audits/YYYY-MM-DD.md` |
| General audit | (structured report) | `docs/06-reports/audits/YYYY-MM-DD-{scope}.md` |

### For all modes

Output includes:
```markdown
## 🎼 Orchestration Report

### Mode: [A: Party | B: Expert Panel | C: Parallel]
### Experts Invoked: [count] (minimum 3)

| # | Expert | Domain | Key Finding |
|---|--------|--------|------------|
| 1 | [agent] | [area] | [finding] |

### Severity Summary
🔴 HIGH: [count] — must fix before proceed
🟡 MEDIUM: [count] — should fix
🟢 LOW: [count] — nice to have

### Recommended Actions (priority order)
1. [Most critical]
```

After report: Update `docs/DOCUMENT-INDEX.md`

---

## No-BMAD Fallback

- Mode A → structured role-play perspectives (SA, PM, QA, Dev, UX)
- Mode B → works without BMAD (AG Kit agents + SP parallel dispatch)
- Mode C → works without BMAD (SP parallel agents)
