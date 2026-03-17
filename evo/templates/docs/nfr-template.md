# Non-Functional Requirements (NFR)

<!-- 
  Template based on ISO/IEC 25010:2023 (Quality Model)
  Version: {version} | Date: {date}
-->

| Field | Value |
|-------|-------|
| **Document ID** | NFR-{project}-{version} |
| **Project** | {project_name} |
| **Version** | {version} |
| **Status** | Draft / Approved |
| **Date** | {date} |

---

## 1. Performance

| ID | Requirement | Target | Measurement |
|----|------------|--------|-------------|
| NFR-P01 | API response time (p95) | < 200ms | Load test (Gatling) |
| NFR-P02 | Page load time | < 2s | Lighthouse |
| NFR-P03 | Concurrent users | {N} | Load test |
| NFR-P04 | Database query time | < 50ms | APM monitoring |

## 2. Security

| ID | Requirement | Standard | Verification |
|----|------------|----------|-------------|
| NFR-S01 | Authentication | OAuth2 / JWT | Pen test |
| NFR-S02 | Data encryption at rest | AES-256 | Audit |
| NFR-S03 | Data encryption in transit | TLS 1.3 | SSL scan |
| NFR-S04 | Input validation | OWASP Top 10 | SAST/DAST |
| NFR-S05 | Audit logging | Immutable logs | Review |

## 3. Reliability

| ID | Requirement | Target | Measurement |
|----|------------|--------|-------------|
| NFR-R01 | Uptime SLA | {99.9%} | Monitoring |
| NFR-R02 | Recovery Time Objective (RTO) | {time} | DR drill |
| NFR-R03 | Recovery Point Objective (RPO) | {time} | Backup test |
| NFR-R04 | Error rate | < 0.1% | APM |

## 4. Scalability

| ID | Requirement | Target | Strategy |
|----|------------|--------|---------|
| NFR-SC01 | Horizontal scaling | {N} instances | K8s HPA |
| NFR-SC02 | Data growth | {N} GB/year | Archival policy |
| NFR-SC03 | Peak load | {N}x normal | Auto-scaling |

## 5. Maintainability

| ID | Requirement | Target | Method |
|----|------------|--------|--------|
| NFR-M01 | Code coverage | > 80% | CI gate |
| NFR-M02 | Technical debt ratio | < 5% | SonarQube |
| NFR-M03 | Build time | < 5 min | CI metrics |
| NFR-M04 | Deployment frequency | {cadence} | CD pipeline |

## 6. Usability

| ID | Requirement | Target | Method |
|----|------------|--------|--------|
| NFR-U01 | Accessibility | WCAG 2.1 AA | Axe audit |
| NFR-U02 | Browser support | {browsers} | E2E tests |
| NFR-U03 | Mobile responsive | {breakpoints} | Visual test |

## 7. Compliance

| ID | Requirement | Regulation | Evidence |
|----|------------|-----------|---------|
| NFR-C01 | {requirement} | {regulation} | {evidence} |

---

## Traceability

| NFR ID | Related FR | SRS Section |
|--------|-----------|-------------|
| NFR-P01 | FR-{NNN} | SRS §3.2 |
