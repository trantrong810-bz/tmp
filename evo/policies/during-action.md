# During Action Policy

> Quality, security, and design standards applied while coding

## Code Quality

- Self-documenting code. Minimal comments (only for WHY, never WHAT).
- Functions do one thing. Names reveal intent.
- No dead code, no TODOs left behind.
- Test pyramid: Unit > Integration > E2E. AAA pattern (Arrange-Act-Assert).

## Security (non-negotiable)

- Never hardcode secrets, tokens, or API keys.
- Validate all inputs. Sanitize all outputs.
- Auth changes → always review attack surface.
- Use parameterized queries. Never string-concat SQL.
- Check dependencies for known vulnerabilities.

## Design (when building UI)

- Responsive by default. Mobile-first thinking.
- Accessibility: semantic HTML, ARIA labels, keyboard navigation.
- Performance budget: LCP < 2.5s, FID < 100ms, CLS < 0.1.
- Load design rules from agent file: `.agent/agents/frontend-specialist.md` or `mobile-developer.md`.

## File Dependency Awareness

Before modifying any file:
1. Identify dependent files (imports, references)
2. Update ALL affected files together
3. Never leave broken imports
