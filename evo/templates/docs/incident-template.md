# Incident Report

<!-- 
  Template based on PagerDuty Incident Response + Google SRE
  Date: {date}
-->

| Field | Value |
|-------|-------|
| **Incident ID** | INC-{YYYY}-{NNN} |
| **Severity** | P1 / P2 / P3 / P4 |
| **Status** | Detected / Triaging / Mitigating / Resolved / Postmortem |
| **Detected** | {datetime} |
| **Resolved** | {datetime} |
| **Duration** | {duration} |
| **Impact** | {user/system impact} |
| **Incident Commander** | {name} |

---

## 1. Timeline

| Time | Event | Actor |
|------|-------|-------|
| {HH:MM} | Alert triggered: {alert_name} | Monitoring |
| {HH:MM} | Incident declared (P{N}) | {person} |
| {HH:MM} | Root cause identified | {person} |
| {HH:MM} | Fix deployed | {person} |
| {HH:MM} | Incident resolved | {person} |

---

## 2. Impact Assessment

| Dimension | Detail |
|-----------|--------|
| Users affected | {count / percentage} |
| Duration | {minutes/hours} |
| Revenue impact | {estimated / N/A} |
| Data loss | {none / detail} |
| SLA breach | {yes/no, which SLA} |

---

## 3. Root Cause

### What happened
{description_of_failure}

### Why it happened
{root_cause_analysis — use 5 Whys}

| # | Why | Answer |
|---|-----|--------|
| 1 | Why did {symptom}? | {because} |
| 2 | Why did {answer_1}? | {because} |
| 3 | Why did {answer_2}? | {because} |
| 4 | Why did {answer_3}? | {because} |
| 5 | Why did {answer_4}? | {root_cause} |

### Contributing Factors
- {factor_1}
- {factor_2}

---

## 4. Resolution

### Immediate Fix
{what_was_done_to_resolve}

### Verification
{how_resolution_was_verified}

---

## 5. Postmortem Action Items

| # | Action | Type | Owner | Deadline | Status |
|---|--------|------|-------|----------|--------|
| 1 | {action} | Prevention | {person} | {date} | Open |
| 2 | {action} | Detection | {person} | {date} | Open |
| 3 | {action} | Response | {person} | {date} | Open |

### Action Types
- **Prevention:** Stop it from happening again
- **Detection:** Detect it faster next time
- **Response:** Respond more effectively
- **Process:** Improve incident process itself

---

## 6. Lessons Learned

### What went well
- {positive_1}

### What went poorly
- {negative_1}

### Where we got lucky
- {lucky_1}

---

## 7. Severity Matrix (Reference)

| Severity | Criteria | Response | Examples |
|----------|----------|----------|---------|
| P1 Critical | Service down, data loss risk | 15 min ack, all-hands | DB crash, auth failure |
| P2 High | Major feature broken | 1 hour ack | Payments fail, search down |
| P3 Medium | Minor feature degraded | 4 hours ack | Slow reports, UI glitch |
| P4 Low | Cosmetic / non-urgent | Next business day | Typo, minor UI issue |
