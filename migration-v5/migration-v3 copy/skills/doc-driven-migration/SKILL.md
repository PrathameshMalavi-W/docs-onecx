---
name: doc-driven-migration
description: Use this skill for runtime-driven migrations that derive tasks from docs and repository evidence instead of a hardcoded checklist.
---

# Doc-Driven Migration Skill

Use this skill when:
- a repository has migration documentation
- the migration should be derived from docs at runtime
- the workflow needs nested tasks
- the user wants minimal interruptions

## Core rules

1. Treat `MIGRATION_PROGRESS.md` as the source of truth.
2. Require the user to specify the intended target version at migration start.
3. Infer the current migration context from the repo.
4. Discover the docs at runtime.
5. Build a hierarchy:
   - parent tasks
   - child tasks
   - leaf tasks
6. Execute only leaf tasks.
7. Validate before completion.
8. Ask the user only for major actions or missing required input.
9. At the core-upgrade gate, ask for approval first; after approval, perform the upgrade as the agent.

## Good runtime behavior

- reuse the same workflow for different migration versions
- handle conditional steps from docs
- derive applicability from repository evidence
- keep the progress file stable across long sessions
- take the migration target from the init prompt instead of guessing it

## What not to do

- do not hardcode one specific version path unless explicitly requested
- do not flatten directory pages into fake completed tasks
- do not mark steps complete during planning
- do not ask the user routine questions the repo can answer

## Helper resources

- [Architecture](../../docs/architecture.md)
- [Runtime discovery](../../docs/runtime-discovery.md)
- [User interaction policy](../../docs/user-interaction-policy.md)
- [Template](../../templates/MIGRATION_PROGRESS.template.md)
