---
name: phase-c-post-migration
description: >
  Execute Phase C: Post-migration stabilization. Record errors, fix all errors,
  update packages, migrate PrimeNG (v17→v19 if used), migrate Nx (if used),
  final validation. All tasks tracked in MIGRATION_PROGRESS.md.
applyTo:
  - .md
codeBlockLanguage: markdown
---

# Phase C: Post-migration Agent

**Responsibility**: Error recording/resolution, package upgrade, PrimeNG migration, Nx migration, finalization  
**Input**: MIGRATION_PROGRESS.md (from Phase B)  
**Output**: All errors fixed, packages migrated, final validation PASS  
**Validation**: Build → Lint → Test (STRICT order) - all MUST PASS for completion  
**Rules to follow**: 00-core-constraints.md, 01-documentation-discovery-rules.md, 04-phase-c-post-migration-rules.md

---

## PHASE C WORKFLOW

### Step 1: Pre-Phase C Checkpoint

- [ ] Ask developer:
  ```
  Core upgrade complete. Ready for post-migration tasks?
  
  Phase C will:
    1. Record and fix ALL build/lint/test errors
    2. Update Copilot-instructions.md (if exists)
    3. Upgrade @onecx packages
    4. Migrate PrimeNG v17→v19 (if used)
    5. Migrate Nx (if used)
    6. Final validation - all PASS
  
  Type 'yes' or 'continue' (default). (Other: 'no' to defer)
  ```

- [ ] If NO → Report back "Phase C deferred - awaiting developer readiness"
- [ ] If YES → Proceed to Step 2

### Step 2: Record ALL Build/Lint/Test Errors

- [ ] Run: `npm run build`
  - Record: FULL output (capture last 50+ lines minimum)
  - Status: PASS or FAIL list

- [ ] Run: `npm run lint`
  - Record: FULL output
  - Status: PASS or list of warnings/errors

- [ ] Run: `npm run test`
  - Record: FULL output
  - Status: PASS or failed tests list

- [ ] For EACH error found:
  - Record in MIGRATION_PROGRESS.md Error Log:
    - Timestamp: [HH:MM:SS]
    - Error message: [50+ lines]
    - Context: [which phase/step]
    - Root cause (initial assessment): [suspected cause]

### Step 3: Fix All Errors Systematically

**FOR EACH ERROR in Error Log**:
  1. **Analyze**: Read error message completely
  2. **Search**: MCP/fallback for solution
  3. **Plan**: Exact fix from documentation
  4. **Execute**: Apply fix (files, line numbers)
  5. **Validate**: Re-run build → lint → test
  6. **Record**: Attempt #, result, resolution

- [ ] Continue until ALL three PASS:
  - npm build ✓
  - npm lint ✓ (0 warnings, 0 errors)
  - npm test ✓

- [ ] Update Error Log with resolution details for each

### Step 4: Update Copilot-instructions.md (if exists)

- [ ] Check if workspace root has `copilot-instructions.md` or `.instructions.md`

- [ ] If exists:
  - [ ] Open file
  - [ ] Find Angular 18-specific rules
  - [ ] Comment them out (don't delete):
    ```
    # REMOVED - Post-Angular {version} cleanup ({timestamp})
    # Old rule: [rule text]
    # Reason: [why removed]
    ```
  - [ ] Save file
  - [ ] Record in MIGRATION_PROGRESS.md:
    - File modified: [path]
    - Change: "Removed Angular 18-specific rules"
    - Timestamp: [timestamp]

- [ ] If NOT exists:
  - [ ] Skip and note: "No copilot-instructions.md found"

### Step 5: Update @onecx Packages

**Based on Phase 1 discovery** (package version matrix in MIGRATION_PROGRESS.md):

- [ ] For each @onecx package MENTIONED in OneCX migration docs:
  - Update to documented version
  - Record: "@onecx/package: old → new (source: OneCX migration docs)"

- [ ] For each @onecx package NOT mentioned in docs:
  - SKIP (keep current)
  - Record: "@onecx/package: SKIP (not mentioned in docs)"

- [ ] Run: `npm install`
  - Record: output, success or error

- [ ] Validate: `npm run build`
  - Record: PASS or FAIL + output
  - If FAIL: Troubleshoot package compatibility, resolve

- [ ] Update MIGRATION_PROGRESS.md:
  - Packages upgraded: [list with versions]
  - Packages skipped: [list with reasons]
  - npm install: PASS/FAIL
  - Build validation: PASS/FAIL

### Step 6: PrimeNG Migration (v17 → v19)

**First: Check if used**:
- [ ] Check package.json for `"primeng"`
- [ ] If NOT found:
  - [ ] Mark task: [-] not applicable "PrimeNG not in package.json"
  - [ ] Skip to Step 7

**If found** (PrimeNG IS used):

#### Step 6a: Fetch v17→v18 Migration Docs

- [ ] Use MCP: Query "PrimeNG v17 v18 migration breaking changes"
- [ ] Fallback: https://primeng.org/migration/v19
- [ ] Also check: node_modules/primeng/CHANGELOG.md (if available)
- [ ] Read: COMPLETE breaking changes list

#### Step 6b: Execute v17→v18 Migration Tasks

**For each breaking change identified**:
  1. Search repository: Find usages of deprecated APIs/components
  2. Plan: Exact replacement per documentation
  3. Execute: File changes (paths, line numbers)
  4. Validate: npm build → lint → test
  5. Checkpoint: Halt for user "next"/"continue"
  6. Record in MIGRATION_PROGRESS.md: Task [x] completed with details

#### Step 6c: Fetch v18→v19 Migration Docs

- [ ] Use MCP: Query "PrimeNG v18 v19 migration"
- [ ] Fallback: https://primeng.org/migration/v19
- [ ] Check: node_modules/primeng/CHANGELOG.md
- [ ] Read: COMPLETE breaking changes list

#### Step 6d: Execute v18→v19 Migration Tasks

**For each breaking change identified**:
  1. Search repository: Find usages
  2. Plan: Exact replacement per documentation
  3. Execute: File changes
  4. Validate: npm build → lint → test (all PASS)
  5. Checkpoint: Halt for user "next"/"continue"
  6. Record in MIGRATION_PROGRESS.md: Task [x] completed

#### Step 6e: Final PrimeNG Validation

- [ ] Run: npm build → MUST PASS
- [ ] Run: npm lint → MUST PASS (0 warnings, 0 errors)
- [ ] Run: npm test → MUST PASS
- [ ] Record in MIGRATION_PROGRESS.md: "PrimeNG migration complete ✓"

### Step 7: Nx Migration (if applicable)

**First: Check if used**:
- [ ] Check package.json for `"@nx/"` or `"nx"`
- [ ] If NOT found:
  - [ ] Mark task: [-] not applicable "Nx not in package.json"
  - [ ] Skip to Step 8

**If found** (Nx IS used):

#### Step 7a: Fetch Nx Migration Docs

- [ ] Use MCP: Query "Nx Angular {version} migration"
- [ ] Fallback: https://nx.dev/docs/technologies/angular/migrations
- [ ] Check: node_modules/nx/CHANGELOG.md
- [ ] Read: Configuration changes, breaking changes, migration procedures

#### Step 7b: Apply Nx Configuration Changes

- [ ] From documentation: Identify nx.json changes needed
- [ ] Open: nx.json
- [ ] Apply: Each configuration change exactly as documented
- [ ] Record: Exact changes (before/after diff)
- [ ] Validate: npm build

#### Step 7c: Execute Nx Migration Tasks

**For each breaking change or required task**:
  1. Plan: Exact change per documentation
  2. Execute: File changes (paths, line numbers)
  3. Validate: npm build → lint → test
  4. Checkpoint: Halt for user "next"/"continue"
  5. Record in MIGRATION_PROGRESS.md: Task [x] completed

#### Step 7d: Final Nx Validation

- [ ] Run: npm build → MUST PASS
- [ ] Run: npm lint → MUST PASS (0 warnings, 0 errors)
- [ ] Run: npm test → MUST PASS
- [ ] Record in MIGRATION_PROGRESS.md: "Nx migration complete ✓"

### Step 8: Code Coverage Comparison

- [ ] From MIGRATION_PROGRESS.md: Get baseline coverage (Phase 1)
- [ ] Run: `npm run test` with coverage capture
- [ ] Extract: Current coverage percentage
- [ ] Calculate: Change (post - baseline)
- [ ] Record in MIGRATION_PROGRESS.md:
  - Baseline: {%}
  - Post-migration: {%}
  - Change: {+/- %}

### Step 9: Final Validation (MANDATORY - ALL MUST PASS)

- [ ] Run: `npm run build`
  - MUST be: ✓ SUCCESS (no errors)
  - If FAIL: Troubleshoot, fix, re-run

- [ ] Run: `npm run lint`
  - MUST be: ✓ SUCCESS (0 warnings, 0 errors)
  - If FAIL: Fix, re-run

- [ ] Run: `npm run test`
  - MUST be: ✓ SUCCESS (all tests passing)
  - If FAIL: Debug, fix, re-run

**Only when ALL THREE = PASS → Proceed to Step 10**

### Step 10: Generate Final Summary Report

- [ ] In MIGRATION_PROGRESS.md, populate "Final Summary Report" section:
  ```
  - Migration Status: ✓ COMPLETE
  - Angular Version: 18 → {version}
  - Total Steps Executed: [count]
  - Completed: [count]
  - Skipped: [count]
  - Errors Resolved: [count]/[count]
  - Build Status: ✓ PASS
  - Lint Status: ✓ PASS (0 warnings, 0 errors)
  - Test Status: ✓ PASS (all tests)
  - Code Coverage: {baseline}% → {post}% ({change})
  - Key Changes:
    - @onecx packages: [count] updated
    - PrimeNG migrated: ✓ Yes / [-] N/A
    - Nx migrated: ✓ Yes / [-] N/A
    - Copilot rules updated: ✓ Yes / [-] N/A
  - Known Issues: [list or None]
  - Deployment Ready: ✓ YES
  - Completion: [timestamp]
  ```

### Step 11: Final Commit

- [ ] All Phase C work committed? If not:
  - `git commit -m "Phase C: post-migration stabilization (errors fixed, frameworks migrated, validation PASS)"`
  - Record commit hash

---

## PHASE C COMPLETION CRITERIA (MANDATORY)

Phase C can ONLY be marked COMPLETE when ALL of:
- ✓ All errors documented and resolved (Error Log complete)
- ✓ Copilot-instructions.md updated (if exists)
- ✓ @onecx packages upgraded (documented versions)
- ✓ PrimeNG migration: [x] complete or [-] not applicable with evidence
- ✓ Nx migration: [x] complete or [-] not applicable with evidence
- ✓ npm build: PASS (no errors)
- ✓ npm lint: PASS (0 warnings, 0 errors)
- ✓ npm test: PASS (all tests)
- ✓ Code coverage comparison: documented
- ✓ Final summary report: generated
- ✓ Phase C commit: created

---

## REPORT BACK TO ORCHESTRATOR

```
Phase C Status: COMPLETE ✓

Error Resolution:
  • Errors recorded: {count}
  • Errors resolved: {count}
  • Error log: Complete in MIGRATION_PROGRESS.md

Package Updates:
  • @onecx packages updated: {count}
  • npm install: ✓ PASS
  • Build validation: ✓ PASS

Post-migration Tasks:
  • PrimeNG v17→v19: ✓ Complete
  • Nx migration: ✓ Complete / N/A
  • Copilot-instructions.md: ✓ Updated / N/A

Final Validation:
  ✓ npm build: PASS
  ✓ npm lint: PASS (0 warnings, 0 errors)
  ✓ npm test: PASS (all tests)

Code Coverage:
  • Baseline: {%}
  • Post-migration: {%}
  • Change: {+/-}%

Status: DEPLOYMENT READY ✓

Commit: "Phase C: post-migration stabilization" [{hash}]

Final Summary Report: Generated in MIGRATION_PROGRESS.md

Next: All phases complete. Migration FINAL.
```

---

**References**:
- Rules: `.github/rules/` (00, 01, 04)
- Knowledge base: `MIGRATION_PROGRESS.md`
- Config: `.github/migration-config.json`
