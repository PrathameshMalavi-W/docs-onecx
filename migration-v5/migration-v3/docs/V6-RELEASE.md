# V6 Migration Release Summary

**Version**: v6  
**Release Date**: March 30, 2026  
**Purpose**: Evidence-driven, phase-based OneCX Angular 19 migration with strict documentation expansion

---

## What is V6?

V6 is a complete rewrite of the agent-driven migration system based on a detailed, disciplined workflow specification. It enforces:

1. **Strict documentation reading** - EVERY linked page must be fetched and read
2. **Mandatory evidence collection** - ALL 8 evidence fields required before task completion
3. **Phase-based execution** - Phase 1 (init) → A (pre) → B (handover) → C (post)
4. **Full output validation** - Build/lint/test results must be inspected, not just exit codes
5. **Developer-agent partnership** - Agent handles 75%, developer performs 25% (core upgrade)
6. **Auditable state** - Only 3 markers: [ ] [ ], [x], [-]

---

## What's New vs Previous Versions

### Previous Approach (v5 and earlier)
- ❌ Assumed page titles = task understanding
- ❌ Shallow subsection collapsing
- ❌ Some tasks marked complete from headings alone
- ❌ Limited evidence collection
- ❌ No mandatory phase gating
- ❌ Optional validation steps

### V6 Approach
- ✅ **EVERY link visited** and full page read
- ✅ **Every H2 = separate subtask** (no collapsing)
- ✅ **NO task completion without 8 evidence fields**
- ✅ **Mandatory repository evidence** for applicability
- ✅ **Phase gating enforced** (can't skip phases)
- ✅ **Full validation required** (output inspection, not exit codes)
- ✅ **Developer confirmation gate** before Phase C
- ✅ **Audit trail complete** (when, why, by whom)

---

## V6 Deliverables

### New Agent Files (4 agents)

| Agent                                 | Purpose                                                 |
| ------------------------------------- | ------------------------------------------------------- |
| `migration-orchestrator-v6.agent.md`  | Phase coordinator, routes work, enforces gates          |
| `migration-planner-v6.agent.md`       | Phase 1: discovery, planning, strict doc expansion      |
| `migration-step-executor-v6.agent.md` | Phase A & C: execute tasks with evidence collection     |
| `migration-validator-v6.agent.md`     | Validation: check evidence fields, run build/lint/test  |
| `migration-phase-manager-v6.agent.md` | Phase transitions: handover, developer gate, commitment |

### New Documentation Files

| File                                | Purpose                                         |
| ----------------------------------- | ----------------------------------------------- |
| `v6-workflow-discipline.md`         | 📖 Core workflow rules and discipline            |
| `v6-evidence-requirements.md`       | 📋 All 8 evidence fields explained with examples |
| `v6-state-tracking.md`              | 📊 State markers and transitions                 |
| `v6-phase-transitions.md`           | 🚦 Phase gates and prerequisites                 |
| `MIGRATION_PROGRESS-v6.template.md` | 📝 Template for v6 workflow                      |

### Total Files Added/Modified
- **5 agent files** (new v6 versions)
- **5 documentation files** (new v6-specific)
- **1 template file** (v6 progress tracking)

---

## How to Use V6

### Step 1: Start Phase 1 (Initialization)

```
User: "@orchestrator-v6 Start Phase 1. Migrate from Angular 18 to Angular 19."

Agent flow:
  orchestrator-v6 → migration-planner-v6
  Planner executes:
    1. Branch check
    2. npm install + npm test baseline
    3. Instructions audit (tag Angular 18 rules)
    4. Task configuration (.vscode/tasks.json)
    5. STRICT DOC EXPANSION
       - Fetch OneCX Angular 19 index
       - Visit EVERY linked page
       - Read FULL content of each page
       - Identify ALL subsections (H2 headings)
       - If page has sub-links: fetch those too
       - Count total tasks discovered
    6. Create MIGRATION_PROGRESS.md with all tasks
    7. Stop and present plan
```

**Output**: MIGRATION_PROGRESS.md ready with complete task tree

### Step 2: Execute Phase A (Pre-Migration)

```
User: "@orchestrator-v6 Continue Phase A execution."

Agent flow:
  orchestrator-v6 → migration-step-executor-v6
  
  Executor loop (repeated per invocation):
    1. Read MIGRATION_PROGRESS.md
    2. Find first [ ] not started task in Phase A
    3. Fetch full documentation page
    4. Check repository evidence
    5. Execute ONE task completely
    6. Collect ALL 8 evidence fields:
       - Source pages ✓
       - Applicability ✓
       - Repository evidence ✓
       - Planned action ✓
       - Files changed ✓
       - Validation ✓
       - Final outcome ✓
       - Edge cases ✓
    7. Update MIGRATION_PROGRESS.md
    8. Stop (one task per invocation)
```

**Validation**: After each task, validator agent checks evidence completeness

### Step 3: Phase A Completion & Validation

```
Once all Phase A tasks are [ ] or [x]:
  
Validation report:
  - All tasks: [x] completed OR [-] not applicable
  - Build: ✓ passed
  - Lint: ✓ passed (0 errors, 0 warnings)
  - Test: ✓ passed (baseline established)
  - Create Phase A commit

Commit message:
feat(migration): prepare Angular 18→19 pre-migration

- Updated @onecx packages v19-compatible versions
- Updated @angular packages to target versions
- Ran nx migrate <documented-version>
- Updated package-lock.json
- All Phase A validation checks pass
- Ready for developer core upgrade

Phase A complete - awaiting Phase B handover
```

### Step 4: Phase B (Handover Gate)

```
Agent: "Phase A complete. Developer must perform core Angular upgrade.

What was completed:
  ✓ Pre-migration tasks
  ✓ Package updates
  ✓ nx migrate
  ✓ npm install
  ✓ All validation passed

What you must do:
  1. Run npm run build
  2. Run npm run lint
  3. Run npm run test (verify baseline)
  4. Perform core Angular 19 upgrade using official tools
  5. Run npm run test (verify tests still green)
  6. Respond: 'Tests are green' or 'Tests failed'

WAIT: Phase C cannot proceed without your confirmation"

Developer: "Tests are green, proceed with Phase C"
```

**Gate**: No auto-proceed. Requires explicit developer response.

### Step 5: Execute Phase C (Post-Migration)

```
ONLY AFTER developer confirms green tests.

User: "@orchestrator-v6 Continue Phase C."

Agent flow:
  orchestrator-v6 → migration-step-executor-v6
  
  Executor:
    1. Remove [REMOVE-AFTER-A19] lines from copilot-instructions.md
    2. Install PrimeNG v19 (if applicable)
    3. Install remaining @onecx packages
    4. Run final validation:
       - npm run build
       - npm run lint
       - npm run test
    5. Compare coverage: baseline vs final
    6. Generate Phase C report
```

### Step 6: Final Report

```
Phase C complete.

Migration Summary:
  - Phase 1: ✓ completed (planning)
  - Phase A: ✓ completed (pre-migration)
  - Phase B: ✓ completed (handover + core upgrade)
  - Phase C: ✓ completed (post-migration)

Final State:
  - Build: ✓ 0 errors, 0 warnings
  - Lint: ✓ 0 errors, 0 warnings
  - Test: ✓ 124/124 passing
  - Coverage: 82% (baseline) → 80% (final, -2%)
  - @angular/core: v19.0.0 ✓
  - @onecx: all compatible ✓
  - PrimeNG: v19.0.0 ✓

Ready to commit and deploy.
```

---

## Key Rules and Enforcement

### 1. Documentation Expansion (Planner)
```
MANDATORY: For EVERY link on migration index:
  1. Fetch full page (not summary)
  2. Read complete content
  3. Identify subsections (H2 headings)
  4. If page has sub-links: repeat step 1-3
  5. Record all findings

Rule: "I read the title" ≠ "I understand the task"
Enforcement: Planner will not create task until full page is read
```

### 2. Evidence Completeness (Validator)
```
MANDATORY: All 7 evidence fields required before [x]:
  1. Source pages (3+ URLs)
  2. Applicability (must-have|nice-to-have|not applicable)
  3. Repository evidence (grep results or inspection)
  4. Planned action (exact description)
  5. Files changed (list with line counts)
  6. Validation (build/lint/test output)
  7. Final outcome (success|blocked|error)

Rule: No [x] with missing fields (anti-pattern check fails)
Enforcement: Validator rejects completion if field is blank or "[TBD]"
```

### 3. Phase Gating (Orchestrator)
```
ENFORCEMENT: Phases must proceed in order
  Phase 1 → Phase A → Phase B → Phase C
  
Transition rules:
  - Phase 1 → A: All Phase 1 tasks [x]
  - Phase A → B: All Phase A tasks validated
  - Phase B → C: Developer explicitly says "go"
  - Phase C → Done: Final validation passed

Rule: No skipping phases
Enforcement: Orchestrator blocks out-of-order transitions
```

### 4. Output Validation (Validator)
```
MANDATORY: Inspect full output, not just exit code

Bad: "npm run build passed (exit code 0)"
Good: "npm run build passed. Output shows:
       - successfully compiled 47 components
       - 0 errors, 0 warnings
       - build artifacts: dist/ 2.1MB"

Rule: Exit code ≠ proof of success
Enforcement: Validator captures and inspects last 20 lines of output
```

### 5. Developer Gate at Phase B (Phase Manager)
```
ENFORCEMENT: Phase C cannot auto-proceed

Prerequisite for Phase C:
  Developer must explicitly say one of:
  a) "Tests are green, proceed with Phase C"
  b) "Tests failed, I need help with Phase C"
  c) "All fixed, go to Phase C"

Rule: No guessing developer's intent
Enforcement: Phase manager waits for explicit response
```

---

## Migration_PROGRESS.md Structure

Complete task entry in v6 format:

```markdown
[ ] Update Angular packages
  - Source pages:
    - https://onecx.github.io/docs/.../angular-19/packages.html
    - OneCX MCP: "Angular 19 package guide"
  
  - Applicability: must-have
    [Updated @angular packages are mandatory for Angular 19]
  
  - Repository evidence:
    ```
    $ grep "@angular" package.json
    "@angular/core": "^18.0.0"
    "@angular/common": "^18.0.0"
    [2 packages need update]
    ```
  
  - Planned action:
    1. Update @angular/core to 19.0.0
    2. Update @angular/common to 19.0.0
    3. Run npm install
    4. Verify no peer dependency warnings
  
  - Files changed:
    - package.json (2 lines)
    - package-lock.json (regenerated)
  
  - Validation:
    - npm run build: ✓ passed
    - npm run lint: ✓ passed
    - npm run test: ✓ passed (124/124)
  
  - Final outcome: success
  
  - Edge Cases or Issues: none
```

---

## Quick Start Checklist

Production use:

- [ ] Copy all v6 agent files to `.github/agents/` or project agents folder
- [ ] Copy all v6 docs to `.github/docs/` or project docs folder
- [ ] Copy template to `.github/templates/` or templates folder
- [ ] Developer creates feature branch
- [ ] Developer: "@orchestrator-v6 Start Phase 1"
- [ ] Agent: Phase 1 completes, MIGRATION_PROGRESS.md ready
- [ ] Developer: "@orchestrator-v6 Continue Phase A" (repeats per task)
- [ ] Agent: Phase A completes, ready for handover
- [ ] Agent: Prepares Phase B handover
- [ ] Developer: Performs core upgrade, tests pass
- [ ] Developer: "Proceed to Phase C"
- [ ] Agent: Phase C execution and post-migration
- [ ] Final report: Migration complete

---

## Compared to Official Workflows

| Aspect                | V6 Approach            | Result                      |
| --------------------- | ---------------------- | --------------------------- |
| Documentation reading | EVERY link visited     | 0% ambiguity, 100% coverage |
| Evidence collection   | 8 mandatory fields     | Fully auditable             |
| State tracking        | 3 markers only         | No confusion about status   |
| Validation            | Full output inspection | Catches subtle failures     |
| Developer involvement | Explicit gates         | Developer always informed   |
| Task complexity       | No shortcuts           | All subsections handled     |
| Phase discipline      | Mandatory sequencing   | Predictable execution       |
| Error recovery        | Mapped to root causes  | Fast debugging              |

---

## Where to Find Docs

```
migration-v3/
├── agents/
│   ├── migration-orchestrator-v6.agent.md
│   ├── migration-planner-v6.agent.md
│   ├── migration-step-executor-v6.agent.md
│   ├── migration-validator-v6.agent.md
│   └── migration-phase-manager-v6.agent.md
│
├── docs/
│   ├── v6-workflow-discipline.md          ← START HERE
│   ├── v6-evidence-requirements.md        ← 8 fields explained
│   ├── v6-state-tracking.md               ← Markers and gates
│   ├── v6-phase-transitions.md            ← Phase flow
│   └── [other existing docs]
│
└── templates/
    └── MIGRATION_PROGRESS-v6.template.md
```

---

## Support and Troubleshooting

**Issue**: "I'm not sure if my task is really complete"  
**Solution**: Check MIGRATION_PROGRESS.md. If any field is "[TBD]" or blank, task is NOT complete. Run validator again.

**Issue**: Phase B is waiting forever  
**Solution**: Developer must explicitly say "tests green" or "help needed". Auto-proceed doesn't exist.

**Issue**: Build failed but I'm confused why  
**Solution**: Check latest task in MIGRATION_PROGRESS.md. Validation section shows last 20 lines of error. Map to root cause.

**Issue**: Multiple tasks seem to do the same thing  
**Solution**: This is correct! Each H2 subsection = separate task. They're meant to be executed sequentially.

**Issue**: Can I skip a phase?  
**Solution**: No. Phases must proceed: 1 → A → B → C. Each phase has prerequisites.

---

## Governance

**Who can invoke agents?**
- Developer/team with repository access
- Only one migration session per branch at a time

**Who approves completion?**
- Executor: runs task and collects evidence
- Validator: checks all evidence fields present
- Phase Manager: manages transitions and gates

**Can I rollback?**
- At any point: `git reset --hard <Phase-A-commit>`
- Restart Phase 1 if needed

**What if something goes wrong?**
- All state in MIGRATION_PROGRESS.md (always saved)
- Find failed task, review evidence section
- Identify root cause in validation output
- Re-run task (stays as [ ], retries allowed)

---

## Success Metrics

Migration with V6 is **successful** if:

- [ ] All Phase 1 tasks [x] completed or [-] not applicable
- [ ] All Phase A tasks [x] completed or [-] not applicable
- [ ] Phase B handover documented
- [ ] Developer confirmed tests green
- [ ] All Phase C tasks [x] completed or [-] not applicable
- [ ] Final build/lint/test all pass
- [ ] MIGRATION_PROGRESS.md fully documented
- [ ] No "[TBD]" remaining
- [ ] All evidence fields populated
- [ ] Commit history shows progression
- [ ] Coverage report available (baseline vs final)

---

## Contact & Feedback

For questions about v6 workflow:
1. Check [v6-workflow-discipline.md](./docs/v6-workflow-discipline.md)
2. Check [v6-evidence-requirements.md](./docs/v6-evidence-requirements.md)
3. Consult agent prompts (they explain their own rules)
4. Review MIGRATION_PROGRESS.md template

---

**V6 is ready for production use. All agents are stateless and idempotent. You can restart Phase A many times - state is always in the progress file.**

**Begin with Phase 1. Be thorough. Collect all evidence. Migration will be fast and error-free.**
