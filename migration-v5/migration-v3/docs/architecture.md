# Architecture

## Goal

Create a migration workflow where the agent derives work from documentation at runtime instead of following a pre-baked migration checklist.

## Design principles

1. Runtime discovery over hardcoded steps
2. Parent/child/leaf task hierarchy
3. `MIGRATION_PROGRESS.md` as source of truth
4. Leaf-only execution
5. Validation before completion
6. Minimal user interruption

## Agent roles

### `migration-orchestrator`

Purpose:
- route work between specialized agents
- provide a single entry point

What it should do:
- send planning to the planner
- send execution to the executor
- send verification to the validator
- send core-upgrade work to the core-upgrade agent after approval
- send phase summary work to the handover agent

### `migration-core-upgrade`

Purpose:
- perform the core Angular or Angular+Nx upgrade after explicit user approval

What it should do:
- re-read `MIGRATION_PROGRESS.md`
- confirm that the workflow is at the upgrade gate
- confirm that the user has explicitly approved the upgrade
- execute the documented Angular or Angular+Nx upgrade path
- update progress
- stop for validation or next phase

### `migration-planner`

Purpose:
- derive the migration tree at runtime

What it should do:
- inspect repository state
- find the relevant migration docs
- build the migration hierarchy
- create `MIGRATION_PROGRESS.md`
- stop

### `migration-step-executor`

Purpose:
- execute one leaf task only

What it should do:
- re-read `MIGRATION_PROGRESS.md`
- select one unresolved leaf step
- re-open that step's docs
- make the changes
- update progress
- stop

### `migration-validator`

Purpose:
- gate completion

What it should do:
- validate the latest leaf
- check build, lint, test, or targeted evidence as appropriate
- decide whether leaf and parent states can be updated

### `migration-handover`

Purpose:
- communicate cross-phase transitions

What it should do:
- summarize what is done
- ask for explicit approval before the core upgrade phase when required
- stop until explicit approval or go-ahead

## Supporting layers

### Instructions

Always-on behavioral rules:
- do not mark steps complete from titles
- re-read `MIGRATION_PROGRESS.md`
- ask the user only when necessary

### Prompt files

User-invoked entry points:
- initialize
- run core upgrade after approval
- execute next step
- validate current step
- generate handover

### Skill

Reusable workflow knowledge:
- runtime discovery rules
- task extraction rules
- completion gates

### Hooks

Session safety net:
- remind the agent to checkpoint before compaction
- remind the agent to use the progress file on resume

### Scripts

Optional helpers:
- build a docs outline from an index file
- support runtime discovery

## State model

The progress file should contain:
- context
- documentation sources
- repository discovery
- ordered plan
- current state snapshot

Each task should contain:
- status marker
- type: parent or leaf
- dependencies
- source pages
- summary
- repository evidence
- files changed
- validation
- edge cases or issues

## Why not hardcode everything

Hardcoding is tempting because it makes one migration feel precise.

But it breaks when:
- docs change
- a new migration version appears
- the docs contain conditional branches
- the app only uses a subset of the documented components
- the same workflow should be reused for another version

Runtime discovery is slower than hardcoding, but much more resilient.

## Approval model

This workflow uses the following approval model:
- the agent performs pre-migration work
- the workflow pauses at the core-upgrade gate
- the user approves the upgrade
- the agent performs the upgrade
- the workflow continues

This matches the intended meaning of:
- do not perform the core upgrade unless explicitly instructed

It does not mean:
- the user must manually perform the upgrade
