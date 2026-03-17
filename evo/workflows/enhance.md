---
description: Add or update features in existing application. Used for iterative development.
---

# /enhance — Smart Brownfield Development

$ARGUMENTS

---

## Step 1: Project Detection

Read `evo/evo-registry.yaml` → detect project type → select agent.

---

## Step 2: Scope Analysis + Change Management

1. **Understand the feature** — What is being added/changed?
2. **Read existing code** — Find 1 similar feature → match patterns exactly
3. **Impact analysis** — What modules/files are affected?
4. **Change classification:**

| Size | Files | Change Type | Process |
|------|-------|-----------|---------|
| Simple | 1-3 | Standard | Direct implementation |
| Medium | 4-10 | Normal | Plan first → implement |
| Large | 10+ / new module | Normal | Story spec → implement |
| Breaking | Any (API/DB change) | Normal + approval | Change request required |

5. **For Medium/Large/Breaking changes:**
   - Use `evo/templates/docs/change-request-template.md`
   - Document: what, why, impact, risk, rollback plan
   - Save to: `docs/06-reports/change-requests/CR-{YYYY}-{NNN}.md`
   - Gate: user approval before proceeding
   - If mid-sprint scope change → `bmad-correct-course` skill

---

## Step 3: Route by Complexity

### Simple Change (1-3 files)

→ Direct implementation with domain agent:
- Apply DDD Gate (if applicable)
- Use `sp-test-driven-development` RED-GREEN-REFACTOR
- Use `sp-verification-before-completion` before done

### Medium Change (4-10 files)

→ Plan first:
1. Use `sp-writing-plans` micro-task breakdown
2. Execute plan with domain agent
3. Verify all changes coherent

### Large Change (10+ files or new module)

→ BMAD story flow:
1. If BMAD installed → suggest `bmad-create-story` first
2. Then `/dev story-file.md`
3. If no BMAD → use `sp-writing-plans` + domain agent

---

## Step 4: Verification

Before claiming done:
- All existing tests still pass (zero regression)
- New tests added for new behavior
- Build compiles clean
- If BMAD: story file updated, sprint-status updated
- If change request: update CR status → Completed
- Update `docs/DOCUMENT-INDEX.md` if docs changed
