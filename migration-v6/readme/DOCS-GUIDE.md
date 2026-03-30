# Migration-V6 Documentation Guide

This is the **single human-facing guide** for understanding the `migration-v6` documentation layout.

If someone asks:

- why there are many files,
- where a new rule should be added,
- which files each agent actually uses,
- and what is required vs optional,

start here.

> `../docs/` = **agent runtime rules**  
> `./readme/` = **human/background reading**

---

## Why are there so many files in `docs/`?

The runtime docs are split intentionally.

- **One file per concern** — behavior, hard constraints, discovery, execution, post-migration validation, version upgrades, skipping, and context handling are separated.
- **Safer maintenance** — you can change one topic without touching a huge monolithic document.
- **Better agent behavior** — the agents can follow focused rules instead of one mixed file with unrelated content.
- **The files are long on purpose** — they include edge cases, anti-patterns, and real migration failures so the agents do not guess or mark incomplete work as finished.

### Practical rule

Do **not** create a new file for every small tweak.
Prefer updating an existing owner file unless the rule introduces a **new concern/category**.

---

## Which agents use which files?

### Shared by all agents

These are the common runtime rule files:

- `../docs/AGENT-RULES.md`
- `../docs/HARD-RULES.md`

### Agent-to-file mapping

| Agent                                | Main files it uses                                                                                                                                                                        | Why                                                                             |
| ------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------- |
| `migration-orchestrator-v6.agent.md` | `../docs/AGENT-RULES.md`, `../docs/HARD-RULES.md`, `../docs/SKIP-FUNCTIONALITY.md`                                                                                                        | Routing, phase gates, skip handling, when to ask the user                       |
| `migration-planner-v6.agent.md`      | `../docs/RUNTIME-DISCOVERY-PIPELINE.md`, `../docs/STRICT-DOC-EXPANSION.md`, `../docs/AGENT-RULES.md`, `../docs/HARD-RULES.md`                                                             | Discovery, task creation, link expansion, planning discipline                   |
| `migration-executor-v6.agent.md`     | `../docs/MULTI-PHASE-ERROR-TRACKING.md`, `../docs/EXECUTOR-PHASE-SUPPORT.md`, `../docs/NEVER-SKIP-ALWAYS-FIX-PROTOCOL.md`, `../docs/VERSION-AWARE-UPGRADE-PROTOCOL.md`, plus shared rules | Task execution, validation, post-migration recovery, and version-aware upgrades |

### Supporting files used by the system

| File                                          | Used by                           | Purpose                            |
| --------------------------------------------- | --------------------------------- | ---------------------------------- |
| `../templates/MIGRATION_PROGRESS.template.md` | Planner + Executor + Orchestrator | Source-of-truth task/progress file |
| `../README.md`                                | Humans                            | Quick overview                     |
| `../SETUP.md`                                 | Humans                            | Setup and installation             |
| `../USAGE.md`                                 | Humans + agents indirectly        | Command flow and expected behavior |

---

## Where should I add a new rule?

### Rule placement guide

| If the rule is about...                     | Add it here first                           | Also update if needed                                                              |
| ------------------------------------------- | ------------------------------------------- | ---------------------------------------------------------------------------------- |
| General behavior for all agents             | `../docs/AGENT-RULES.md`                    | Relevant `agents/*.agent.md` file                                                  |
| A strict must/never constraint              | `../docs/HARD-RULES.md`                     | Relevant `agents/*.agent.md` file                                                  |
| Phase 1 planning or doc discovery           | `../agents/migration-planner-v6.agent.md`   | `../docs/RUNTIME-DISCOVERY-PIPELINE.md` or `../docs/STRICT-DOC-EXPANSION.md`       |
| Execution of a specific migration task/step | `../agents/migration-executor-v6.agent.md`  | `../docs/EXECUTOR-PHASE-SUPPORT.md` or `../docs/NEVER-SKIP-ALWAYS-FIX-PROTOCOL.md` |
| Post-migration validation / deferred errors | `../docs/MULTI-PHASE-ERROR-TRACKING.md`     | `../agents/migration-executor-v6.agent.md`                                         |
| Version upgrade behavior                    | `../docs/VERSION-AWARE-UPGRADE-PROTOCOL.md` | `../agents/migration-executor-v6.agent.md`                                         |
| Skip / fast-forward behavior                | `../docs/SKIP-FUNCTIONALITY.md`             | `../agents/migration-orchestrator-v6.agent.md`                                     |

> **Rule of thumb:** if the rule is tied to one concrete step, put it in the **owning agent file first**. If it should be reusable or human-readable, mirror it in the matching file under `../docs/`.

---

## Example: adding a rule for one specific step

### Scenario

You want a new rule only for a specific post-migration step, for example:

> “When a task updates PrimeNG table filters, the executor must run build + tests for that table flow before marking the step done.”

### Where to add it

1. **First:** `../agents/migration-executor-v6.agent.md`
2. **Then mirror/explain in:** `../docs/EXECUTOR-PHASE-SUPPORT.md` or `../docs/MULTI-PHASE-ERROR-TRACKING.md`

### Example snippet

```markdown
### PrimeNG table migration rule
- If the current task changes `p-table` filtering, verify build passes and the related tests pass before marking the task complete.
- If this is Phase C and the failure is clearly caused by a later cleanup task, record the error and revisit it in final validation.
```

This is a **step-specific rule**, so it belongs with the **executor**.

---

## Example: adding a generic rule for every step

### Generic-rule scenario

You want a rule that should apply to **every migration step**, such as:

> “Every task must record the exact command and output used for validation.”

### Where to add a generic rule

1. **First:** `../docs/HARD-RULES.md` or `../docs/AGENT-RULES.md`
2. **Then mirror in:** all relevant agent files if the rule changes actual execution behavior

### Generic rule example snippet

```markdown
### H21: Validation Evidence Must Be Explicit
- ✅ Record the exact validation command that was run
- ✅ Record whether `build`, `lint`, and `test` passed or failed
- ❌ Do NOT claim success without fresh output evidence
```

This is a **global rule**, so it belongs in the **shared rule files**.

---

## What each file is for

### Runtime docs in `../docs/`

| File                                | What it contains                                                 | Required for normal migration? |
| ----------------------------------- | ---------------------------------------------------------------- | ------------------------------ |
| `AGENT-RULES.md`                    | Core behavior contract, when to ask the user, ambiguity handling | **Yes**                        |
| `HARD-RULES.md`                     | Non-negotiable constraints and completion gates                  | **Yes**                        |
| `RUNTIME-DISCOVERY-PIPELINE.md`     | How planning discovers pages, links, and tasks                   | **Yes** for Phase 1            |
| `MULTI-PHASE-ERROR-TRACKING.md`     | Phase A vs Phase C error handling and final validation           | **Yes** for post-migration     |
| `VERSION-AWARE-UPGRADE-PROTOCOL.md` | How Angular/Nx/PrimeNG version upgrades are resolved             | **Yes** when upgrades run      |
| `SKIP-FUNCTIONALITY.md`             | `Skip~N` behavior                                                | Only if you use skipping       |
| `STRICT-DOC-EXPANSION.md`           | No-assumption reading rules for planner                          | Supporting                     |
| `CONTEXT-PRESERVATION-MANDATE.md`   | State preservation and progress-file discipline                  | Supporting                     |
| `EXECUTOR-PHASE-SUPPORT.md`         | Explanatory overview of Phase A/B/C behavior                     | Supporting                     |
| `NEVER-SKIP-ALWAYS-FIX-PROTOCOL.md` | Detailed executor discipline and anti-patterns                   | Supporting                     |

### Background files in this `readme/` folder

| File                            | What it contains                                           | Can a normal run skip reading it? |
| ------------------------------- | ---------------------------------------------------------- | --------------------------------- |
| `REAL-WORLD-FINDINGS.md`        | Problems seen in actual migrations and their fixes         | **Yes**                           |
| `V6-REAL-WORLD-IMPROVEMENTS.md` | Summary of how v6 was hardened                             | **Yes**                           |
| `V2-V3-BORROWING-PLAN.md`       | Design notes and borrowing decisions from earlier versions | **Yes**                           |

---

## Minimum files required for a migration run

If you want the migration system to work correctly, keep at least these:

1. `../agents/migration-orchestrator-v6.agent.md`
2. `../agents/migration-planner-v6.agent.md`
3. `../agents/migration-executor-v6.agent.md`
4. `../templates/MIGRATION_PROGRESS.template.md`
5. `../README.md`, `../SETUP.md`, `../USAGE.md`
6. `../docs/AGENT-RULES.md`
7. `../docs/HARD-RULES.md`
8. `../docs/RUNTIME-DISCOVERY-PIPELINE.md`
9. `../docs/MULTI-PHASE-ERROR-TRACKING.md`
10. `../docs/VERSION-AWARE-UPGRADE-PROTOCOL.md`

---

## What can be skipped?

### Usually skippable for reading

- Most of `readme/` during a normal run
- `../docs/SKIP-FUNCTIONALITY.md` if you never use `Skip~N`
- Supporting docs such as `EXECUTOR-PHASE-SUPPORT.md` or `CONTEXT-PRESERVATION-MANDATE.md` unless you are debugging or customizing behavior

### Important note

- **Skippable** here means **you do not need to read it every time**.
- It does **not** automatically mean the file is safe to delete from the package.

---

## Related root guides

- `../README.md` — overview and quick start
- `../INDEX.md` — navigation hub
- `../SETUP.md` — install/copy/symlink setup
- `../USAGE.md` — how to run the migration step by step
- `../PHASE-1-INTEGRATION-SUMMARY.md` — integration history
- `../REAL-WORLD-INTEGRATION.md` — real-world lessons
