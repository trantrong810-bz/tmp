---
description: Smart code review. BMAD adversarial + domain checklist.
---

# /review — Smart Code Review

$ARGUMENTS

---

## Routing

1. **Check BMAD installed:** Does `_bmad/_config/` exist?
   - YES → Use `bmad-code-review` skill (adversarial multi-layer review)
   - NO → Use `sp-requesting-code-review` severity-based format

2. **Supplement with domain checklist:**
   - `pom.xml` exists → Apply `@java-backend-specialist` Review Checklist
   - `package.json` exists → Apply frontend review patterns
   - Other → Apply `agkit-code-review-checklist` general patterns

3. **Output format:** Use `evo/templates/docs/code-review-template.md`

---

## Report Output

Use template: `evo/templates/docs/code-review-template.md`
Save to: `docs/06-reports/code-reviews/YYYY-MM-DD-{scope}.md`

Report includes:
- Review ID, scope, reviewer, date
- Severity summary (🔴/🟡/🟢 counts)
- Verdict: Approved / Approved with changes / Requires re-review
- Individual findings with file + line + fix
- Checklist results (tests, build, security, DDD, naming, errors)

After report:
- Update `docs/DOCUMENT-INDEX.md`
- Suggest next action:
  ```
  If Approved → "Ready to deploy. Run /deploy or continue /dev [next-story]"
  If Approved with changes → "Fix 🟡 findings, then re-run /review"
  If Requires re-review → "Fix 🔴 findings first. Run /review again after fixes."
  ```

---

## No-BMAD Fallback

If BMAD not installed, use structured review format:
1. **Blind review** — scan all changed files without context
2. **Contextual review** — re-read with architecture understanding
3. **Checklist review** — domain-specific checklist
4. Report findings using template
