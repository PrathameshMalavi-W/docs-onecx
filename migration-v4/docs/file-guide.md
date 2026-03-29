# File Guide

## `instructions/migration-bundled.instructions.md`

Always-on rules for the low-request workflow.

Purpose:
- preserve the root prompt guardrails
- keep top-level-step execution disciplined
- stop the agent from marking steps complete from titles alone

## `agents/migration-bundled-planner.agent.md`

The initialization and planning agent.

Purpose:
- run Phase 1 initialization
- discover docs at runtime
- create `MIGRATION_PROGRESS.md`
- define top-level steps and internal substeps

## `agents/migration-bundled-step.agent.md`

The main execution agent.

Purpose:
- execute one top-level step in one prompt
- fetch substep docs inside the same run
- validate the full step before completion

## `agents/migration-bundled-core-upgrade.agent.md`

The core-upgrade agent.

Purpose:
- stop the workflow from upgrading Angular too early
- perform the actual core upgrade after explicit approval

## `prompts/migration-init.prompt.md`

Starts initialization and planning.

## `prompts/migration-run-step.prompt.md`

Runs the next top-level step.

## `prompts/migration-core-upgrade.prompt.md`

Runs the approved core-upgrade phase.

## `templates/MIGRATION_PROGRESS.template.md`

The shared progress-file structure.

Purpose:
- keep top-level steps visible
- keep internal substeps documented inside the parent step

## `settings/vscode.settings.example.json`

Optional settings if you keep this workflow in a custom folder instead of default Copilot locations.
