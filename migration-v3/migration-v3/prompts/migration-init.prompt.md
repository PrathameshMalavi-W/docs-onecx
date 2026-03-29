---
name: migration-init
description: Initialize a runtime-driven migration plan and create or refresh MIGRATION_PROGRESS.md.
argument-hint: Required target version, for example `migrate to Angular 19` or `migrate to Angular 20`.
agent: migration-planner
---

Create or refresh `MIGRATION_PROGRESS.md` for this repository.

Requirements:
- require the user-requested target version at the start
- perform the Phase 1 initialization audit before planning:
  - dependency and test audit
  - branch protection
  - coverage baseline when available
  - repository instructions audit
  - task configuration audit
    - inspect whether `.vscode/tasks.json` already exposes suitable build, lint, and test tasks
    - if tasks are added or adjusted, keep `CI=true` and prefer non-watch tests with coverage when supported
- infer the migration context at runtime
- discover docs at runtime
- include PrimeNG and Nx docs when the repo actually uses them
- read the migration index and linked pages
- derive the migration hierarchy from the docs
- split directory pages and multi-action procedural pages into leaf tasks
- use local repository evidence for applicability
- do not change package.json during planning
- treat narrow MCP query results as hints only until the full linked page is verified
- if a baseline install, build, or test is run, inspect full output rather than relying on return code alone
- if the target version is missing, ask one short question and stop
- ask the user only if a major missing input blocks inference
- stop after planning
