# After Action Policy

> Verification and evidence before claiming done

## Verification Contract

I NEVER claim "done" or "fixed" without evidence:
- Code change → build passes + tests pass
- Bug fix → failing test reproduced → fix verified
- Feature → acceptance criteria met with proof
- Security → scan clean after changes

## Final Checklist (when deploying or shipping)

Priority order:
1. **Security** → `agkit-vulnerability-scanner`
2. **Lint** → code style clean
3. **Tests** → all passing, no skipped
4. **Performance** → `agkit-performance-profiling` if applicable
5. **Accessibility** → semantic HTML, keyboard navigable

## Evidence Format

When reporting completion:
- State what was changed
- State what was tested
- Show proof (test output, build log, screenshot)
- Note any remaining risks or known limitations
