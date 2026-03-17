# Security Audit Report

<!-- 
  Based on OWASP methodology
  Date: {date}
-->

| Field | Value |
|-------|-------|
| **Audit ID** | SA-{YYYY-MM-DD} |
| **Scope** | {modules_audited} |
| **Auditor** | {auditor} |
| **Date** | {date} |
| **Standard** | OWASP Top 10 (2025) |

---

## Executive Summary

| Risk Level | Count | Previous | Trend |
|-----------|-------|----------|-------|
| 🔴 Critical | {N} | {N} | ↑ ↓ → |
| 🟠 High | {N} | {N} | ↑ ↓ → |
| 🟡 Medium | {N} | {N} | ↑ ↓ → |
| 🟢 Low | {N} | {N} | ↑ ↓ → |

---

## Findings

### SA-001: {vulnerability_title}
| Attribute | Value |
|-----------|-------|
| **Severity** | Critical / High / Medium / Low |
| **OWASP Category** | {A01-A10} |
| **Location** | `{file:line}` |
| **Description** | {what_is_wrong} |
| **Impact** | {what_could_happen} |
| **Remediation** | {how_to_fix} |
| **Status** | Open / Fixed / Accepted Risk |

---

## OWASP Top 10 Coverage

| # | Category | Status | Notes |
|---|----------|--------|-------|
| A01 | Broken Access Control | ✅ / ⚠️ / ❌ | {notes} |
| A02 | Cryptographic Failures | ✅ / ⚠️ / ❌ | {notes} |
| A03 | Injection | ✅ / ⚠️ / ❌ | {notes} |
| A04 | Insecure Design | ✅ / ⚠️ / ❌ | {notes} |
| A05 | Security Misconfiguration | ✅ / ⚠️ / ❌ | {notes} |
| A06 | Vulnerable Components | ✅ / ⚠️ / ❌ | {notes} |
| A07 | Auth Failures | ✅ / ⚠️ / ❌ | {notes} |
| A08 | Data Integrity Failures | ✅ / ⚠️ / ❌ | {notes} |
| A09 | Logging Failures | ✅ / ⚠️ / ❌ | {notes} |
| A10 | SSRF | ✅ / ⚠️ / ❌ | {notes} |

---

## Recommendations

| Priority | Action | Deadline |
|----------|--------|----------|
| P0 | {action} | {date} |
