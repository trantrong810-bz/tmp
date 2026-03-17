# Evo Trident — Setup & Architecture Guide v2

> 3 hệ thống, 1 giao diện, 179 skills, 12 smart workflows

---

## Design Philosophy

### Tại sao cần Evo Trident?

3 công cụ AI mạnh nhất — BMAD, AG Kit, Superpowers — mỗi cái giỏi 1 việc:

| Tool | Giỏi | Yếu |
|------|------|-----|
| **BMAD** | Process (khi nào, thứ tự nào, track ở đâu) | Generic (không biết Java/React) |
| **AG Kit** | Knowledge (patterns, rules, best practices) | Passive (chỉ loaded khi gọi) |
| **Superpowers** | Discipline (enforce, verify, evidence) | Không có workflows |

**Vấn đề:** User phải nhớ 40+ commands từ 3 systems. Phải tự biết khi nào dùng tool nào.

**Giải pháp:** Evo Trident = **1 abstract layer** bọc 3 systems. User chỉ cần nhớ 12 commands.

### Triết lý kiến trúc

```
1. ROUTE, don't REPLACE — Evo không thay thế BMAD/AG Kit/SP,
   nó routing đến đúng tool tại đúng thời điểm.

2. THIN wrappers — Workflows chỉ chứa routing logic (30-80 dòng),
   sức mạnh thực sự nằm trong skills được gọi.

3. REGISTRY-driven — Thêm stack mới = 5 dòng YAML,
   không sửa workflow nào.

4. GRACEFUL degradation — Không có BMAD? Vẫn hoạt động (fallback).
   Không có AG Kit agent? Dùng base agent.

5. AGENT ≤ 200 dòng — Prevent LLM context dilution.
   Agent = persona + routing. Knowledge = trong skills.
```

---

## 3-Layer Architecture

```
┌─────────────────────────────────────────────────┐
│ Layer 1: PROCESS (When? What order? Track?)      │ ← BMAD
│                                                  │
│   ┌─────────────────────────────────────────┐   │
│   │ Layer 2: KNOWLEDGE (How? Patterns? Rules?)│   │ ← AG Kit
│   │                                          │   │
│   │   ┌─────────────────────────────────┐   │   │
│   │   │ Layer 3: DISCIPLINE (Enforce?)   │   │   │ ← Superpowers
│   │   └─────────────────────────────────┘   │   │
│   └─────────────────────────────────────────┘   │
└─────────────────────────────────────────────────┘
                      ▲
              Evo Trident (routing layer)
```

Mỗi action cần cả 3 layers:

| Phase | BMAD (process) | AG Kit (knowledge) | SP (discipline) |
|-------|---------------|-------------------|----------------|
| Dev | Story tracking, status | DDD patterns, build order | TDD, verify |
| Review | Adversarial 3-layer | Domain checklist | Severity format |
| Debug | — | Stack-specific patterns | 4-phase method |
| Plan | Sprint planning | Architecture decisions | Micro-task breakdown |

---

## Configuration Layers

```
evo/ (Source of Truth — bạn sửa ở đây)
├── GEMINI.md                  ← Tầng 1: Constitutional (AI behavior)
├── evo-registry.yaml          ← Tầng 2: Registry (project detect + agent routing)
├── agents/                    ← Tầng 3: Specialist agents (persona + routing)
│   └── java-backend-specialist.md
├── workflows/                 ← Tầng 3: Smart dispatchers (12 files)
├── skills/                    ← Tầng 3: Enhanced domain skills
├── policies/                  ← Tầng 3: Project-wide rules
├── templates/                 ← Agent creation template
│   └── agent-template.md
└── sync-super-framework.ps1   ← Sync engine

.agent/ (Runtime — AI đọc từ đây, ĐỪNG sửa trực tiếp)
├── rules/GEMINI.md            ← Synced from evo/
├── agents/                    ← AG Kit (20) + evo overrides
├── workflows/                 ← AG Kit (3) + evo overrides (12)
├── skills/                    ← bmad-* + agkit-* + sp-*
└── policies/                  ← Synced from evo/

_upstream/ (Git submodules — read-only)
├── antigravity-kit/           ← AG Kit upstream
└── superpowers/               ← SP upstream

_bmad/ (BMAD exclusive — managed by npx bmad-method)
```

**Nguyên tắc:** Sửa trong `evo/` → chạy sync → `.agent/` auto-updated.

---

## Quick Start

```powershell
# 1. Clone + setup (lần đầu)
.\evo\setup.ps1

# 2. Sync (daily)
.\evo\sync-super-framework.ps1

# 3. Sync without git pull
.\evo\sync-super-framework.ps1 -SkipSubmoduleUpdate

# 4. Preview changes
.\evo\sync-super-framework.ps1 -DryRun

# 5. Update BMAD
npx bmad-method install --yes
```

---

## 12 Commands

```
/create          Full product lifecycle (brief → PRD → arch → epics)
/architecture    BMAD process + auto-detect stack + domain agent
/dev             Story mode | quick mode + auto-verification
/review          BMAD adversarial 3-layer + domain checklist
/test            Auto-detect framework + e2e/coverage sub-commands
/debug           SP 4-phase systematic + domain patterns
/enhance         Brownfield (complexity routing: simple/medium/large)
/plan            BMAD sprint | SP micro-task breakdown
/orchestrate     BMAD party | expert panel (parallel) | parallel impl
/brainstorm      BMAD guided 4-mode | structured exploration
/status          Sprint tracking
/help            Command reference + project detection
```

---

## Extensibility

### Thêm stack mới (5 dòng YAML)

```yaml
# evo/evo-registry.yaml
go-backend:
  detect_files: ["go.mod"]
  agent: backend-specialist
  base_skills: []              # thêm agkit-go khi có
```

### Tạo specialist agent mới (30 phút)

```powershell
# 1. Copy template
Copy-Item evo\templates\agent-template.md evo\agents\go-specialist.md

# 2. Fill in: mindset, DDD gate, architecture rules, review checklist

# 3. Update registry
# evo/evo-registry.yaml → go-backend → agent: go-specialist

# 4. Sync
.\evo\sync-super-framework.ps1 -SkipSubmoduleUpdate
```

### Sửa behavior AI

| Muốn thay gì | Sửa file | Sync |
|--------------|---------|------|
| AI mindset/routing | `evo/GEMINI.md` | ✅ |
| Project detection | `evo/evo-registry.yaml` | — (read trực tiếp) |
| Agent persona | `evo/agents/*.md` | ✅ |
| Workflow logic | `evo/workflows/*.md` | ✅ |
| Domain skill | `evo/skills/` | ✅ |
| Coding rule | `evo/policies/*.md` | ✅ |
| Pin upstream | `_upstream/` git checkout | ✅ |

---

## Troubleshooting

| Vấn đề | Fix |
|--------|-----|
| Slash commands không hiện | Check `.agent/workflows/` có files |
| BMAD skills mất | `npx bmad-method install --yes` |
| Agent cũ sau sync | Kiểm tra `evo/agents/` có file mới chưa |
| Workflow không override | Kiểm tra whitelist trong `sync-super-framework.ps1` |
| Registry không detect | Kiểm tra `evo/evo-registry.yaml` detect_files |
