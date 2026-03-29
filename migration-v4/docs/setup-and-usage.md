# Setup And Usage

## Setup in a target app repo

The leanest setup is:
- one instructions file
- three agents
- three prompt files
- one progress template

Recommended locations:
- `.github/instructions/`
- `.github/agents/`
- `.github/prompts/`

If you do not want to use default locations, use the settings example in [vscode.settings.example.json](../settings/vscode.settings.example.json).

## User workflow

### 1. Initialize once

Run:
- `/migration-init migrate to Angular 19`

or:
- `/migration-init migrate to Angular 20`

What happens:
- the planner runs the initialization checks from the root prompt
- it takes the user-requested target version as the intended migration destination
- it discovers the migration path at runtime
- it creates `MIGRATION_PROGRESS.md`
- it groups work into top-level executable steps

Important:
- the target version should be supplied by the user in the init prompt
- if no target is supplied, the planner should ask a short question and stop

### 2. Execute one top-level step at a time

Run:
- `/migration-run-step`

What happens:
- the step agent re-reads `MIGRATION_PROGRESS.md`
- it selects the next unresolved top-level step
- it re-opens that step's page and all relevant linked child pages
- it executes the substeps inside the same run
- it validates the whole step
- it updates `MIGRATION_PROGRESS.md`
- it stops

### 3. Approve the core upgrade when the gate is reached

When the pre-migration steps are done, the step agent should stop and ask for approval.

You then reply with something like:
- `Go ahead`

### 4. Run the core upgrade

Run:
- `/migration-core-upgrade`

What happens:
- the core-upgrade agent re-reads the progress file
- it confirms approval exists
- it fetches the documented upgrade path
- it performs the Angular or Angular+Nx core upgrade
- it updates `MIGRATION_PROGRESS.md`
- it stops

### 5. Continue post-migration

Run again:
- `/migration-run-step`

Repeat until all top-level post-migration steps are complete.

## Behind the scenes

This version minimizes prompts by bundling substeps.

That means:
- the planner creates a detailed plan
- the step executor works at top-level-step granularity
- the user does not send separate prompts for each child task
- the agent still fetches child docs and sub-docs internally when needed

## Tradeoff

This version is cheaper in prompt count than `migration-v2`, but it is more aggressive.

That means:
- fewer prompts
- less chat overhead
- more internal work per run
- a slightly higher risk that a very large step becomes harder for the agent to finish cleanly

For apps with moderate complexity, this is usually a good tradeoff.
