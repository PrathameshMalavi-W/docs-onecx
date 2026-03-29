# V6 Workflow Discipline - Evidence-Driven OneCX Angular 19 Migration

**Version**: v6  
**Date**: March 30, 2026  
**Purpose**: Enforce strict documentation reading, evidence collection, and phase-based execution

---

## Core Principles

### 1. Documentation Expansion is Mandatory
- **Rule**: No task may be created from a page INDEX alone
- **Rule**: EVERY linked page MUST be fetched and read in full
- **Rule**: If a page contains sub-links, those must be fetched too
- **Rule**: Page SUMMARY is not task EXECUTION

### 2. Evidence Before Completion
- **Rule**: No task may be marked [x] completed unless ALL evidence fields are documented
- **Missing field** = task stays [ ] not started
- **Evidence fields**: source pages, applicability, repo evidence, planned action, files changed, validation, final outcome

### 3. State Tracking Only Uses 3 Markers
- `[ ]` = not started (or rework needed)
- `[-]` = not applicable (with evidence)
- `[x]` = completed (with all evidence fields)
- NO other markers in MIGRATION_PROGRESS.md

### 4. Phase Discipline
- **Phase 1**: Initialize and plan (read all documentation, create task tree)
- **Phase A**: Pre-migration (execute preparation steps)
- **Phase B**: Handover (developer performs core upgrade)
- **Phase C**: Post-migration (finalize and cleanup)
- Phases must proceed IN ORDER - no skipping

### 5. Developer-Agent Partnership
- **Agent responsibility**: Phase 1, A, C (planning and pre/post work)
- **Developer responsibility**: Phase B (core framework upgrade)
- **Gate at Phase B**: Agent WAITS for developer explicitly saying "tests green"

---

## Phase 1: Initialization (Planner Agent)

### 1.1 Branch Check
```
if branch in [main, master, develop]:
  STOP
  ask developer: "Please create feature branch"
else:
  record branch name
  continue
```

### 1.2 Dependency Audit
```
run: npm install (full output, not just exit code)
if FAILED:
  record last 20 lines
  map each error to root cause
  STOP
  
run: npm run test (full output, not just exit code)
if FAILED:
  record last 20 lines
  map each error to root cause
  STOP
  
record baseline coverage %
continue
```

### 1.3 Copilot Instructions Audit
```
read: .github/copilot-instructions.md or root copilot-instructions.md
find: lines specific to Angular 18
tag: with # [REMOVE-AFTER-A19] comment
record: tagged sections in MIGRATION_PROGRESS.md
```

### 1.4 Task Configuration
```
read: .vscode/tasks.json
verify: npm:build task exists
verify: npm:lint task exists
verify: npm:test task exists

if any missing:
  create using template
  add "CI": "true" to env
  
if test task exists:
  verify no watch mode
  verify coverage enabled
```

### 1.5 Documentation Discovery (STRICT)
```
query OneCX MCP: "Angular 19 migration"
fetch: index page (FULL content)

for each link on index page:
  fetch: full linked page
  read: complete content
  count: subsections (H2 headings)
  identify: nested links
  
  for each nested link:
    fetch: full nested page
    read: complete content
    record: subsection count

if repo uses primeng:
  fetch: PrimeNG v19 migration page
  read: complete content
  
if workspace is Nx:
  fetch: Nx migration guide
  read: complete content

record: all pages visited
record: total subsection count
record: all source URLs
```

Example discovery tree:
```
OneCX Angular 19 Index
├─ Pre-migration
│  ├─ Package updates (4 subsections)
│  ├─ Code cleanup (3 subsections)
│  └─ Dependency audit (2 subsections)
├─ Core migration (agent does NOT do this)
├─ Post-migration
│  ├─ Component updates (5 subsections)
│  ├─ Style migration (2 subsections)
│  └─ Testing (3 subsections)
└─ Optional features
   ├─ Standalone components
   └─ Signal-based state
```

### 1.6 Task Breakdown
```
for each discovered page:
  if type == "directory page":
    create one task per linked page
  
  if type == "procedural page":
    for each H2 heading:
      create one task per heading
  
  if type == "simple page":
    create one task total
    
  check applicability:
    if "optional" or "if applicable":
      check repo evidence
      if evidence supports: mark must-have
      if evidence contradicts: mark not applicable
      if unclear: ask developer
    else:
      mark must-have
```

### 1.7 Create MIGRATION_PROGRESS.md
```
use template: MIGRATION_PROGRESS-v6.template.md

for each task:
  - Source pages: [list URLs]
  - Applicability: must-have|nice-to-have|not applicable
  - Repository evidence: [TBD]
  - Planned action: [TBD]
  - Files changed: [TBD]
  - Validation: [TBD]
  - Final outcome: [TBD]
```

### 1.8 Review and Clarify
```
if any task is ambiguous:
  STOP
  ask developer for clarification
  
if any dependency chain is unclear:
  STOP
  ask developer
  
record clarifications in MIGRATION_PROGRESS.md
```

---

## Phase A: Pre-Migration (Executor Agent)

Per task invocation:

```
1. re-read MIGRATION_PROGRESS.md
2. find first [ ] not started task in Phase A
3. fetch source documentation page (FULL content)
4. check repository evidence for applicability
5. execute the task (ONE task per invocation)
6. update MIGRATION_PROGRESS.md with ALL evidence fields
7. STOP
```

### Evidence Fields (ALL REQUIRED)

```
[ ] Task Name
  - Source pages: [list URLs that were fetched]
  - Applicability: must-have|nice-to-have|not applicable
  - Repository evidence: grep, file paths, inspection results
  - Planned action: exact description of what will be done
  - Files changed: [list of files or "no changes needed"]
  - Validation: [build/lint/test output or status]
  - Final outcome: success|blocked|error
  - Edge Cases or Issues: [if any]
```

### Special Rules

**nx migrate**:
```
NEVER use "latest"
ALWAYS use fixed documented version
Example: "nx migrate 20.0.0"

Source: OneCX docs → Nx docs → fallback

After nx migrate:
  check package.json for compatibility
  resolve conflicts before proceeding
  run npm install
  run nx migrate --run-migrations
  run npm install again
```

**styles.scss**:
```
if docs require style changes:
  apply EXACTLY as documented
  
if conflict (Nx array vs Sass @import):
  STOP
  ask developer which pattern to use
  record decision
```

**PrimeNG issues**:
```
if imports break:
  fetch PrimeNG v19 migration
  apply only documented fixes
  record which fixes applied
```

### Error Handling

```
if build fails:
  capture last 20 lines
  map each error to root cause
  record in MIGRATION_PROGRESS.md
  STOP - do not proceed
  
if test fails:
  capture last 20 lines
  check if pre-existing or new
  record in MIGRATION_PROGRESS.md
  STOP - do not proceed
```

### Execution Flow

```
Phase A tasks (in order):
└─ Update @onecx packages
└─ Update @angular to target
└─ npm install
└─ [nx migrate] (if Nx) → npm install → nx migrate --run-migrations
└─ All other pre-migration tasks
├─ Build validation
├─ Lint validation
├─ Test validation
└─ [Phase A complete, proceed to Phase B]
```

---

## Phase B: Handover (Phase Manager Agent)

```
prerequisites:
  - All Phase A tasks [x] completed
  - Working directory is CLEAN
  
actions:
  1. Prepare handover checklist
  2. Create commit message
  3. Present to developer
  4. WAIT for explicit confirmation
  
NEVER proceed to Phase C without developer saying:
  a) "Tests green, proceed"
  b) "Tests failed, help"
  c) "Proceed, I'll handle remaining"
```

### Handover Checklist

```markdown
## What was completed (Phase A):
- [x] Pre-migration tasks
- [x] Package updates
- [x] nx migrate (if applicable)
- [x] npm install
- [x] npm migrate --run-migrations
- [x] All validation passed

## What developer must do (Phase B):
1. Run npm run build
2. Run npm run lint
3. Run npm run test (baseline)
4. Perform core Angular 19 upgrade
5. Run npm run test (verify green)
6. Respond to agent

## Commit ready:
feat(migration): prepare Angular 18→19 pre-migration

- Updated @onecx packages
- Updated @angular packages  
- Ran nx migrate <version>
- Updated package-lock.json
- All validation checks pass
- Ready for core upgrade

## Awaiting:
Developer: "Tests green" or "Need help"
```

---

## Phase C: Post-Migration (Executor Agent)

Trigger: ONLY if developer confirms "tests green" or requests error help

```
1. Clean up copilot-instructions.md
   - Remove [REMOVE-AFTER-A19] lines
   - Inform developer of changes
   
2. Install PrimeNG v19 (if applicable)
   - Fetch PrimeNG migration docs
   - Apply documented changes
   
3. Install remaining @onecx packages
   - Update package.json per docs
   - Run npm install
   
4. Final validation
   - npm run build
   - npm run lint
   - npm run test
   - Compare coverage vs baseline
   
5. Report final state
```

---

## State Tracking Excellence

### Task State Progression

```
[ ] not started
  │
  ├─ Agent executes completely
  │  └─ Validator checks evidence
  │     └─ All fields present?
  │        ├─ YES: [x] completed
  │        └─ NO: [ ] not started (redo)
  │
  ├─ Task not applicable
  │  └─ Repository evidence confirms?
  │     ├─ YES: [-] not applicable (done)
  │     └─ NO: ask developer clarification
  │
  └─ Task blocked
     └─ Dependency not met?
        ├─ YES: [?] blocked - waiting for [dependency]
        └─ NO: unblock and execute
```

### Evidence Checklist

Before marking [x] EVER, verify:

- [ ] Source pages: URLs listed (3-10 expected)
- [ ] Applicability: explicitly stated (must-have|nice-to-have|not applicable)
- [ ] Repository evidence: grep/file inspection results
- [ ] Planned action: detailed description of what was done
- [ ] Files changed: list of files or explicit "no changes needed"
- [ ] Validation: build/lint/test output (not just "passed")
- [ ] Final outcome: success|blocked|error
- [ ] Edge Cases: any issues or context notes

**Missing any field** = task stays [ ] not started

---

## Documentation Sources (Priority Order)

1. **OneCX MCP** → `about_onecx` tool
2. **PrimeNG MCP** → (if repo uses primeng)
3. **Nx MCP** → (if Nx workspace)
4. **Fallback URLs**:
   - OneCX: https://onecx.github.io/docs/documentation/current/onecx-portal-ui-libs/migrations/angular-19/index.html
   - PrimeNG: https://primeng.org/migration/v19
   - Nx: https://nx.dev/docs/technologies/angular/migrations

Record which source was used for EACH major task section in MIGRATION_PROGRESS.md.

---

## Validation Discipline

### After Every Phase A Task

```
run npm run build (full output)
  |
  ├─ 0 errors? → continue
  └─ errors? → capture 20 lines, map to cause, STOP

run npm run lint (full output)
  |
  ├─ 0 errors, 0 warnings? → continue
  └─ errors/warnings? → capture, STOP

run npm run test (full output)
  |
  ├─ all passing? → continue
  └─ failing? → capture 20 lines, map to cause, STOP
  
if all pass: mark [x] completed + all evidence fields
if any fail: mark [ ] not started (redo)
```

### Output-Based Validation (NOT just exit codes)

**BAD**: 
```
$ npm run build
> exit code: 0
Great, build passed!
```

**GOOD**:
```
$ npm run build
> [output starts]
> successfully compiled 47 components
> 0 warnings
> build artifacts produced: dist/ (2.1MB)
> [output ends]
Confirmed: build succeeded with full output verification
```

---

## Anti-Patterns to AVOID

❌ **Don't**: "I read the title of the migration page, so I understand the task"  
✅ **Do**: "I fetched the full page, read every section, found 4 subsections, identified 12 concrete actions"

❌ **Don't**: "The test passed (exit code 0), so the task is done"  
✅ **Do**: "The test passed. Output shows: [X tests passed], [Y% coverage], all assertions green"

❌ **Don't**: "Got 5 links on the index, so I'll create 5 tasks"  
✅ **Do**: "Visited all 5 links, found [N] total subsections, created explicit task per subsection"

❌ **Don't**: Mark [x] completed with missing evidence fields  
✅ **Do**: "All 7 evidence fields documented, validation passed, mark [x]"

❌ **Don't**: Skip "optional" sections without checking repo  
✅ **Do**: "Marked 'optional', checked repo for evidence, decided must-have|not applicable"

❌ **Don't**: Use `nx migrate latest`  
✅ **Do**: "Researched documented version, using `nx migrate 20.0.0` from OneCX docs"

---

## Quick Start (Checklist)

1. [ ] Developer creates feature branch
2. [ ] Agent runs Phase 1 (full planner execution)
3. [ ] MIGRATION_PROGRESS.md created with all tasks
4. [ ] Agent executes Phase A tasks one by one
5. [ ] Each task validated with full evidence
6. [ ] Phase A commit created
7. [ ] Agent prepares Phase B handover
8. [ ] Developer performs core Angular upgrade
9. [ ] Developer confirms tests green
10. [ ] Agent executes Phase C post-migration
11. [ ] Final validation and coverage report
12. [ ] Migration complete

---

## Troubleshooting

**Issue**: Task says "complete" but I'm not sure it really is  
**Fix**: Check MIGRATION_PROGRESS.md - if any evidence field is missing or says "TBD", task is NOT actually complete

**Issue**: Phase B is waiting forever  
**Fix**: Phase B expects explicit developer confirmation - not automatic

**Issue**: Multiple tasks seem to do the same thing  
**Fix**: Review documentation expansion in Phase 1 - likely different sections of same page, each is distinct task

**Issue**: Build failed but I'm not sure which task caused it  
**Fix**: Check last executed task in MIGRATION_PROGRESS.md, review "Files changed", rerun that task's validations

---

## Governance

- **Phase transitions**: Require ALL prerequisites met (no exceptions)
- **Task completion**: Require ALL evidence fields present (no exceptions)
- **Documentation**: EVERY page must be read (no summaries)
- **Validation**: Output must be inspected (exit codes not sufficient)
- **Developer gate**: Phase B requires explicit confirmation (no auto-proceed)

---

**Goal**: Create auditable, reproducible migration with ZERO hidden tasks or skipped steps.
