# V6 State Tracking Rules

**Goal**: Maintain accurate, auditable state in MIGRATION_PROGRESS.md using only 3 official state markers.

---

## The 3 Official State Markers

### [ ] Not Started
**Meaning**: Task has not been executed yet (or needs rework)

**When to use**:
- Task has never been executed
- Task was attempted but requires rework (failed validation)
- Task was blocked but dependency is now resolved
- Task needs to be executed in current phase

**Examples**:
```markdown
[ ] Update @angular/core to version 19
    [no execution yet, ready for executor]

[ ] Install PrimeNG v19
    [Executor attempted but test failed, needs rework]
    [See Validation section for error]
```

### [x] Completed
**Meaning**: Task has been fully executed AND all 8 evidence fields are present AND validation passed

**When to use** (ALL conditions must be met):
1. Task was executed (not skipped)
2. All 7 evidence fields documented:
   - Source pages ✓
   - Applicability ✓
   - Repository evidence ✓
   - Planned action ✓
   - Files changed ✓
   - Validation ✓
   - Final outcome ✓
3. Validation (build/lint/test) all passed
4. No fields say "TBD" or are blank
5. Executor ran it, Validator approved it

**Examples**:
```markdown
[x] Update Angular packages
    - Source pages: [list]
    - Applicability: must-have
    - Repository evidence: [grep results]
    - Planned action: [completed description]
    - Files changed: [list with line counts]
    - Validation: build ✓, lint ✓, test ✓
    - Final outcome: success

[x] Remove Material Legacy API
    [all evidence fields complete, validation passed]
```

**NEVER mark [x] if**:
- Any evidence field is missing
- Any field says "[TBD]"
- Validation failed
- Task was skipped
- Test output not verified

### [-] Not Applicable
**Meaning**: Task does NOT apply to this repository (proven by evidence)

**When to use**:
- Repository evidence clearly shows task doesn't apply
- Documented in source page but repo doesn't match condition
- Alternative approach already completed
- Feature is not used in this repo

**Conditions**:
- MUST have repository evidence proving non-applicability
- MUST show grep results or file inspection
- CANNOT be "I think it doesn't apply"

**Examples**:
```markdown
[-] Install PrimeNG v19
    - Applicability: not applicable
    - Repository evidence:
      ```
      $ grep -r "primeng" package.json
      [no results - primeng not installed]
      
      $ grep -r "from '@primeng" src/
      [no results - no primeng imports in code]
      ```
    - Reason: Repository does not use PrimeNG
    - Files changed: none
    - Final outcome: not applicable

[-] Migrate Material Legacy API
    - Applicability: not applicable
    - Repository evidence:
      ```
      $ grep -r "@angular/material" src/ | wc -l
      0
      ```
    - Reason: Material not used in this repository
```

**NEVER mark [-] if**:
- Evidence is lacking
- You're "pretty sure" but didn't check
- Documentation says "optional" but repo might use it
- You didn't actually read the source page

---

## State Transitions (Flow Diagram)

```
START (Phase 1)
    ↓
[ ] not started ← Planning created this task
    ↓
[Executor runs task]
    ↓
[Validator checks evidence]
    ├─ All fields complete AND validation passed
    │  └─ [x] completed
    │
    ├─ Any field missing OR validation failed
    │  └─ [ ] not started (redo)
    │
    └─ Evidence proves non-applicable
       └─ [-] not applicable (done)
```

---

## Evidence-Driven State Rules

### Rule 1: No [x] Without Complete Evidence
```
If any of these is true:
  - Source pages: blank or vague
  - Applicability: not stated
  - Repository evidence: missing
  - Planned action: says "[TBD]"
  - Files changed: says "[TBD]"
  - Validation: incomplete or says "[TBD]"
  - Final outcome: not stated

THEN: Task MUST stay [ ] not started

You cannot mark [x] "pending evidence"
Evidence must be present WHEN marking [x]
```

### Rule 2: Validation Before Completion
```
Before marking [x]:

Must have:
  ✓ npm run build: passed (or "N/A for this task")
  ✓ npm run lint: passed (or "N/A for this task")  
  ✓ npm run test: passed (or "N/A for this task")

Must show:
  ✓ Full output (not just "passed")
  ✓ Error count shown (0 errors, 0 warnings)
  ✓ Not just exit code

If ANY validation step failed:
  → Task stays [ ] not started
```

### Rule 3: One Step = One Marker
```
Task cannot be:
  [~] in-progress ← Not allowed (no such marker)
  [?] blocked ← Not allowed (no such marker)  
  [?] pending ← Not allowed (no such marker)

Task state MUST be one of:
  [ ] not started
  [x] completed
  [-] not applicable

If blocked: add note in [ ] and explain blocker
If in-progress: still [ ] not started (working on it)
```

---

## Handling Edge Cases

### Task is blocking downstream task?
```
Blocked task marker: [ ] not started
Add explanation:
  - Reason: Waiting for [dependency task] to complete
  - Depends on: [task name]
  - Status: Blocked, resumable after [when]
  - Unblock action: [what needs to happen]
```

### Task requires developer decision?
```
Status: [ ] not started
Add explanation:
  - Reason: Decision needed from developer
  - Question: [what needs deciding]
  - Options: 
    a) [option 1]
    b) [option 2]
    c) [option 3]
  - Status: Awaiting developer response
```

### Task failed, trying different approach?
```
Status: [ ] not started (mark for redo)
Add explanation:
  - Previous attempt: [what was tried]
  - Result: Failed at [stage]
  - Error: [brief error description]
  - Next attempt: [new approach]
  - Status: Ready for retry
```

### Task is optional but repo might need it?
```
Status: [-] not applicable OR [ ] not started (your call)

If optional and repo evidence unclear:
  → Mark [ ] not started + ask developer
  → NOT [-] not applicable

If optional and repo evidence says "not used":
  → Mark [-] not applicable + show evidence
```

---

## Validator Agent Checklist

Before approving any task for [x] completion:

**Evidence Fields** (all 7 must be present):
- [ ] Source pages documented (3+ URLs or MCP sources)
- [ ] Applicability explicitly stated
- [ ] Repository evidence shown (grep/inspection)
- [ ] Planned action described
- [ ] Files changed listed
- [ ] Validation results shown
- [ ] Final outcome stated

**Validation Tests** (all must pass):
- [ ] Build: 0 errors, 0 warnings (or N/A)
- [ ] Lint: 0 errors, 0 warnings (or N/A)
- [ ] Test: all passing (or N/A)
- [ ] No "[TBD]" remaining in any field

**State Judgement**:
- If all above pass → mark [x] completed
- If any evidence missing → mark [ ] not started (redo)
- If repo evidence shows non-applicable → mark [-] not applicable

**No exceptions**. No shortcuts.

---

## Examples of Correct State Tracking

### Example 1: Successful Task
```markdown
[x] Update Angular packages to v19
  - Source pages:
    - https://onecx.github.io/docs/.../angular-19/packages.html
    - OneCX MCP: Angular 19 package guide
  - Applicability: must-have
  - Repository evidence: package.json currently has @angular/core@18.0.0
  - Planned action: Updated @angular package versions in package.json
  - Files changed:
    - package.json (3 lines: @angular/core, @angular/common, @angular/forms)
  - Validation:
    - npm run build: ✓ passed (0 errors, 0 warnings)
    - npm run lint: ✓ passed (0 errors, 0 warnings)
    - npm run test: ✓ passed (all 124 tests green)
  - Final outcome: success
```

### Example 2: Not Applicable Task
```markdown
[-] Install PrimeNG v19
  - Applicability: not applicable
  - Repository evidence:
    ```
    $ grep -r "primeng" package.json src/
    [no output - not found]
    ```
  - Reason: Repository does not use PrimeNG
  - Files changed: none
  - Final outcome: not applicable
```

### Example 3: Task Needing Rework
```markdown
[ ] Migrate Material Legacy API
  - Status: Needs rework
  - Previous attempt result:
    - Validation FAILED
    - npm run test error: Cannot find module symbol for MatLegacyButton
    - Last 20 lines: [error output shown]
    - Root cause: Not all imports were updated
  - Planned action: Re-run with verify all files updated
  - Current state: Ready for retry
```

### Example 4: Blocked Task
```markdown
[ ] Install PrimeNG v19 after Angular upgrade
  - Status: Blocked
  - Reason: Waiting for Angular 19 upgrade to be completed first
  - Depends on: [x] Update Angular packages to v19
  - Unblock condition: Angular 19 installed and validated
  - Status: Ready to execute after Angular upgrade
```

---

## Common Mistakes to Avoid

| ❌ Mistake | ✅ Correct |
|-----------|----------|
| Mark [x] but Validation says "[TBD]" | Keep as [ ] until validation is done |
| Mark [x] with missing evidence fields | Ensure all 7 fields present with details |
| Mark [-] without grepping repo | Mark [ ], then grep, THEN decide [ ] or [-] |
| Use [~] in-progress | Use [ ] instead, and note "in progress" in text |
| Use [?] blocked | Use [ ], and note "blocked by..." in text |
| Create new marker not in approved list | Use ONLY [ ], [x], or [-] |
| Mark [x] if test says "pending" | Wait for test results, keep as [ ] |
| Skip validation step | Run build/lint/test for EVERY task |

---

## Enforcement by Validator Agent

**Validator will NOT approve [x] if**:
1. Any evidence field is incomplete
2. Any field contains "[TBD]"
3. Build/lint/test not fully verified
4. Outcome says "success" but validation shows errors
5. Applicability not stated
6. Repository evidence missing
7. Source pages not documented

**Validator will force [ ] (redo) if** any above is true

**Validator will mark [-] only if**:
1. Repository evidence clearly proves non-applicability
2. Task was never attempted (not skipped during execution)
3. Applicability field explains why

---

## Migration from Old Workflows

If you have old MIGRATION_PROGRESS.md using different markers:

| Old | V6 Equivalent |
|-----|---------------|
| [TODO] | [ ] not started |
| [IN PROGRESS] | [ ] not started (add note "in progress") |
| [DONE] | [ ] until validator approves with evidence |
| [SKIP] | [-] not applicable (add evidence) |
| [BLOCKED] | [ ] not started (add note "blocked") |
| [~] | [ ] not started |
| [?] | [ ] not started |

Convert all old entries to one of the 3 official markers.

---

## Summary

**3 markers. 3 meanings. No exceptions.**

```
[ ] = Not started (execute next)
[x] = Completed (all evidence present, validation passed)
[-] = Not applicable (repo evidence proves it doesn't apply)
```

**Before marking [x]**:
- All 7 evidence fields ✓
- Build/lint/test all pass ✓
- No "[TBD]" ✓
- Validator approved ✓

**Only then**: mark [x] completed
