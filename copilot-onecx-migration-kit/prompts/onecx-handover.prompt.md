---
name: onecx-handover
description: Prepare the developer handover after pre-migration is complete.
argument-hint: Use this after all pre-migration items are complete.
agent: onecx-validator
---

Prepare the pre-migration handover.

Requirements:
- Re-read `MIGRATION_PROGRESS.md`.
- Confirm that all pre-migration items are complete or explicitly not applicable.
- Summarize:
  - completed OneCX pre-migration work
  - required Angular core upgrade work for the developer
  - expected package family updates
  - major gotchas
- Do not start post-migration work.
- Stop and wait for the developer's explicit "Go".
