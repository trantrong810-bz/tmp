# Change Request

<!-- 
  Based on ITIL Change Management
  Date: {date}
-->

| Field | Value |
|-------|-------|
| **Change ID** | CR-{YYYY}-{NNN} |
| **Type** | Standard / Normal / Emergency |
| **Priority** | Critical / High / Medium / Low |
| **Status** | Proposed / Approved / In Progress / Completed / Rejected |
| **Requestor** | {name} |
| **Date** | {date} |

---

## 1. Change Description

### What is being changed
{description}

### Why (Business Justification)
{business_reason}

### Related documents
- Story: `docs/04-planning/stories/{story}.md`
- SRS requirement: FR-{NNN}
- ADR: `docs/03-architecture/adr/{adr}.md`

---

## 2. Impact Analysis

| Dimension | Impact | Detail |
|-----------|--------|--------|
| Modules affected | {list} | {which_modules} |
| APIs changed | {count} | Breaking: {yes/no} |
| Database schema | {yes/no} | Migration: {changeset} |
| External integrations | {count} | {which_systems} |
| Users impacted | {count} | {during_deployment} |
| Performance impact | {assessment} | {detail} |
| Security impact | {assessment} | {detail} |

### Risk Assessment

| Risk | Probability | Impact | Mitigation |
|------|------------|--------|-----------|
| {risk} | High/Med/Low | High/Med/Low | {mitigation} |

---

## 3. Implementation Plan

| # | Step | Owner | ETA | Verify |
|---|------|-------|-----|--------|
| 1 | {step} | {person} | {date} | {how} |

### Rollback Plan
{rollback_steps}

---

## 4. Testing Requirements

| Test Type | Scope | Status |
|-----------|-------|--------|
| Unit tests | {scope} | ☐ |
| Integration tests | {scope} | ☐ |
| Performance test | {if_needed} | ☐ |
| Security scan | {scope} | ☐ |
| UAT | {scope} | ☐ |

---

## 5. Approvals

| Role | Name | Decision | Date |
|------|------|----------|------|
| Tech Lead | {name} | Approve / Reject | {date} |
| QA Lead | {name} | Approve / Reject | {date} |
| Product Owner | {name} | Approve / Reject | {date} |
| Security (if applicable) | {name} | Approve / Reject | {date} |

---

## 6. Post-Implementation Review

| Check | Result | Notes |
|-------|--------|-------|
| Deployed successfully | ☐ | |
| Smoke tests pass | ☐ | |
| No regression | ☐ | |
| Monitoring normal | ☐ | |
| Stakeholders notified | ☐ | |
