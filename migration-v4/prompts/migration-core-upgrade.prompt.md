---
name: migration-core-upgrade
description: Perform the approved core Angular or Angular+Nx upgrade.
argument-hint: Use this after the workflow reaches the upgrade gate and the user says "Go ahead".
agent: migration-bundled-core-upgrade
---

Re-read `MIGRATION_PROGRESS.md`, confirm the workflow is at the core-upgrade gate and that the user has approved the upgrade, then perform the documented core Angular or Angular+Nx upgrade.

Rules:
- do not ask the user to manually perform the upgrade unless a real blocker requires it
- use the runtime-discovered docs path
- update `MIGRATION_PROGRESS.md`
- stop after the upgrade phase
