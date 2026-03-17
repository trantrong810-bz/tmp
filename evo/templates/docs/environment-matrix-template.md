# Environment Matrix

<!-- 
  Version: {version} | Date: {date}
-->

| Field | Value |
|-------|-------|
| **Document ID** | ENV-{project}-{version} |
| **Version** | {version} |
| **Date** | {date} |

---

## 1. Environment Overview

| Environment | Purpose | Branch | URL | Auto-Deploy |
|------------|---------|--------|-----|-------------|
| Local | Development | feature/* | localhost:{port} | — |
| Dev | Integration | develop | {url} | ✅ On merge |
| Staging | Pre-prod testing | release/* | {url} | ✅ On merge |
| Production | Live users | main | {url} | Manual gate |

---

## 2. Infrastructure Parity

| Component | Local | Dev | Staging | Production |
|-----------|-------|-----|---------|-----------|
| **Application** | | | | |
| Java version | {ver} | {ver} | {ver} | {ver} |
| JVM args | {args} | {args} | {args} | {args} |
| Instances | 1 | {N} | {N} | {N} |
| **Database** | | | | |
| PostgreSQL ver | {ver} | {ver} | {ver} | {ver} |
| Schema | Auto (Liquibase) | Auto | Auto | Manual approve |
| Data | Seed data | Synthetic | Production-like | Live |
| **Cache** | | | | |
| Redis ver | {ver} | {ver} | {ver} | {ver} |
| **Messaging** | | | | |
| {Kafka/RabbitMQ} | {ver} | {ver} | {ver} | {ver} |
| **External Services** | | | | |
| {service} | Mock | Sandbox | Sandbox | Live |

### Parity Rules
- ✅ Same major version across ALL environments
- ✅ Same Liquibase changesets (no env-specific SQL)
- ✅ Same container images (staging = prod image)
- ❌ NEVER use H2 in staging/prod even for testing

---

## 3. Configuration per Environment

| Config | Local | Dev | Staging | Production |
|--------|-------|-----|---------|-----------|
| `spring.profiles.active` | local | dev | staging | prod |
| Log level | DEBUG | DEBUG | INFO | WARN |
| DB pool size | 5 | 10 | {N} | {N} |
| Rate limiting | Off | Off | On | On |
| Feature flags | All on | Config | Config | Config |

### Secrets Management

| Secret | Local | Dev/Staging | Production |
|--------|-------|-------------|-----------|
| DB credentials | `.env` (gitignored) | {Vault / K8s secrets} | {Vault / K8s secrets} |
| API keys | `.env` (gitignored) | {Vault / K8s secrets} | {Vault / K8s secrets} |
| JWT secret | Fixed (dev) | Rotated weekly | Rotated weekly |
| TLS certs | Self-signed | Let's Encrypt | {CA cert provider} |

---

## 4. Promotion Rules

| From → To | Gate | Approval |
|-----------|------|----------|
| Local → Dev | PR approved + CI pass | 1 reviewer |
| Dev → Staging | All tests pass + security scan | Tech lead |
| Staging → Prod | UAT pass + smoke tests | 2 reviewers + PO |

### Promotion Checklist

| # | Check | Dev→Staging | Staging→Prod |
|---|-------|-------------|-------------|
| 1 | All CI stages pass | ✅ Required | ✅ Required |
| 2 | Performance test | ☐ Optional | ✅ Required |
| 3 | Security scan clean | ✅ Required | ✅ Required |
| 4 | DB migration tested | ✅ Required | ✅ Required |
| 5 | Rollback tested | ☐ Optional | ✅ Required |
| 6 | Docs updated | ☐ Optional | ✅ Required |

---

## 5. Access Control

| Environment | Developer | Tech Lead | DevOps | PO |
|------------|-----------|-----------|--------|-----|
| Local | Full | Full | Full | — |
| Dev | Read + Deploy | Full | Full | Read |
| Staging | Read | Read + Deploy | Full | Read |
| Production | Read (restricted) | Read | Deploy | Read |
