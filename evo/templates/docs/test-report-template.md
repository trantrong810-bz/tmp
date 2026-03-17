# Test Report

<!-- 
  Version: {version} | Date: {date}
-->

| Field | Value |
|-------|-------|
| **Report ID** | TR-{YYYY-MM-DD}-{scope} |
| **Scope** | {what_was_tested} |
| **Runner** | {manual / CI pipeline #NNN} |
| **Date** | {date} |

---

## Summary

| Metric | Value | Threshold | Status |
|--------|-------|-----------|--------|
| Total tests | {N} | — | — |
| Passed | {N} | 100% | ✅/❌ |
| Failed | {N} | 0 | ✅/❌ |
| Skipped | {N} | < 5% | ✅/❌ |
| Code coverage | {N}% | ≥ 80% | ✅/❌ |
| New code coverage | {N}% | ≥ 80% | ✅/❌ |
| Flaky tests | {N} | 0 | ✅/❌ |
| Duration | {time} | < {threshold} | ✅/❌ |

---

## Coverage by Module

| Module | Lines | Branches | Status |
|--------|-------|----------|--------|
| {module} | {N}% | {N}% | ✅/❌ |

---

## Failed Tests

| # | Test | Module | Error | Ticket |
|---|------|--------|-------|--------|
| 1 | {test_name} | {module} | {error_message} | {ticket} |

---

## New Tests Added

| # | Test | Type | Covers |
|---|------|------|--------|
| 1 | {test_name} | Unit/Integration/E2E | FR-{NNN} / bugfix |

---

## Regression Check

| Check | Result |
|-------|--------|
| All existing tests pass | ✅/❌ |
| No new failures introduced | ✅/❌ |
| Performance baseline maintained | ✅/❌ |

---

## Recommendations

| # | Finding | Action |
|---|---------|--------|
| 1 | {finding} | {action} |
