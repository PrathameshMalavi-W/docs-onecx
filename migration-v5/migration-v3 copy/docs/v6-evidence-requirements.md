# V6 Evidence Requirements

Every task in MIGRATION_PROGRESS.md must have ALL of these fields documented before marking [x] completed.

---

## The 7 Required Evidence Fields

### 1. Source Pages
**What**: URLs of all documentation pages read for this task  
**Why**: Proves research was done, allows verification

**Format**:
```markdown
- Source pages: 
  - https://onecx.github.io/docs/.../angular-19/packages.html
  - https://onecx.github.io/docs/.../angular-19/dependencies.html
  - https://primeng.org/migration/v19#material
```

**Examples of COMPLETE**:
```
- Source pages:
  - OneCX MCP: Angular 19 package updates guide
  - PrimeNG MCP: Material components breaking changes
  - Nx docs: package.json migration
```

**Examples of INCOMPLETE** (not acceptable):
```
- Source pages: Angular docs
- Source pages: TBD
- Source pages: [not filled in]
```

### 2. Applicability
**What**: Is this task required (must-have), optional (nice-to-have), or doesn't apply (not applicable)?  
**Why**: Justifies whether task was included/skipped

**Values**:
- `must-have` - required for Angular 19 compatibility
- `nice-to-have` - improves code but not required
- `not applicable` - repo evidence shows this doesn't apply

**Format**:
```markdown
- Applicability: must-have
```

OR if not applicable:
```markdown
- Applicability: not applicable
- Reason: Repository uses Material v18 Legacy API, not New API
  Evidence: grep shows 0 uses of MatLegacyButton patterns
```

**Examples of COMPLETE**:
```
- Applicability: must-have (required for Angular 19 compatibility)
- Applicability: nice-to-have (improves performance, not required)
- Applicability: not applicable (repo doesn't use PrimeNG)
```

**Examples of INCOMPLETE** (not acceptable):
```
- Applicability: [TBD]
- Applicability: probably applicable
- Applicability: [not documented]
```

### 3. Repository Evidence
**What**: Grep results, file inspection, or data that proves applicability decision  
**Why**: Shows decision was based on actual repository state, not guessing

**Format**:
```markdown
- Repository evidence:
  ```
  $ grep -r "MatLegacy" src/
  src/app/components/buttons.ts: import { MatLegacyButton }
  src/shared/forms.ts: import { MatLegacyForm }
  [2 uses found]
  ```
```

**Examples of COMPLETE**:
```
- Repository evidence:
  - package.json:
    ```
    "@angular/material": "^18.0.0"
    ```
  - Grep: `grep -r "standalone:" src/ | wc -l` = 0 (no standalone components yet)

- Repository evidence:
  - Checked: nx.json (Nx workspace confirmed, v19 migration applies)
  - Checked: package.json (ng version 18.0.0)
```

**Examples of INCOMPLETE** (not acceptable):
```
- Repository evidence: [TBD]
- Repository evidence: looks like repo doesn't use this
- Repository evidence: [pending]
```

### 4. Planned Action
**What**: Exact description of what the task requires or what was done  
**Why**: Creation = what will be done; after execution = what was actually done

**Before Execution**:
```markdown
- Planned action: 
  1. Update @angular/core from 18.0.0 to 19.0.0 in package.json
  2. Update @angular/common from 18.0.0 to 19.0.0
  3. Update @angular/forms from 18.0.0 to 19.0.0
  4. Run npm install
  5. Verify no other breaking changes
```

**After Execution**:
```markdown
- Planned action: Updated Angular packages to v19
  - Completed: npm install
  - Result: package-lock.json regenerated (1024 lines changed)
  - Verified: no peer dependency warnings
```

**Examples of COMPLETE**:
```
- Planned action: Remove @angular/material@18 legacy API imports and replace with new API
  Steps:
  1. grep for MatLegacyButton, MatLegacyForm, MatLegacyTable
  2. Replace with Material v19 equivalents
  3. Verify templates updated
  4. Run tests to check breaking changes
  
After execution:
- Completed: Updated 12 files, 47 lines changed
- Validation: All affected tests pass
```

**Examples of INCOMPLETE** (not acceptable):
```
- Planned action: Update Angular [vague]
- Planned action: [TBD]
- Planned action: Follow the docs [too vague]
```

### 5. Files Changed
**What**: List of files that were modified, AND their line counts or scope  
**Why**: Proves actual code changes were made (if applicable)

**Format - if changes made**:
```markdown
- Files changed:
  - package.json (2 lines: angular core/common versions)
  - src/app/app.module.ts (1 line: add standalone: false)
  - src/shared/material.ts (12 lines: replace legacy components)
  - src/styles/material.scss (4 lines: update variables)
```

**Format - if no changes needed**:
```markdown
- Files changed: none (audit only - no code changes required)
```

**Examples of COMPLETE**:
```
- Files changed:
  - package.json (updated @angular versions)
  - package-lock.json (1200+ lines regenerated)
  - src/app/components/*.ts (12 files: updated imports)

- Files changed: none (step was visual verification only)

- Files changed:
  - .vscode/tasks.json (1 task added: npm:build)
```

**Examples of INCOMPLETE** (not acceptable):
```
- Files changed: [TBD]
- Files changed: some files
- Files changed: [N/A]
```

### 6. Validation
**What**: Build, lint, and/or test results proving the task worked  
**Why**: Prevents silent failures or partial execution

**Format**:
```markdown
- Validation:
  - npm run build: ✓ passed (0 errors, 0 warnings)
    Output: "successfully compiled 47 components"
  - npm run lint: ✓ passed (0 errors, 0 warnings)
  - npm run test: ✓ passed (124 tests passing)
    Coverage: 82% (same as baseline)
```

**Minimal validation**:
```markdown
- Validation:
  - npm run build: passed
  - npm run test: passed (all 124 tests green)
```

**If validation fails** (task must be [[x](/x)]):
```markdown
- Validation:
  - npm run build: ✗ FAILED
    Last 20 lines:
    ```
    error NG6003: Identifier 'MatLegacyButton' not found in '@angular/material'
    src/shared/buttons.ts:12:3 - error NG6003: Identifier 'MatLegacyButton' not found
    Compilation failed. 2 errors total.
    ```
    Root cause: Legacy Material API still being imported
    Action needed: Update imports to new Material API
```

**Examples of COMPLETE**:
```
- Validation:
  - npm run build: ✓ 0 errors
  - npm run lint: ✓ 0 errors, 0 warnings
  - npm run test: ✓ 124/124 tests pass
  
- Validation:
  - Step was config change, build/lint/test passed next
  - No breaking changes detected
  
- Validation: FAILED
  - npm run build error: [error output]
  - Root cause identified: [reason]
  - Awaiting fix before re-run
```

**Examples of INCOMPLETE** (not acceptable):
```
- Validation: [TBD]
- Validation: looks good
- Validation: passed (no details)
```

### 7. Final Outcome
**What**: Single word summary: success|blocked|error  
**Why**: Quick status check

**Values**:
- `success` - task executed fully, all validation passed, evidence complete
- `blocked` - task blocked by external dependency or decision needed
- `error` - task executed but validation failed

**Format**:
```markdown
- Final outcome: success
```

OR:
```markdown
- Final outcome: blocked
- Block reason: Awaiting developer confirmation on PrimeNG version choice
- Status: Can proceed after developer provides decision
```

OR:
```markdown
- Final outcome: error
- Error: npm run build failed with 2 compilation errors (see Validation section)
- Status: Needs investigation and re-run
```

**Examples of COMPLETE**:
```
- Final outcome: success

- Final outcome: blocked - Nx 20 requires Node 18.12+
  Current: Node 16.14.0
  Solution: Developer must upgrade Node first

- Final outcome: error - Tests fail due to Material API breaking change
  Action: Running task again to apply documented fix
```

**Examples of INCOMPLETE** (not acceptable):
```
- Final outcome: [TBD]
- Final outcome: looks okay
- Final outcome: proceeding
```

---

## Additional Evidence Field (Optional)

### 8. Edge Cases or Issues
**What**: Any special circumstances, gotchas, or decisions made  
**Why**: Explains non-obvious aspects of task

**Examples**:
```markdown
- Edge Cases or Issues:
  - Material v19 dropped MatLegacy API, forced immediate upgrade
  - 3 components had @ViewChild references that needed adjustment
  - Coverage dropped 2% due to test rewrites (acceptable per Angular 19 API changes)
  - Standalone: false added only to 2 modules per OneCX architecture guidelines
```

---

## Complete Example Task Entry

```markdown
[ ] Remove Angular Material Legacy API
  - Source pages:
    - https://primeng.org/migration/v19#breaking-changes
    - https://material.angular.io/guide/migration (Material v19 breaking changes)
    - OneCX MCP: "Material component migration for Angular 19"
  
  - Applicability: must-have
    Evidence: Repository actively uses Material components (12 files import from @angular/material)
  
  - Repository evidence:
    ```
    $ grep -r "MatLegacy" src/
    src/app/components/buttons.ts: import { MatLegacyButton }
    src/app/components/forms.ts: import { MatLegacyForm }
    src/shared/data-table.ts: import { MatLegacyTableDataSource }
    Total: 3 files with legacy imports
    ```
  
  - Planned action:
    1. Replace MatLegacyButton with MatButton
    2. Replace MatLegacyForm with MatFormField
    3. Replace MatLegacyTableDataSource with MatTableDataSource
    4. Update test mocks for new API
    5. Run full test suite to verify no breaking changes
  
  - Files changed:
    - src/app/components/buttons.ts (4 lines: import statement)
    - src/app/components/forms.ts (2 lines: import statement)
    - src/shared/data-table.ts (3 lines: import statement)
    - src/app/components/*.spec.ts (8 files: updated mocks, 24 lines total)
  
  - Validation:
    - npm run build: ✓ passed (0 errors, 0 warnings)
      Output: "successfully compiled 47 components"
    - npm run lint: ✓ passed (0 errors, 0 warnings)
    - npm run test: ✓ passed
      Results: 124/124 tests pass, 82% coverage (unchanged)
  
  - Final outcome: success
  
  - Edge Cases or Issues:
    - MatLegacyTableDataSource API changed size parameters
    - Updated 2 test files that mocked the component APIs
    - No user-facing changes, internal refactor only
```

---

## Evidence Checklist (Before Marking [x])

- [ ] Source pages: 3+ URLs documented
- [ ] Applicability: explicitly stated (must-have|nice-to-have|not applicable)
  - If not applicable: repository evidence provided
- [ ] Repository evidence: grep/inspection results shown
- [ ] Planned action: detailed steps documented
- [ ] Files changed: list provided (or "none" if applicable)
- [ ] Validation: build/lint/test output shown
  - All passed? ✓
  - Any failed? ✗ (task must stay [ ])
- [ ] Final outcome: success|blocked|error stated
- [ ] Edge cases: any gotchas documented (or "none" if N/A)

**All 8 checkboxes must be ✓ before marking [x] completed**

---

## Common Shortcuts (Anti-Patterns)

| ❌ Shortcut | ✅ Instead |
|------------|-----------|
| Validation: TBD | Validation: npm run build ✓, npm run test ✓ (with details) |
| Files changed: some files | Files changed: [list 3-5 files with line counts] |
| Source pages: Angular docs | Source pages: [specific URLs], OneCX MCP, PrimeNG docs |
| Applicability: probably applicable | Applicability: must-have [repo evidence provided] |
| Planned action: follow docs | Planned action: [explicit steps 1-5] |
| Repository evidence: looks okay | Repository evidence: grep output showing 0/N cases |
| Final outcome: proceeding | Final outcome: success|blocked|error + reason |

---

## Enforcement

**Rule**: If ANY field is incomplete, vague, or says "TBD" → task must stay [ ] not started  
**Rule**: Only [x] mark tasks that pass the complete checklist  
**Rule**: Validator agent MUST check all 8 fields before approving completion

This rigor prevents hidden failures and ensures every task is fully executed and verified.
