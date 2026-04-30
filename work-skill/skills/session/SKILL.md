---
name: session
description: Context window management. Clear between tasks, compact when full, rewind on mistakes, resume past sessions. Context is the most constrained resource.
---

# /session — Manage Your Context Window

Context is Claude's most constrained resource. Performance degrades as it fills. Manage it aggressively.

## Core Principle

> The context window holds your entire conversation, files read, and command output. LLM performance degrades as context fills. Manage it like memory — free it when you're done.

## Operations

### `/clear` — Reset Between Tasks

Use between unrelated tasks. Long sessions with irrelevant context reduce performance.

**Trigger:** Switching from feature A to feature B. Any time a previous conversation has no bearing on the next task.

### `/compact` — Compress Long Sessions

When auto-compaction triggers, Claude summarizes what matters. For manual control:

```
/compact Focus on the API changes and the error handling pattern
```

**Customize in CLAUDE.md:**
```
When compacting, always preserve the full list of modified files and test commands.
```

### `/rewind` — Undo Mistakes

`Esc + Esc` or `/rewind` to open checkpoint menu. Restore conversation, code, or both to any previous state.

**Use when:** Claude went down the wrong path, or you want to try a different approach without losing earlier context.

### `--continue` / `--resume` — Resume Past Sessions

```bash
claude --continue    # Resume most recent
claude --resume      # Pick from list
```

**Use `/rename`** to give sessions descriptive names like `"oauth-migration"`.

### `/btw` — Ask Without Polluting Context

Quick questions that don't need to stay in context. Answer appears in a dismissible overlay.

## Failure Pattern

> The "kitchen sink session": You start with task A, ask about task B, go back to task A. Context is full of irrelevant noise.
>
> **Fix:** `/clear` between unrelated tasks.

## Article Reference

> "Manage context aggressively." / "Run /clear between unrelated tasks to reset context." / "Context is the most important resource to manage."
