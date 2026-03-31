# Phase C: Post-migration Stabilization & Finalization Rules

## Phase C Workflow (MANDATORY)

### Pre-Phase C Checkpoint
**Ask developer**: "Core upgrade complete. Ready for post-migration tasks? (Yes to continue)"
- If NO → Wait for developer to confirm
- If YES (or default) → Proceed to Phase C

**Verify**:
- Core upgrade complete (either Assistant-executed with commit, or Developer-confirmed)
- Working directory clean
- Ready to proceed with error resolution

## Error Recording & Resolution Process

### 1. Run Complete Validation Suite
```
npm run build  → Capture all output, PASS or FAIL
npm run lint   → Capture all output, PASS or FAIL  
npm run test   → Capture all output, PASS or FAIL
```

### 2. Record ALL Errors in MIGRATION_PROGRESS.md Error Log
**For each error**:
- Timestamp: [when error occurred]
- Phase: [Phase C task name]
- Full error output: [last 20+ lines minimum]
- Root cause analysis: [what's causing this error]
- Resolution attempt: [what will be tried]
- Status: [pending / resolved / escalated]

### 3. Address Errors Systematically
**For each error**:
1. Analyze root cause from error message
2. Search documentation (MCP/fallback) for similar issues
3. Apply fix based on documentation
4. Re-run build/lint/test
5. Record result in error log
6. If resolved → move to next error
7. If still failing → try alternative fix and log attempt

### 4. Continue Until all Validations PASS
- npm run build: ✓ PASS (no errors)
- npm run lint: ✓ PASS (0 warnings, 0 errors, unless developer explicitly allows exceptions)
- npm run test: ✓ PASS (all tests passing)

**Do not proceed with package upgrades or PrimeNG/Nx migration until these three PASS.**

## Copilot-instructions.md Cleanup

**If copilot-instructions.md exists**:
1. Open the file
2. Identify rules specific to Angular 18
3. Remove or comment out Angular 18-specific rules
4. Add comment: `# Post-Angular 19 cleanup - {timestamp}`
5. Record in MIGRATION_PROGRESS.md:
   - Files modified: [path]
   - Specific rules removed: [list with section references]
   - Timestamp: [when changed]

**Example**:
```
# REMOVED - Post-Angular 19 cleanup (2024-01-15)
# - Rule: Use deprecated HttpClientJsonpModule (Angular 18)
# - Reason: Removed in Angular 19, use jsonp() directly
```

## Package Upgrade (Post-error-resolution)

### Step 1: Update @onecx Packages
**Based on OneCX documentation**:
- For each @onecx package mentioned in docs:
  - Update to documented version (e.g., ^6.2.0)
- For each @onecx package NOT mentioned in docs:
  - SKIP (keep current version)
- Record in MIGRATION_PROGRESS.md:
  - Package → [current version] → [new version] (source documentation)
  - Skipped packages: [list with reason "Not in OneCX migration docs"]

### Step 2: npm install
- Run: `npm install`
- Record result: PASS or FAIL

### Step 3: Build Compatibility Check
- Run: `npm run build`
- If fails → investigate compatibility issues
  - Check error messages for package incompatibilities
  - Search documentation for known issues
  - Adjust package versions as needed
  - Record all troubleshooting attempts
- If passes → continue to PrimeNG migration

### Step 4: Record in MIGRATION_PROGRESS.md
```
- [ ] Upgrade @onecx packages
  - Packages updated:
    - @onecx/package1: old → new (source: OneCX docs)
    - @onecx/package2: old → new (source: OneCX docs)
  - Packages skipped: [list]
  - npm install result: PASS / FAIL
  - Build compatibility check: PASS / FAIL
```

## PrimeNG Migration (v17 → v19) - POST PACKAGE UPGRADE

### Pre-step: Determine if PrimeNG is Used
- Search package.json for "primeng"
- If NOT present → Mark step [-] not applicable "PrimeNG not used in project"
- If present → Proceed to migration

### Phase 1: Fetch Fresh PrimeNG Documentation

**Use MCP or fallback** (at task START, not relying on earlier notes):
- **Primary**: MCP server query "PrimeNG v17 v18 v19 migration"
- **Secondary**: node_modules/primeng/CHANGELOG.md
- **Tertiary**: https://primeng.org/migration/v19

**Document in MIGRATION_PROGRESS.md**:
- Source used: [MCP / CHANGELOG.md / fallback URL]
- Fetch timestamp: [when fetched]
- v17→v18 breaking changes: [extracted list]
- v18→v19 breaking changes: [extracted list]

### Phase 2: Execute v17→v18 Migration Tasks

**For each breaking change identified**:
1. **Applicability**: Search repository for evidence
   - Search for component names, import paths, API calls
   - Record search results
   
2. **Plan**: Document changes needed before executing
   - Files to modify
   - Specific changes per file
   - Expected outcomes

3. **Execute**: Make changes exact as documented
   - Record commit or file changes

4. **Validate**: Run build/lint/test
   - Record results

5. **Checkpoint**: Halt and wait for "next"/"continue"

### Phase 3: Execute v18→v19 Migration Tasks

**Same process as v17→v18**:
1. Search repository for evidence of v18 APIs
2. Plan exact changes
3. Execute changes
4. Validate with build/lint/test
5. Record in MIGRATION_PROGRESS.md

### Phase 4: Final PrimeNG Validation
- Run: `npm run build` → must PASS
- Run: `npm run lint` → must PASS (0 warnings, 0 errors)
- Run: `npm run test` → must PASS
- Record results in MIGRATION_PROGRESS.md

**PrimeNG migration can ONLY be marked [x] completed when all three PASS**

## Nx Migration (if applicable) - POST PACKAGE UPGRADE

### Pre-step: Determine if Nx is Used
- Check package.json for "nx" or "@nx"
- If NOT present → Mark [-] not applicable "Nx not in package.json"
- If present → Proceed to migration

### Phase 1: Fetch Fresh Nx Documentation

**Use MCP or fallback** (at task START):
- **Primary**: MCP server query "Nx Angular {version} migration"
- **Secondary**: node_modules/nx/CHANGELOG.md
- **Tertiary**: https://nx.dev/docs/technologies/angular/migrations

**Document in MIGRATION_PROGRESS.md**:
- Source used: [MCP / CHANGELOG.md / fallback URL]
- Fetch timestamp: [when fetched]
- Nx version target (from docs): [version]
- Breaking changes identified: [extracted list]
- Configuration changes needed: [list]

### Phase 2: Apply Nx Configuration Changes

**From documentation**:
1. Open nx.json
2. Apply configuration changes exactly as documented
3. Document changes:
   - File: nx.json
   - Specific changes: [lines modified with before/after]
   - Source: [documentation section]

### Phase 3: Execute Nx Migration Tasks

**For each task identified**:
1. **Check for Nx generators**: If documentation mentions migration generators
   - Example: `nx migrate latest`, `nx migrate --run-migrations`
   - Execute generators exactly as documented
   
2. **For manual tasks**:
   - Search repository for affected files (plugins, configurations, etc.)
   - Apply changes per documentation
   - Record exact paths and line ranges

3. **Validate**: After each task
   - Run: `npm run build`
   - Run: `npm run lint`
   - Run: `npm run test`
   - Record results

### Phase 4: Final Nx Validation
- Run: `npm run build` → must PASS
- Run: `npm run lint` → must PASS (0 warnings, 0 errors)
- Run: `npm run test` → must PASS
- Record results in MIGRATION_PROGRESS.md

**Nx migration can ONLY be marked [x] completed when all three PASS**

## Post-migration Completion Criteria (MANDATORY)

**Post-migration can ONLY be marked [x] completed AFTER ALL of**:
1. ✓ All build/lint/test failures from initial Phase C run addressed (or marked acceptable)
2. ✓ Copilot-instructions.md updated (Angular 18 rules removed)
3. ✓ @onecx packages upgraded (documented versions)
4. ✓ PrimeNG migration completed: (v17→v18→v19) or marked [-] not applicable
5. ✓ Nx migration completed (if used) or marked [-] not applicable
6. ✓ npm run build: PASS (no errors)
7. ✓ npm run lint: PASS (0 warnings, 0 errors unless developer allows)
8. ✓ npm run test: PASS (all tests passing)
9. ✓ Code coverage comparison documented: [baseline %] → [post %]
10. ✓ All migration steps marked [x] completed or [-] not applicable
11. ✓ Final summary report generated

**If any validation fails**:
- Document error in error log
- Troubleshoot
- Resolve before marking post-migration complete

## Final Summary Report

Generate in MIGRATION_PROGRESS.md:
```
## Final Summary Report

- Migration Status: ✓ COMPLETE / [ ] BLOCKED
- Angular Version: 18 → {version}
- Total Steps: [count]
- Completed: [count]
- Skipped: [count]
- Errors Resolved: [count]/[count]
- Build Status: ✓ PASS
- Lint Status: ✓ PASS (0 warnings, 0 errors)
- Test Status: ✓ PASS (all tests)
- Code Coverage: [baseline %] → [post %] ([change])
- Key Changes:
  - @onecx packages: [count] updated
  - PrimeNG migrated: ✓ Yes / [ ] N/A
  - Nx migrated: ✓ Yes / [ ] N/A
  - Copilot rules updated: ✓ Yes / [ ] N/A
- Known Issues: [list or "None"]
- Deployment Ready: ✓ YES
- Completion: [timestamp]
```

## Recording Template for Phase C Tasks

**After each Phase C task**:
```
- [x] Task Name
  - Source pages: [(URL) title]
  - Applicability: YES / NO [evidence]
  - Planned action: [steps]
  - Execution steps: [timestamped actual steps]
  - Files changed: [exact paths and line ranges]
  - Build/Lint/Test result: [✓PASS / ✗FAIL]
  - Edge cases or issues: [any blockers]
```
