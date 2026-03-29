# Agent Behavior Reference

Quick lookup for the new agent behaviors.

---

## Migration Planner

**What Changed**:
1. Performs **DEEP DISCOVERY** instead of shallow page reading
2. Visits **EVERY link** instead of assuming from titles
3. Extracts **EVERY H2 heading** as potential task
4. Maintains **full context stack** (doesn't discard parent pages)
5. Records **subsection count** in task entries

**Key Rules**:
```
❌ "Don't assume page 'Material Migration' is just a package upgrade"
✓ "Visit the page, read all sections, create task per section"

❌ "If 4 links exist, plan 2-3 tasks"
✓ "Visit all 4 links, count actual subtasks"

❌ "Collapse all sections into parent task"
✓ "Create one leaf task per H2 section"
```

**Output**:
```markdown
# MIGRATION_PROGRESS.md

[?] discovered | Phase 1: Upgrade
  [?] 1.1 Core Dependencies (src: docs/core.md#deps)
  [?] 1.2 Refactor Components (src: docs/components.md)
      - subsectionsCount: 7
      - nested-links: [signals-guide, binding-changes, ...]
  [?] 1.3 Update Styles (src: docs/styles.md)
      - subsectionsCount: 3
```

---

## Migration Executor

**What Changed**:
1. **NEVER skips** complex tasks (escalates instead)
2. Executes subsection **COMPLETELY** (not just partially)
3. Asks user **permission** before risky changes
4. Records **evidence** of what changed
5. Records **escalation history** if asked user

**Key Rules**:
```
❌ "This looks complex, I'll skip it"
✓ "This is complex. [asks user] Should I proceed? Y/N"

❌ "I'll just do the first 2 subsections"
✓ "I'll do all subsections in this section"

❌ "No audit trail of what happened"
✓ "Records timestamps, file changes, test results"
```

**Escalation Pattern**:
```markdown
Found: [Task Title]

Reason: [Why needs decision]
Current state: [repo evidence]

Options:
a) Proceed with caution
b) Mark as blocked (defer)
c) Skip (with evidence)

Your choice? [A/B/C]
```

**Output**:
```markdown
[x] completed | Update Material API
  - source: docs/material.md#api-changes
  - executed: 2024-03-30 14:25-14:35
  - evidence: [list of files changed]
  - tests: [passed/failed]
  - escalations: 1 (user approved API refactor)
```

---

## Delegation vs Escalation vs Skip

**Decision Tree**:

```
Task discovered
  │
  ├─ Can independently execute?
  │  ├─ NO: Escalate (ask user)
  │  └─ YES: Check applicability
  │
  ├─ Is definitely not applicable?
  │  ├─ NO: Proceed to "Risky?"
  │  └─ YES: Mark not applicable (with evidence)
  │
  └─ Is risky/complex/ambiguous?
     ├─ YES: Escalate (ask permission)
     └─ NO: Execute
```

**Never silently skip** - always ask or mark blocked.

---

## Subsection Tasks

**How Subsections Become Tasks**:

```
Page: Angular 19 Component Migration

[H2] Convert to Standalone Components
  └─ [?] 1.1 Convert to Standalone Components
     - source: docs/components.md#standalone
     - complexity: moderate
     - subsectionsCount: 3

[H2] Signal-based State Management
  └─ [?] 1.2 Signal-based State Management
     - source: docs/components.md#signals
     - complexity: complex

[H2] Event Binding Changes  
  └─ [?] 1.3 Event Binding Changes
     - source: docs/components.md#event-bindings
     - complexity: simple
```

Each subsection = 1 leaf task
Executor handles 1 subsection per invocation
Next invocation handles next subsection

---

## Context Persistence

**What Gets Recorded**:

```markdown
[status] | [Task Title]
  - source: [link to docs page or section]
  - type: parent|child|leaf
  - complexity: simple|moderate|complex
  - applicability: must-have|nice-to-have|unknown
  - subsectionsCount: [N] (if directory page)
  - pageVisited: [timestamp or "init"]
  - description: [from docs opening paragraph]
  - prerequisites: [if any]
  - executed: [timestamp] (on completion)
  - evidence: [file changes or test results]
  - escalations: [count of times user asked]
  - nextStep: [link to next task]
```

**Nothing is discarded.** MIGRATION_PROGRESS.md is always accurate.

---

## MCP Server Usage

**Pattern: Narrow Result = Hint Only**

```
MCP query: "Show migration steps for Angular 19"
Result: [Snippet with 3-4 items]
        (narrow, incomplete)
        
WRONG: "I'll plan only these 3-4 tasks" ❌
CORRECT: "These are hints. I'll fetch the full page and extract all tasks" ✓
```

**Always**:
1. Query MCP to get discovery hints
2. Fetch full page from link
3. Extract all H2 sections
4. Create tasks for each section
5. Record subsection count

---

## Red Flags: When to Escalate

| Red Flag                                               | Action                              |
| ------------------------------------------------------ | ----------------------------------- |
| "Optional" or "if applicable" section                  | Check repo evidence, ask if unclear |
| "Advanced" or "expert-only"                            | Escalate with options               |
| Large structural change (50+ lines, 10+ files)         | Ask permission                      |
| Potentially destructive (removes old code/imports)     | Ask permission                      |
| External dependency (API config, keys, tokens)         | Ask user to provide or defer        |
| Ambiguous applicability (conflicting patterns in repo) | Ask which pattern to apply          |
| Security change                                        | Ask permission                      |
| Performance-impacting                                  | Ask permission                      |

---

## Task Progression Flow

```
[?] discovered (planner found it)
    ├─ Executor can execute alone
    │  └─ [~] in-progress (executor working)
    │      └─ [x] completed (validator approved)
    │
    ├─ Needs user decision
    │  └─ [?] blocked - needs permission (executor asks)
    │      ├─ User says YES
    │      │   └─ [~] in-progress
    │      │       └─ [x] completed
    │      ├─ User says NO/DEFER
    │      │   └─ [?] blocked - awaiting [reason]
    │      └─ User says SKIP
    │          └─ [-] not applicable - [reason]
    │
    ├─ Blocked by dependency
    │  └─ [?] blocked - waiting for [task X]
    │      └─ Dependency done → [x] by executor
    │
    └─ Provably not applicable
       └─ [-] not applicable - [repo evidence]
```

---

## Message Examples

### Ambiguous Optional Step

```
Found: Enable Feature X

The docs say "if using Feature X".
Repo evidence: [3 files reference feature flag, 8 don't]

Is Feature X enabled in your app?
a) Yes, enable it everywhere
b) No, skip this step
c) Only in specific modules

Your choice? [A/B/C]
```

### Destructive Large Change

```
Found: Remove unused Angular Material imports

I found 47 occurrences across:
  - libs/ui-components/ (12 files)
  - libs/shared/ (23 files)
  - apps/ (12 files)

Estimated removal: ~400 lines

Should I:
a) Proceed (I'll log all changes)
b) Defer (mark as blocked)
c) Do specific files only (you choose which)

Your choice? [A/B/C]
```

### Missing External Input

```
Found: Set up remote component configuration

This requires:
1. API endpoint URL for remote components
2. Feature flag names for component loading

Current repo: [no remote component config found]

Do you have this information?
a) Yes, here it is: [I'll provide]
b) No, needs external setup (mark as blocked)
c) This app doesn't use remote components (skip)

Your choice? [A/B/C]
```

---

## Minimal Agent Architecture

**5 Agents Only** (no per-task overhead):

1. **migration-orchestrator**
   - Routes to other agents
   - Never executes tasks
   - Handles user requests

2. **migration-planner**
   - Runs once per migration init
   - Deep discovery protocol
   - Creates MIGRATION_PROGRESS.md

3. **migration-step-executor**
   - Runs repeatedly (once per leaf task)
   - Executes 1 subsection completely
   - Asks for permission if needed
   - Updates MIGRATION_PROGRESS.md

4. **migration-validator**
   - Runs after executor (auto or manual)
   - Validates leaf task
   - Opens gates for next tasks
   - Records validation results

5. **migration-handover**
   - Runs at phase boundaries
   - Summarizes progress
   - Lists incomplete/blocked tasks
   - Prepares user for next phase

**Why 5?**
- Each agent has distinct responsibility
- No agent multiplication with task count
- Planner discovers 1000 tasks → 1 invocation
- Executor handles all 1000 tasks sequentially
- Total invocations: 1 plan + 1000 executions + 1000 validations = manageable

---

## Validation Checklist

Before using in production, verify:

- [ ] Planner discovers and records ALL subsections (no collapsing)
- [ ] Executor records evidence of execution (files changed, tests run)
- [ ] Escalations record user choices and reasons
- [ ] Context never lost between invocations
- [ ] MIGRATION_PROGRESS.md format consistent across all entries
- [ ] Source page links included for every task
- [ ] Subsection count recorded for directory pages
- [ ] MCP results treated as hints (full pages always visited)

---

## Migration from Old Workflow

If you have old MIGRATION_PROGRESS.md files:

1. Planner will read old file
2. Add deep discovery metadata to existing tasks
3. Fill in missing subsection entries
4. Remove collapsed parent tasks (expand to subsections)
5. Re-validate applicability with repo evidence
6. Record discovery findings

**No data loss.** Existing progress is enhanced, not replaced.

---

## References

- [deep-discovery-protocol.md](./deep-discovery-protocol.md) - Phase 1-4 workflow
- [delegation-policy.md](./delegation-policy.md) - Escalation rules
- [IMPROVEMENTS-SUMMARY.md](./IMPROVEMENTS-SUMMARY.md) - Full change summary
