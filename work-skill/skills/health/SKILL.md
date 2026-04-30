---
name: health
description: Audit Claude Code configuration. Checks CLAUDE.md, rules, skills, hooks, MCP, permissions, auto memory. Flags bloat, redundancy, and missing pieces by severity.
---

# /health — Audit Your Claude Code Setup

Check every layer of your configuration. Identify what's bloated, broken, or missing.

## Audit Checklist

### 1. CLAUDE.md

- [ ] **Under 200 lines.** Longer files consume more context and reduce adherence. If growing large, move content to path-scoped rules or skills.
- [ ] **Specific and verifiable.** "Use 2-space indentation" not "Format code properly." "Run `npm test` before committing" not "Test your changes."
- [ ] **Only what Claude can't infer.** Build commands, non-standard conventions, env quirks. No standard language conventions, no file-by-file codebase descriptions.
- [ ] **No conflicting rules.** If two CLAUDE.md files or rules give different guidance for the same behavior, Claude picks one arbitrarily. Review periodically.
- [ ] Uses emphasis sparingly (`IMPORTANT`, `YOU MUST`) for critical rules.

**When to add to CLAUDE.md:**
- Claude made the same mistake a second time
- Code review caught something Claude should have known
- You typed the same correction you typed last session

**Red flag:** Claude keeps doing something wrong despite a rule → file is too long and the rule is getting lost.

### 2. .claude/rules/ (Path-Scoped Rules)

- [ ] Rules that only apply to specific file types are path-scoped (not dumped in the main CLAUDE.md).
- [ ] No rule that should be a skill instead (rules load every session; skills load on demand).
- [ ] No rules conflicting with CLAUDE.md or other rules.
- [ ] Symlinked rules are intentional and the targets still exist.

### 3. Hooks

- [ ] Hooks configured for actions that must happen EVERY time with zero exceptions.
- [ ] No hook that could be a CLAUDE.md instruction instead (hooks are deterministic, CLAUDE.md is advisory).
- [ ] Run `/hooks` to review current configuration.

### 4. Auto Memory

- [ ] Auto memory is enabled (`autoMemoryEnabled` not set to false).
- [ ] `MEMORY.md` is under 200 lines / 25KB (beyond that isn't loaded at session start).
- [ ] No stale or incorrect memories. Run `/memory` to browse and prune.
- [ ] Detailed topic files exist for non-trivial entries (keeps `MEMORY.md` lean).

### 5. Skills

- [ ] Each skill has a clear trigger (when to use it).
- [ ] No skill overlaps with another (ambiguous ownership).
- [ ] Skills that have side effects use `disable-model-invocation: true`.

### 6. MCP Servers

- [ ] All configured servers are responsive.
- [ ] No unused or broken servers.

### 7. Permissions

- [ ] Auto mode or allowlists configured to reduce unnecessary approval prompts.
- [ ] Dangerous commands properly restricted.
- [ ] Sandboxing enabled if working with untrusted code.

### 8. CLI Tools

- [ ] `gh` installed for GitHub operations (avoids rate limits).
- [ ] Cloud CLIs available if needed (`aws`, `gcloud`).

## Nested CLAUDE.md Awareness

- Project-root CLAUDE.md survives `/compact` (re-read from disk and re-injected).
- Nested CLAUDE.md in subdirectories does NOT survive compact — reloads next time Claude reads a file in that subdirectory.
- If an instruction disappeared after compact, it was only in conversation or a nested file that hasn't reloaded yet.

## Severity Levels

| Level | Meaning |
|-------|---------|
| 🔴 Critical | Claude will make wrong decisions (e.g., missing test command, conflicting rules) |
| 🟡 Warning | Wasted context or unclear ownership (e.g., bloated CLAUDE.md, stale auto memory) |
| 🔵 Info | Optimization opportunity (e.g., rule could be path-scoped, skill could be more specific) |

## References

- [Claude Code Best Practices](https://code.claude.com/docs/en/best-practices) — CLAUDE.md design principles
- [How Claude remembers your project](https://code.claude.com/docs/en/memory) — CLAUDE.md, auto memory, path-scoped rules
