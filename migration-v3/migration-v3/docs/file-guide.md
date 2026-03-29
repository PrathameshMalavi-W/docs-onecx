# File Guide

This guide explains every file in `migration-v3` and what it is for.

## Agents

### `agents/migration-orchestrator.agent.md`

What it does:
- entry-point agent
- coordinates planning, execution, validation, and handover

Why it exists:
- gives you one top-level workflow agent
- avoids mixing every concern into one agent

### `agents/migration-planner.agent.md`

What it does:
- discovers the migration at runtime
- reads docs
- creates `MIGRATION_PROGRESS.md`

Why it exists:
- planning should be separate from code changes

### `agents/migration-core-upgrade.agent.md`

What it does:
- performs the core Angular or Angular+Nx upgrade after explicit user approval

Why it exists:
- this makes the approval boundary explicit
- it avoids ambiguity about whether the user or the agent performs the upgrade

### `agents/migration-step-executor.agent.md`

What it does:
- executes exactly one leaf task

Why it exists:
- prevents the model from running too far ahead

### `agents/migration-validator.agent.md`

What it does:
- validates the latest leaf task
- gates completion

Why it exists:
- a step should not become complete just because the agent thinks it is done

### `agents/migration-handover.agent.md`

What it does:
- summarizes current progress and required user actions

Why it exists:
- phase boundaries should be explicit

## Prompts

### `prompts/migration-init.prompt.md`

Purpose:
- starts runtime planning

### `prompts/migration-next-step.prompt.md`

Purpose:
- executes the next leaf task

### `prompts/migration-validate.prompt.md`

Purpose:
- validates the latest leaf task

### `prompts/migration-handover.prompt.md`

Purpose:
- prepares user handover

### `prompts/migration-core-upgrade.prompt.md`

Purpose:
- performs the approved core upgrade phase

## Instructions

### `instructions/migration-runtime.instructions.md`

Purpose:
- always-on behavioral safety rules

Why it exists:
- if the agent drifts, these rules still apply across chats

## Skill

### `skills/doc-driven-migration/SKILL.md`

Purpose:
- reusable migration workflow knowledge

Why it exists:
- good for portability across repositories and future migration versions

## Hooks

### `hooks/checkpoint-guard.json`

Purpose:
- reminder hook file

Why it exists:
- helps preserve discipline around checkpoints and progress-file re-sync

## Scripts

### `scripts/checkpoint-reminder.ps1`

Purpose:
- emits reminder text for hook events

Required:
- no

Use it when:
- you want session reminders before compaction or stop
- you want a hook-based nudge to re-read `MIGRATION_PROGRESS.md`

### `scripts/discover-migration-outline.ps1`

Purpose:
- optional helper script to build a migration-page outline from local docs

Why it exists:
- supports runtime discovery without hardcoding the plan

Required:
- no

Important note:
- in a real OneCX app repo, the planner should usually rely on MCP docs and fallback URLs instead
- this script is mainly for repositories that already contain local migration docs

## Settings

### `settings/vscode.settings.example.json`

Purpose:
- tells VS Code where to find these customizations

## Template

### `templates/MIGRATION_PROGRESS.template.md`

Purpose:
- generic progress-file structure

Why it exists:
- gives the planner a stable target format without hardcoding one exact migration checklist
