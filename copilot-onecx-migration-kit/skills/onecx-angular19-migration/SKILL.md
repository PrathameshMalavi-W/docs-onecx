---
name: onecx-angular19-migration
description: Use this skill to run a checkpointed OneCX Angular 18 to 19 migration workflow with MIGRATION_PROGRESS.md as the source of truth.
---

# OneCX Angular 19 Migration Skill

Use this skill when:
- a repository is a OneCX Angular 18 application
- the project uses OneCX UI libs v5.x
- the goal is to prepare for Angular 19 and OneCX UI libs v6.x
- long-running chat sessions tend to drift or become lazy

## Core rules

1. Treat `MIGRATION_PROGRESS.md` as the source of truth.
2. Never mark a migration step completed based only on the index title.
3. For each migration step, open and read the linked OneCX migration page first.
4. If that page contains materially relevant sub-pages, read those too.
5. Extract hierarchical tasks, not just a flat list:
   - parent tasks
   - child tasks
   - grandchild tasks when needed
6. Execute one leaf migration step at a time.
7. Stop after every executed step.
8. On continuation, re-read `MIGRATION_PROGRESS.md` before doing more work.

## Required repositories and docs

- OneCX Angular 18 to 19 migration index
- PrimeNG migration docs if `primeng`, `primeicons`, or `primeflex` are used
- Nx migration docs if the repository is an Nx workspace

## Required progress file shape

Use the structure from [MIGRATION_PROGRESS.template.md](../../templates/MIGRATION_PROGRESS.template.md).
Use the hierarchy contract from [hierarchical-task-extraction.md](../../docs/hierarchical-task-extraction.md).

Each migration step must include:
- state marker
- dependencies
- source pages
- summary
- repository evidence
- files changed
- validation
- edge cases or issues

## Working pattern

### Planning checkpoint
- audit branch, tasks, tests, and baseline
- expand every linked migration page into the progress file
- classify each page as:
  - directory page
  - procedural page
  - simple page
- split parent pages into child tasks when required
- stop

### Execution checkpoint
- re-read the progress file
- execute one leaf step only
- update evidence
- stop

### Validation checkpoint
- validate the latest step
- only then allow completion
- stop

## Good outcomes

- The migration plan can be long and detailed.
- False completion is not allowed.
- Rich structure is encouraged.
- Evidence is mandatory.
- Parent steps are allowed, but they are not complete until their children are resolved.
