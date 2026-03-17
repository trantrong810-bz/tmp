---
description: Sprint and project status. BMAD sprint-status integration.
---

# /status — Smart Status

$ARGUMENTS

---

## Routing

1. **Check sprint-status.yaml:**
   - Exists → SPRINT STATUS MODE
   - Not exists → PROJECT STATUS MODE

---

## SPRINT STATUS MODE

- **BMAD installed** → Use `bmad-sprint-status` skill (summary + risk surfacing + next action)
- **No BMAD** → Parse `sprint-status.yaml` directly:
  1. Count stories by status (ready, in-progress, review, done)
  2. Show current sprint progress %
  3. Identify blocked stories
  4. Suggest next action

---

## PROJECT STATUS MODE

Scan project for progress indicators:
1. Check git log for recent activity
2. Check test results (pass/fail count)
3. Check build status
4. Report project health summary

---

## OPS STATUS MODE

```
/status ops
```

Check operational health:

| # | Check | Source | Report |
|---|-------|--------|--------|
| 1 | Health endpoints | `GET /actuator/health` | UP/DOWN |
| 2 | Recent errors | Application logs (last 1h) | Error count |
| 3 | Response times | APM / metrics | p50/p95/p99 |
| 4 | Resource usage | Infrastructure monitoring | CPU/Memory % |
| 5 | Recent incidents | `docs/06-reports/incidents/` | Open count |
| 6 | Pending CRs | `docs/06-reports/change-requests/` | In-progress |

Refer to: `docs/05-guides/observability.md` for monitoring setup.
