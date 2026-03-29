---
name: migration-init
description: Initialize a runtime-driven migration plan and create or refresh MIGRATION_PROGRESS.md.
argument-hint: Required target version, for example `migrate to Angular 19` or `migrate to Angular 20`.
agent: migration-planner
---

Create or refresh `MIGRATION_PROGRESS.md` for this repository.

Requirements:
- require the user-requested target version at the start
- perform Phase 1 initialization first:
  - run `npm install`
  - run tests before planning continues
  - stop if install or test fails
  - check for a protected branch
  - capture coverage baseline if available
  - audit Copilot instructions for version-specific cleanup later
  - verify build, lint, and test task configuration
- infer the migration context at runtime
- discover docs at runtime
- read the migration index and linked pages
- derive the migration hierarchy from the docs
- use local repository evidence for applicability
- use VS Code tasks when suitable tasks exist instead of ad-hoc terminal commands
- if the target version is missing, ask one short question and stop
- ask the user only if a major missing input blocks inference
- stop after planning
