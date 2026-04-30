---
name: scale
description: Run Claude at scale. Non-interactive mode, parallel sessions, fan-out across files, CI integration. Validate on small samples before full runs.
---

# /scale — Automate and Multiply

Move beyond one-human-one-Claude. Run non-interactive, parallel, and in CI.

## Patterns

### Non-Interactive Mode

```bash
claude -p "Explain what this project does"
claude -p "List all API endpoints" --output-format json
claude -p "Analyze this log file" --output-format stream-json
```

Use in: CI pipelines, pre-commit hooks, scripts, data pipelines.

### Fan-Out Across Files

For large migrations or batch operations:

1. **Generate task list.** Have Claude list all files needing change.
2. **Write a loop script.**
   ```bash
   for file in $(cat files.txt); do
     claude -p "Migrate $file: [specific instructions]. Return OK or FAIL." \
       --allowedTools "Edit,Bash(git commit *)"
   done
   ```
3. **Test on 2-3 files first.** Refine the prompt based on failures.
4. **Run at scale.** Use `--allowedTools` to scope permissions for unattended runs.

### Parallel Sessions

| Pattern | How |
|---------|-----|
| **Writer/Reviewer** | Session A implements, Session B reviews (clean context = unbiased review) |
| **Test-first** | Session A writes tests, Session B writes code to pass them |
| **Multi-feature** | Independent features in parallel sessions with isolated worktrees |

### Auto Mode

```bash
claude --permission-mode auto -p "fix all lint errors"
```

Classifier reviews commands before execution. Blocks scope escalation, unknown infrastructure, hostile actions. For `-p` runs, aborts if repeatedly blocked (no user to fall back to).

### Pipe Integration

```bash
claude -p "<prompt>" --output-format json | your_command
cat error.log | claude -p "Summarize the errors"
```

## Safety Rules

- Always test prompts on 2-3 files before full runs.
- Use `--allowedTools` to restrict what batch runs can do.
- Use `--verbose` during development, turn off in production.
- Never run destructive operations unattended without explicit allowlisting.

## Article Reference

> "Once you're effective with one Claude, multiply your output with parallel sessions, non-interactive mode, and fan-out patterns."
