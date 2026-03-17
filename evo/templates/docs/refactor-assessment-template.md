# Refactor Assessment Report

<!-- 
  Document ID: REF-{project}-{version}
  Date: {date}
  Assessor: {name/AI}
  Template: evo/templates/docs/refactor-assessment-template.md | Template-version: 1.0
-->

| Field | Value |
|-------|-------|
| **Project** | {project_name} |
| **Date** | {date} |
| **Stack** | {detected_stack} |
| **Codebase size** | {N} files, {N} LOC |

---

## Executive Summary

{2-3 sentences: overall state, biggest risks, recommendation}

**Overall Score: {N}/10** — {Excellent / Good / Needs Work / Critical}

---

## Gap Analysis

| # | Category | Current | Target | Score | Weight | Weighted |
|---|----------|---------|--------|-------|--------|---------|
| 1 | Architecture | {description} | {target} | {N}/10 | 25% | {N} |
| 2 | Code quality | {description} | {target} | {N}/10 | 20% | {N} |
| 3 | Test coverage | {N}% | ≥ 80% | {N}/10 | 20% | {N} |
| 4 | Security | {N} findings | 0 critical | {N}/10 | 15% | {N} |
| 5 | Dependencies | {versions} | Latest LTS | {N}/10 | 10% | {N} |
| 6 | Documentation | {state} | Full docs/ | {N}/10 | 10% | {N} |
| | **TOTAL** | | | | | **{N}/10** |

---

## Detailed Findings

### Architecture

| # | Finding | Current | Target | Risk | Effort |
|---|---------|---------|--------|------|--------|
| 1 | {finding} | {as-is} | {to-be} | H/M/L | {days} |

### Code Quality

| # | Finding | Files Affected | Severity |
|---|---------|---------------|----------|
| 1 | {smell/issue} | {count} | 🔴/🟡/🟢 |

### Security

| # | Vulnerability | OWASP Category | Severity | Fix |
|---|-------------|----------------|----------|-----|
| 1 | {vuln} | {category} | Critical/High/Medium | {fix} |

### Dependencies

| Dependency | Current | Latest | EOL? | Breaking changes? |
|-----------|---------|--------|------|-------------------|
| {dep} | {ver} | {ver} | Yes/No | Yes/No |

### Testing

| Metric | Current | Target | Gap |
|--------|---------|--------|-----|
| Unit tests | {N} | {N} | {N} to write |
| Integration tests | {N} | {N} | {N} to write |
| E2E tests | {N} | {N} | {N} to write |
| Coverage | {N}% | ≥ 80% | +{N}% needed |
| Flaky tests | {N} | 0 | {N} to fix |

---

## Risk Matrix

| Risk | Impact | Likelihood | Mitigation |
|------|--------|-----------|-----------|
| {risk} | H/M/L | H/M/L | {mitigation} |

---

## Recommended Refactor Phases

| Phase | Focus | Risk | Estimated Effort |
|-------|-------|------|-----------------|
| A | Foundation (runtime, tools) | Low | {N} days |
| B | Safety net (tests first) | Low | {N} days |
| C | Architecture (restructure) | Medium | {N} days |
| D | Polish (conventions, docs) | Low | {N} days |
| **Total** | | | **{N} days** |

---

## Revision History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | {date} | {author} | Initial assessment |
