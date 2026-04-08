---
description: Legacy project modernization. Scan → assess → plan → execute → verify with zero regression.
---

# /refactor — Smart Legacy Modernization

$ARGUMENTS

---

## Sub-commands

```
/refactor scan          Scan codebase, generate AS-IS docs
/refactor scan business Generate business docs (PRD, Use Cases, User Flows)
/refactor scan srs      Generate SRS (IEEE 830, BR extraction from code)
/refactor scan ux       Generate UX spec + design system
/refactor scan epics    Generate Epics/Stories from code
/refactor scan full     Scan + all SDLC docs
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

## SCAN BUSINESS MODE

```
/refactor scan business
```

**Goal:** Generate business & requirements docs from existing code. Code is source of truth.

> **Prerequisite:** Run `/refactor scan` first. Uses scan results from `{project_knowledge}/`.

> **Language:** Communication + doc headers in configured language. Code refs stay English.

### 4a. Business Documents → `docs/01-business/`

**Product Brief** → `docs/01-business/product-brief.md`
```
Template: evo/templates/docs/product-brief-template.md
Extract from: README, package description, auth roles, controllers/routes, config
```

**PRD** → `docs/01-business/prd.md`
```
Sections: Product Overview, Target Users (from auth/role code),
Feature Inventory (1 section per controller), Business Workflows (mermaid flowcharts),
NFR (from config/annotations), Known Limitations
```

**Use Cases** → `docs/01-business/use-cases.md`
```
For EACH controller/route group:
  UC-XX: [Name] — Actor, Trigger, Pre/Post condition
  Main Flow: sequenceDiagram (Actor→Frontend→API→DB)
  Alternative + Exception Flows

For schedulers/background jobs:
  BP-XX: [Process Name] — flowchart TD with decision points
```

**User Flows** → `docs/01-business/user-flows.md`
```
Navigation Map: graph TD (screen connections from routes)
Per Screen: sequenceDiagram for page load + user actions
Auth flows: login, refresh token, logout sequences
```

Gate: User reviews ✅

---

## SCAN SRS MODE

```
/refactor scan srs
```

**Goal:** Generate IEEE 830 SRS with business rules extracted from code.

> **Prerequisite:** Run `/refactor scan` first (and optionally `scan business`).

### 4b. SRS → `docs/02-requirements/srs.md`

```
Template: evo/templates/docs/srs-template.md (IEEE 830)

CRITICAL — Business Rules extraction:
  For EACH service method with logic:
    BR-XX-YY: [Mô tả] — `ClassName.method():lineNumber`

§1 Introduction: from project overview
§2 Overall Description: from architecture docs
§3.1 Functional Requirements:
  For EACH API endpoint / feature:
    FR-NNN: [Name]
    - Trigger, Actor, Input, Output
    - Business Rules with code references (BR-XX-YY)
    - State transitions (stateDiagram-v2 if state machine found)
    - Sequence diagram (actor→service→repository→external)
    - Exception flows with HTTP codes
    - Validation rules table
    - Formulas (if calculations found in code)
§3.2 Non-Functional Requirements: from config, annotations, infrastructure
§4 External Interfaces: from API contracts + frontend routes
§5 Appendices:
  A. Use Case Diagrams (link to use-cases.md)
  B. Data Dictionary (from data-models)
  C. Traceability Matrix: BR → FR → Epic → Code File
```

Gate: User reviews ✅

---

## SCAN UX MODE

```
/refactor scan ux
```

**Goal:** Generate UX design spec from frontend code.

> **Prerequisite:** Run `/refactor scan` first. Only applicable if project has frontend.

### 4c. UX Design → `docs/02-requirements/ux-design.md`

```
Template: evo/templates/docs/ux-design-template.md

Extract from frontend routes, pages, components, CSS/theme:
§1 User Personas: from auth roles
§2 User Flows: link to user-flows.md
§3 Screen Specifications:
  Per page/route: layout diagram (mermaid graph), key interactions, data sources
§4 Interaction Patterns: from shared components
§5 Accessibility: WCAG notes if found
§6 Design System:
  Colors (CSS variables/theme), Typography, Components, Spacing & Grid
```

Gate: User reviews ✅

---

## SCAN EPICS MODE

```
/refactor scan epics
```

**Goal:** Generate Epic/Story mapping from code structure.

> **Prerequisite:** Run `/refactor scan srs` first (needs FR references).

### 4d. Epics → `docs/04-planning/epics.md`

```
Template: evo/templates/docs/epic-template.md

Group by service boundaries / feature areas:
  Epic Overview table: Epic | Tên | Module | FRs | Stories
  Per Epic:
    - Module, linked FRs from SRS
    - Stories with Acceptance Criteria (Given-When-Then)

Traceability Matrix: FR → Epic → Story → Code File
```

Gate: User reviews ✅

---

## SCAN FULL MODE

```
/refactor scan full
```

Runs all scan steps sequentially:
1. `/refactor scan` (code scan + architecture)
2. `/refactor scan business` (PRD, use cases, user flows)
3. `/refactor scan srs` (IEEE 830 SRS)
4. `/refactor scan ux` (UX spec — skip if no frontend)
5. `/refactor scan epics` (epic/story mapping)
6. Cross-validation:
   - [ ] Every controller → has FR in SRS
   - [ ] Every FR → has Epic/Story
   - [ ] Every entity → in data-models
   - [ ] Every route → in UX spec
   - [ ] Every `if/switch/validation` → has BR-XX-YY in SRS
7. Update `docs/DOCUMENT-INDEX.md` + `docs/00-project/glossary.md`

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
