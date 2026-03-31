# Phase A: Pre-migration Execution Rules

## Pre-migration Principle
- **Goal**: Prepare all OneCX packages, configuration, and environment for core Angular upgrade
- **Do NOT Perform**: Core Angular framework upgrade (that's Phase B)
- **Do Perform**: All OneCX-specific preparation tasks from documentation

## Execution Model

### For Each Pre-migration Task
1. **REDISCOVER** documentation for that specific task (fresh MCP/fallback)
2. **READ FULLY** - Extract actual keywords and content (not just title)
3. **DETERMINE APPLICABILITY**:
   - Search repository using actual keywords from documentation
   - If no evidence → mark [-] not applicable with search details
   - If evidence found → proceed to plan
4. **PLAN** exact execution steps before executing
5. **EXECUTE** exactly as planned
6. **VALIDATE**:
   - Run: npm run build (must PASS, no errors)
   - Run: npm run lint (must be 0 warnings, 0 errors)
   - Run: npm run test (must PASS all tests)
7. **CHECKPOINT** - Halt and wait for "next"/"continue"
8. **UPDATE MIGRATION_PROGRESS.md** with execution details

### Build/Lint/Test Validation After Each Task
- **Order**: Build → Lint → Test (STRICT, NEVER changes)
- **Failure Handling**: If any fails:
  - Capture last 20+ lines of error output
  - Map each error to root cause
  - Troubleshoot and resolve before proceeding
  - Do NOT proceed to next task until ALL three PASS
- **Recording**: Update MIGRATION_PROGRESS.md with full validation output

## Package Update Rules During Pre-migration

### @onecx Packages
- **Source of truth**: OneCX migration documentation
- **For each @onecx package**:
  1. Check if OneCX docs explicitly mention it (e.g., "@onecx/portal-ui: ^6.2.0")
  2. If mentioned → Update to documented version
  3. If NOT mentioned → SKIP (don't update, keep current)
  4. Record in MIGRATION_PROGRESS.md: "Updated to {version} per documentation" or "Skipped - not in docs"

### package.json Changes
- Update only what documentation specifies
- Add "CI": "true" to build/lint/test tasks in .vscode/tasks.json
- Do NOT remove packages unless documentation explicitly says to remove
- Do NOT guess versions - always source from documentation

## Nx.migrate Usage Rule (if Nx used in project)

**PRE-MIGRATION NX STEP** (if Nx is in package.json):
1. Determine target Nx version from OneCX documentation
2. If not in OneCX docs → check Nx documentation
3. If version available:
   - Run: `nx migrate <EXACT_VERSION>` (no "latest", no version ranges)
   - Check package.json adjustments
   - Run: `npm install`
   - Run: `nx migrate --run-migrations` (if applicable)
4. Record in MIGRATION_PROGRESS.md:
   - Nx version before/after
   - What nx migrate changed in package.json
   - Installation result

## Pre-migration Completion Criteria (MANDATORY)

**Pre-migration task can ONLY be marked [x] completed AFTER ALL of**:
1. ✓ npm run build completes successfully with no errors
2. ✓ npm run lint completes with 0 warnings and 0 errors (unless developer explicitly relaxes)
3. ✓ npm run test passes all tests
4. ✓ All changes committed with message: `"Pre-migration: prepare for Angular {version} upgrade"`

**If any validation fails**:
- Capture last 20+ lines of error output in MIGRATION_PROGRESS.md error log
- Map each error to root cause
- Troubleshoot and resolve
- Do NOT proceed to Phase B until all validations PASS

## Recording in MIGRATION_PROGRESS.md

**After each task execution, update**:
```
- [x] Task Name
  - Source pages: [(URL) title]
  - Section: h2 "[section name]"
  - Applicability determination: YES [evidence] / NO [evidence]
  - Planned action: [steps planned]
  - Execution steps: [actual timestamped steps taken]
  - Files changed: [exact paths and line ranges modified]
  - Build/Lint/Test result: npm build [✓PASS / ✗FAIL], npm lint [✓PASS / ✗FAIL], npm test [✓PASS / ✗FAIL]
  - Validation evidence: [full output or key lines]
  - Edge cases or issues: [any blockers or decisions]
```

**Update Current Session Context**:
- Last executed step: [step name and outcome]
- Next planned step: [step name]
- Open issues/blockers: [any blocking issues]
