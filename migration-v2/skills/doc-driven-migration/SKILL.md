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
2. Start with initialization:
   - dependency install
   - test audit
   - branch protection
   - coverage baseline if available
   - instructions audit
   - task verification
3. Require the user to specify the intended target version at migration start.
4. Infer the current migration context from the repo.
5. Discover the docs at runtime.
6. Build a hierarchy:
   - parent tasks
   - child tasks
   - leaf tasks
7. Execute only leaf tasks.
8. Validate before completion.
9. Ask the user only for major actions or missing required input.
10. At the core-upgrade gate, ask for approval first; after approval, perform the upgrade as the agent.

## OneCX-specific enforcement

- Prefer OneCX MCP first, then PrimeNG or Nx sources as relevant, then fallback URLs.
- Use tasks for build, lint, and test where available, and fall back to terminal only when tasks are not suitable.
- If a build, lint, or test step fails, capture the last 20 useful log lines and record likely causes.
- Use a fixed documented Nx migrate version when Nx upgrade work is required.
- Do not guess ambiguous documentation details.
- Do not guess the migration target; take it from the init prompt and validate it against repo state and docs.
- At the pre-upgrade boundary, prepare a clean checkpoint summary, working tree status, and a concise upgrade cheat-sheet before asking for approval.

## Good runtime behavior

- reuse the same workflow for different migration versions
- handle conditional steps from docs
- derive applicability from repository evidence
- keep the progress file stable across long sessions

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
