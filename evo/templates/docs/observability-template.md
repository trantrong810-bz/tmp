# Observability & Monitoring Strategy

<!-- 
  Three pillars: Metrics, Logs, Traces
  Version: {version} | Date: {date}
-->

| Field | Value |
|-------|-------|
| **Document ID** | OBS-{project}-{version} |
| **Version** | {version} |
| **Date** | {date} |

---

## 1. Monitoring Architecture

```
Application → Metrics  → {Prometheus / CloudWatch / Datadog} → Dashboards
           → Logs     → {ELK / CloudWatch Logs / Loki}      → Search
           → Traces   → {Jaeger / Zipkin / AWS X-Ray}        → Analysis
           → Alerts   → {PagerDuty / OpsGenie / Slack}       → On-call
```

---

## 2. Key Metrics (RED + USE)

### Application Metrics (RED Method)

| Metric | Description | Alert Threshold |
|--------|------------|-----------------|
| **Rate** | Requests per second | < {N} rps (⚠️ drop) |
| **Errors** | Error rate (5xx/total) | > 1% → ⚠️, > 5% → 🔴 |
| **Duration** | Response time p50/p95/p99 | p95 > 500ms → ⚠️, p99 > 2s → 🔴 |

### Infrastructure Metrics (USE Method)

| Resource | Utilization | Saturation | Errors |
|----------|------------|-----------|--------|
| CPU | > 80% → ⚠️ | Queue depth | — |
| Memory | > 85% → ⚠️ | Swap usage | OOM kills |
| Disk | > 90% → 🔴 | I/O wait | Read/write errors |
| Network | > 70% → ⚠️ | Connection queue | Timeouts |
| DB connections | > 80% pool → ⚠️ | Wait time | Deadlocks |

### Business Metrics

| Metric | Description | Alert |
|--------|------------|-------|
| {login_rate} | Logins per hour | Drop > 50% → 🔴 |
| {order_rate} | Orders per hour | Drop > 30% → 🔴 |
| {api_latency} | Critical API p95 | > {threshold} → ⚠️ |

---

## 3. Logging Strategy

### Log Levels

| Level | Usage | Example |
|-------|-------|---------|
| ERROR | Unexpected failures requiring attention | Exception in payment processing |
| WARN | Recoverable issues, degraded performance | Retry succeeded after 2 attempts |
| INFO | Business events, state transitions | Order #123 created, User logged in |
| DEBUG | Detailed diagnostic (dev/staging only) | SQL query, request/response body |

### Structured Logging Format

```json
{
  "timestamp": "2026-03-17T12:00:00Z",
  "level": "ERROR",
  "service": "{service_name}",
  "traceId": "{trace_id}",
  "spanId": "{span_id}",
  "module": "{module_name}",
  "message": "{message}",
  "context": { "userId": "123", "orderId": "456" },
  "error": { "type": "PaymentException", "message": "..." }
}
```

### Log Retention

| Environment | Retention | Storage |
|------------|-----------|---------|
| Production | 90 days (hot) + 1 year (cold) | {storage} |
| Staging | 30 days | {storage} |
| Development | 7 days | Local |

---

## 4. Distributed Tracing

| Aspect | Configuration |
|--------|-------------|
| Propagation | W3C TraceContext |
| Sampling rate | 100% (errors), {10}% (success) |
| Key spans | HTTP in/out, DB queries, message publish/consume |

---

## 5. Dashboards

| Dashboard | Purpose | Key Panels |
|-----------|---------|-----------|
| Overview | System health at glance | RED metrics, uptime, error rate |
| Per-Service | Deep dive into service | Latency distribution, top errors, throughput |
| Database | DB performance | Query time, connections, slow queries, locks |
| Business | Business KPIs | User activity, transaction volume, revenue |
| Infrastructure | Server/container health | CPU, memory, disk, network |

---

## 6. Alerting Rules

| Severity | Response time | Notification | Escalation |
|----------|-------------|-------------|-----------|
| 🔴 P1 Critical | ≤ 15 min | PagerDuty + Phone | → Tech Lead (30min) → CTO (1h) |
| 🟠 P2 High | ≤ 1 hour | Slack + PagerDuty | → Tech Lead (2h) |
| 🟡 P3 Medium | ≤ 4 hours | Slack | → Team (next standup) |
| 🟢 P4 Low | Next business day | Email | — |

### Alert Anti-patterns to Avoid
- ❌ Alert on every single error (use rate-based)
- ❌ Alert without actionable runbook
- ❌ Alert on metrics with no owner
- ❌ More than 5 P1 alerts per week (alert fatigue)

---

## 7. On-Call

| Aspect | Policy |
|--------|--------|
| Rotation | Weekly, {N} engineers |
| Handoff | Friday 10:00 AM → Friday 10:00 AM |
| Escalation | P1 unacked 15min → secondary → tech lead |
| Compensation | {policy} |
| Runbook required | Every alert must link to runbook |

---

## 8. Health Endpoints

| Endpoint | Purpose | Expected |
|----------|---------|----------|
| `GET /actuator/health` | Liveness probe | `{"status":"UP"}` |
| `GET /actuator/health/readiness` | Readiness probe | `{"status":"UP"}` |
| `GET /actuator/info` | Version info | Build version, git hash |
| `GET /actuator/prometheus` | Metrics export | Prometheus format |
