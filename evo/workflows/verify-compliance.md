---
description: Verify code matches planning docs (SRS, Architecture, API Spec). Docs = source of truth. Use when the user says "verify code compliance", "check code vs docs", or "kiểm tra code đúng docs chưa".
---

# /verify-compliance — Code vs Docs Compliance Check

$ARGUMENTS

---

## Sub-commands

```
/verify-compliance              Full compliance check (all FRs)
/verify-compliance epic E1      Check specific epic
/verify-compliance fr FR-05     Check specific FR
/verify-compliance changed      Check FRs with recent doc changes
/verify-compliance report       View latest compliance report
```

---

## Step 1: Project Detection

Read `evo/evo-registry.yaml` → detect stack → select domain agent.

---

## Phase 1: Load Context

1. **Load planning docs** from `docs/`:
   - `docs/02-requirements/srs.md` — FRs, BRs, exception flows, formulas
   - `docs/01-business/prd.md` — Business rules, acceptance criteria
   - `docs/01-business/use-cases.md` — Use case flows
   - `docs/03-architecture/architecture.md` — Architecture constraints
   - `docs/03-architecture/database-design.md` — DB schema, ER
   - `docs/03-architecture/api-design.md` — API endpoints, request/response
   - `docs/04-planning/epics.md` — FR→Epic→Story mapping

   > If docs are in different locations, ask user to specify paths.

2. **Ask user — Scope:**
   - `[A]` **All** — Check all FRs
   - `[E]` **Epic** — Check 1 specific epic
   - `[F]` **FR** — Check 1 specific FR
   - `[C]` **Changed** — Only FRs with recent doc changes (git diff)

---

## Phase 2: Extract Compliance Checklist

From docs, build checklist per FR/BR in scope:

```
### FR-XX: [Name]

**Business Rules:**
- [ ] BR-XX-01: [Description] → search hint: [class/method]
- [ ] BR-XX-02: [Description] → search hint: [class/method]

**Exception Flows:**
- [ ] EF-XX-01: [Description] → expected: [behavior]

**Formulas:**
- [ ] [Name]: [Expected formula from docs]

**Validation Rules:**
- [ ] [Field]: [Rules from SRS]

**API Contract:**
- [ ] [Endpoint]: [Method, request/response schema]
```

---

## Phase 3: Code Scan & Compare

Per checklist item:

1. **Locate:** `grep`/`find` to find relevant classes, methods, constants
2. **Read:** Extract actual code implementation
3. **Compare:** Check if code logic matches docs specification
4. **Classify:**

   | Status | Meaning |
   |--------|---------|
   | ✅ `MATCH` | Code matches docs exactly |
   | ⚠️ `PARTIAL` | Logic correct but missing edge case or detail |
   | ❌ `DEVIATION` | Code logic contradicts docs |
   | 🔍 `NOT_FOUND` | No code found for this requirement |

> **Technique:** Grep first, read code second — efficient scanning.
> **Every BR/EF must have a verdict** — no skipping.

---

## Phase 4: Deviation Report

Generate `docs/06-reports/compliance/compliance-report-YYYY-MM-DD.md`:

```markdown
# Code Compliance Report

**Date:** [date]
**Scope:** [scope]
**Docs version:** [latest commit/date]

## Summary

| Status | Count | % |
|--------|-------|---|
| ✅ MATCH | X | X% |
| ⚠️ PARTIAL | X | X% |
| ❌ DEVIATION | X | X% |
| 🔍 NOT_FOUND | X | X% |
| **Compliance** | **X/Y** | **X%** |

## ❌ Deviations

### DEV-001: [BR-XX-YY] [Name]
- **Docs says:** [excerpt from SRS/BRD]
- **Code does:** [actual behavior]
- **File:** `ClassName.java:lineNumber`
- **Fix required:** [specific change]
- **Severity:** Critical / Major / Minor

## ⚠️ Partial Matches

### PAR-001: [BR-XX-YY] [Name]
- **Docs says:** [excerpt]
- **Code does:** [partial implementation]
- **Missing:** [what's missing]
- **File:** `ClassName.java:lineNumber`

## 🔍 Not Found

### NF-001: [FR-XX] [Name]
- **Expected:** [what docs require]
- **Search attempted:** [classes/patterns searched]
- **Recommendation:** Implement / Docs outdated
```

Update `docs/DOCUMENT-INDEX.md`.

---

## Phase 5: Fix Decision

Present report to user:

| Option | Action |
|--------|--------|
| `[F]` Fix All | Auto-fix all deviations (code → match docs) |
| `[S]` Selective | Choose which items to fix |
| `[R]` Report Only | Keep report, no changes |
| `[D]` Docs Wrong | Update docs to match code instead |

---

## Phase 6: Apply Fixes

If user chooses Fix:

1. Per deviation → edit code to match docs spec
2. Use TDD (`sp-test-driven-development`):
   - Write test for expected behavior (from docs)
   - Fix code to pass test
   - Run existing tests → zero regression
3. Mark item ✅ in report after fix
4. After all fixes → update report with final status

---

## Critical Rules

- 📖 **Docs = Source of Truth.** Code ≠ docs → code is wrong (unless user says `[D]`)
- 🎯 **Stay in scope** — don't check outside selected scope
- 📋 **Every BR/EF gets a verdict** — no items skipped
- 🔍 **Grep first, read second** — efficient scanning
- ⚠️ **PARTIAL ≠ DEVIATION** — PARTIAL = right logic, missing edge; DEVIATION = wrong logic
- 🚫 **No auto-fix without user approval**

---

## Skills Used

| Phase | Skills |
|-------|--------|
| Scan | Domain agent (from evo-registry), `bmad-wds-analysis` |
| Compare | `bmad-code-review`, `agkit-clean-code` |
| Fix | `sp-test-driven-development`, `sp-verification-before-completion` |
| Report | `sp-requesting-code-review` |

---

## Usage Examples

```
User: "verify code compliance cho FR-20"
→ Phase 1: Load FR-20 (DCA) from SRS
→ Phase 2: Extract BRs (BR-20-01 → BR-20-06)
→ Phase 3: Scan DcaScheduler, OrderLifecycleService
→ Phase 4: Report deviations
→ Phase 5: User decides

User: "check code vs docs cho epic E5"
→ Phase 1: Load E5 → FR-11,12,16~22,24
→ Phase 2: Extract ~40 BRs
→ Phase 3: Scan order-execution service
→ Phase 4: Report
→ Phase 5: Fix loop

User: "/verify-compliance changed"
→ git diff docs/ → find changed FRs
→ Run phases 2-6 only for those FRs
```
