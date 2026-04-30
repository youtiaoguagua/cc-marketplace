---
name: check
description: Pre-merge review. Reviews the diff, auto-fixes safe issues, flags destructive commands, runs verification. Evidence before assertions.
---

# /check — Verify Before You Ship

Review the diff, run verification, flag risks. No claim of "done" without evidence.

## When to Use

- After completing a task
- Before committing or creating a PR
- Before claiming something "works" or "is fixed"

## Workflow

1. **Review the diff.** `git diff` — read every change. Look for:
   - Leftover debug code (console.log, print, etc.)
   - Unintended file changes
   - Missing error handling
   - Hardcoded values that should be config
   - Security issues (injection, exposed secrets)

2. **Run verification.**
   - Full test suite (or relevant subset)
   - Lint / typecheck
   - Build if applicable

3. **Auto-fix safe issues.** Formatting, import ordering, obvious leftovers.

4. **Flag destructive patterns.** Before running force-push, hard reset, or `git clean`, confirm with the user.

5. **Produce evidence.**
   ```
   Tests: 42 passed, 0 failed
   Lint: clean
   Typecheck: clean
   Diff: 3 files, +127 -14
   ```

## Commit

When verification passes:

1. Draft a descriptive commit message (focused on WHY, not WHAT).
2. Stage specific files — never `git add -A` or `git add .`.
3. Commit. Never amend published commits.

## Article Reference

> "Give Claude a way to verify its work — this is the single highest-leverage thing you can do." / "Common failure: trust-then-verify gap."
