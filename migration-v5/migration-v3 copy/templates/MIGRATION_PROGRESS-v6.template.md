# MIGRATION_PROGRESS.md - Angular 18 → 19 (OneCX v6 Workflow)

**Workflow Version**: v6 (Strict documentation expansion, mandatory evidence)  
**Start Date**: [YYYY-MM-DD]  
**Target**: Angular 18 → 19 (OneCX compatible)  
**Developer**: [name]  
**Branch**: [feature/angular-19-migration]

---

## Summary

**Current Phase**: Phase 1 (Initialization)  
**Phase Status**: [ ] Not started | [ ] In progress | [x] Completed

**Overall Progress**:
- Phase 1 (Init): [PROGRESS]
- Phase A (Pre-migration): [PROGRESS]
- Phase B (Handover): [PENDING]
- Phase C (Post-migration): [PENDING]

---

## PHASE 1: INITIALIZATION & PLANNING

### [ ] Branch Check
- **Status**: [ ] not started | [x] completed
- **Source pages**: N/A (git repository)
- **Summary**: Verify working on feature branch, not main/master/develop
- **Repository evidence**: 
  ```
  git status output: [branch name]
  ```
- **Planned action**: Ensure feature branch exists and is checked out
- **Files changed**: None
- **Validation**: Git branch confirmed
- **Final outcome**: [success|blocked|error]
- **Edge Cases or Issues**: [none if success]

### [ ] Dependency and Test Audit
- **Status**: [ ] not started
- **Source pages**: npm documentation, project package.json
- **Summary**: Run npm install and npm test to verify baseline health
- **Repository evidence**: [TBD]
- **Planned action**: 
  1. Run npm install (via VS Code task or terminal)
  2. Capture install output (full, not just exit code)
  3. Run npm run test (via VS Code task or terminal)
  4. Capture test output and baseline coverage %
- **Files changed**: 
  - package-lock.json (may be updated)
  - No source files changed
- **Validation**: 
  - npm install: [success/failure, last 20 lines if failed]
  - npm test: [success/failure, last 20 lines if failed]
  - Baseline coverage: [X% or N/A]
- **Final outcome**: [success|blocked - install failed|blocked - tests failed]
- **Edge Cases or Issues**: [note any pre-existing test failures]

### [ ] Coverage Audit (Optional)
- **Status**: [ ] not started
- **Source pages**: Test output from npm run test
- **Summary**: Extract and record code coverage baseline for comparison in Phase C
- **Repository evidence**: [coverage % from test output]
- **Planned action**: Parse test output for coverage metric
- **Files changed**: None
- **Validation**: Coverage baseline extracted
- **Final outcome**: [coverage recorded|N/A - coverage not available]
- **Edge Cases or Issues**: [note if coverage reporting not configured]

### [ ] Copilot Instructions Audit
- **Status**: [ ] not started
- **Source pages**: .github/copilot-instructions.md or root copilot-instructions.md
- **Summary**: Review for Angular 18-specific rules and tag for removal in Phase C
- **Repository evidence**: [path to instructions file]
- **Planned action**: 
  1. Read copilot-instructions.md file
  2. Identify lines specific to Angular 18
  3. Tag those lines with # [REMOVE-AFTER-A19] comment
  4. Record tagged sections in this document
- **Files changed**: 
  - .github/copilot-instructions.md (additions of # [REMOVE-AFTER-A19] tags)
- **Validation**: File reviewed and tagged sections identified
- **Final outcome**: [success|no instructions file found]
- **Edge Cases or Issues**: [none if success]

Example angular 18-specific rules to look for:
```
# [REMOVE-AFTER-A19] No standalone components in app shell
# [REMOVE-AFTER-A19] Always use zone.run for event handlers
# [REMOVE-AFTER-A19] Import MatLegacy components
```

### [ ] Task Configuration Audit
- **Status**: [ ] not started
- **Source pages**: .vscode/tasks.json
- **Summary**: Verify required VS Code build tasks exist and are properly configured
- **Repository evidence**: [current tasks.json content]
- **Planned action**:
  1. Open .vscode/tasks.json
  2. Verify tasks exist: npm:build, npm:lint, npm:test
  3. For test task: verify CI=true flag, no watch mode
  4. Create any missing tasks using provided template
  5. Ensure "CI": "true" in env for all build tasks
- **Files changed**: 
  - .vscode/tasks.json (if tasks added or updated)
- **Validation**: 
  - npm:build task: [exists|created]
  - npm:lint task: [exists|created]
  - npm:test task: [exists|created]
  - CI flag: [present|added]
- **Final outcome**: [success|no changes needed]
- **Edge Cases or Issues**: [document if tasks already existed]

### [ ] Documentation Discovery (STRICT EXPANSION)
- **Status**: [ ] not started
- **Source pages**: 
  - OneCX MCP: Angular 19 migration index
  - PrimeNG MCP: v19 migration (if used)
  - Nx MCP: ng migration (if workspace is Nx)
- **Summary**: 
  Perform exhaustive documentation expansion:
  1. Query OneCX MCP for "Angular 19 migration"
  2. Fetch index page (full content, not summary)
  3. For EVERY link on index:
     - Fetch full linked page
     - Read complete content
     - Identify subsections and action steps
     - If page has sub-links: fetch those too
     - Record subsection count
  4. Fetch PrimeNG v19 migration (if repo uses primeng)
  5. Fetch Nx migration guide (if Nx workspace)
  6. Build complete tree before task creation
- **Repository evidence**: 
  - package.json dependencies: [primeng|no primeng], [nx|no nx]
  - Nx config: [nx.json present|absent]
- **Planned action**:
  1. Visit OneCX migration index: [URL]
  2. Found [N] linked pages
  3. Fetched all [N] pages
  4. Identified [N] concrete action steps
  5. Created task entries for each step
- **Files changed**: None (documentation review only)
- **Validation**: All linked pages read and documented
- **Final outcome**: success
- **Edge Cases or Issues**: [any unclear sections noted for Phase A]

**Discovery Results**:
- OneCX migration index: [SOURCE] [URL]
- PrimeNG migration: [NOT APPLICABLE | SOURCE | URL]
- Nx migration: [NOT APPLICABLE | SOURCE | URL]
- Total tasks discovered: [N]
- Total sub-pages expanded: [N]

### [ ] Task Breakdown and Planning
- **Status**: [ ] not started
- **Source pages**: [All discovered pages from Documentation Discovery step]
- **Summary**: Break down discovered documentation into explicit tasks
- **Repository evidence**: N/A
- **Planned action**:
  1. Parse each discovered page
  2. For each page with multiple actions: create one task per action
  3. For procedural pages: create one task per H2 heading
  4. For simple pages: one task total
  5. Verify no task is vague (all must be executable)
  6. Check applicability with repo evidence
  7. Create task entries in MIGRATION_PROGRESS.md Phase A section
- **Files changed**: None
- **Validation**: All tasks documented and ordered by dependency
- **Final outcome**: success
- **Edge Cases or Issues**: [any ambiguous sections noted for clarification]

### [ ] Create MIGRATION_PROGRESS.md (This Document)
- **Status**: [ ] not started
- **Source pages**: Task breakdown above
- **Summary**: Document all tasks with required evidence fields
- **Repository evidence**: N/A
- **Planned action**:
  1. Create structured task entries for Phase A (pre-migration)
  2. Create structured task entries for Phase C (post-migration)
  3. Use evidence field template for each task
  4. Leave TBD for Planned action, Files changed, Validation (filled during execution)
- **Files changed**: 
  - MIGRATION_PROGRESS.md (this file, created)
- **Validation**: Document structure verified
- **Final outcome**: success
- **Edge Cases or Issues**: [none]

### [ ] Review and Clarify Plan
- **Status**: [ ] not started
- **Source pages**: Completed MIGRATION_PROGRESS.md
- **Summary**: Verify plan clarity and resolve ambiguities with developer
- **Repository evidence**: N/A
- **Planned action**:
  1. Review MIGRATION_PROGRESS.md for clarity
  2. If any task is ambiguous: STOP and ask developer
  3. If any dependency chain is unclear: STOP and ask developer
  4. Note clarifications in this section
- **Files changed**: None
- **Validation**: Plan reviewed and clarified
- **Final outcome**: [success|clarifications needed]
- **Edge Cases or Issues**: [clarifications recorded]

---

## PHASE A: PRE-MIGRATION EXECUTION

**Phase Status**: [ ] Not started | [ ] In progress | [ ] Completed

### [ ] Update @onecx packages
- **Source pages**: [OneCX migration v19 guide link]
- **Summary**: [TBD - based on OneCX docs]
- **Repository evidence**: [TBD]
- **Planned action**: [TBD]
- **Files changed**: [TBD]
- **Validation**: [TBD]
- **Final outcome**: [TBD]
- **Edge Cases or Issues**: [TBD]

### [ ] Update Angular to target version
- **Source pages**: [OneCX migration v19 guide link]
- **Summary**: [TBD - based on OneCX docs]
- **Repository evidence**: [TBD]
- **Planned action**: [TBD]
- **Files changed**: [TBD]
- **Validation**: [TBD]
- **Final outcome**: [TBD]
- **Edge Cases or Issues**: [TBD]

### [ ] Run nx migrate (if Nx workspace)
- **Source pages**: [OneCX or Nx migration guide - exact version link]
- **Summary**: [TBD]
- **Repository evidence**: [TBD - nx.json verification]
- **Planned action**: [TBD - exact nx migrate command with fixed version]
- **Files changed**: [TBD - generated migration files]
- **Validation**: [TBD]
- **Final outcome**: [TBD]
- **Edge Cases or Issues**: [TBD - will record exact nx migrate version used]

**CRITICAL**: nx migrate version MUST come from OneCX or Nx documentation.
Example: `nx migrate 20.0.0` (NOT latest, NOT range)

### [ ] npm install
- **Source pages**: Phase A orchestration requirement
- **Summary**: Install updated dependencies
- **Repository evidence**: [TBD]
- **Planned action**: Run npm install via VS Code task or terminal
- **Files changed**: [TBD - package-lock.json]
- **Validation**: [TBD - success confirmation]
- **Final outcome**: [TBD]
- **Edge Cases or Issues**: [TBD]

### [ ] nx migrate --run-migrations (if Nx workspace)
- **Source pages**: [Nx documentation]
- **Summary**: Apply generated migrations
- **Repository evidence**: [TBD]
- **Planned action**: Run nx migrate --run-migrations
- **Files changed**: [TBD - list all migrated files]
- **Validation**: [TBD]
- **Final outcome**: [TBD]
- **Edge Cases or Issues**: [TBD]

### Validation After All Phase A Tasks

#### Build Test
- Command: npm run build
- Status: [ ] Pending
- Output: [TBD - last 20 lines if failed]
- Result: [success|failed - error mapping]

#### Lint Test
- Command: npm run lint
- Status: [ ] Pending
- Requirements: 0 errors, 0 warnings
- Output: [TBD]
- Result: [success|failed - error mapping]

#### Test Suite
- Command: npm run test
- Status: [ ] Pending
- Baseline comparison: [TBD]
- Output: [TBD - last 20 lines if failed]
- Result: [success|failed - error mapping]

#### Phase A Commit
- Status: [ ] Pending
- Commit message:
  ```
  feat(migration): prepare Angular 18→19 pre-migration
  
  - Updated @onecx packages to v19-compatible versions
  - Updated @angular packages to target versions
  - Ran nx migrate <version>
  - Updated package-lock.json
  - All pre-migration validation checks pass
  - Ready for core Angular framework upgrade
  ```
- Commit hash: [TBD]
- Files committed: [TBD]

---

## PHASE B: HANDOVER & COMMIT

**Phase Status**: [ ] Pending | [ ] In progress | [ ] Completed

### Developer Actions Required

**Critical**: Developer must perform core Angular framework upgrade using official Angular tools.
This agent does NOT perform the core upgrade - only pre and post migration steps.

Developer checklist:
1. [ ] Run: npm run build
2. [ ] Run: npm run lint
3. [ ] Run: npm run test (baseline)
4. [ ] Perform core Angular 19 upgrade (using official Angular tool or guide)
5. [ ] Run: npm run test (verify tests green)
6. [ ] Respond: "Tests green" or "Tests failed, need help"

### Developer Confirmation

**Status**: [ ] Waiting for response

Response from developer (choose one):
- [ ] "Tests are green after core upgrade, proceed with Phase C"
- [ ] "Tests failed, please help resolve errors"
- [ ] "Proceed with Phase C, I'll handle remaining issues"

Date of response: [TBD]

---

## PHASE C: POST-MIGRATION FINALIZATION

**Phase Status**: [ ] Not started | [ ] Pending phase B | [ ] In progress | [ ] Completed

**Trigger**: ONLY proceed if developer confirms green tests or explicitly requests error resolution

### [ ] Clean up copilot-instructions.md
- **Source pages**: Copilot instructions audit from Phase 1
- **Summary**: Remove Angular 18-specific rules tagged with [REMOVE-AFTER-A19]
- **Repository evidence**: [TBD - audit results from Phase 1]
- **Planned action**: Remove or comment lines tagged [REMOVE-AFTER-A19]
- **Files changed**: [TBD - .github/copilot-instructions.md]
- **Validation**: File updated, removed rules verified
- **Final outcome**: [TBD]
- **Edge Cases or Issues**: [TBD]

### [ ] Install PrimeNG v19 (if applicable)
- **Source pages**: [PrimeNG v19 migration docs, OneCX integration guide]
- **Summary**: [TBD - based on PrimeNG docs]
- **Repository evidence**: [TBD - primeng current version]
- **Planned action**: [TBD]
- **Files changed**: [TBD]
- **Validation**: [TBD]
- **Final outcome**: [TBD]
- **Edge Cases or Issues**: [TBD]

### [ ] Install remaining @onecx packages
- **Source pages**: [OneCX documentation]
- **Summary**: [TBD]
- **Repository evidence**: [TBD]
- **Planned action**: [TBD]
- **Files changed**: [TBD]
- **Validation**: [TBD]
- **Final outcome**: [TBD]
- **Edge Cases or Issues**: [TBD]

### Final Build & Test
- Command: npm run build
- Result: [TBD]
- Command: npm run lint
- Result: [TBD]
- Command: npm run test
- Result: [TBD]
- Coverage comparison: 
  - Phase 1 baseline: [X%]
  - Phase C final: [Y%]
  - Change: [+/- Z%]

### [ ] Phase C Completion
- **Status**: [TBD]
- **Date**: [TBD]
- **Final outcome**: [success|issues found]
- **Summary**: [TBD]

---

## Edge Cases or Issues

[Record any issues, blockers, or edge cases discovered during migration]

Example:
- Issue: PrimeNG component import breaking (section X, date Y)
  Solution: Applied fix from PrimeNG v19 migration guide, verified with [file list]

---

## Additional Notes

- Workflow: v6 (strict documentation expansion, mandatory evidence)
- All phase transitions require prerequisites to be met
- No task may be marked [x] completed without ALL evidence fields documented
- Rollback available at any phase: git checkout main && git reset <hash>

---

## Quick Reference

| Phase | Status | Trigger |
|-------|--------|---------|
| Phase 1 (Init) | [ ] | Start |
| Phase A (Pre) | [ ] | Phase 1 complete |
| Phase B (Handover) | [ ] | Phase A complete |
| Phase C (Post) | [ ] | Developer confirms or requests |
| Final | [ ] | Phase C complete |

**Documentation Sources Used**:
- OneCX MCP: [yes|no]
- OneCX Fallback URL: [yes|no]
- PrimeNG MCP: [yes|no]
- PrimeNG Fallback URL: [yes|no]
- Nx MCP: [yes|no]
- Nx Fallback URL: [yes|no]
