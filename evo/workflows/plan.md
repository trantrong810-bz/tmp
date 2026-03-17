---
description: Smart planning. Auto-detects sprint planning vs quick task breakdown.
---

# /plan — Smart Planning

$ARGUMENTS

---

## Routing

1. **Detect scope from argument:**
   - "sprint" or `sprint-status.yaml` exists → SPRINT MODE
   - "story" or "create story" → STORY MODE
   - "retro" or "retrospective" → RETRO MODE
   - Other → QUICK PLAN MODE

---

## SPRINT MODE

- **BMAD installed** → Use `bmad-sprint-planning` skill (Bob 🏃 Scrum Master)
  - Output: `_bmad-output/implementation-artifacts/sprint-status.yaml`
  - **Auto-export** → `docs/04-planning/sprint-status.yaml`
- **No BMAD** → Manual sprint plan:
  1. List all epics and stories
  2. Prioritize by dependency and business value
  3. Create `docs/04-planning/sprint-status.yaml`

---

## STORY MODE

- **BMAD installed** → Use `bmad-create-story` skill (Bob 🏃 Scrum Master)
  - Output: `_bmad-output/implementation-artifacts/stories/{story-file}.md`
  - **Auto-export** → `docs/04-planning/stories/{story-file}.md`
  - Add traceability: reference SRS requirement IDs (FR-NNN)
- **No BMAD** → Create `docs/04-planning/stories/{story-file}.md` directly

---

## RETRO MODE

Use `bmad-retrospective` skill
Template: `evo/templates/docs/retrospective-template.md`
Output: `docs/06-reports/retrospectives/YYYY-MM-DD-sprint-{N}.md`

Report includes: sprint metrics, went well, went wrong, action items, follow-up from previous retro.

---

## QUICK PLAN MODE

Use `sp-writing-plans` micro-task breakdown:

1. Break work into 2-5 minute sub-tasks
2. Order by dependency
3. Each task = verifiable outcome
4. For Java projects: enforce DDD build order (Domain → Infra → App → API)

---

## Auto-Export Rules

After BMAD creates planning artifacts:
1. Ensure `docs/04-planning/` exists
2. Copy/transform to traditional path
3. For stories: ensure `docs/04-planning/stories/` exists
4. Update `docs/DOCUMENT-INDEX.md`
5. Log: `"✅ Exported: [source] → [dest]"`

---

## Glossary Maintenance

When creating stories or sprint plans, if new domain terms appear:
- Use `evo/templates/docs/glossary-template.md`
- Append to `docs/00-project/glossary.md`
