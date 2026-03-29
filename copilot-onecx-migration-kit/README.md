# Copilot OneCX Migration Kit

This folder contains a self-contained GitHub Copilot workflow for preparing OneCX Angular 18 applications that use OneCX UI libs v5.x for migration to Angular 19 with OneCX UI libs v6.x.

It is designed to solve the main failure mode of long-running Copilot chats:
- the plan looks good
- the agent keeps running
- after several minutes it becomes lazy
- it starts marking steps completed from titles instead of from the actual linked documentation pages

This kit avoids that by splitting the work into planning, execution, and validation checkpoints.

## What is included

```text
copilot-onecx-migration-kit/
  agents/
    onecx-orchestrator.agent.md
    onecx-planner.agent.md
    onecx-step-executor.agent.md
    onecx-validator.agent.md
  docs/
    hierarchical-task-extraction.md
  instructions/
    onecx-migration.instructions.md
  prompts/
    onecx-init.prompt.md
    onecx-next-step.prompt.md
    onecx-verify-step.prompt.md
    onecx-handover.prompt.md
  skills/
    onecx-angular19-migration/
      SKILL.md
  hooks/
    checkpoint-guard.json
  scripts/
    checkpoint-reminder.ps1
  settings/
    vscode.settings.example.json
  templates/
    MIGRATION_PROGRESS.template.md
```

## Recommended setup

This kit uses custom locations instead of the default `.github/...` paths so you can keep everything in one folder.

1. Open your workspace in VS Code.
2. Copy the contents of [settings/vscode.settings.example.json](./settings/vscode.settings.example.json) into your workspace `.vscode/settings.json`.
3. Confirm these settings are enabled:
   - `chat.instructionsFilesLocations`
   - `chat.agentFilesLocations`
   - `chat.promptFilesLocations`
   - `chat.agentSkillsLocations`
   - `chat.hookFilesLocations`
   - `chat.useCustomAgentHooks`
4. Open the Chat view in VS Code.
5. Use `/agents`, `/prompts`, or `/skills` to verify that the new customizations are visible.

## Alternative setup

If you prefer the official default GitHub Copilot locations, copy the contents of this folder into these paths in the target repository:

- `instructions/*` -> `.github/instructions/`
- `agents/*` -> `.github/agents/`
- `prompts/*` -> `.github/prompts/`
- `skills/*` -> `.github/skills/`
- `hooks/*.json` -> `.github/hooks/`

The template file can live anywhere, but keeping it in the repository is convenient.

## Suggested usage flow

### Option A: Prompt-driven workflow

1. Run `/onecx-init migrate to Angular 19`
   - This uses the planner agent.
   - It should create or refresh `MIGRATION_PROGRESS.md`.
   - It should take the user-requested target version from the init prompt.
   - It should read the OneCX Angular 19 index and then expand each linked migration page.
   - It should split parent pages, child pages, and section-level actions into hierarchical tasks.
   - It should stop after Phase 1.

2. Review `MIGRATION_PROGRESS.md`
   - Confirm that future migration items are still `[ ] not started` unless they were truly executed.
   - Confirm that each step contains `Source pages`.
   - Confirm that directory pages such as `switch-to-new-components` became parent steps with child tasks.
   - Confirm that procedural pages such as `update-component-imports`, `update-translations`, and `remove-portal-layout-styles` were split into child tasks.

3. Run `/onecx-next-step`
   - This uses the step executor.
   - It must execute exactly one unresolved leaf step.
   - It must update `MIGRATION_PROGRESS.md`.
   - It must stop.

4. Run `/onecx-verify-step`
   - This uses the validator.
   - It checks whether the current step can really become `[x] completed`.

5. Repeat `/onecx-next-step` and `/onecx-verify-step`
   - Continue until all pre-migration steps are complete.

6. Run `/onecx-handover`
   - This prepares the developer handover before the Angular core upgrade.

7. After the Angular 19 upgrade is performed by the developer, resume with `/onecx-next-step`
   - The executor should re-read `MIGRATION_PROGRESS.md` and continue with the first unresolved post-migration step.

### Option B: Agent-driven workflow

Use the agents directly from the agent picker:

- `onecx-orchestrator`
  - entry point with handoffs
- `onecx-planner`
  - documentation expansion and plan creation
- `onecx-step-executor`
  - one migration step at a time
- `onecx-validator`
  - validation and completion gating

## Why this works better than one long prompt

- Planning is separated from execution.
- The planner can model parent steps, child steps, and sub-steps instead of flattening everything.
- The executor is forced to do one leaf step only.
- The validator is forced to check evidence before completion.
- The instructions file keeps core anti-lazy rules active across chats.
- The hook reminds the session to re-read `MIGRATION_PROGRESS.md` before continuing after context compaction.
- The skill keeps the process reusable across repositories.

## Notes

- This kit assumes the target repository has access to the OneCX MCP server when available.
- This kit is intentionally scoped to the OneCX Angular `18 -> 19` path. The init prompt should therefore specify `Angular 19` as the target version.
- If the user requests a different target version, the planner should stop and tell them to use a more generic workflow such as `migration-v2`, `migration-v3`, or `migration-v4`.
- If the MCP server is unavailable, the workflow should fall back to the documented OneCX public migration pages.
- For Nx workspaces, the planner should include the OneCX Nx migration page and the documented fixed `nx migrate` version.
- For PrimeNG usage, the planner should include PrimeNG migration tasks in the post-migration phase.
- The hierarchy rules are documented in [hierarchical-task-extraction.md](./docs/hierarchical-task-extraction.md).

## Official references

- VS Code custom agents:
  [code.visualstudio.com/docs/copilot/customization/custom-agents](https://code.visualstudio.com/docs/copilot/customization/custom-agents)
- VS Code prompt files:
  [code.visualstudio.com/docs/copilot/customization/prompt-files](https://code.visualstudio.com/docs/copilot/customization/prompt-files)
- VS Code agent skills:
  [code.visualstudio.com/docs/copilot/customization/agent-skills](https://code.visualstudio.com/docs/copilot/customization/agent-skills)
- VS Code hooks:
  [code.visualstudio.com/docs/copilot/customization/hooks](https://code.visualstudio.com/docs/copilot/customization/hooks)
