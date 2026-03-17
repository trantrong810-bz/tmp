---
description: Design architecture with BMAD guided process + domain agent consultation.
---

# /architecture — Smart Architecture Design

$ARGUMENTS

---

## Step 1: Auto-Detect Stack

Read `evo/evo-registry.yaml` → match project files:

| Detected | Domain Agent | Domain Skills Auto-Loaded |
|----------|-------------|--------------------------| 
| java-spring | `@java-backend-specialist` | `agkit-java-spring-boot` (DDD, Hexagonal, API JAR, schema-per-module) |
| react-frontend | `@frontend-specialist` | `agkit-nextjs-react-expert` (SSR, hydration, bundle) |
| python-backend | `@backend-specialist` | `agkit-python-patterns` (Django/FastAPI patterns) |
| nodejs-backend | `@backend-specialist` | `agkit-nodejs-best-practices` (async, middlewares) |
| rust | `@backend-specialist` | `agkit-rust-pro` (ownership, lifetimes, tokio) |
| mobile | `@mobile-developer` | `agkit-mobile-design` (touch, platform conventions) |
| no match | generic | `agkit-architecture` (decision framework only) |

---

## Step 2: Architecture Process

### BMAD Installed

1. Use `bmad-create-architecture` skill (Winston 🏗️ guides full process)
2. **At EVERY design decision**, the detected domain agent automatically provides stack-specific input:

   **For Java (example):**
   - Module structure → DDD bounded contexts, API JAR pattern
   - Data model → Aggregate roots, `@Version`, `BaseDomainModel`
   - Layer architecture → Domain → Infrastructure → Application → Presentation
   - Cross-module → Domain Events + QueryService (no direct dependency)
   - Database → Liquibase, `{prefix}_{module}` schema naming
   - Testing → 4-level: Domain (JUnit), Service (Mockito), Integration (Testcontainers), Arch (ArchUnit)

   **For React (example):**
   - Component structure → Pages, Layouts, Features, Shared
   - State management → Server state (React Query) vs Client state (Zustand)
   - Rendering → SSR vs CSR vs ISR decision matrix
   - Bundle → Code splitting, lazy loading boundaries

3. Output: write to `docs/03-architecture/` using **industry-standard templates**

### No BMAD

1. Domain agent creates architecture using templates
2. Use `agkit-architecture` skill for ADR decision framework

---

## Step 3: Document Output

Use templates from `evo/templates/docs/`:

| Output | Template | Path |
|--------|----------|------|
| Architecture doc | `architecture-template.md` (ISO 42010 + arc42) | `docs/03-architecture/ARCHITECTURE.md` |
| Domain model | `domain-model-template.md` (DDD) | `docs/03-architecture/domain-model.md` |
| Database design | `database-design-template.md` | `docs/03-architecture/database-design.md` |
| API design | `api-design-template.md` (REST/OpenAPI) | `docs/03-architecture/api-design.md` |
| NFR | `nfr-template.md` (ISO 25010) | `docs/02-requirements/nfr.md` |
| ADR (per decision) | `adr-template.md` (Michael Nygard) | `docs/03-architecture/adr/NNN-{name}.md` |
| Glossary updates | `glossary-template.md` | `docs/00-project/glossary.md` (append) |

All documents include: document ID, version, revision history, cross-references.

---

## Step 4: Validation

1. If BMAD → `bmad-check-implementation-readiness` (cross-validates PRD + UX + Architecture)
2. Verify architecture doc includes:
   - ✅ Stack-specific conventions (not generic boxes)
   - ✅ Module boundaries with enforcement mechanism
   - ✅ Testing strategy per layer
   - ✅ Cross-module integration pattern
   - ✅ Database/schema conventions
3. Update `docs/DOCUMENT-INDEX.md` with new/updated docs
4. Suggest next: `/create epics` or `/plan sprint`
