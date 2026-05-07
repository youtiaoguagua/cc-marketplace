---
name: spec
description: Turn ambiguous requirements into structured spec documents. Surface assumptions → interview → spec → human review → execute in fresh session. Spec is a contract, not a suggestion.
---

# /spec — Specify Before You Build

Turn "I want a login" into a spec Claude can execute precisely. The spec is the shared source of truth — it defines what we're building, why, and how we'll know it's done. Code without a spec is guessing.

## When to Use

- Starting a new project, feature, or significant change
- Requirements are ambiguous, incomplete, or only a vague idea
- The change touches multiple files or modules
- You're about to make an architectural decision
- Implementation would take more than 30 minutes

**When NOT to use:** Single-line fixes, typo corrections, or changes where requirements are unambiguous and self-contained.

## The Gated Workflow

Four phases. Do not advance until the current phase is human-reviewed and approved.

```
SPECIFY ──→ PLAN ──→ TASKS ──→ IMPLEMENT
   │           │         │            │
   ▼           ▼         ▼            ▼
 review      review    review       review
```

### Phase 1: Specify

**Step 1: Surface assumptions immediately.** Before writing any spec content, list what you're assuming:

```
ASSUMPTIONS I'M MAKING:
1. This is a web application (not native mobile)
2. Authentication uses session-based cookies (not JWT)
3. The database is PostgreSQL (based on existing Prisma schema)
4. We're targeting modern browsers only (no IE11)
→ Correct me now or I'll proceed with these.
```

Don't silently fill in ambiguous requirements. The spec's entire purpose is to surface misunderstandings *before* code gets written — assumptions are the most dangerous form of misunderstanding.

**Step 2: Interview.** Use AskUserQuestion until nothing is vague:

```
I want to build [brief description]. Interview me in detail using AskUserQuestion.
Ask about technical implementation, UX, edge cases, security, performance, tradeoffs.
Don't ask obvious questions — dig into the hard parts I might not have considered.
Keep interviewing until everything is covered, then produce a complete spec.
```

**Step 3: Write the spec.** Cover six core areas:

```markdown
# Spec: [Project/Feature Name]

## 1. Objective
What we're building and why. Who is the user. What success looks like.

## 2. Commands
Full executable commands with flags:
build: npm run build
test: npm test -- --coverage
lint: npm run lint --fix
dev: npm run dev

## 3. Project Structure
src/       → Application source code
src/components/ → React components
src/lib/   → Shared utilities
tests/     → Unit and integration tests
e2e/       → End-to-end tests
docs/      → Documentation

## 4. Code Style
One real code snippet showing your style beats three paragraphs describing it. Include naming conventions, formatting rules, examples of good output.

## 5. Testing Strategy
What framework, where tests live, coverage expectations, which test levels for which concerns.

## 6. Boundaries
- Always: Run tests before commits, follow naming conventions, validate inputs
- Ask first: Database schema changes, adding dependencies, changing CI config
- Never: Commit secrets, edit vendor directories, remove failing tests without approval

## 7. Success Criteria
Specific, testable conditions that define "done."

## 8. Open Questions
Anything unresolved that needs human input.
```

**Step 4: Reframe vague requirements into testable criteria.**

```
REQUIREMENT: "Make the dashboard faster"

REFRAMED SUCCESS CRITERIA:
- Dashboard LCP < 2.5s on 4G connection
- Initial data load completes in < 500ms
- No layout shift during load (CLS < 0.1)
→ Are these the right targets?
```

This lets you loop, retry, and problem-solve toward a clear goal rather than guessing what "faster" means.

### Phase 2: Plan

With the validated spec, generate a technical implementation plan:

1. Identify the major components and their dependencies
2. Determine the implementation order (what must be built first)
3. Note risks and mitigation strategies
4. Identify what can be built in parallel vs. what must be sequential
5. Define verification checkpoints between phases

The plan must be reviewable: the human should be able to read it and say "yes, that's the right approach" or "no, change X."

### Phase 3: Tasks

Break the plan into discrete, implementable tasks:

- Each task completable in a single focused session
- Each task has explicit acceptance criteria
- Each task includes a verification step (test, build, manual check)
- Tasks ordered by dependency, not by perceived importance
- No task should require changing more than ~5 files

```markdown
- [ ] Task: Implement password validation function
  - Acceptance: Password 8-128 chars, upper+lower+digit, returns valid + errors array
  - Verify: npm test -- --testPathPattern password
  - Files: src/lib/password.ts, tests/password.test.ts
```

### Phase 4: Implement

**Execute in a fresh session.** This is not optional. Close the session after writing the spec, open a new one. A clean context fully focused on implementation, with the spec as the contract.

```
Spec session:     Surface assumptions → Interview → Write spec → Save → Close
Implement session: Read spec → Execute tasks one by one → Verify against spec
```

## Keeping the Spec Alive

The spec is a living document, not a one-time artifact:

- **Update when decisions change.** Data model needs to change → update spec first, then code.
- **Update when scope changes.** Features added or cut should be reflected in the spec.
- **Commit the spec.** The spec belongs in version control alongside the code.
- **Reference the spec in PRs.** Link back to the spec section each PR implements.

## Spec Format Selection

| Scenario | Format | Location |
|----------|--------|----------|
| Small feature | Single `spec/<feature>.md` | `spec/` directory |
| Large feature touching DB + API + UI | Three files: `requirements.md` / `design.md` / `tasks.md` | `spec/<feature>/` |
| Architectural decisions (auth strategy, caching, event queue) | ADR | `docs/adr/0001-<title>.md` |
| Long-term coding standards | CLAUDE.md | Project root |

## Common Rationalizations

| Rationalization | Reality |
|---|---|
| "This is simple, I don't need a spec" | Simple tasks don't need *long* specs, but they still need acceptance criteria. A two-line spec is fine. |
| "I'll write the spec after I code it" | That's documentation, not specification. The spec's value is in forcing clarity *before* code. |
| "The spec will slow us down" | A 15-minute spec prevents hours of rework. Waterfall in 15 minutes beats debugging in 15 hours. |
| "Requirements will change anyway" | That's why the spec is a living document. An outdated spec is still better than no spec. |
| "I know exactly what I want" | There are always implicit assumptions. The spec surfaces them. |

## Red Flags

- Starting to write code without any written requirements
- Asking "should I just start building?" before clarifying what "done" means
- Implementing features not mentioned in any spec or task list
- Making architectural decisions without documenting them
- Skipping the spec because "it's obvious what to build"

## Verification

Before proceeding to implementation, confirm:

- [ ] All six core areas covered
- [ ] Human has reviewed and approved the spec
- [ ] Success criteria are specific and testable
- [ ] Boundaries (Always/Ask First/Never) are defined
- [ ] Spec is saved to a file in the repository
