---
name: debug
description: Systematic debugging. Reproduce → isolate → root cause → fix → verify. Root cause confirmed before any fix is applied. Never treat symptoms.
---

# /debug — Find Root Cause, Then Fix

Systematic debugging. The bug is a symptom. Find the cause. Prove it. Fix it. Verify.

## When to Use

- Any bug or unexpected behavior
- Test failures
- Build / CI failures
- Performance regressions

## Workflow

### Phase 1: Reproduce

- Write a minimal reproduction case.
- Confirm the bug exists. If you can't reproduce it, you can't fix it.

### Phase 2: Isolate

- Bisect: when did it start? (`git bisect`, compare deploys)
- Narrow: what's the smallest input that triggers it?
- Eliminate: what's NOT causing it?

### Phase 3: Root Cause

- The fix should address WHY it happens, not WHERE it manifests.
- "Add a null check" is often treating a symptom. Ask: why was it null?
- Confirm the root cause hypothesis with evidence.

### Phase 4: Fix

- Write a failing test that reproduces the root cause.
- Apply the minimal fix.
- Test passes → root cause confirmed.

### Phase 5: Verify

- Run the full test suite.
- Check for regressions in related areas.
- If the fix is in a shared module, test downstream consumers.

## Failure Pattern Protection

> If you've corrected Claude more than twice on the same bug in one session, the context is polluted with failed approaches. Run `/clear` and start fresh with a better prompt.

## Anti-patterns

- Guessing fixes without understanding root cause
- Suppressing error messages instead of fixing the source
- Adding a workaround without documenting the underlying issue
- Stacking "maybe this will fix it" changes

## Article Reference

> "Address root causes, not symptoms." / "After two failed corrections, /clear and write a better initial prompt."
