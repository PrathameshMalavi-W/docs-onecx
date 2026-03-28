# User Interaction Policy

## Goal

The agent should drive routine migration work autonomously.

The user should only be interrupted for:
- major decisions
- missing required input
- external actions the agent cannot perform
- explicit phase gates

## When the agent should ask the user

### Ask the user immediately

- the current branch is `main`, `master`, or `develop`
- the docs are contradictory
- the migration target cannot be inferred from repo state or the user request
- an external dependency, access issue, or manual platform step blocks progress
- a major risky adaptation is needed and the docs do not settle it
- the workflow reaches a required go-ahead boundary

### Do not ask the user for routine things

Do not ask for:
- whether a grep should be run
- whether a package is used if the repo can answer that
- whether a step applies before checking the codebase
- whether the docs should be read
- whether the next unresolved leaf should be executed

## Good prompts to the user

Good prompts are:
- concise
- specific
- only about decisions the user actually must make

Good example:
- "The docs require one of two styles.scss adaptations and the repo does not make the choice clear. Should I use the Nx styles array or Sass @import pattern?"

Bad example:
- "What should I do next?"

## Phase gates

The user should normally be prompted at:
- feature branch gate
- explicit approval before the core Angular or Nx upgrade
- explicit post-upgrade resume point

Clarification:
- the approval gate does not mean the user must manually do the upgrade
- it means the agent must not perform the core upgrade until the user explicitly authorizes it
- after approval, the agent should perform the upgrade itself

## Ambiguity rule

If the agent does not understand the docs well enough to act safely:
- stop
- record the ambiguity in `MIGRATION_PROGRESS.md`
- ask the user one short major question
