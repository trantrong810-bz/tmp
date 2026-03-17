# Deployment Runbook

<!-- Date: {date} | Version: {version} -->

| Field | Value |
|-------|-------|
| **Version** | {release_version} |
| **Date** | {deploy_date} |
| **Environment** | Staging / Production |
| **Deployer** | {deployer} |
| **Approver** | {approver} |

---

## Pre-Deployment Checklist

| # | Check | Status |
|---|-------|--------|
| 1 | All tests pass on CI | ☐ |
| 2 | Code review approved | ☐ |
| 3 | Security scan clean | ☐ |
| 4 | DB migration tested on staging | ☐ |
| 5 | Rollback plan documented | ☐ |
| 6 | Stakeholders notified | ☐ |
| 7 | Monitoring dashboards ready | ☐ |

---

## Deployment Steps

| # | Step | Command / Action | Verify |
|---|------|-----------------|--------|
| 1 | Backup database | `{backup_command}` | Backup file exists |
| 2 | Deploy to staging | `{deploy_staging}` | Health check OK |
| 3 | Run smoke tests | `{smoke_test}` | All pass |
| 4 | Deploy to production | `{deploy_prod}` | Health check OK |
| 5 | Run production smoke | `{smoke_test}` | All pass |
| 6 | Monitor for 30 min | Dashboard | No errors |

---

## Rollback Plan

| Trigger | Action | Time |
|---------|--------|------|
| Health check fails | Revert deployment | < 5 min |
| Error rate > 1% | Revert deployment | < 5 min |
| DB migration fails | Rollback changeset | < 10 min |

### Rollback Steps
1. {rollback_step_1}
2. {rollback_step_2}
3. Verify rollback: {verification}

---

## Post-Deployment

| # | Check | Status |
|---|-------|--------|
| 1 | Health endpoints responding | ☐ |
| 2 | Key user flows working | ☐ |
| 3 | Error rate normal | ☐ |
| 4 | Performance normal | ☐ |
| 5 | Stakeholders notified of completion | ☐ |

---

## Changes in this Release

| Type | Description | Ticket |
|------|-------------|--------|
| Feature | {description} | {ticket_id} |
| Bugfix | {description} | {ticket_id} |
| Migration | {description} | {changeset} |
