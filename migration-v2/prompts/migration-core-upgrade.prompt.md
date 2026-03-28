---
name: migration-core-upgrade
description: Perform the core Angular or Angular+Nx upgrade after explicit user approval.
argument-hint: Use this after pre-migration is complete and the user has said "Go ahead".
agent: migration-core-upgrade
---

Re-read `MIGRATION_PROGRESS.md`, confirm the workflow is at the upgrade gate and that the user has explicitly approved the upgrade, then perform the documented core Angular or Angular+Nx upgrade.

Rules:
- do not ask the user to manually perform the upgrade unless a real blocker requires it
- follow the runtime-discovered docs path
- update `MIGRATION_PROGRESS.md`
- stop after the upgrade step
