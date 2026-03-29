# Delegation and Escalation Policy

## Core Principle

Agents should **delegate or escalate** rather than **skip tasks**, even when tasks are complex. An unresolved task creates technical debt and partial state. Always ask for permission before skipping.

## Decision Tree

```
Task discovered
  ├─ Can agent execute fully? (Yes/No)
  │  ├─ YES → Execute the task
  │  └─ NO → Ask user permission
  │
  ├─ Is repo evidence insufficient? (Yes/No)
  │  ├─ YES → Gather evidence, then ask user
  │  └─ NO → Proceed
  │
  ├─ Is task blocked by dependency? (Yes/No)
  │  ├─ YES → Block task, wait for dependency
  │  └─ NO → Execute
  │
  └─ Is task destructive/risky? (Yes/No)
     ├─ YES → Ask for explicit approval + proceed
     └─ NO → Execute
```

## Delegation vs Escalation vs Skip

| Action             | When                               | Outcome                                                         |
| ------------------ | ---------------------------------- | --------------------------------------------------------------- |
| **Delegate**       | Task is suitable for another agent | Route to appropriate agent (e.g., planner, executor, validator) |
| **Escalate**       | Task requires user decision/action | Ask user 1 concise question; wait for response                  |
| **Skip**           | Task is provably not applicable    | Mark `[-] not applicable` with evidence ONLY                    |
| **Block**          | Task is blocked by dependency      | Mark `[?] blocked - waiting for [X]`                            |
| **Ask Permission** | Task is complex but executable     | Ask user: "Should I proceed? Y/N"                               |

## When to Escalate (Ask User Permission)

### Pattern 1: Ambiguous Applicability

```
Task: "Add standalone: false to [NgModule]"
Evidence: Repo has feature modules (applicable)
But: Feature module pattern is inconsistent in repo

Escalation message:
"I found [feature modules] in [paths].
The migration docs suggest adding standalone: false.
But [some modules] don't follow the pattern.

Should I:
a) Apply to all modules matching the pattern
b) Apply only to [specific modules] you approve
c) Skip this step

Which approach?
```

### Pattern 2: Potentially Destructive Change

```
Task: "Remove all deprecated RouterModule imports"
Evidence: Found 47 occurrences across [paths]

Escalation message:
"I'm about to remove RouterModule imports from 47 files.

Review:
- Modules affected: [list]
- Estimated change size: ~250 lines

Approve? Y/N"
```

### Pattern 3: Complex Dependencies

```
Task: "Update package.json for Angular 19"
Blockers: 
  - PrimeNG version unclear
  - Custom internal package version undefined

Escalation message:
"The migration requires PrimeNG v21.
Current package.json has `"primeng": "^18"`.

Options:
a) Upgrade PrimeNG to v21 (may break components)
b) Keep PrimeNG v18 (defers migration)
c) You decide the PrimeNG version

What's your preference?"
```

### Pattern 4: External Dependencies

```
Task: "Configure Remote Component Config"
Blockers:
  - Requires API endpoint definition
  - Requires feature flag names

Escalation message:
"This step needs:
1. API endpoint URL for remote components
2. Feature flag configuration

Provide these, or should I mark this task as 'blocked - needs external setup'?"
```

## Never Skip; Always Escalate

### ❌ BAD

```
Task: "Set up module federation"
Agent thinks: "This looks complex, I'll skip it"
Result: MIGRATION INCOMPLETE, HARD TO DETECT
```

### ✅ GOOD

```
Task: "Set up module federation"
Agent: "This task requires understanding your app's deployment setup.
I can help, but I need approval first.

Current discovery:
- [paths] have potential federation patterns
- [other paths] may need configuration

Should I proceed? Y/N"

[If Yes]: Agent executes task
[If No]: Agent marks as "blocked - awaiting user setup"
```

## Escalation Message Format

Always follow this structure:

```
Task: [title]
Reason: [why escalation is needed]
Current state: [repo evidence, findings]
Options:
  a) [Option 1 description]
  b) [Option 2 description]
  c) [Option 3 description - often "block/mark not applicable"]
Your choice? [A/B/C]
```

## Task States and Transitions

```
[?] discovered
    ├─ Agent can execute alone
    │  └─ → [~] in-progress → [x] completed
    │
    ├─ Needs user permission
    │  └─ → [?] escalated - awaiting user decision
    │      ├─ User says YES → [~] in-progress → [x] completed
    │      ├─ User says NO/BLOCK → [?] blocked - [reason]
    │      └─ User says SKIP → [-] not applicable - [reason]
    │
    ├─ Blocked by dependency
    │  └─ → [?] blocked - waiting for [task X]
    │      └─ Dependency complete → [~] in-progress → [x] completed
    │
    └─ Provably not applicable
       └─ → [-] not applicable - [evidence]
```

## Minimum Agents Policy

To keep agent count minimal while ensuring task completion:

### Agent Roles (5 agents minimum)

1. **Orchestrator**: Workflow coordinator, no direct execution
2. **Planner**: Discovers all tasks, builds tree, creates MIGRATION_PROGRESS.md
3. **Executor**: Executes EXACTLY ONE leaf task per invocation
4. **Validator**: Validates latest leaf task, opens gates for next tasks
5. **Handover**: Summarizes phase boundaries, prepares user handoffs

### Task Subdivision Within Agents

Rather than creating per-task agents, agents should handle **multiple related tasks** with delegation:

```
Executor: "I found 12 subsections in this procedural page"
Plan: "I'll step through them 1-2 at a time, escalating only when needed"

[Subsection 1] → Execute → Validate ✓
[Subsection 2] → Execute → Validate ✓
[Subsection 3] → Execute → Escalate (asks permission) → Wait

User response: "Proceed with caution"
[Subsection 3] → Execute with logging → Validate ✓
[Subsection 4] → Execute → Validate ✓
...continue
```

## Context Preservation Rules

Each agent MUST:

1. **Read the full MIGRATION_PROGRESS.md** before taking action
2. **Record findings** in MIGRATION_PROGRESS.md before stopping
3. **Link tasks to source pages** - every task must have a `source:` entry
4. **Track page traversal** - record which pages were visited and what was found
5. **Preserve subsection depth** - indent child tasks under parents

### Context Preservation Example

```markdown
# MIGRATION_PROGRESS.md

[~] in-progress | Phase 1: Angular 19 Upgrade (source: [upgrade-guide.md](link))

[x] completed | 1. Update Angular dependencies
  - source: https://onecx.docs/angular19/upgrade.md#dependencies
  - completed: 2024-03-30 14:25

[?] discovered | 2. Update Material (source: https://onecx.docs/angular19/material.md)

  [?] discovered | 2.1 Upgrade @angular/material package
    - source: https://onecx.docs/angular19/material.md#package-upgrade
    
  [?] discovered | 2.2 Update Material API usage
    - source: https://onecx.docs/angular19/material.md#api-breaking-changes
    - pageVisited: 2024-03-30 14:30
    - subsectionsDiscovered: 3
      * Material button API changes
      * Material form field changes
      * Material table changes

  [?] discovered | 2.3 Update component templates
    - source: https://onecx.docs/angular19/material.md#templates

← Executor last stopped here with task 2.2 partially explored
← Needs return to explore all 3 subsections before marking 2 complete
```

## Audit Trail

Every task entry should include:

```markdown
[status] | [Title]
  - source: [link to docs]
  - discovered: [timestamp or "init"]
  - lastChecked: [timestamp]
  - pageVisited: [Y/N]
  - subsectionsCount: [number or N/A]
  - escalations: [number]
  - reason: [if blocked or not applicable]
```

This prevents tasks from being silently skipped or forgotten.
