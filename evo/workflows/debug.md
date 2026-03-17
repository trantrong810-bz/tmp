---
description: Systematic debugging with domain awareness. SP 4-phase + domain patterns.
---

# /debug — Smart Debugging

$ARGUMENTS

---

## Process: SP Systematic Debugging (4 Phases)

Always follow `sp-systematic-debugging` methodology:

### Phase 1: Reproduce
- Get exact error message, stack trace, reproduction steps
- Identify: expected behavior vs actual behavior
- Note: recent changes that could be related

### Phase 2: Hypothesize
- List possible root causes ordered by likelihood
- For Java projects: check common Spring Boot issues:
  - Transaction boundaries (`@Transactional` misplacement)
  - Lazy loading (`LazyInitializationException`)
  - Circular dependencies
  - Schema/migration issues (Liquibase)
  - State machine violations

### Phase 3: Test Each Hypothesis
- Test most likely hypothesis first
- Check logs, data flow, debug output
- Use elimination method — one variable at a time
- **Do not guess.** Verify each hypothesis with evidence.

### Phase 4: Fix and Prevent
- Apply minimal fix for root cause
- Explain WHY it happened
- Add regression test for the bug
- Use `sp-verification-before-completion` before claiming fixed

---

## Domain Enhancement

- `pom.xml` exists → Reference `agkit-java-spring-boot` patterns
- `package.json` exists → Reference React/Next.js patterns
- Other → Generic debugging

---

## No-BMAD Fallback

This workflow does not depend on BMAD. Works identically everywhere.
