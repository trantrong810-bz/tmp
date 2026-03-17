---
description: Deployment command for production releases. Pre-flight checks, CI/CD verification, and deployment execution.
---

# /deploy — Smart Deployment

$ARGUMENTS

---

## Step 1: Pre-flight Checks

Run ALL checks BEFORE any deployment:

| # | Check | Command / Method | Pass Criteria | Template |
|---|-------|-----------------|---------------|---------|
| 1 | CI/CD pipeline pass | Check latest pipeline | All stages green | `ci-cd-pipeline-template.md` |
| 2 | All tests pass | `./mvnw.cmd test` / `npm test` | 0 failures | — |
| 3 | Build clean | `./mvnw.cmd package -q` / `npm run build` | No errors | — |
| 4 | Security scan | `agkit-vulnerability-scanner` | No 🔴 critical | — |
| 5 | Code review approved | Check recent `/review` report | Approved | `code-review-template.md` |
| 6 | DB migration tested | Liquibase dry-run on staging | No conflicts | — |
| 7 | Environment parity | Verify staging ≈ production | Config aligned | `environment-matrix-template.md` |
| 8 | Monitoring ready | Health endpoints + dashboards | Accessible | `observability-template.md` |
| 9 | DR plan current | Backup verified, rollback tested | Pass | `disaster-recovery-template.md` |
| 10 | Docs up-to-date | Check `docs/DOCUMENT-INDEX.md` | All living docs current | — |

All pass → proceed. Any fail → STOP and report.

---

## Step 2: Deployment Runbook

Template: `evo/templates/docs/deployment-template.md`
Output: `docs/05-guides/deployment.md` (living doc, updated per release)

Fill in:
- Version, date, deployer, approver
- Pre-deployment checklist results
- Step-by-step commands
- Rollback plan with triggers
- Post-deployment verification

---

## Step 3: Execute

Based on environment (see `docs/05-guides/environment-matrix.md`):

| Target | Strategy | Gate |
|--------|----------|------|
| Staging | Auto-deploy on merge to develop | CI pass |
| Production | Manual trigger on merge to main | 2 reviewers + PO |

### Deploy Steps
1. Backup database (verify backup)
2. Deploy to staging → smoke test
3. Manual approval gate (for production)
4. Deploy to production → smoke test
5. Monitor for 30 minutes

---

## Step 4: Post-Deployment Verification

### Immediate (0-30 min)
| Check | Tool | Alert if |
|-------|------|---------|
| Health endpoints | `GET /actuator/health` | Not UP |
| Error rate | Monitoring dashboard | > 1% |
| Response time | APM | p95 > baseline × 1.5 |
| Key user flows | Smoke tests | Any failure |

### Short-term (30 min - 24h)
| Check | Tool | Alert if |
|-------|------|---------|
| Business metrics | Dashboard | Drop > 10% |
| Memory/CPU | Infrastructure monitoring | Sustained > 80% |
| Log anomalies | Log search | New error patterns |

Refer to: `docs/05-guides/observability.md` for monitoring setup.

---

## Step 5: Documentation

After successful deployment:
1. Update `docs/05-guides/deployment.md` with results
2. Update `docs/DOCUMENT-INDEX.md`
3. Tag release in git: `v{version}`
4. Notify stakeholders

---

## Rollback

If any post-deployment check fails:
1. Execute rollback steps from deployment doc
2. Verify rollback success
3. Create incident report: `docs/06-reports/incidents/INC-{YYYY}-{NNN}.md`
   Template: `evo/templates/docs/incident-template.md`
4. Trigger `/incident` workflow if P1/P2

---

## Related Templates

| Template | Purpose | docs/ path |
|----------|---------|-----------|
| `deployment-template.md` | Runbook | `docs/05-guides/deployment.md` |
| `ci-cd-pipeline-template.md` | Pipeline spec | `docs/05-guides/ci-cd-pipeline.md` |
| `environment-matrix-template.md` | Env parity | `docs/05-guides/environment-matrix.md` |
| `observability-template.md` | Monitoring | `docs/05-guides/observability.md` |
| `disaster-recovery-template.md` | DR plan | `docs/05-guides/disaster-recovery.md` |
| `incident-template.md` | Incident report | `docs/06-reports/incidents/` |
