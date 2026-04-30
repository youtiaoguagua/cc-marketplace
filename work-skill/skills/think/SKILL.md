---
name: think
description: Pressure-test requirements, explore alternatives, and produce a written plan before any code is written. Use interview mode for ambiguous specs.
---

# /think — Plan Before You Build

Challenge the problem, pressure-test the design, validate architecture. No code until the plan is clear.

## When to Use

- Building anything new (feature, refactor, migration)
- The approach isn't obvious
- Multiple files will change
- You're unsure about architecture tradeoffs

## When to Skip

- The fix is one line and obvious
- You could describe the diff in one sentence
- Exploratory throwaway work

## Workflow

### Phase 1: Clarify (Interview Mode)

For ambiguous requirements, start with:

```
I want to build [brief description]. Interview me in detail using the AskUserQuestion tool.
Ask about technical implementation, UI/UX, edge cases, concerns, and tradeoffs.
Don't ask obvious questions — dig into the hard parts.
Keep interviewing until we've covered everything.
```

### Phase 2: Design

1. Identify what files change and how.
2. Surface hidden constraints (backwards compat, performance, security).
3. Choose between alternatives with explicit tradeoffs.
4. Write the plan to a plan file.

### Phase 3: Pressure Test

- What breaks if this goes wrong?
- What edge cases aren't covered?
- Can this be rolled back safely?

## Output

A concrete plan: files to change, order of changes, verification strategy, rollback path. The plan is a contract — `/build` executes against it.

## Article Reference

> "Explore first, then plan, then code." / "Let Claude interview you." / "Planning is most useful when you're uncertain about the approach."
