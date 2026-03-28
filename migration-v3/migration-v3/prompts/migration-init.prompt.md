---
name: migration-init
description: Initialize a runtime-driven migration plan and create or refresh MIGRATION_PROGRESS.md.
argument-hint: Optionally provide migration family, source version, target version, or docs location if known.
agent: migration-planner
---

Create or refresh `MIGRATION_PROGRESS.md` for this repository.

Requirements:
- infer the migration context at runtime
- discover docs at runtime
- read the migration index and linked pages
- derive the migration hierarchy from the docs
- use local repository evidence for applicability
- ask the user only if a major missing input blocks inference
- stop after planning
