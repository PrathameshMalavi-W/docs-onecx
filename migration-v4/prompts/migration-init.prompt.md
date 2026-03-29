---
name: migration-init
description: Initialize the low-request migration workflow and create or refresh MIGRATION_PROGRESS.md.
argument-hint: Required target version, for example `migrate to Angular 19` or `migrate to Angular 20`.
agent: migration-bundled-planner
---

Create or refresh `MIGRATION_PROGRESS.md` for this repository.

Requirements:
- require the user-requested target version at the start
- run the full initialization phase first
- discover the docs path at runtime
- build top-level executable steps
- keep internal substeps inside each step entry
- do not mark migration steps complete during planning
- if the target version is missing, ask one short question and stop
- stop after planning
