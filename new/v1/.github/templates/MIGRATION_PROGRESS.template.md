# MIGRATION_PROGRESS.md Template

> **Note**: This is the PRIMARY KNOWLEDGE BASE for the entire migration. Update CONTINUOUSLY during execution, not at the end. Reference it BEFORE each step. It must contain all rules, knowledge, data, context, and logs.

---

## Header Section (Created once, updated as needed)

- **Project**: [project name]
- **Angular Version Target**: 18 → [19/20/21]
- **Repository**: [path]
- **Git Branch**: [branch name]
- **Start Date**: [YYYY-MM-DD]
- **Status**: [In Progress / Blocked / Completed]
- **Generalized for**: Angular [19/20/21] migration (same steps for each, parameters adjusted)

---

## Custom Rules & Constraints (Add as discovered)

- Developer-specified rules (override defaults if any)
- Project-specific constraints
- Build/test/lint configuration notes
- Any special requirements from developer
- Extract from USER_CUSTOM_RULES.md if exists

---

## Documentation Discovery (Comprehensive map)

### Main Index Page
- URL: [onecx index URL]
- Title: [page title]
- Fetched: [timestamp]

### H1 Sections in Main Index
- [H1 Section 1]
- [H1 Section 2]
- etc.

### All Discovered Pages (Expanded from index)

#### Page 1: [title]
- URL: [url]
- H1 Context: [H1 title if applicable]
- H2 Sections (independent tasks):
  - [ ] [H2 section name]
  - [ ] [H2 section name]
- Secondary links to other pages:
  - [linked page title](URL)
  - [linked page title](URL)

#### Page 2: [title]
- URL: [url]
- H1 Context: [H1 title if applicable]
- H2 Sections (independent tasks):
  - [ ] [H2 section name]
  - [ ] [H2 section name]
- Secondary links to other pages:
  - [linked page title](URL)

**[Continue for each discovered page...]**

### Documentation Hierarchy Notes
- Pages sourced from: [MCP server / fallback URL]
- Recursive expansion complete: [yes/no]
- Last documentation refresh: [timestamp]

---

## Baseline Metrics (Captured in Phase 1)

- **npm install**: [pass/fail with key output]
- **npm run test**: [pass/fail, baseline test count, coverage if available]
- **npm run build**: [pass/fail, baseline build output summary]
- **npm run lint**: [pass/fail, baseline warnings/errors count]
- **Code coverage**: [baseline percentage if available]
- **Known issues before migration**: [any pre-existing failures]
- **Captured**: [timestamp]

---

## Dependency Analysis

### @onecx Packages Currently in Use
- [package name]: [current version] → [documented target version or "SKIP - not in docs"]
- [package name]: [current version] → [documented target version or "SKIP - not in docs"]
- [etc.]

### PrimeNG
- Current version: [version or "not used"]
- Target version (from docs): [version or "N/A"]
- Used components: [list or "not used"]
- Migration paths: [v17→v18, v18→v19 if used]

### Nx
- Current version: [version or "not used"]
- Target version (from docs): [version or "N/A"]
- Workspace plugins: [list or "not used"]

### Breaking Changes Identified (from documentation)
- [breaking change 1]
- [breaking change 2]
- [etc.]

### Version Compatibility Matrix (from documentation)
| Package | Current | Target | Reason |
|---------|---------|--------|--------|
| @angular/core | x.x.x | y.y.y | Core upgrade target |
| @onecx/package | x.x.x | y.y.y | Documented version |
| primeng | x.x.x | y.y.y | PrimeNG migration v17→v19 |

---

## Migration Tasks (Phase A & Phase C)

> **Format per task**:
> - [ ] Task name
>   - Source pages: [URL + title]
>   - Section: [H2 header from source]
>   - Documentation summary: [key points from reading full content]
>   - Applicability determination: [YES/NO with evidence]
>   - Repository evidence: [specific paths, grep results, etc.]
>   - Planned action: [detailed steps before execution]
>   - **Execution steps**: [timestamped actual steps taken during execution]
>   - **Files changed**: [specific file paths and line ranges modified]
>   - **Build/Lint/Test result**: [pass/fail with key output lines]
>   - **Validation evidence**: [full logs or key excerpts]
>   - Edge cases or issues: [any blockers, workarounds, decisions made]

### Phase A: Pre-migration Tasks

#### [Source] Page: OneCX Angular 19 Migration Guide

- [ ] Task 1: [H2 Section Name]
  - Source pages: [(url) page title]
  - Section: h2 "[H2 section name]"
  - Documentation summary: [key points]
  - Applicability determination: [YES/NO with evidence]
  - Repository evidence: [file paths, grep, package.json, etc.]
  - Planned action: [steps before execution]
  - Execution steps: [actual steps taken]
  - Files changed: [exact paths and line ranges]
  - Build/Lint/Test result: [pass/fail]
  - Validation evidence: [key output lines]
  - Edge cases or issues: [blockers or decisions]

- [ ] Task 2: [H2 Section Name]
  - [same structure as Task 1]

**[Continue for each task discovered in Phase A...]**

### Phase C: Post-migration Tasks

#### Package Upgrade & Stabilization

- [ ] Address all build/lint/test failures
  - Errors documented: [error log entries with timestamps]
  - Root causes mapped: [each error → root cause]
  - Fixes applied: [list of fixes attempted]
  - Final build/lint/test result: [pass/fail]

- [ ] Update Copilot-instructions.md (if needed)
  - Rules removed (Angular 18 specific): [list with line numbers]
  - Files modified: [paths]
  - Timestamp: [timestamp]

- [ ] Upgrade @onecx packages
  - Packages updated: [list with versions, source documentation]
  - Packages skipped: [list with reasons "Not in docs"]
  - Files modified: [package.json changes]
  - npm install result: [pass/fail]
  - Build/Lint/Test result: [pass/fail]

#### PrimeNG Migration (v17 → v19)

- [ ] Apply PrimeNG v17 to v18 migration tasks
  - Documentation source: [(URL) page title]
  - Breaking changes addressed: [list of changes]
  - Files modified: [specific paths and line ranges]
  - Build/Lint/Test result: [pass/fail]

- [ ] Apply PrimeNG v18 to v19 migration tasks
  - Documentation source: [(URL) page title]
  - Breaking changes addressed: [list of changes]
  - Files modified: [specific paths and line ranges]
  - Build/Lint/Test result: [pass/fail]

- [ ] Final PrimeNG validation
  - Build/Lint/Test result: [pass/fail]
  - Validation evidence: [key output lines or full logs]

#### Nx Migration (if applicable)

- [ ] Check if Nx is used
  - Evidence: [grep output, package.json, nx.json exists]
  - Decision: [SKIP - not used / PROCEED - Nx found]

- [ ] Apply Nx migration tasks (only if Nx used)
  - Documentation source: [(URL) page title]
  - Nx version target: [version]
  - Configuration changes: [nx.json updates with line ranges]
  - Files modified: [specific paths]
  - Build/Lint/Test result: [pass/fail]

#### Final Validation & Completion

- [ ] Final build/lint/test validation
  - Build result: [pass/fail with output]
  - Lint result: [pass/fail, 0 warnings/errors]
  - Test result: [pass/fail with test count]
  - Timestamp: [completion timestamp]

- [ ] Code coverage comparison
  - Baseline (Phase 1): [coverage %]
  - Post-migration: [coverage %]
  - Change: [+/- percentage points]

---

## Current Session Context (Updated continuously)

- **Last executed step**: [step name and outcome]
- **Next planned step**: [step name and dependencies]
- **Open issues/blockers**: [current blocking issues]
- **Recent discoveries**: [new information from documentation]
- **Temporary working notes**: [in-progress context]
- **Last update**: [timestamp]

---

## Error Log Repository (Captured during execution)

### Error 1: [Error title]
- **Timestamp**: [YYYY-MM-DD HH:MM:SS]
- **Context**: [Phase/Step where error occurred]
- **Full error output** (last 20+ lines):
  ```
  [error output pasted here]
  ```
- **Root cause analysis**: [mapped to specific issue]
- **Resolution attempt 1**: [what was tried]
  - Result: [outcome]
  - Timestamp: [when tried]
- **Resolution attempt 2**: [what was tried]
  - Result: [outcome]
  - Timestamp: [when tried]
- **Final resolution**: [what finally worked or status]

**[Continue for each error encountered...]**

---

## Decision Log (Track all non-trivial choices)

### Decision 1: [Decision title]
- **Date**: [YYYY-MM-DD]
- **Context**: [situation that required decision]
- **Decision**: [what choice was made]
- **Rationale**: [why this choice]
- **Alternatives considered**: [other options]
- **Related documentation**: [links to supporting docs]
- **Impact**: [what this decision affects]

**[Continue for each decision made...]**

---

## Phase Completion Checklist

### Phase 1: Initialization and Planning
- [ ] Branch protection verified (not on main/master/develop)
- [ ] npm install completed successfully
- [ ] npm test baseline captured
- [ ] Build/Lint/Test baseline captured
- [ ] Code coverage baseline captured (if available)
- [ ] Documentation discovery complete (all pages, H1/H2, sub-pages)
- [ ] Dependency analysis complete (@onecx packages, PrimeNG, Nx)
- [ ] MIGRATION_PROGRESS.md created with complete structure
- [ ] Migration plan reviewed by developer: **✓ Approved** / [ ] Pending
- [ ] **CHECKPOINT**: Wait for developer to say "start" (default: start)

### Phase A: Pre-migration Tasks
- [ ] All pre-migration tasks identified and listed
- [ ] Each task: [x] completed or [-] not applicable with evidence
- [ ] npm run build: **PASS** (no errors)
- [ ] npm run lint: **PASS** (0 warnings, 0 errors)
- [ ] npm run test: **PASS** (all tests passing)
- [ ] All changes committed: `git commit -m "Pre-migration: prepare for Angular {version} upgrade"`
- [ ] **Status**: ✓ Pre-migration COMPLETE / [ ] Blocked

### Phase B: Core Angular Upgrade
- [ ] OneCX upgrade documentation fetched and reviewed
- [ ] Cheat sheet created (commands, flags, version matrix)
- [ ] Developer confirmation obtained: [Yes / No]
- [ ] Ownership decided: [Assistant executes / Developer executes]
- [ ] Core upgrade executed: [Complete / Pending / Deferred]
- [ ] Commit created (if executed): `git commit -m "Core: upgrade Angular to version {version}"`
- [ ] **Status**: ✓ Complete / [ ] Pending Developer / [ ] Blocked

### Phase C: Post-migration & Finalization
- [ ] Build/Lint/Test failures recorded in Error Log
- [ ] All errors addressed (or marked acceptable with justification)
- [ ] Copilot-instructions.md updated (Angular 18 rules removed)
- [ ] @onecx packages upgraded (documented versions)
- [ ] npm install completed: PASS / FAIL
- [ ] PrimeNG migration (v17→v19): [x] complete or [-] not applicable
  - [ ] v17→v18 tasks completed
  - [ ] v18→v19 tasks completed
  - [ ] Final validation: npm run build/lint/test PASS
- [ ] Nx migration (if applicable): [x] complete or [-] not applicable
  - [ ] Configuration updated per documentation
  - [ ] Final validation: npm run build/lint/test PASS
- [ ] Final build/lint/test: **PASS** (all validations)
- [ ] Code coverage compared: [baseline] → [post-migration]
- [ ] Summary report generated
- [ ] **Status**: ✓ Post-migration COMPLETE / [ ] Blocked

---

## Final Summary Report (Generated after Phase C completion)

- **Migration Status**: ✓ COMPLETE / [ ] BLOCKED
- **Angular Version**: 18 → [19/20/21]
- **Total Steps Executed**: [number]
- **Steps Completed**: [x] count
- **Steps Skipped**: [-] count
- **Errors Encountered**: [count]
- **Errors Resolved**: [count]
- **Build Status**: ✓ PASS / [ ] FAIL
- **Lint Status**: ✓ PASS (0 warnings, 0 errors) / [ ] FAIL
- **Test Status**: ✓ PASS (all tests) / [ ] FAIL
- **Code Coverage Change**: [baseline %] → [post-migration %] ([+/- difference])
- **Key Changes**:
  - @onecx packages updated: [list]
  - PrimeNG migrated: ✓ Yes / [ ] N/A
  - Nx updated: ✓ Yes / [ ] N/A
  - Copilot rules updated: ✓ Yes / [ ] N/A
- **Known Issues Remaining**: [list or "None"]
- **Deployment Ready**: ✓ Yes / [ ] Needs Review
- **Completion Date**: [YYYY-MM-DD HH:MM:SS]
- **Total Duration**: [time from start to completion]

---

**Last Updated**: [YYYY-MM-DD HH:MM:SS]
