---
name: onecx-init
description: Create or refresh MIGRATION_PROGRESS.md for a OneCX Angular 18 to 19 migration.
argument-hint: Optionally add the project name or repo path context.
agent: onecx-planner
---

Create or refresh `MIGRATION_PROGRESS.md` for this repository.

Requirements:
- Use [the migration skill](../skills/onecx-angular19-migration/SKILL.md).
- Use [the hierarchy rules](../docs/hierarchical-task-extraction.md).
- Follow [the progress template](../templates/MIGRATION_PROGRESS.template.md).
- Perform initialization and planning only.
- Fetch the OneCX Angular 18 to 19 migration index and expand every linked migration page before planning.
- Build a hierarchical plan with parent tasks, child tasks, and grandchild tasks when needed.
- Include PrimeNG migration tasks if PrimeNG is used.
- Include Nx migration tasks only if this is an Nx workspace.
- Do not mark future migration action steps completed during planning.
- Stop after Phase 1 and record the next active step.
