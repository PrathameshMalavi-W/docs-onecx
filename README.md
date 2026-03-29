# docs-onecx

This repository contains reference docs, prompt variants, and Copilot workflow kits for OneCX Angular migrations.

The migration-related assets in this repo are designed for different tradeoffs:
- lowest setup
- strongest control
- lowest request count
- narrow `18 -> 19` specialization
- reusable runtime-driven workflows for future versions

## What is in this repo

Reference content:
- [docs-lib](./docs-lib) is the local OneCX docs mirror used as a design reference in this repo
- [v5-lib](./v5-lib) is the OneCX UI libs workspace for the Angular 18 generation
- [v6-lib](./v6-lib) is the OneCX UI libs workspace for the Angular 19 generation

Migration workflow assets:
- [ai-prompt.txt](./ai-prompt.txt)
- [ai-prompt-v2.txt](./ai-prompt-v2.txt)
- [ai-prompt-v3.txt](./ai-prompt-v3.txt)
- [copilot-onecx-migration-kit](./copilot-onecx-migration-kit)
- [migration-v2](./migration-v2)
- [migration-v3/migration-v3](./migration-v3/migration-v3)
- [migration-v4](./migration-v4)

## Version overview

| Asset | Scope | Best for | Setup | Execution style | Rough prompt count |
|---|---|---|---|---|---|
| [ai-prompt.txt](./ai-prompt.txt) | Fixed OneCX `18 -> 19` | Original long prompt baseline | none | one pasted prompt, then ad-hoc follow-ups | `1` to start, then variable |
| [ai-prompt-v2.txt](./ai-prompt-v2.txt) | Fixed OneCX `18 -> 19` | Stricter anti-lazy single-paste prompt | none | one pasted prompt with stronger evidence rules | `1` to start, then variable |
| [ai-prompt-v3.txt](./ai-prompt-v3.txt) | Fixed OneCX `18 -> 19` | Checkpointed single-paste prompt | none | one pasted prompt plus explicit resume checkpoints | `1` to start, then `+1` per continuation |
| [copilot-onecx-migration-kit](./copilot-onecx-migration-kit) | Fixed OneCX `18 -> 19` | Narrow custom-agent workflow for Angular 19 target only | custom agents/prompts/instructions | planner + one leaf step + validator | about `2N + 2` |
| [migration-v2](./migration-v2) | Generic runtime-driven workflow | Best balance of control and reuse | custom agents/prompts/instructions | one leaf task per run, with explicit core-upgrade phase | about `2N + 4` |
| [migration-v3/migration-v3](./migration-v3/migration-v3) | Generic runtime-driven workflow | Refined `v2`-style workflow with stronger repo-side guidance | custom agents/prompts/instructions | one leaf task per run, with explicit core-upgrade phase | about `2N + 4` |
| [migration-v4](./migration-v4) | Generic runtime-driven workflow | Lowest prompt count | custom agents/prompts/instructions | one top-level step per run, substeps bundled internally | about `T + 3` |

Request math terms:
- `N` = number of real leaf migration tasks
- `T` = number of top-level migration steps

## Main differences

### `ai-prompt.txt`

Use when:
- you want the original full prompt as a copy-paste starting point

Tradeoff:
- simplest to start
- most likely to drift in long chats

### `ai-prompt-v2.txt`

Use when:
- you want a stronger version of the original prompt without moving to a custom-agent workflow

Tradeoff:
- better evidence rules than the original
- still depends on one long-running chat staying coherent

### `ai-prompt-v3.txt`

Use when:
- you want to stay in plain Copilot Chat
- you want checkpointing without building a full custom-agent kit

Tradeoff:
- much better than the original prompt for long sessions
- still not as structured as the agent-based kits

### `copilot-onecx-migration-kit`

Use when:
- the migration is specifically OneCX Angular `18 -> 19`
- you want a narrow specialized kit

Tradeoff:
- strong specialization
- not intended for `19 -> 20` or future targets

### `migration-v2`

Use when:
- you want a reusable runtime-driven workflow
- you want strong control and evidence at leaf-task granularity

Tradeoff:
- more prompts than `v4`
- strongest general-purpose option here

### `migration-v3`

Use when:
- you want the `v2` model with slightly more refined runtime guidance
- you are okay with the actual kit living under [migration-v3/migration-v3](./migration-v3/migration-v3)

Tradeoff:
- similar request cost to `v2`
- slightly heavier workflow surface

### `migration-v4`

Use when:
- you want the fewest user prompts
- you are comfortable letting one run handle a full top-level step plus its child docs

Tradeoff:
- lowest prompt count
- more work per run, so a very large step can still stress the agent

## Target-version rule

The current recommended rule is:
- the user supplies the target version at the start
- the workflow infers only the current repo state
- the planner validates the requested target against the documented OneCX path

Examples:
- `/migration-init migrate to Angular 19`
- `/migration-init migrate to Angular 20`
- `/onecx-init migrate to Angular 19`

This rule now applies to:
- [migration-v2](./migration-v2)
- [migration-v3/migration-v3](./migration-v3/migration-v3)
- [migration-v4](./migration-v4)
- [copilot-onecx-migration-kit](./copilot-onecx-migration-kit)

Important scope note:
- [copilot-onecx-migration-kit](./copilot-onecx-migration-kit) is intentionally limited to the OneCX `18 -> 19` path

## Minimal setup by version

### No-setup prompt variants

For these files, setup is just:
1. open a fresh Copilot Chat in VS Code
2. paste the prompt text
3. point it at the target repo

Files:
- [ai-prompt.txt](./ai-prompt.txt)
- [ai-prompt-v2.txt](./ai-prompt-v2.txt)
- [ai-prompt-v3.txt](./ai-prompt-v3.txt)

### `copilot-onecx-migration-kit`

Minimum practical setup:
- [onecx-migration.instructions.md](./copilot-onecx-migration-kit/instructions/onecx-migration.instructions.md)
- [onecx-planner.agent.md](./copilot-onecx-migration-kit/agents/onecx-planner.agent.md)
- [onecx-step-executor.agent.md](./copilot-onecx-migration-kit/agents/onecx-step-executor.agent.md)
- [onecx-validator.agent.md](./copilot-onecx-migration-kit/agents/onecx-validator.agent.md)
- [onecx-init.prompt.md](./copilot-onecx-migration-kit/prompts/onecx-init.prompt.md)
- [onecx-next-step.prompt.md](./copilot-onecx-migration-kit/prompts/onecx-next-step.prompt.md)
- [onecx-verify-step.prompt.md](./copilot-onecx-migration-kit/prompts/onecx-verify-step.prompt.md)
- [MIGRATION_PROGRESS.template.md](./copilot-onecx-migration-kit/templates/MIGRATION_PROGRESS.template.md)

### `migration-v2`

Minimum practical setup:
- [migration-runtime.instructions.md](./migration-v2/instructions/migration-runtime.instructions.md)
- [migration-planner.agent.md](./migration-v2/agents/migration-planner.agent.md)
- [migration-step-executor.agent.md](./migration-v2/agents/migration-step-executor.agent.md)
- [migration-validator.agent.md](./migration-v2/agents/migration-validator.agent.md)
- [migration-core-upgrade.agent.md](./migration-v2/agents/migration-core-upgrade.agent.md)
- [migration-init.prompt.md](./migration-v2/prompts/migration-init.prompt.md)
- [migration-next-step.prompt.md](./migration-v2/prompts/migration-next-step.prompt.md)
- [migration-validate.prompt.md](./migration-v2/prompts/migration-validate.prompt.md)
- [migration-core-upgrade.prompt.md](./migration-v2/prompts/migration-core-upgrade.prompt.md)
- [MIGRATION_PROGRESS.template.md](./migration-v2/templates/MIGRATION_PROGRESS.template.md)

### `migration-v3`

Minimum practical setup:
- [migration-runtime.instructions.md](./migration-v3/migration-v3/instructions/migration-runtime.instructions.md)
- [migration-planner.agent.md](./migration-v3/migration-v3/agents/migration-planner.agent.md)
- [migration-step-executor.agent.md](./migration-v3/migration-v3/agents/migration-step-executor.agent.md)
- [migration-validator.agent.md](./migration-v3/migration-v3/agents/migration-validator.agent.md)
- [migration-core-upgrade.agent.md](./migration-v3/migration-v3/agents/migration-core-upgrade.agent.md)
- [migration-init.prompt.md](./migration-v3/migration-v3/prompts/migration-init.prompt.md)
- [migration-next-step.prompt.md](./migration-v3/migration-v3/prompts/migration-next-step.prompt.md)
- [migration-validate.prompt.md](./migration-v3/migration-v3/prompts/migration-validate.prompt.md)
- [migration-core-upgrade.prompt.md](./migration-v3/migration-v3/prompts/migration-core-upgrade.prompt.md)
- [MIGRATION_PROGRESS.template.md](./migration-v3/migration-v3/templates/MIGRATION_PROGRESS.template.md)

### `migration-v4`

Minimum practical setup:
- [migration-bundled.instructions.md](./migration-v4/instructions/migration-bundled.instructions.md)
- [migration-bundled-planner.agent.md](./migration-v4/agents/migration-bundled-planner.agent.md)
- [migration-bundled-step.agent.md](./migration-v4/agents/migration-bundled-step.agent.md)
- [migration-bundled-core-upgrade.agent.md](./migration-v4/agents/migration-bundled-core-upgrade.agent.md)
- [migration-init.prompt.md](./migration-v4/prompts/migration-init.prompt.md)
- [migration-run-step.prompt.md](./migration-v4/prompts/migration-run-step.prompt.md)
- [migration-core-upgrade.prompt.md](./migration-v4/prompts/migration-core-upgrade.prompt.md)
- [MIGRATION_PROGRESS.template.md](./migration-v4/templates/MIGRATION_PROGRESS.template.md)

## Usage quick start

### Prompt-only variants

1. Open a fresh Copilot Chat.
2. Paste one of:
   - [ai-prompt.txt](./ai-prompt.txt)
   - [ai-prompt-v2.txt](./ai-prompt-v2.txt)
   - [ai-prompt-v3.txt](./ai-prompt-v3.txt)
3. Tell Copilot the target repo and target version.
4. Follow the prompt's own checkpointing model.

### `copilot-onecx-migration-kit`

1. Load the kit into VS Code.
2. Run `/onecx-init migrate to Angular 19`.
3. Review `MIGRATION_PROGRESS.md`.
4. Loop `/onecx-next-step` and `/onecx-verify-step`.
5. Use `/onecx-handover` at the upgrade boundary.

### `migration-v2` and `migration-v3`

1. Load the kit into VS Code.
2. Run `/migration-init migrate to Angular 19` or `/migration-init migrate to Angular 20`.
3. Review `MIGRATION_PROGRESS.md`.
4. Loop `/migration-next-step` and `/migration-validate`.
5. Run `/migration-handover` at the upgrade boundary.
6. Reply with approval such as `Go ahead`.
7. Run `/migration-core-upgrade`.
8. Continue `/migration-next-step` and `/migration-validate`.

### `migration-v4`

1. Load the kit into VS Code.
2. Run `/migration-init migrate to Angular 19` or `/migration-init migrate to Angular 20`.
3. Review `MIGRATION_PROGRESS.md`.
4. Loop `/migration-run-step`.
5. Reply with approval such as `Go ahead` at the upgrade gate.
6. Run `/migration-core-upgrade`.
7. Continue `/migration-run-step`.

## Prompt count and premium-request notes

Rough prompt counts in this README are user-prompt counts, not internal tool-call counts.

For GitHub Copilot agent mode in the IDE, GitHub's docs currently say:
- each prompt you enter counts as one premium request, multiplied by the model's multiplier
- follow-up tool calls or agent actions inside the same run do not count as separate premium requests
- if you use an included model with multiplier `0`, those prompts do not consume premium requests

Official references:
- [Asking GitHub Copilot questions in your IDE](https://docs.github.com/copilot/using-github-copilot/asking-github-copilot-questions-in-your-ide?tool=vscode)
- [About premium requests](https://docs.github.com/copilot/managing-copilot/monitoring-usage-and-entitlements/about-premium-requests)

So in practice:
- the formulas above are best used as prompt-count estimates
- actual premium-request cost depends on the selected model
- included-model usage can effectively be `0` premium requests even though prompts are still being sent

## Recommended picks

Choose:
- [ai-prompt-v3.txt](./ai-prompt-v3.txt) if you want the lightest possible starting point without custom agents
- [copilot-onecx-migration-kit](./copilot-onecx-migration-kit) if the work is strictly OneCX `18 -> 19`
- [migration-v2](./migration-v2) if you want the safest reusable workflow
- [migration-v3/migration-v3](./migration-v3/migration-v3) if you want `v2`-style control with slightly more refined repo-side guidance
- [migration-v4](./migration-v4) if minimizing prompt count is the main goal
