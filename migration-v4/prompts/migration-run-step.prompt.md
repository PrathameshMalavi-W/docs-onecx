---
name: migration-run-step
description: Execute the next unresolved top-level migration step and stop.
argument-hint: Optionally add blocker context or a note about the next step.
agent: migration-bundled-step
---

Re-read `MIGRATION_PROGRESS.md` and execute only the next unresolved top-level step whose dependencies are satisfied.

Rules:
- fetch and use the step page and relevant child pages inside this same run
- execute the internal substeps in this one prompt
- validate the step before completion
- update `MIGRATION_PROGRESS.md`
- stop after that one top-level step
