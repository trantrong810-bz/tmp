---
description: Smart development. Auto-detects story mode vs quick mode, routes to domain-specific agent.
---

# /dev — Smart Development

$ARGUMENTS

---

## Step 1: Context Detection

1. **Story file detection:**
   - Argument contains `.md` path → STORY MODE
   - `sprint-status.yaml` exists with `ready-for-dev` → offer STORY MODE
   - Otherwise → QUICK MODE

2. **Project type detection:**
   - Read `evo/evo-registry.yaml` → match project files against detectors
   - Select: agent + skills based on registry match
   - Fallback: no registry match → standard dev with SP verification

---

## STORY MODE

When story file detected or selected:

1. Load the **evo agent** matched by registry (or AG Kit base agent)
2. Pass the story file path as context
3. Agent handles: Quality Gate → TDD → task tracking → sprint-status update
4. **Auto-verification (Step 4 below)**

---

## QUICK MODE

When no story file:

1. Load the **evo agent** matched by registry (or AG Kit base agent)
2. Agent handles: Quality Gate → implement → verify
3. **Auto-verification (Step 4 below)**

---

## Step 4: Auto-Verification (MANDATORY — runs after EVERY dev session)

After all tasks complete, automatically execute before claiming "done":

### 4a. Run Tests
```
Detect test framework from registry:
  java-spring → ./mvnw.cmd test (or ./gradlew test)
  react       → npm test
  python      → pytest
  rust        → cargo test

Report: X passed, Y failed, Z skipped
If ANY fail → fix before proceeding
```

### 4b. Build Check
```
  java-spring → ./mvnw.cmd compile -q
  react       → npm run build
  python      → mypy / ruff check
  rust        → cargo build

Report: clean / errors
If errors → fix before proceeding
```

### 4c. SP Verification Gate
```
Apply sp-verification-before-completion:
  ✅ All tests pass (new + existing)
  ✅ Build compiles clean
  ✅ Zero regression
  ✅ If story: all ACs met
  ✅ If story: sprint-status.yaml updated
```

### 4d. Suggest Next Action
```
If story mode:
  "Story complete. Run /review for code review, or /dev [next-story]"
If quick mode:
  "Feature complete. Run /review to verify quality."
```

---

## No-BMAD Fallback

- Story mode without BMAD → reads story file, executes tasks, skips sprint-status
- Quick mode → works identically (no BMAD dependency)
