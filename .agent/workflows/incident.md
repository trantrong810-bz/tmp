---
description: Production incident response. Triage, mitigate, resolve, postmortem.
---

# /incident — Production Incident Response

$ARGUMENTS

---

## Step 1: Triage

Classify the incident:

| Severity | Criteria | Response Time |
|----------|----------|--------------|
| 🔴 P1 Critical | Service down, data loss risk, security breach | ≤ 15 min |
| 🟠 P2 High | Major feature broken, significant user impact | ≤ 1 hour |
| 🟡 P3 Medium | Minor feature degraded, workaround exists | ≤ 4 hours |
| 🟢 P4 Low | Cosmetic, non-urgent | Next business day |

---

## Step 2: Diagnose

Use `sp-systematic-debugging` with production context:

1. **Gather evidence** — logs, metrics, traces, error samples
2. **Form hypothesis** — based on timeline correlation
3. **Narrow scope** — which module, service, config changed?
4. **Check recent changes** — last deployment, config change, traffic spike

Tools:
- Application logs → structured search with traceId
- Metrics → check RED metrics anomalies
- Traces → distributed trace analysis
- Monitoring → dashboard review

Refer to: `docs/05-guides/observability.md` for dashboard and log locations.

---

## Step 3: Mitigate

Priority = **stop the bleeding**, not fix root cause:

| Action | When |
|--------|------|
| Rollback deployment | Bad deploy detected |
| Feature flag off | New feature causing issue |
| Scale up | Load-related |
| Failover to replica | DB/infra failure |
| Circuit breaker | Downstream dependency down |
| Block traffic | Security breach |

---

## Step 4: Resolve

After mitigation:
1. Identify root cause (5 Whys)
2. Implement permanent fix
3. Test fix in staging
4. Deploy fix through normal CI/CD pipeline

---

## Step 5: Postmortem

Template: `evo/templates/docs/incident-template.md`
Output: `docs/06-reports/incidents/INC-{YYYY}-{NNN}.md`

Report includes:
- Timeline (every event timestamped)
- Impact assessment (users, revenue, SLA)
- Root cause (5 Whys analysis)
- Action items (prevention, detection, response)
- Lessons learned

After postmortem:
- Update `docs/DOCUMENT-INDEX.md`
- Track action items to completion
- Update runbooks if gap found

---

## Integration with Templates

| Phase | Template Used |
|-------|-------------|
| DR scenario | `disaster-recovery-template.md` |
| Report | `incident-template.md` |
| Fix as change | `change-request-template.md` (if significant) |
| Process improvement | `retrospective-template.md` |
