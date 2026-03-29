# Agent Workflow Improvements: Implementation Summary

**Date**: March 30, 2026  
**Scope**: Minimal agent pipeline with exhaustive task handling and delegation  
**Target**: OneCX migration workflows using MCP server

---

## What Changed

Your agent workflow has been enhanced to implement:

1. **Deep discovery protocol** - exhaustive page traversal
2. **Delegation and escalation** - no lazy task skipping
3. **Subsection-as-tasks** - each H2 heading is a distinct task
4. **Context persistence** - full task tree maintained
5. **Minimal agents** - 5 core agents handling complete workflows

---

## Core Improvements

### 1. Deep Discovery Protocol (`docs/deep-discovery-protocol.md`)

**Problem**: Agents assumed task meaning from headlines and skipped complex pages.

**Solution**: 4-phase protocol for thorough discovery:
- **Phase 1: Page Entry** - Identify page type (directory/procedural/simple)
- **Phase 2: Link Traversal** - Visit EVERY link, do not assume from title
- **Phase 3: Subsection Extraction** - Extract every H2 heading as a potential task
- **Phase 4: Context Stacking** - Maintain full parent/child context tree

**Key Rules**:
```
Page title "Material Migration" ≠ plan only package upgrades
    → MUST visit and read all sections
    
Page contains 4 links ≠ assumes 2 tasks only
    → MUST visit ALL 4 links and count actual subtasks
    
Procedural page with 6 H2 sections ≠ flatten to 1 task
    → Create 6 distinct leaf tasks, 1 per section
```

### 2. Delegation Policy (`docs/delegation-policy.md`)

**Problem**: Agents skipped complex tasks instead of asking for permission.

**Solution**: Explicit escalation workflow with user Decision options.

**No More Skipping**:
```
BAD:   Found complex task → Agent silently skips → Task forgotten ❌
GOOD:  Found complex task → Agent asks permission → User decides → Task recorded ✓
```

**Escalation Pattern**:
```markdown
### Found: [Task Title]

Reason: [Why needs permission]
Current state: [repo evidence]

Options:
a) Execute (I'll handle it with caution)
b) Defer (mark as blocked)
c) Skip (only with your approval)

Your choice? [A/B/C]
```

**Outcomes**:
- `a) Execute` → Agent proceeds, logs in MIGRATION_PROGRESS.md
- `b) Defer` → Task marked `[?] blocked - waiting for...`
- `c) Skip` → Task marked `[-] not applicable - reason with evidence`

### 3. Subsection-as-Tasks Model

**Problem**: Procedural pages collapsed into single tasks, missing execution granularity.

**Solution**: Each H2 heading = 1 leaf task, executed sequentially.

**Example: Angular 19 Component Migration Page**
```
Page: docs/angular19/components.md
Found 5 sections (H2 headings):
  [?] 1.1 Convert to Standalone Components
      ├─ source: docs/angular19/components.md#standalone
      ├─ subsections: 3
      └─ pageVisited: 2024-03-30 14:25
  
  [?] 1.2 Update Signal-based State
      ├─ source: docs/angular19/components.md#signals
      ├─ subsections: 2
      └─ nested-links: [signals-guide.md, rxjs-migration.md]
  
  [?] 1.3 Migrate Event Bindings
      └─ ...
  
  [?] 1.4 Update Template Syntax
      └─ ...
  
  [?] 1.5 OneTime Bindings
      └─ ...
```

**Execution**: Executor handles 1.1, then stop. Next run handles 1.2, etc.

### 4. Context Persistence Rules

**Problem**: Agents visited pages, extracted info, then discarded context.

**Solution**: Every task entry records:
```markdown
[?] discovered | [Task Title]
  - source: https://docs/path#section
  - type: parent|child|leaf
  - complexity: simple|moderate|complex
  - applicability: must-have|nice-to-have|unknown
  - subsectionsCount: [N]
  - pageVisited: [timestamp]
  - description: [from docs]
```

No context lost. MIGRATION_PROGRESS.md is always accurate and complete.

### 5. Minimal Agent Architecture

**5 Core Agents** (no per-task agents):

| Agent            | Role                 | Scope                                                      |
| ---------------- | -------------------- | ---------------------------------------------------------- |
| **Orchestrator** | Workflow coordinator | Routes to other agents, never executes                     |
| **Planner**      | Discovery & planning | Reads docs, runs deep discovery, creates task tree         |
| **Executor**     | Implementation       | Executes 1 leaf task completely, asks permission if needed |
| **Validator**    | Quality check        | Validates leaf task, updates gates                         |
| **Handover**     | Phase summaries      | Reports progress at phase boundaries                       |

**Task Scaling Within Agents**:
- Agents don't multiply with task count
- Planner discovers 100 tasks → 1 invocation
- Executor runs tasks sequentially → reused for all tasks
- No per-task agent overhead

---

## Updated Files

### 1. New Documentation

**[deep-discovery-protocol.md](./docs/deep-discovery-protocol.md)** (NEW)
- 4-phase discovery workflow
- Pseudocode for thorough traversal
- Red flags for escalation
- Task entry format

**[delegation-policy.md](./docs/delegation-policy.md)** (NEW)
- Decision tree: delegate vs escalate vs skip
- Escalation message patterns
- Never skip without evidence
- Audit trail format

### 2. Updated Agents

**[migration-planner.agent.md](./agents/migration-planner.agent.md)** ✏️
- Added: "Visit EVERY link, do not assume from titles"
- Added: "Extract ALL H2 headings as tasks"
- Added: "Maintain full context stack"
- Reference: deep-discovery-protocol.md
- Reference: delegation-policy.md

**[migration-step-executor.agent.md](./agents/migration-step-executor.agent.md)** ✏️
- Added: "Execute leaf COMPLETELY, never skip subsections"
- Added: "If complex: mark blocked, ask permission, wait"
- Added: "Never default to skip without evidence"
- Escalation rules: ambiguous, destructive, external dependency
- Example escalations included

### 3. Updated Documentation

**[runtime-discovery.md](./docs/runtime-discovery.md)** ✏️
- Expanded: "4. Expand linked pages" → moved to deep discovery
- Added: "DEEP DISCOVERY: Do NOT assume from titles"
- Added: "Examples of what NOT to do"
- Added: "Build task hierarchy (REVISED)" with anti-patterns
- Reference: deep-discovery-protocol.md

**[migration-runtime.instructions.md](./instructions/migration-runtime.instructions.md)** ✏️
- Added: "DEEP DISCOVERY BEHAVIOR (NEW - Critical)"
- Added: "DELEGATION AND ESCALATION BEHAVIOR (NEW - Critical)"
- Added: "ESCALATION EXAMPLES:"
- Added: "Context preservation behavior (NEW)"

---

## Usage Workflow

### Initialize Migration
```
user: "migrate onecx from 18 to 19"
↓
orchestrator routes to planner
↓
planner:
  1. Audit repo (branch protection, dependencies, etc)
  2. Discover docs (MCP server)
  3. DEEP DISCOVERY:
     - Visit every link
     - Extract every H2 section
     - Build complete task tree
  4. Create MIGRATION_PROGRESS.md
  5. Stop
↓
result: Full task tree, no assumptions
```

### Execute Tasks
```
user: "continue migration"
↓
orchestrator routes to executor
↓
executor:
  1. Read MIGRATION_PROGRESS.md
  2. Find next unresolved leaf [?]
  3. Read source docs page
  4. Execute COMPLETELY (all steps in subsection)
  5. If complex/ambiguous: escalate (ask permission)
  6. Update MIGRATION_PROGRESS.md
  7. Stop
↓
validator runs (auto or manual)
  → validates
  → updates gates
  → marks [x] completed or blockers
↓
next invocation handles next task
```

### Escalation Example
```
executor finds: "Update @angular/material packages"
Read docs → Complex refactor → 47 files affected
executor: "[?] blocked - needs permission | Material API Update"
  Reason: Large API refactor, 47 files
  Evidence: [file list]
  Options: a) proceed, b) mark blocked, c) skip
  
user: "proceed"
↓
executor continues, logs changes, validates
↓
[x] completed | Material API Update
  evidence: [file changes, test results]
```

---

## Key Behaviors

### ✅ NOW ENFORCED

1. **Every page is visited** - no assumptions from titles
2. **Every H2 section becomes a task** - no collapsing subsections
3. **Complex tasks escalate** - no silent skipping
4. **Full context maintained** - MIGRATION_PROGRESS.md never loses info
5. **User asked for major decisions** - not left guessing
6. **Audit trail complete** - when/why each decision made

### ❌ NOW PREVENTED

1. Skipping tasks due to complexity
2. Assuming task meaning from headlines
3. Collapsing subsections into parent tasks
4. Losing context between agent invocations
5. Marking tasks complete without validation
6. Visiting only subset of linked pages

---

## MCP Server Integration

When agents use onecx MCP server:

```
agent query: "List all migration steps for Angular 19"
result: Narrow snippet with 3-4 items
↓
WRONG: Plan only 3-4 tasks ❌
CORRECT: Visit actual docs page, extract all H2s, plan complete tree ✓
```

**Narrow results = discovery hints only**

Always fetch full page before implementing.

---

## Testing the New Workflow

Create a test repo with this structure:
```
docs/migration/19/
  ├─ overview.md (directory page, 4 links)
  ├─ core.md (procedural, 5 H2 sections)
  ├─ components.md (procedural, 7 H2 sections)
  ├─ styles.md (procedural, 3 H2 sections)
  ├─ performance.md (simple page)
  └─ optional/
      ├─ feature-x.md
      └─ feature-y.md
```

**Expected Planner Output**:
```
[?] discovered | Phase 1: Angular 19 Upgrade
  [?] discovered | 1. Core Setup (5 subsections)
      [?] 1.1 Update Angular Core
      [?] 1.2 Update TypeScript
      [?] 1.3 Update Build Config
      [?] 1.4 Update Dependencies
      [?] 1.5 Update package.json
  
  [?] discovered | 2. Component Refactor (7 subsections)
      [?] 2.1 Convert Standalone
      [?] 2.2 Update Signals
      ... 5 more subsections
  
  [?] discovered | 3. Style Migration (3 subsections)
      ... detailed subsections
```

Not collapsed. Not assumed. Every section treated as task.

---

## Documentation Map

```
Root
├─ [deep-discovery-protocol.md] NEW
│  ├─ 4-phase workflow
│  ├─ Pseudocode
│  └─ Red flags
│
├─ [delegation-policy.md] NEW
│  ├─ Decision tree
│  ├─ Message patterns
│  └─ Task states
│
├─ [runtime-discovery.md] UPDATED
│  ├─ Phases 1-3 (unchanged)
│  └─ Phase 4+ (revised for deep discovery)
│
├─ [migration-planner.agent.md] UPDATED
│  └─ References both new docs
│
├─ [migration-step-executor.agent.md] UPDATED
│  └─ Escalation patterns + examples
│
└─ [migration-runtime.instructions.md] UPDATED
   └─ All new behavior sections
```

---

## Success Metrics

Migration workflows are **improved** if:

- [ ] No task is skipped silently (all escalated if needed)
- [ ] Every page link is visited during discovery
- [ ] Every H2 section becomes a distinct task
- [ ] No context is lost between agent invocations
- [ ] User approval happens before risky/complex changes
- [ ] MIGRATION_PROGRESS.md accurately tracks full task tree
- [ ] Audit trail shows when/why each decision made
- [ ] Agent count stays at 5 (no per-task agents)

---

## Next Steps

1. **Test deep discovery** - run planner on an actual migration docs repo
2. **Record page traversal** - verify all pages visited, subsections counted
3. **Simulate escalations** - trigger complex tasks, verify user is asked
4. **Validate persistence** - check MIGRATION_PROGRESS.md format
5. **Measure task granularity** - count H2 sections vs final tasks

---

## Files Changed Summary

| File                                | Change  | Impact                                |
| ----------------------------------- | ------- | ------------------------------------- |
| `deep-discovery-protocol.md`        | NEW     | Core discovery workflow               |
| `delegation-policy.md`              | NEW     | Escalation/delegation rules           |
| `migration-planner.agent.md`        | UPDATED | Deep discovery + references           |
| `migration-step-executor.agent.md`  | UPDATED | Escalation + subsection handling      |
| `runtime-discovery.md`              | UPDATED | Phase 4+ revised, references new docs |
| `migration-runtime.instructions.md` | UPDATED | New behavior sections + examples      |

**Total**: 2 new files, 4 updated files
**Lines added**: ~600+ (new documentation + agent improvements)
**Breaking changes**: None (fully backward compatible)

---

## Quick Start

Copy the entire `migration-v3` folder structure to your workspace:
```
workspace/
└─ .github/migration/
   ├─ agents/
   │  ├─ migration-orchestrator.agent.md
   │  ├─ migration-planner.agent.md
   │  ├─ migration-step-executor.agent.md
   │  ├─ migration-validator.agent.md
   │  └─ migration-handover.agent.md
   ├─ docs/
   │  ├─ deep-discovery-protocol.md
   │  ├─ delegation-policy.md
   │  ├─ architecture.md
   │  └─ ... (others)
   ├─ instructions/
   ├─ prompts/
   ├─ skills/
   └─ templates/
```

Then initialize: `@orchestrator Start Planning` with migration target version.

---

**All improvements maintain backward compatibility while enforcing thorough, user-driven task execution.**
