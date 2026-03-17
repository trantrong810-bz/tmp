# BMAD → docs/ Export Mapping

> AI agents MUST read this file before transforming BMAD output to docs/.
> This defines the exact section-by-section mapping.

---

## PRD → SRS (IEEE 830)

| BMAD PRD Section | → SRS Section | Notes |
|-----------------|---------------|-------|
| Problem Statement | §1.1 Purpose | Rewrite as system purpose |
| Product Vision | §1.2 Scope | Define boundaries |
| Target Users | §2.3 User Classes | Add characteristics |
| User Stories / Features | §3.1 Functional Requirements | Convert each to FR-NNN with AC |
| Success Criteria / KPIs | §3.2 Non-Functional Requirements | Convert to NFR-NNN |
| Constraints | §2.5 Design and Implementation Constraints | Copy + expand |
| Assumptions | §2.6 Assumptions and Dependencies | Copy |
| — (generate) | §1.3 Definitions | → link to `00-project/glossary.md` |
| — (generate) | §1.4 References | → link to brief, architecture |
| — (generate) | Revision History table | Auto-fill version, date, author |
| — (generate) | Document ID header | `SRS-{project}-{version}` |

### FR Conversion Rule

```
BMAD User Story:
  "As a [role], I want to [action] so that [benefit]"

→ SRS FR:
  FR-001: [Action Title]
  - Priority: High/Medium/Low
  - Description: [expanded from story]
  - Acceptance Criteria:
    - Given [context] When [action] Then [result]
```

---

## Product Brief → Product Brief (docs/)

| BMAD Section | → Template Section |
|-------------|-------------------|
| Vision | §1 Vision |
| Problem | §2 Problem Statement |
| Users | §3 Target Users |
| Features | §4 Key Features (table format) |
| Metrics | §5 Success Metrics (table) |
| Risks | §6 Constraints & Risks (table) |
| Timeline | §7 Timeline (table) |

---

## UX Design → UX Design Spec

| BMAD Section | → Template Section |
|-------------|-------------------|
| User Flows | §2 User Flows (table + diagram) |
| Screens | §3 Screen Specifications (per screen) |
| Interactions | §4 Interaction Patterns |
| — (generate) | §1 User Personas |
| — (generate) | §5 Accessibility (WCAG) |

---

## Epics → Epics (docs/)

Add to each epic:
- Traceability: link to FR-NNN from SRS
- Priority rationale
- Dependencies between epics

---

## Stories → Stories (docs/)

Add to each story:
- FR reference: `Implements: FR-001, FR-003`
- AC format: Given-When-Then (standardized)
- Technical notes from architecture docs

---

## Common: Export Header

Every exported document MUST have:

```markdown
<!-- 
  Document ID: {TYPE}-{PROJECT}-{VERSION}
  Exported: {YYYY-MM-DD}
  Source: _bmad-output/{path}
  Version: {N}
  Status: Draft / In Review / Approved
  Approved-by: {name}
  Approval-date: {date}
  Template: evo/templates/docs/{template-name}
  Template-version: 1.0
-->
```
