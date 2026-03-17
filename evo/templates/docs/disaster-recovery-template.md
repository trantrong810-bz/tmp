# Disaster Recovery Plan

<!-- 
  Based on ISO 22301:2019 (Business Continuity)
  Version: {version} | Date: {date}
-->

| Field | Value |
|-------|-------|
| **Document ID** | DRP-{project}-{version} |
| **RTO** | {Recovery Time Objective} |
| **RPO** | {Recovery Point Objective} |
| **Version** | {version} |
| **Last DR drill** | {date} |
| **Next DR drill** | {date} |
| **Date** | {date} |

---

## 1. Business Impact Analysis

| System/Service | Business Impact | Max Downtime | RPO | Priority |
|----------------|----------------|-------------|-----|----------|
| {service} | {impact} | {time} | {time} | P1/P2/P3 |

---

## 2. Recovery Objectives

| Objective | Target | Current Capability |
|-----------|--------|--------------------|
| **RTO** (time to restore) | {target} | {actual} |
| **RPO** (max data loss) | {target} | {actual} |
| **MTTR** (mean time to repair) | {target} | {actual} |

---

## 3. Backup Strategy

| Data | Method | Frequency | Retention | Location | Verified |
|------|--------|-----------|-----------|----------|---------|
| Database | {pg_dump / WAL archiving} | {frequency} | {retention} | {location} | {last_test_date} |
| File storage | {S3 replication / rsync} | {frequency} | {retention} | {location} | {last_test_date} |
| Configuration | Git | On every change | Permanent | {remote_repo} | — |
| Secrets | {Vault backup} | {frequency} | {retention} | {location} | {last_test_date} |

### Backup Verification
- ✅ Automated restore test: {frequency}
- ✅ Verify data integrity after restore
- ✅ Measure restore time (must be < RTO)

---

## 4. Disaster Scenarios

### Scenario 1: Database Failure
| Aspect | Detail |
|--------|--------|
| Trigger | DB crash, corruption, accidental delete |
| Detection | Health check fails, alerting fires |
| Response | Failover to replica → restore from backup if needed |
| Team | DBA + DevOps + Tech Lead |

| # | Step | Command/Action | ETA |
|---|------|---------------|-----|
| 1 | Verify failure | Check DB health, connection pool | 2 min |
| 2 | Failover to replica | {failover_command} | 5 min |
| 3 | Verify data integrity | Run consistency checks | 10 min |
| 4 | Restore from backup (if needed) | {restore_command} | {time} |
| 5 | Verify application | Smoke tests | 5 min |

### Scenario 2: Full Infrastructure Failure
| # | Step | Action | ETA |
|---|------|--------|-----|
| 1 | Spin up new infrastructure | {IaC command} | {time} |
| 2 | Restore database | From latest backup | {time} |
| 3 | Deploy application | From latest artifact | {time} |
| 4 | DNS failover | Update DNS records | {time} |
| 5 | Verify | Full smoke test suite | {time} |

### Scenario 3: Security Breach
| # | Step | Action | Owner |
|---|------|--------|-------|
| 1 | Isolate affected systems | Network isolation | DevOps |
| 2 | Preserve evidence | Snapshot logs, DB state | Security |
| 3 | Assess damage | Review access logs | Security |
| 4 | Remediate | Rotate secrets, patch vuln | DevOps + Dev |
| 5 | Restore from known-good state | Verified backup | DevOps |
| 6 | Notify stakeholders | Per legal requirements | Management |

---

## 5. Communication Plan

| Audience | Channel | Who notifies | When |
|----------|---------|-------------|------|
| Engineering team | {Slack / Teams} | Incident Commander | Immediately |
| Management | Email + Phone | Tech Lead | 30 min |
| Customers | Status page | Communications | 1 hour |
| Legal/Compliance | Email | Management | Per requirement |

---

## 6. DR Drill Schedule

| Drill Type | Frequency | Last | Next | Result |
|-----------|-----------|------|------|--------|
| Backup restore | Monthly | {date} | {date} | Pass/Fail |
| Failover test | Quarterly | {date} | {date} | Pass/Fail |
| Full DR simulation | Annually | {date} | {date} | Pass/Fail |
| Tabletop exercise | Semi-annual | {date} | {date} | — |

---

## 7. Contacts

| Role | Name | Phone | Email |
|------|------|-------|-------|
| Incident Commander | {name} | {phone} | {email} |
| DBA on-call | {name} | {phone} | {email} |
| DevOps on-call | {name} | {phone} | {email} |
| Cloud provider support | — | {phone} | {case_url} |
