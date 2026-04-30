---
name: explore
description: Read-only codebase exploration. Maps structure, patterns, and boundaries before any code is written. Use subagents to isolate context.
---

# /explore — Map Before You Move

Read-only investigation phase. Understand what exists before you change anything. Never edit files.

## When to Use

- Diving into unfamiliar code
- Before `/think` when the terrain is unknown
- Answering "how does X work?" questions

## Workflow

1. **Scope the exploration.** What area, what question, what boundaries.
2. **Use subagents for broad searches.** Delegate with `"use subagents to investigate X"` — they explore in separate context, report summaries, keep your main session clean.
3. **Read key files directly.** For targeted lookups, read the specific files.
4. **Map the patterns.** Identify: existing conventions, extension points, error handling, auth, data flow.
5. **Report findings concisely.** Structure, gotchas, relevant files. No implementation suggestions yet.

## Anti-patterns

- Reading hundreds of files into main context ("infinite exploration")
- Starting to edit during exploration
- Exploring without a clear question to answer

## Article Reference

> "Explore first, then plan, then code." / "Use subagents for investigation."
