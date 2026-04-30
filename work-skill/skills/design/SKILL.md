---
name: design
description: Build frontend interfaces with a committed aesthetic direction. Screenshot-based self-verification loop. Not generic defaults.
---

# /design — Build Distinctive UI

Produce UI with intentional aesthetic choices, not framework defaults. Verify visually — screenshot, compare, fix, repeat.

## When to Use

- Building or redesigning UI components, pages, or layouts
- The user provides a reference screenshot or design spec
- Any frontend work where visual quality matters

## Workflow

1. **Establish aesthetic direction.** Choose a style (minimalism, brutalism, glassmorphism, etc.), color palette, font pairing. Commit to it — don't drift.
2. **Build the component.** Reference existing patterns in the codebase if they exist.
3. **Screenshot the result.** Use the Claude in Chrome extension or a screenshot tool.
4. **Compare to reference.** List differences. Be specific.
5. **Fix discrepancies.** Iterate until the output matches intent.
6. **Verify responsiveness.** Test at multiple viewport sizes.

## Key Principle

> "Take a screenshot of the result and compare it to the original. List differences and fix them."

A screenshot is the verification. "Looks good" without visual evidence is not verification.

## Anti-patterns

- Defaulting to generic design system styles without intent
- Building without a reference or clear aesthetic direction
- Skipping the screenshot comparison step

## Article Reference

> "Verify UI changes visually." / "Take a screenshot of the result and compare it to the original."
