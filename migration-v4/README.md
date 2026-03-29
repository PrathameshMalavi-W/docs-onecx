# Migration V4

`migration-v4` is the low-request version of the migration workflow.

It is designed for this operating model:
- `1` prompt for initialization and planning
- `1` prompt for each top-level migration step
- `1` approval prompt from the user at the core-upgrade gate
- `1` prompt for the core Angular or Angular+Nx upgrade

This version reduces prompt count by bundling substeps into their parent step.

## What "one request per step" means

In this version:
- a `step` means one top-level migration step from the runtime-discovered guide
- substeps and sub-substeps stay inside that step
- the agent must still fetch and read substep docs, but it handles them inside the same run

For example, if a migration guide contains:
- `Remove keycloak auth`
- `Update component imports`
- `Switch to new components`

then each of those is one execution prompt.

If `Switch to new components` links to several child pages, those child pages are still fetched and used, but they do not become separate user prompts in this variant.

## Approval model

This version keeps the same core-upgrade safety model:
1. the agent performs initialization and planning
2. the agent performs pre-migration steps
3. the agent stops at the core-upgrade gate
4. the user explicitly approves the upgrade
5. the agent performs the core upgrade
6. the agent performs post-migration steps

The user does not have to manually perform the core upgrade unless a real blocker requires it.

## What this preserves from `ai-prompt.txt`

This version still preserves the important root-prompt guardrails:
- `npm install`
- test audit before planning continues
- protected-branch check
- coverage baseline capture when available
- Copilot-instructions audit
- task configuration audit
- OneCX MCP first, then relevant docs, then fallback URLs
- fixed documented Nx migration version
- task-based build, lint, and test when suitable tasks exist
- failure logging into `MIGRATION_PROGRESS.md`
- explicit approval before the core upgrade

The main change is granularity:
- `v2` was optimized for control and evidence per leaf task
- `v4` is optimized for fewer prompts per top-level step

## How `v4` knows which migration to use

`v4` should not guess the target blindly.

The planner should determine the migration family from:
- the user's explicit target version in the init prompt
- `package.json` and lockfile data
- the installed Angular major version such as `@angular/core`
- the installed OneCX library major version such as `@onecx/*`
- workspace indicators such as Nx usage

So the intended behavior is:
- the user tells the workflow what they want to migrate to
- the planner infers what the repo is currently on
- the planner validates that the chosen target matches a documented migration path

For OneCX, the version pairing should be validated against the docs:
- Angular `18` with OneCX libs `v5.x` points to the `18 -> 19` migration guide
- Angular `19` with OneCX libs `v6.x` points to the `19 -> 20` migration guide

If the user does not provide a target version, the planner should stop and ask one concise major question.

If the repo state and the requested target do not line up cleanly with the docs, the planner should stop and ask one concise major question instead of guessing.

## Folder contents

```text
migration-v4/
  agents/
    migration-bundled-core-upgrade.agent.md
    migration-bundled-planner.agent.md
    migration-bundled-step.agent.md
  docs/
    file-guide.md
    setup-and-usage.md
  instructions/
    migration-bundled.instructions.md
  prompts/
    migration-core-upgrade.prompt.md
    migration-init.prompt.md
    migration-run-step.prompt.md
  settings/
    vscode.settings.example.json
  templates/
    MIGRATION_PROGRESS.template.md
```

## Minimum app-repo setup

Copy these into the target app repo:
- `instructions/migration-bundled.instructions.md`
- `agents/migration-bundled-planner.agent.md`
- `agents/migration-bundled-step.agent.md`
- `agents/migration-bundled-core-upgrade.agent.md`
- `prompts/migration-init.prompt.md`
- `prompts/migration-run-step.prompt.md`
- `prompts/migration-core-upgrade.prompt.md`
- `templates/MIGRATION_PROGRESS.template.md`

You can place them in default Copilot locations such as:
- `.github/instructions/`
- `.github/agents/`
- `.github/prompts/`

## Request math

If there are `T` top-level migration steps, the rough request count is:
- `1` for `/migration-init`
- `T` for `/migration-run-step`
- `1` for the user's approval message such as `Go ahead`
- `1` for `/migration-core-upgrade`

So the rough total is:
- `T + 3`

If the user asks extra questions or the workflow hits blockers, add more prompts on top of that.

This is much lower than the `v2` pattern, but it also gives the agent more work per run.

## Start here

1. Read [setup-and-usage.md](./docs/setup-and-usage.md)
2. Read [file-guide.md](./docs/file-guide.md)
3. Copy [vscode.settings.example.json](./settings/vscode.settings.example.json) into the target workspace if you use custom locations
4. Start with `/migration-init migrate to Angular 19` or `/migration-init migrate to Angular 20`
