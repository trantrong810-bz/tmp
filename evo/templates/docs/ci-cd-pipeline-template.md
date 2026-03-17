# CI/CD Pipeline Specification

<!-- 
  Version: {version} | Date: {date}
-->

| Field | Value |
|-------|-------|
| **Document ID** | CICD-{project}-{version} |
| **Platform** | {GitHub Actions / GitLab CI / Jenkins} |
| **Version** | {version} |
| **Date** | {date} |

---

## 1. Pipeline Architecture

```
Commit → Build → Test → Quality Gate → Security → Staging → Production
```

### Stages

| Stage | Trigger | Duration Target | Blocker if fail |
|-------|---------|----------------|-----------------|
| Build | Every push | < 3 min | ✅ Yes |
| Unit Tests | Every push | < 5 min | ✅ Yes |
| Integration Tests | PR / merge | < 10 min | ✅ Yes |
| Quality Gate | PR / merge | < 2 min | ✅ Yes |
| Security Scan | PR / merge | < 5 min | ✅ Critical only |
| Deploy Staging | Merge to develop | < 5 min | ✅ Yes |
| Smoke Tests Staging | After staging deploy | < 3 min | ✅ Yes |
| Deploy Production | Merge to main (manual gate) | < 5 min | ✅ Yes |
| Smoke Tests Prod | After prod deploy | < 3 min | ✅ Yes |

---

## 2. Build Stage

```yaml
steps:
  - checkout
  - cache: {dependencies}
  - build: {build_command}            # ./mvnw.cmd package -DskipTests / npm run build
  - archive: {artifact_path}
```

| Check | Criteria | Action on fail |
|-------|----------|---------------|
| Compilation | 0 errors | Block merge |
| Warnings | < {N} new warnings | Warn |
| Build time | < {N} minutes | Alert |

---

## 3. Test Stage

### Unit Tests
```yaml
command: {test_command}               # ./mvnw.cmd test / npm test
coverage_tool: {jacoco / istanbul}
coverage_threshold: {80}%
```

### Integration Tests
```yaml
command: {integration_command}        # ./mvnw.cmd verify -P integration
services:
  - database: {postgres:16}
  - cache: {redis:7}
```

### Architecture Tests (Java)
```yaml
command: ./mvnw.cmd test -pl :mes-app -Dtest=*ArchTest
enforcement: module boundaries, layer rules, naming conventions
```

| Metric | Threshold | Blocker |
|--------|-----------|---------|
| Code coverage | ≥ {80}% | ✅ Yes |
| New code coverage | ≥ {80}% | ✅ Yes |
| Test pass rate | 100% | ✅ Yes |
| Flaky test rate | 0% | ⚠️ Warn |

---

## 4. Quality Gate

| Check | Tool | Threshold |
|-------|------|-----------|
| Code duplication | {SonarQube / PMD} | < 3% |
| Technical debt ratio | SonarQube | < 5% |
| Code smells | SonarQube | 0 new blockers |
| Cyclomatic complexity | SonarQube | < 15 per method |
| Static analysis | {Checkstyle / ESLint} | 0 errors |

---

## 5. Security Gate

| Check | Tool | Threshold |
|-------|------|-----------|
| SAST | {SonarQube / Checkmarx / Semgrep} | 0 critical, 0 high |
| Dependency scan | {OWASP Dep Check / Snyk / npm audit} | 0 critical |
| Secret scan | {GitLeaks / TruffleHog} | 0 findings |
| Container scan | {Trivy} | 0 critical (if containerized) |
| License check | {FOSSA / license-checker} | No copyleft in prod deps |

---

## 6. Deployment Configuration

### Environment Matrix

| Environment | Branch | Auto-deploy | Approval |
|------------|--------|-------------|----------|
| Development | feature/* | No | — |
| Staging | develop | ✅ Auto | — |
| Production | main | Manual trigger | ✅ Required (2 reviewers) |

### Deploy Strategy

| Strategy | Environment | Rollback time |
|----------|-------------|--------------|
| {Blue-Green / Rolling / Canary} | Production | < {N} min |
| Direct | Staging | Immediate |

---

## 7. Notifications

| Event | Channel | Recipients |
|-------|---------|-----------|
| Build failure | {Slack / Teams / Email} | Committer + team |
| Security finding | {Slack / Teams} | Security + tech lead |
| Deploy success | {Slack / Teams} | Team |
| Deploy failure | {PagerDuty / Slack} | DevOps + tech lead |

---

## 8. Pipeline Maintenance

| Task | Frequency |
|------|-----------|
| Update CI runner | Monthly |
| Review security tools | Quarterly |
| Audit pipeline permissions | Quarterly |
| Review threshold adjustments | Per sprint |
