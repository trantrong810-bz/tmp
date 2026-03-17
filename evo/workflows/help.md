---
description: Show available commands, detect project type, recommend next action.
---

# /help — Evo Trident Command Reference

## Available Commands

| Command | Description |
|---------|------------|
| `/create [brief\|prd\|ux\|epics\|full]` | Product lifecycle creation (BMAD → docs/) |
| `/dev [story\|feature]` | Develop — story mode (BMAD tracking) or quick mode |
| `/enhance [feature]` | Add feature to existing project (brownfield + change mgmt) |
| `/refactor [scan\|assess\|plan\|execute\|verify]` | Legacy modernization (TDD-based, zero regression) |
| `/review` | Multi-layer code review (BMAD adversarial + domain checklist) |
| `/test [file\|e2e\|coverage\|perf\|report]` | Smart testing — auto-detects framework |
| `/debug [issue]` | Systematic debugging (SP 4-phase + domain patterns) |
| `/deploy` | Deployment with 10-point pre-flight + rollback |
| `/incident [description]` | Production incident response (triage → postmortem) |
| `/plan [sprint\|story\|retro]` | Planning — BMAD sprint, stories, or retrospective |
| `/brainstorm [topic]` | Guided brainstorming (BMAD 4-mode or structured exploration) |
| `/orchestrate [task]` | Multi-expert coordination (Party / Expert panel / Parallel) |
| `/architecture` | Design architecture (BMAD guided + domain agent consult) |
| `/status [ops]` | Sprint status or operational health |
| `/help` | This command reference |

## Project Detection

Read `evo/evo-registry.yaml` and check current project:

1. Scan for detector files (pom.xml, package.json, Cargo.toml, etc.)
2. Match markers in found files
3. Report detected project type and recommended agent

```
📁 Project detected:  [type from registry]
🤖 Recommended agent: [agent name]
📚 Skills available:  [count] loaded, [count] on-demand
```

## Quick Start

```
New project  → /brainstorm → /plan → /architecture → /dev
Existing     → /enhance [feature] or /dev [story]
Bug          → /debug [issue]
Review       → /review
```
