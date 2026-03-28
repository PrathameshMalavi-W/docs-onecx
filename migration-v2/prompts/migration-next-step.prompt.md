---
name: migration-next-step
description: Execute the next unresolved leaf task from MIGRATION_PROGRESS.md and stop.
argument-hint: Optionally add blocker or context notes for the next leaf.
agent: migration-step-executor
---

Re-read `MIGRATION_PROGRESS.md` and execute only the first unresolved leaf task whose dependencies are satisfied.

Rules:
- do not execute a parent task while child tasks remain unresolved
- re-open the leaf task's documentation page before changing code
- update evidence in `MIGRATION_PROGRESS.md`
- stop after that one leaf task
