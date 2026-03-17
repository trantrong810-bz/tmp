---
description: Legacy project modernization. Scan → assess → plan → execute → verify with zero regression.
---

# /refactor — Smart Legacy Modernization

$ARGUMENTS

---

## Sub-commands

```
/refactor scan          Scan codebase, generate AS-IS docs
/refactor assess        Gap analysis vs target standards
/refactor plan          Create phased refactor plan
/refactor execute [id]  Execute specific refactor task (TDD, zero regression)
/refactor verify        Compare before/after, full validation
```

---

## Step 1: Project Detection

Read `evo/evo-registry.yaml` → detect stack → select domain agent + skills.

---

## SCAN MODE

```
/refactor scan
```

**Goal:** Understand the existing codebase before changing anything.

1. **Project scan** using `bmad-document-project`:
   - File structure, module boundaries, dependency graph
   - Tech stack versions, frameworks, libraries
   - Patterns in use (DDD? Anemic? Layered? MVC?)
   - Code metrics: file count, LOC, test count, coverage

2. **Reverse engineering** using `bmad-wds-reverse-engineering`:
   - Extract existing conventions, naming patterns
   - Identify shared utilities, base classes

3. **Output:**
   - `docs/03-architecture/ARCHITECTURE-AS-IS.md` (current state)
   - `docs/03-architecture/CODEBASE.md` (file map, dependency graph)
   - Update `docs/DOCUMENT-INDEX.md`

---

## ASSESS MODE

```
/refactor assess
```

**Goal:** Quantify gaps between current state and target standards.

1. **Load target standards** from domain skills:
   - Java → `agkit-java-spring-boot` (DDD, Hexagonal, API JAR, 4-level testing)
   - React → `agkit-nextjs-react-expert` (SSR, bundle, performance)
   - Other → `agkit-clean-code` (general standards)

2. **Multi-layer assessment** using `bmad-code-review`:
   - Architecture: patterns, module boundaries, coupling
   - Code quality: clean code, naming, complexity
   - Security: `agkit-vulnerability-scanner` (OWASP scan)
   - Performance: `agkit-performance-profiling` (baseline)
   - Testing: coverage %, test quality, flaky tests

3. **Gap scoring:**

   | Category | Score 1-10 | Weight |
   |----------|-----------|--------|
   | Architecture | {N} | 25% |
   | Code quality | {N} | 20% |
   | Test coverage | {N} | 20% |
   | Security | {N} | 15% |
   | Dependencies | {N} | 10% |
   | Documentation | {N} | 10% |
   | **Weighted total** | **{N}/10** | |

4. **Output:**
   - Template: `evo/templates/docs/refactor-assessment-template.md`
   - Save to: `docs/06-reports/refactor-assessment-YYYY-MM-DD.md`
   - Update `docs/DOCUMENT-INDEX.md`

---

## PLAN MODE

```
/refactor plan
```

**Goal:** Create phased, risk-ordered refactor plan.

1. **Read** assessment report (from ASSESS)
2. **Plan** using `sp-writing-plans` micro-task breakdown:

   **Ordering rules:**
   ```
   Phase A: Foundation (LOW risk)
     → Upgrade runtime, add migration tool, add CI
     → Zero behavior change — just infrastructure

   Phase B: Safety Net (LOW risk)
     → Add tests for critical paths FIRST
     → Coverage must reach ≥ 50% before structural refactor
     → "Never refactor code without tests"

   Phase C: Architecture (MEDIUM risk)
     → Restructure modules, extract domains, apply patterns
     → Each step: write test → refactor → verify → commit

   Phase D: Polish (LOW risk)
     → Code conventions, coverage ≥ 80%, docs finalize
   ```

3. **Each task includes:**
   - ID, description, effort estimate, risk level
   - Files affected
   - Dependencies on other tasks
   - Rollback strategy
   - Definition of done (specific)

4. **Output:**
   - Save to: `docs/04-planning/refactor-plan.md`
   - Update `docs/DOCUMENT-INDEX.md`
   - Suggest: `/refactor execute A1`

---

## EXECUTE MODE

```
/refactor execute A1
/refactor execute B3
/refactor execute C1
```

**Goal:** Execute one refactor task with zero regression.

1. **Read** `docs/04-planning/refactor-plan.md` → find task {id}
2. **Read** `docs/03-architecture/ARCHITECTURE.md` → understand target patterns
3. **Read** existing code that will be changed
4. **Execute** with TDD (`sp-test-driven-development`):

   ```
   Step 1: Write tests for CURRENT behavior (if not exists)
   Step 2: Run tests → all GREEN ✅
   Step 3: Refactor code toward target pattern
   Step 4: Run tests → must still GREEN ✅ (zero regression)
   Step 5: Clean up (remove dead code, rename, format)
   Step 6: Run FULL test suite → zero regression ✅
   ```

5. **Verify** with `sp-verification-before-completion`:
   - ✅ All existing tests pass
   - ✅ New tests added for changed behavior
   - ✅ Build compiles clean
   - ✅ No new warnings/errors introduced
   - ✅ Architecture rules pass (ArchUnit if Java)

6. **Update** `docs/04-planning/refactor-plan.md`: task → ✅ Done
7. **Suggest next:** `/refactor execute {next-task}` or `/refactor verify` if all done

---

## VERIFY MODE

```
/refactor verify
```

**Goal:** Final validation after all refactor phases complete.

1. **Full test suite** → `docs/06-reports/test-reports/`
2. **Code review** using `bmad-code-review` → `docs/06-reports/code-reviews/`
3. **Test quality** using `bmad-testarch-test-review`
4. **Traceability** using `bmad-testarch-trace`
5. **Before/After comparison:**

   | Metric | Before | After | Target | Status |
   |--------|--------|-------|--------|--------|
   | Architecture score | {N}/10 | {N}/10 | ≥ 8 | ✅/❌ |
   | Test coverage | {N}% | {N}% | ≥ 80% | ✅/❌ |
   | Security findings | {N} | {N} | 0 critical | ✅/❌ |
   | Code smells | {N} | {N} | < 5 | ✅/❌ |
   | Build warnings | {N} | {N} | 0 | ✅/❌ |

6. **Output:**
   - Save to: `docs/06-reports/refactor-results-YYYY-MM-DD.md`
   - Update `ARCHITECTURE-AS-IS.md` → rename to `ARCHITECTURE.md` (now it IS the target)
   - Update `docs/DOCUMENT-INDEX.md`

---

## Skills Used (17, all pre-existing)

| Phase | Skills |
|-------|--------|
| Scan | `bmad-document-project`, `bmad-wds-analysis`, `bmad-wds-reverse-engineering` |
| Assess | `bmad-code-review`, `agkit-vulnerability-scanner`, `agkit-performance-profiling`, `agkit-clean-code`, domain skill |
| Plan | `sp-writing-plans`, `agkit-architecture`, `agkit-plan-writing` |
| Execute | `sp-test-driven-development`, `sp-verification-before-completion`, `sp-systematic-debugging`, domain skill |
| Verify | `bmad-code-review`, `bmad-testarch-test-review`, `bmad-testarch-trace`, `sp-requesting-code-review` |

---

## No-BMAD Fallback

- SCAN → Direct file analysis + `agkit-*` skills
- ASSESS → `agkit-clean-code` + `agkit-vulnerability-scanner`
- PLAN → `sp-writing-plans`
- EXECUTE → `sp-test-driven-development` + domain agent
- VERIFY → `sp-requesting-code-review` + domain agent
