# Project Context — Evo Trident

> This file is read by the AI agent at the START of every conversation.
> It defines project conventions, documentation structure, and CM rules.
> Source of truth: `evo/project-context.md` → synced to `.agent/project-context.md`

> **⚠️ CRITICAL FOR AI AGENTS:**
> When creating ANY document in `docs/`, ALWAYS:
> 1. Load the matching template from `evo/templates/docs/` FIRST
> 2. Read `evo/templates/docs/EXPORT-MAPPING.md` for section-by-section mapping
> 3. Include approval metadata in export header

---

## Tech Stack

Read `evo/evo-registry.yaml` for project type detection.

```yaml
primary_stack: java-spring
java_version: 21
spring_boot: 3.3+
build_tool: maven
database: postgresql
migration: liquibase
architecture: modular-monolith, DDD, hexagonal
testing: junit5, mockito, testcontainers, archunit
```

---

## Definition of Done (DoD)

Every story/feature is "done" when ALL pass:

| # | Check | Tool/Workflow |
|---|-------|-------------|
| 1 | All tests pass (new + existing, zero regression) | `/test` |
| 2 | Code coverage ≥ 80% (new code) | `/test coverage` |
| 3 | Build compiles clean | `./mvnw.cmd compile -q` |
| 4 | Code review approved (no 🔴 findings) | `/review` |
| 5 | Security scan clean | CI pipeline |
| 6 | Story AC verified (Given-When-Then) | manual + `/test` |
| 7 | Sprint-status updated | `/plan` |
| 8 | Docs updated (if applicable) | `/create`, `/architecture` |
| 9 | DOCUMENT-INDEX.md updated (if docs changed) | auto |

---

## Acceptance Criteria Format

All AC across SRS, stories, and test cases use **Given-When-Then**:

```
Given [precondition/context]
When [action/trigger]
Then [expected result/outcome]
```

---

## Documentation Structure

### Ownership Rules

| Owner | Workspace | Purpose |
|-------|-----------|---------| 
| **BMAD** | `_bmad-output/` | AI drafts (WIP) |
| **BMAD WDS** | `design-artifacts/` | UI/UX design specs |
| **Evo / Manual** | `docs/` | Approved, human-readable, stakeholder review |

### Smart Export Flow

```
BMAD creates draft → _bmad-output/ (AI format)
  → User reviews & approves ✅
  → Read EXPORT-MAPPING.md for section mapping
  → Transform + rewrite using evo/templates/docs/ (industry-standard)
  → Add approval metadata (who, when, evidence)
  → Save to docs/ (human-readable)
  → Update DOCUMENT-INDEX.md
  → Version-locked in git
```

Export is **rewrite**, not copy. Uses industry-standard templates.

### BMAD workspace (AI-managed)

```
_bmad-output/
├── planning-artifacts/              ← Brief, PRD, UX, Epics (BMAD format)
└── implementation-artifacts/        ← Sprint status, Stories
    └── stories/

design-artifacts/                    ← UI/UX pages, design system
```

### docs/ (Human-facing, industry-standard)

```
docs/
├── 00-project/                      ← Project overview (all roles)
│   ├── README.md                    ← Project introduction
│   ├── glossary.md                  ← Ubiquitous language (shared)
│   ├── team.md                      ← Team contacts, roles
│   └── conventions.md               ← Coding/naming conventions + DoD
│
├── 01-business/                     ← BA & Stakeholder review
│   ├── product-brief.md             ← from BMAD (product-brief-template.md)
│   ├── business-requirements.md     ← manual if needed
│   └── process-flows/               ← BPMN, flowcharts
│
├── 02-requirements/                 ← PM & Team review
│   ├── srs.md                       ← from BMAD PRD (srs-template.md, IEEE 830)
│   ├── ux-design.md                 ← from BMAD (rewritten)
│   └── nfr.md                       ← ISO 25010 quality model
│
├── 03-architecture/                 ← Tech Lead & Architect review
│   ├── ARCHITECTURE.md              ← ISO 42010 + arc42
│   ├── domain-model.md              ← DDD bounded contexts, aggregates
│   ├── database-design.md           ← ERD, schema, indexes
│   ├── api-design.md                ← REST/OpenAPI contracts
│   └── adr/                         ← Architecture Decision Records (Nygard)
│
├── 04-planning/                     ← PM & SM review
│   ├── epics.md                     ← from BMAD (FR traceability)
│   ├── sprint-status.yaml           ← from BMAD
│   └── stories/                     ← from BMAD
│
├── 05-guides/                       ← Ops & Dev team
│   ├── setup.md                     ← Developer onboarding
│   ├── deployment.md                ← Deployment runbook
│   ├── ci-cd-pipeline.md            ← Pipeline specification
│   ├── environment-matrix.md        ← Dev/Staging/Prod parity
│   ├── observability.md             ← Monitoring, logging, tracing
│   ├── disaster-recovery.md         ← DR plan (ISO 22301)
│   └── configuration-management.md  ← CM rules
│
├── 06-reports/                      ← QA & Lead review
│   ├── code-reviews/                ← /review output
│   ├── security-audits/             ← /orchestrate security
│   ├── performance-audits/          ← /orchestrate performance, /test perf
│   ├── test-reports/                ← /test report
│   ├── incidents/                   ← /incident postmortem
│   ├── change-requests/             ← /enhance (breaking changes)
│   └── retrospectives/             ← /plan retro
│
└── DOCUMENT-INDEX.md                ← Auto-generated index
```

### Industry-Standard Templates

Templates in `evo/templates/docs/` (25 total):

| Template | Standard | Workflow | docs/ path |
|----------|----------|---------|-----------|
| **Discovery & Requirements** | | | |
| `product-brief-template.md` | Structured | `/create brief` | `01-business/` |
| `srs-template.md` | IEEE 830 / ISO 29148 | `/create prd` | `02-requirements/` |
| `ux-design-template.md` | WCAG 2.1 AA | `/create ux` | `02-requirements/` |
| `nfr-template.md` | ISO 25010 | `/architecture` | `02-requirements/` |
| **Architecture** | | | |
| `architecture-template.md` | ISO 42010 + arc42 | `/architecture` | `03-architecture/` |
| `domain-model-template.md` | DDD conventions | `/architecture` | `03-architecture/` |
| `database-design-template.md` | DB standards | `/architecture` | `03-architecture/` |
| `api-design-template.md` | OpenAPI / REST / RFC 7807 | `/architecture` | `03-architecture/` |
| `adr-template.md` | Michael Nygard | `/architecture` | `03-architecture/adr/` |
| **Planning** | | | |
| `epic-template.md` | FR traceability | `/create epics` | `04-planning/` |
| **Operations** | | | |
| `ci-cd-pipeline-template.md` | CI/CD best practices | `/deploy` | `05-guides/` |
| `deployment-template.md` | Runbook format | `/deploy` | `05-guides/` |
| `environment-matrix-template.md` | Env parity | `/deploy` | `05-guides/` |
| `observability-template.md` | RED/USE + 3 pillars | `/deploy` | `05-guides/` |
| `disaster-recovery-template.md` | ISO 22301 | `/deploy` | `05-guides/` |
| **Reports** | | | |
| `code-review-template.md` | 3-layer adversarial | `/review` | `06-reports/code-reviews/` |
| `security-audit-template.md` | OWASP Top 10 | `/orchestrate` | `06-reports/security-audits/` |
| `test-report-template.md` | Coverage + regression | `/test report` | `06-reports/test-reports/` |
| `incident-template.md` | PagerDuty + Google SRE | `/incident` | `06-reports/incidents/` |
| `change-request-template.md` | ITIL Change Mgmt | `/enhance` | `06-reports/change-requests/` |
| `retrospective-template.md` | Agile retro | `/plan retro` | `06-reports/retrospectives/` |
| `release-notes-template.md` | Customer-facing | `/deploy` | per release |
| **Shared** | | | |
| `glossary-template.md` | DDD ubiquitous lang | `/architecture` | `00-project/` |
| `document-index-template.md` | Index | auto | `DOCUMENT-INDEX.md` |
| `EXPORT-MAPPING.md` | Section mapping | `/create` | — (reference only) |

### Document version tracking

Every exported document has a header:
```
<!-- 
  Document ID: {TYPE}-{PROJECT}-{VERSION}
  Exported: {date} | Source: _bmad-output/{path} | Version: {N}
  Status: Draft / In Review / Approved
  Approved-by: {name} | Approval-date: {date}
  Template: evo/templates/docs/{template} | Template-version: 1.0
-->
```

---

## Configuration Management Rules

### Source Code
- Branch: `main` → `develop` → `feature/*` | `bugfix/*` | `hotfix/*`
- **PR naming**: `[FR-NNN] description` or `[STORY-X-Y] description` for traceability
- All code changes verified before merge (`sp-verification-before-completion`)
- Breaking changes require Change Request (`change-request-template.md`)

### Application Config
- Profile-based: `application.yml` + `application-{env}.yml`
- Secrets: NEVER in code → env vars or vault
- Feature flags: `app.features.*` in config, not code branches
- Environment parity: documented in `docs/05-guides/environment-matrix.md`

### Database
- Liquibase changesets: sequential, immutable after release
- Schema naming: `{prefix}_{module}` (e.g., `mes_inv`)
- Every schema change = new changeset file
- Migration tested on staging before production

### Dependencies
- Cross-module: API JAR only (compile-time enforce)
- External: version pinning in parent POM `dependencyManagement`
- Dependency scan: OWASP Dependency Check in CI

### CI/CD
- Pipeline: documented in `docs/05-guides/ci-cd-pipeline.md`
- Quality gates: coverage ≥ 80%, 0 critical security findings, 0 test failures
- Deploy strategy: staging (auto) → UAT pass → production (manual gate + 2 reviewers)
- **UAT gate**: Staging deploy → QA/PO verify key flows → ✅ approve → Production

### Testing
- **Regression strategy:**
  - Hotfix → full suite (all modules)
  - Feature branch → module suite + integration
  - PR merge → full suite + E2E
  - Release candidate → full suite + E2E + perf
- **Test reports**: `/test report` → `docs/06-reports/test-reports/`

### Monitoring
- Observability: documented in `docs/05-guides/observability.md`
- Health endpoints: `/actuator/health`, `/actuator/prometheus`
- Alerting: severity P1-P4 with escalation policy

### Incident Response
- Process: `/incident` workflow
- Postmortem: `docs/06-reports/incidents/INC-{YYYY}-{NNN}.md`
- DR plan: `docs/05-guides/disaster-recovery.md`

### Documentation
- BMAD drafts: `_bmad-output/` (AI workspace)
- Approved docs: `docs/` (human-facing, industry-standard)
- Export = transform + rewrite using templates + EXPORT-MAPPING.md
- **Revision history**: MANDATORY update on every document edit
- Living docs: ARCHITECTURE.md, domain-model.md updated with code
- Immutable after approval: SRS, ADR
- Rule: edit approved doc → go back to BMAD → new draft → re-approve → re-export
- **Template versioning**: all templates include `<!-- Template version: 1.0 -->` header

---

## Naming Conventions

| Item | Convention | Example |
|------|-----------|---------| 
| Module | `mes-{domain}` | `mes-inv`, `mes-prd` |
| API JAR | `mes-{domain}-api` | `mes-inv-api` |
| Package | `com.company.mes.{domain}` | `com.company.mes.inventory` |
| DB schema | `mes_{domain}` | `mes_inv` |
| Liquibase | `V{NNN}__{description}.yaml` | `V003__add_batch.yaml` |
| Story file | `story-{epic}-{seq}-{name}.md` | `story-1-1-inventory.md` |
| ADR | `{NNN}-{decision}.md` | `001-modular-monolith.md` |
| PR title | `[FR-NNN] description` | `[FR-012] Add batch tracking` |
| Report | `YYYY-MM-DD-{scope}.md` | `2026-03-17-security.md` |
| Doc ID | `{TYPE}-{project}-{version}` | `SRS-MES-1.0` |
| Incident | `INC-{YYYY}-{NNN}` | `INC-2026-001` |
| Change Request | `CR-{YYYY}-{NNN}` | `CR-2026-015` |
