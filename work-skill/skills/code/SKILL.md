---
name: code
description: Execute an implementation plan with verification at every step. Tests first, then code. Stop on failures — never stack problems.
---

# /code — Implement with Verification

Execute from a plan. Every change is verified. Failures stop the line.

## When to Use

- Implementing from a `/think` plan
- Making changes that span multiple files
- Any time you need a tight verify-then-proceed loop

## Workflow

1. **Start from the plan.** Re-read the plan file. Confirm what's being built.
2. **Write tests first.** Failing test → implementation → passing test. One unit at a time.
3. **Verify every change.**
   - Run the test suite for the changed area
   - For UI: take screenshots, compare to reference
   - For CLI: run the command, check exit code and output
   - For API: curl the endpoint, validate response
4. **Stop on red.** A failing test is the highest priority. Fix it before any new code.
5. **Commit small.** Each logical chunk gets its own commit with a descriptive message.

## Verification Checklist

- [ ] Tests pass (unit + integration for changed area)
- [ ] Typecheck / lint clean
- [ ] No new warnings
- [ ] Manual smoke test (UI screenshot or CLI output)
- [ ] Edge cases from the plan are covered

## Anti-patterns

- Writing 5 files then running tests (too late, debugging is harder)
- Ignoring a failing test to "fix later"
- No verification step at all

## Article Reference

> "Give Claude a way to verify its work." / "Claude performs dramatically better when it can verify its own work."
