---
description: Smart testing. Auto-detects framework and applies domain-specific patterns.
---

# /test — Smart Testing

$ARGUMENTS

---

## Sub-commands

```
/test                  Run all tests
/test [file/feature]   Generate tests for specific target  
/test e2e              Generate E2E tests (BMAD QA if available)
/test coverage         Show test coverage report
/test review           Review test quality (BMAD TEA if available)
/test perf             Run performance tests
/test report           Generate formal test report
```

---

## Framework Detection

1. **Java** (`pom.xml` + JUnit):
   - Domain test: plain JUnit (no Spring, no mocks)
   - Service test: `@ExtendWith(MockitoExtension.class)`
   - Integration test: `@SpringBootTest` + Testcontainers
   - Architecture test: ArchUnit rules
   - Reference: `agkit-java-spring-boot` §11 DDD Testing Patterns

2. **Frontend** (`package.json` + Jest/Vitest):
   - Unit: Jest/Vitest + Testing Library
   - E2E: Playwright
   - Use project's existing test framework and patterns

3. **Other:** Detect test framework from project structure, follow existing patterns

---

## E2E Sub-command

```
/test e2e
```

- **BMAD installed** → Use `bmad-qa-generate-e2e-tests` skill
- **BMAD TEA module** → Use `bmad-testarch-automate` skill
- **No BMAD** → Generate E2E tests following project patterns

---

## Performance Sub-command

```
/test perf
```

1. Identify critical paths (APIs with high traffic, complex queries)
2. Set baselines: response time p50/p95/p99, throughput
3. Run load tests: {JMeter / k6 / Gatling}
4. Compare against NFR thresholds from `docs/02-requirements/nfr.md`
5. Save report → `docs/06-reports/performance-audits/YYYY-MM-DD.md`

---

## Test Report Sub-command

```
/test report
```

Template: `evo/templates/docs/test-report-template.md`
Output: `docs/06-reports/test-reports/YYYY-MM-DD-{scope}.md`

Report includes:
- Summary: total/passed/failed/skipped/coverage
- Coverage by module
- Failed tests with error details
- New tests added (linked to FR-NNN)
- Regression check results

After report: Update `docs/DOCUMENT-INDEX.md`

---

## Test Quality Review

```
/test review
```

- **BMAD TEA installed** → Use `bmad-testarch-test-review` (0-100 scoring)
- **No TEA** → Manual review: coverage gaps, flaky tests, assertion quality

---

## Regression Strategy

| Trigger | Test Scope | Duration target |
|---------|-----------|----------------|
| Hotfix | Full suite (all modules) | < 15 min |
| Feature branch | Module suite + integration | < 10 min |
| PR merge to develop | Full suite + E2E | < 20 min |
| Release candidate | Full suite + E2E + perf | < 30 min |

---

## Key Principles

- Test BEHAVIOR not implementation
- Follow Arrange-Act-Assert pattern
- Match project's existing test style
- Use `sp-test-driven-development` RED-GREEN-REFACTOR when generating
- Acceptance Criteria format: Given-When-Then
