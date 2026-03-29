# Migration V3

This folder contains a runtime-driven GitHub Copilot workflow kit for documentation-based migrations.

It is designed to solve two problems:
- long-running agent sessions drift, become lazy, or mark broad steps completed too early
- hardcoded step lists do not generalize well to other versions, future migrations, or different documentation sets

This version is intentionally not tied to a single migration path. Instead, the planner is expected to derive the migration tree at runtime from:
- the repository state
- the migration documentation index
- linked migration pages
- relevant linked sub-pages
- section headings that represent concrete actions

## Important reality check

The `docs-lib` folder in this repository was used only as a reference to design the workflow.

In a real OneCX application repository, the workflow should normally use:
1. OneCX MCP
2. PrimeNG MCP if relevant
3. Nx docs or Nx MCP if relevant
4. fallback URLs only when MCP is unavailable

The target application repo is not expected to contain a local `docs-lib` copy.

## What this kit is for

Use this kit when:
- the migration is documented in a docs site, docs folder, or MCP server
- the docs have an index page and linked detail pages
- the migration contains conditional branches, sub-steps, and sometimes sub-sub-steps
- you want the agent to drive the work with minimal user interruption

This kit is especially suitable for:
- OneCX Angular 18 to 19
- OneCX Angular 19 to 20
- future OneCX migration families
- other documentation-driven upgrade workflows that follow a similar pattern

## What this kit is not

It is not a hardcoded checklist for one specific migration version.

It is also not a full parser-based automation pipeline yet. It is a runtime-guided agent workflow that:
- derives tasks dynamically
- keeps progress in a structured file
- executes one leaf step at a time
- asks the user only for major decisions or missing required input

## Chosen approval model

This workflow is standardized on this model:

1. the agent performs pre-migration work
2. the agent pauses before the core Angular or Nx upgrade
3. the user gives explicit approval such as "Go ahead"
4. the agent performs the core upgrade itself
5. the agent continues with post-migration work

So the user does not have to manually perform the core upgrade unless they want to.

## How `migration-v3` chooses the migration path

`migration-v3` should not guess the target version blindly.

The intended behavior is:
- the user states the desired target version in the init prompt
- the planner infers the current repo state
- the planner matches the requested target against the documented migration guides

For OneCX, this usually means:
- Angular `18` plus OneCX libs `v5.x` can map to the `18 -> 19` guide
- Angular `19` plus OneCX libs `v6.x` can map to the `19 -> 20` guide

If the target version is missing, or if the repo state and requested target do not line up with a documented path, the planner should stop and ask one concise major question.

## Folder contents

```text
migration-v3/
  agents/
    migration-core-upgrade.agent.md
    migration-orchestrator.agent.md
    migration-planner.agent.md
    migration-step-executor.agent.md
    migration-validator.agent.md
    migration-handover.agent.md
  docs/
    architecture.md
    file-guide.md
    runtime-discovery.md
    usage-and-workflow.md
    user-interaction-policy.md
  hooks/
    checkpoint-guard.json
  instructions/
    migration-runtime.instructions.md
  prompts/
    migration-core-upgrade.prompt.md
    migration-handover.prompt.md
    migration-init.prompt.md
    migration-next-step.prompt.md
    migration-validate.prompt.md
  scripts/
    checkpoint-reminder.ps1
    discover-migration-outline.ps1
  settings/
    vscode.settings.example.json
  skills/
    doc-driven-migration/
      SKILL.md
  templates/
    MIGRATION_PROGRESS.template.md
```

## Start here

1. Read [architecture.md](./docs/architecture.md)
2. Read [usage-and-workflow.md](./docs/usage-and-workflow.md)
3. Read [file-guide.md](./docs/file-guide.md)
4. Copy [vscode.settings.example.json](./settings/vscode.settings.example.json) into your workspace `.vscode/settings.json`
5. Open Copilot Chat in VS Code
6. Start with `/migration-init migrate to Angular 19` or `/migration-init migrate to Angular 20`

## Minimal setup in the target OneCX app repo

The user does not need every file from this folder in the target application repository.

### Required for actual migration use

These are the files or concepts you really need:

1. One always-on instructions file
   - `instructions/migration-runtime.instructions.md`

2. Four core agents
   - `agents/migration-planner.agent.md`
   - `agents/migration-step-executor.agent.md`
   - `agents/migration-validator.agent.md`
   - `agents/migration-core-upgrade.agent.md`

3. Four core prompt files
   - `prompts/migration-init.prompt.md`
   - `prompts/migration-next-step.prompt.md`
   - `prompts/migration-validate.prompt.md`
   - `prompts/migration-core-upgrade.prompt.md`

4. One progress template
   - `templates/MIGRATION_PROGRESS.template.md`

5. One VS Code settings configuration
   - either use the default `.github/...` layout
   - or use the custom folder layout with `settings/vscode.settings.example.json`

6. Access to the required documentation sources
   - OneCX MCP preferred
   - PrimeNG MCP if relevant
   - fallback URLs if MCP is unavailable

### Useful but optional

- `agents/migration-orchestrator.agent.md`
- `agents/migration-handover.agent.md`
- `prompts/migration-handover.prompt.md`
- `skills/doc-driven-migration/SKILL.md`
- `hooks/checkpoint-guard.json`
- `scripts/checkpoint-reminder.ps1`
- `scripts/discover-migration-outline.ps1`
- the docs in `docs/`

### Simplest app-repo setup

If you want the leanest practical setup in a OneCX app repo, copy only:
- one instructions file
- planner agent
- step executor agent
- validator agent
- core-upgrade agent
- init prompt
- next-step prompt
- validate prompt
- core-upgrade prompt
- progress template

Everything else is optional.

## Setup summary

This kit uses custom discovery locations so you can keep everything under one folder.

Enable these settings:
- `chat.instructionsFilesLocations`
- `chat.agentFilesLocations`
- `chat.promptFilesLocations`
- `chat.agentSkillsLocations`
- `chat.hookFilesLocations`
- `chat.useCustomAgentHooks`

See [vscode.settings.example.json](./settings/vscode.settings.example.json).

### Easiest placement option

For the target app repository, the simplest approach is usually to use the default GitHub Copilot locations instead of custom locations:

- `.github/instructions/`
- `.github/agents/`
- `.github/prompts/`
- `.github/skills/`
- `.github/hooks/`

If you use the default locations, you may not need the custom-location settings at all.

## Main operating model

### 1. Runtime planning

The planner should:
- take the intended target from the user prompt and infer the current repo state
- discover the relevant migration docs at runtime
- read the migration index
- read each linked migration page
- classify pages as directory pages, procedural pages, or simple pages
- derive parent tasks, child tasks, and leaf tasks
- create `MIGRATION_PROGRESS.md`
- stop

In a real OneCX app repo, this should usually mean:
- use OneCX MCP first
- then PrimeNG MCP if the repo uses PrimeNG
- then Nx docs if the repo is an Nx workspace
- then fallback URLs only when MCP is unavailable

### 2. Leaf execution

The executor should:
- re-read `MIGRATION_PROGRESS.md`
- pick the first unresolved leaf task whose dependencies are satisfied
- re-read the linked page for that leaf
- execute only that leaf
- update the progress file
- stop

### 3. Validation

The validator should:
- validate the latest leaf task
- decide whether it can become completed
- check whether parent completion gates are now satisfied
- update the progress file
- stop

### 4. Handover

The handover agent should:
- summarize completed pre-migration work
- request explicit approval before the core upgrade phase

### 5. Core upgrade after approval

After the user gives explicit approval, the core-upgrade agent should:
- perform the Angular or Angular+Nx core upgrade itself
- follow the documented upgrade path
- update `MIGRATION_PROGRESS.md`
- stop before or after validation depending on the workflow state

## User interruption policy

The user should only be prompted when:
- the current branch is protected and migration work should not continue
- the docs are ambiguous or contradictory
- the repo lacks enough information to infer the correct migration path
- an external step must be performed by the user
- a major risky choice has to be made
- the workflow requires an explicit go-ahead between phases

See [user-interaction-policy.md](./docs/user-interaction-policy.md).

## Why this version is better

- It is not tied to Angular 19 only
- It expects step discovery at runtime
- It models nested tasks
- It pushes the agent to act autonomously for routine work
- It limits user prompts to major or necessary decisions
- It keeps the core upgrade behind explicit approval without forcing the user to do that upgrade manually

## What the scripts do

### `scripts/checkpoint-reminder.ps1`

This is a helper for hooks.

What it does:
- prints reminder messages at session start, before context compaction, and on stop
- reminds the agent to re-read `MIGRATION_PROGRESS.md`
- reminds the agent to checkpoint state before long sessions are compacted

What it does not do:
- it does not discover migration docs
- it does not generate the migration plan
- it does not execute migration steps

This script is optional.

### `scripts/discover-migration-outline.ps1`

This is an optional helper for local docs.

What it does:
- reads a local migration index file
- extracts linked `.adoc` pages
- lists headings and optional nested xrefs
- helps the planner build an outline if local migration docs exist in the repo

What it does not do:
- it is not required for the normal OneCX MCP-based workflow
- it is not the main discovery mechanism for a real OneCX app repo

Because your real workflow should use MCP or fallback URLs, this script is optional and mainly useful when a repo already contains local migration docs.

## Official references

- VS Code custom agents:
  [code.visualstudio.com/docs/copilot/customization/custom-agents](https://code.visualstudio.com/docs/copilot/customization/custom-agents)
- VS Code prompt files:
  [code.visualstudio.com/docs/copilot/customization/prompt-files](https://code.visualstudio.com/docs/copilot/customization/prompt-files)
- VS Code agent skills:
  [code.visualstudio.com/docs/copilot/customization/agent-skills](https://code.visualstudio.com/docs/copilot/customization/agent-skills)
- VS Code hooks:
  [code.visualstudio.com/docs/copilot/customization/hooks](https://code.visualstudio.com/docs/copilot/customization/hooks)
- VS Code custom instructions:
  [code.visualstudio.com/docs/copilot/customization/custom-instructions](https://code.visualstudio.com/docs/copilot/customization/custom-instructions)
