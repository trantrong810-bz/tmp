# Project Conventions

> Coding standards, naming rules, and Definition of Done for fun5.

---

## Definition of Done (DoD)

Every story/feature is "done" when **ALL** pass:

| # | Check | Tool |
|---|-------|------|
| 1 | All tests pass (new + existing, zero regression) | `/test` |
| 2 | Code coverage ≥ 80% (new code) | `/test coverage` |
| 3 | Build compiles clean | `./mvnw.cmd compile -q` |
| 4 | Code review approved (no 🔴 findings) | `/review` |
| 5 | Security scan clean (no critical) | CI pipeline |
| 6 | Story AC verified (Given-When-Then) | manual + `/test` |
| 7 | Sprint-status updated | `/plan` |
| 8 | Docs updated (if applicable) | workflows |
| 9 | DOCUMENT-INDEX.md updated (if docs changed) | auto |

---

## Acceptance Criteria Format

All AC use **Given-When-Then**:

```
Given [precondition/context]
When [action/trigger]
Then [expected result/outcome]
```

---

## PR Naming Convention

```
[FR-NNN] Short description          ← Feature linked to SRS
[STORY-X-Y] Short description       ← Story reference
[BUGFIX] Short description           ← Bug fix
[HOTFIX] Short description           ← Production hotfix
```

---

## Code Conventions

*(To be populated when application stack is chosen via `/architecture`)*

- Language conventions: per `agkit-*` skill for detected stack
- Naming: see `evo/project-context.md` §Naming Conventions
- Architecture: see `docs/03-architecture/ARCHITECTURE.md`
- DDD patterns: see `docs/03-architecture/domain-model.md`

---

## Regression Strategy

| Trigger | Test Scope | Duration |
|---------|-----------|----------|
| Hotfix | Full suite (all modules) | < 15 min |
| Feature branch | Module suite + integration | < 10 min |
| PR merge to develop | Full suite + E2E | < 20 min |
| Release candidate | Full + E2E + perf | < 30 min |
