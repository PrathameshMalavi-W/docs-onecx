# Usage And Workflow

## Recommended workflow

### Phase 1: Initialization and planning

Run:
- `/migration-init`

Expected result:
- the planner audits the repo
- the planner discovers the migration docs at runtime
- the planner creates `MIGRATION_PROGRESS.md`
- the planner stops

What you should review:
- the inferred migration context
- the chosen doc sources
- whether the hierarchy looks correct
- whether parent tasks and leaf tasks make sense

### Phase 2: Execute the next leaf step

Run:
- `/migration-next-step`

Expected result:
- the executor re-reads `MIGRATION_PROGRESS.md`
- it picks the first unresolved leaf
- it executes only that leaf
- it updates the progress file
- it stops

### Phase 3: Validate the current leaf

Run:
- `/migration-validate`

Expected result:
- the validator checks the latest leaf
- it updates evidence and validation output
- it decides whether the leaf can be completed
- it updates any parent completion gate if applicable

### Phase 4: Repeat

Repeat:
- `/migration-next-step`
- `/migration-validate`

### Phase 5: Handover

Run:
- `/migration-handover`

Expected result:
- the handover agent summarizes what is done
- it asks for explicit approval before the core upgrade phase

### Phase 6: Core upgrade after approval

When the user says "Go ahead" or otherwise explicitly approves the upgrade, run:
- `/migration-core-upgrade`

Expected result:
- the core-upgrade agent re-reads `MIGRATION_PROGRESS.md`
- it confirms the workflow is at the upgrade gate
- it performs the documented core Angular or Angular+Nx upgrade itself
- it updates the progress file
- it stops

### Phase 7: Resume post-migration execution

After the core upgrade is done, continue with:
- `/migration-next-step`
- `/migration-validate`

## When the user should be asked something

Only ask the user when:
- a protected branch blocks execution
- docs are ambiguous
- the migration target cannot be inferred
- an external change is required
- a risky decision has to be made
- the next phase explicitly requires approval

Routine applicability checks should not be pushed to the user.

## Suggested chat pattern

1. Start a fresh chat
2. Run `/migration-init`
3. Review the plan
4. Run `/migration-next-step`
5. Run `/migration-validate`
6. Repeat until pre-migration is complete
7. Run `/migration-handover`
8. After the user explicitly approves the core upgrade, run `/migration-core-upgrade`
9. Continue with `/migration-next-step`

## Optional helper script use

If the docs are local and the planner needs help building an outline, run:
- `scripts/discover-migration-outline.ps1`

This is optional. The workflow is designed so the agent can still do runtime discovery without it.
