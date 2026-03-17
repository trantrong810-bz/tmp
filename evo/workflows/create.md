---
description: Create new application or product. Wraps BMAD product lifecycle (brief → PRD → validate → architecture → epics).
---

# /create — Smart Product Creation

$ARGUMENTS

---

## Overview

BMAD runs independently in `_bmad-output/`. After each user approval gate, **transform and rewrite** to `docs/` using industry-standard templates for stakeholder review.

```
BMAD draft (_bmad-output/) → User approves → Transform to template → docs/ (human-readable)
```

---

## Full Lifecycle

### Step 1: Product Brief
```
Route: bmad-create-product-brief
Output: _bmad-output/planning-artifacts/product-brief.md
Gate: User approves ✅
Export: Transform to evo/templates/docs/product-brief-template.md
  → docs/01-business/product-brief.md
```

### Step 2: PRD → SRS
```
Route: bmad-create-prd
Output: _bmad-output/planning-artifacts/prd.md
Gate: bmad-validate-prd + User approves ✅
Export: Transform to evo/templates/docs/srs-template.md (IEEE 830)
  → docs/02-requirements/srs.md
  Sections: rewrite BMAD PRD into IEEE structure:
    - BMAD "Problem Statement" → SRS §1.1 Purpose
    - BMAD "User Stories" → SRS §3.1 Functional Requirements (FR-NNN format)
    - BMAD "Success Criteria" → SRS §3.2 Non-Functional Requirements
    - BMAD "Constraints" → SRS §2.5 Constraints
    Add: revision history, document ID, traceability references
```

### Step 3: UX Design (optional)
```
Route: bmad-create-ux-design
Output: _bmad-output/planning-artifacts/ux-design.md
Gate: User approves ✅
Export: Rewrite → docs/02-requirements/ux-design.md
  Add: document header, version, reference to SRS
```

### Step 4: Architecture
```
Route: /architecture workflow
Template: evo/templates/docs/architecture-template.md (ISO 42010 + arc42)
Output: docs/03-architecture/ARCHITECTURE.md (writes directly, no export needed)
Related: docs/03-architecture/domain-model.md (using domain-model-template.md)
Related: docs/03-architecture/database-design.md (using database-design-template.md)
Gate: bmad-check-implementation-readiness
```

### Step 5: Epics & Stories
```
Route: bmad-create-epics-and-stories
Output: _bmad-output/planning-artifacts/epics.md
Gate: User approves ✅
Export: Transform to evo/templates/docs/epic-template.md
  → docs/04-planning/epics.md
  Add: document header, FR traceability matrix (every FR from SRS mapped to epic/story)
```

### Step 6: Sprint Planning
```
Route: bmad-sprint-planning
Output: _bmad-output/implementation-artifacts/sprint-status.yaml
Export: Copy → docs/04-planning/sprint-status.yaml (YAML kept as-is)
```

---

## Smart Export Rules

> **CRITICAL:** Before transforming, read `evo/templates/docs/EXPORT-MAPPING.md` for exact section mapping.

Export is **transform + rewrite**, not copy:

1. **Read** approved BMAD artifact
2. **Load** matching template from `evo/templates/docs/`
3. **Read** `EXPORT-MAPPING.md` for section-by-section mapping
4. **Map** BMAD sections → template sections (per mapping doc)
5. **Rewrite** for human readability:
   - Add document header with approval info
   - Add/update revision history (MANDATORY on every edit)
   - Convert AI-style prose → structured sections with tables
   - Standardize AC format: Given-When-Then
   - Add cross-references to related documents
   - Add glossary reference → `docs/00-project/glossary.md`
6. **Save** to `docs/` with version header:
   ```
   <!-- 
     Document ID: {TYPE}-{PROJECT}-{VERSION}
     Exported: {date} | Source: _bmad-output/{path} | Version: {N}
     Status: Draft / In Review / Approved
     Approved-by: {name} | Approval-date: {date}
     Template: evo/templates/docs/{template} | Template-version: 1.0
   -->
   ```
7. **Update** `docs/DOCUMENT-INDEX.md`
8. **Log**: `"✅ Exported: [source] → [dest] using [template]"`

### BMAD → Template Mapping

| BMAD artifact | Template | docs/ path |
|---------------|----------|-----------| 
| product-brief.md | `product-brief-template.md` | `docs/01-business/product-brief.md` |
| prd.md | `srs-template.md` (IEEE 830) | `docs/02-requirements/srs.md` |
| ux-design.md | `ux-design-template.md` | `docs/02-requirements/ux-design.md` |
| ARCHITECTURE.md | `architecture-template.md` (arc42) | `docs/03-architecture/ARCHITECTURE.md` |
| domain model | `domain-model-template.md` | `docs/03-architecture/domain-model.md` |
| database design | `database-design-template.md` | `docs/03-architecture/database-design.md` |
| epics.md | `epic-template.md` | `docs/04-planning/epics.md` |

Full section-by-section mapping: `evo/templates/docs/EXPORT-MAPPING.md`

---

## Quick Start

```
/create brief           → Step 1 only
/create prd             → Step 2 only
/create architecture    → Step 4 (→ /architecture)
/create epics           → Step 5 only
/create full            → All steps sequentially
```

---

## No-BMAD Fallback

Without BMAD, create docs directly using templates:
1. Load template from `evo/templates/docs/`
2. Fill in sections through guided questions
3. Save to `docs/`
4. Update `docs/DOCUMENT-INDEX.md`

