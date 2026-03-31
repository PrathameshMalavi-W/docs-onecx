---
name: phase-1-initializer
description: >
  Execute Phase 1: Initialization and Planning.
  Branch check, npm baseline, documentation discovery (recursive, all pages, H1/H2 hierarchy),
  dependency analysis, create MIGRATION_PROGRESS.md template, present plan.
applyTo:
  - .md
codeBlockLanguage: markdown
---

# Phase 1: Initializer Agent

**Responsibility**: Branch protection, baseline metrics, documentation discovery, plan creation  
**Input**: migration-config.json, rules from .github/rules/  
**Output**: MIGRATION_PROGRESS.md (fully populated), plan ready for user approval  
**Rules to follow**: 00-core-constraints.md, 01-documentation-discovery-rules.md

---

## PHASE 1 CHECKLIST (In Order)

### Step 1: Branch Protection Check
- [ ] Check current Git branch: `git branch --show-current`
- [ ] If branch = main / master / develop:
  - STOP and report back: "ERROR: Cannot run on main/master/develop. Switch to feature branch first."
  - Exit Phase 1
- [ ] If branch = feature branch:
  - Continue to Step 2

**Report**: "✓ Branch OK: {branch_name}"

### Step 2: Dependency & Baseline Audit
- [ ] Run: `npm install`
  - Record output: success or error details
  - If fails: STOP, report error, exit Phase 1
- [ ] Record in future MIGRATION_PROGRESS.md: "npm install: PASS"

- [ ] Run: `npm run test` (if available)
  - Record output, test count, coverage if available
  - Record test coverage baseline (if available)
  - Note: Failures OK at this point—just capturing baseline

- [ ] Run: `npm run build`
  - Record output summary (success/failure)
  - Note any pre-existing failures in MIGRATION_PROGRESS.md

- [ ] Run: `npm run lint`
  - Record output (warnings, errors count)
  - Note baseline lint state

**Report**: "✓ Baseline metrics captured"

### Step 3: Documentation Discovery (RECURSIVE, ALL PAGES)

**START**: Read `.github/rules/01-documentation-discovery-rules.md` to understand full discovery process

- [ ] **Fetch OneCX Angular Migration Index**:
  - Use MCP: `mcp_onecx-docs-mc_about_onecx` with query "{version} migration index"
  - Fallback: https://onecx.github.io/docs/documentation/current/onecx-portal-ui-libs/migrations/angular-{version}/index.html
  - Record URL and page title

- [ ] **Record Main Index Structure**:
  - List all H1 sections (high-level grouping)
  - List all H2 sections (if any at index level)
  - List all outgoing links from index page

- [ ] **Expand Each Linked Page** (Recursive):
  - For each page linked from index:
    1. Fetch and read FULL page content (not just title)
    2. Record URL and page title
    3. List H1 (page context)
    4. List ALL H2 sections (these become independent tasks)
    5. List ALL secondary links from this page
    6. If this page links to other pages → apply same process recursively
    
- [ ] **Extract Task Granularity** (H1 = context, H2 = task):
  - H1 is page grouping context (not a separate task)
  - Each H2 becomes ONE independent task in MIGRATION_PROGRESS.md
  - Record format: "- [ ] [H2 section name]"

- [ ] **Continue Recursive Expansion Until**:
  - All linked pages from index are fetched
  - All sub-linked pages are fetched
  - Complete chain exhausted
  - Total page count: [count]
  - Total tasks identified: [count]

**Report**: "✓ Documentation discovery complete: {count} pages, {count} tasks identified"

### Step 4: Dependency Analysis

- [ ] **Extract @onecx Packages from Docs**:
  - Search discovery notes for @onecx package mentions
  - For each mentioned: Record package name + version specified in docs
  - Create list: "@onecx/package: version" (from documentation)
  - Record: "NOT mentioned in docs" for any @onecx packages in current package.json not found in docs

- [ ] **Extract PrimeNG Scope** (if @onecx packages mention it):
  - Note if PrimeNG migration is scope of Phase C
  - Record current version from package.json
  - Record whether v17 → v19 migration needed

- [ ] **Extract Nx Scope** (if @onecx packages or docs mention it):
  - Check package.json for "@nx/..."
  - Record current Nx version
  - Note if Nx migration is scope of Phase C

**Report**: "✓ Dependency analysis complete"

### Step 5: Create MIGRATION_PROGRESS.md Template

- [ ] Copy `.github/templates/MIGRATION_PROGRESS.template.md` to workspace root: `MIGRATION_PROGRESS.md`
  
- [ ] Populate Header Section:
  - Project: [projectName from config]
  - Angular Version Target: [from config]
  - Repository: [from config]
  - Git Branch: [from config]
  - Start Date: [today's date]
  - Status: In Progress

- [ ] Populate Custom Rules & Constraints:
  - Check if USER_CUSTOM_RULES.md exists
  - If yes: Copy relevant sections
  - If no: "None - using defaults"

- [ ] Populate Documentation Discovery:
  - Main index page URL and title
  - All discovered pages with URLs, titles, H1/H2 structure
  - Secondary links hierarchy
  - Complete discovery notes

- [ ] Populate Baseline Metrics:
  - npm install: {result}
  - npm test: {result with test count and coverage}
  - npm build: {result}
  - npm lint: {result}
  - Code coverage baseline: {%}
  - Known pre-existing issues: [list]

- [ ] Populate Dependency Analysis:
  - @onecx packages table
  - PrimeNG scope (used/not used, versions)
  - Nx scope (used/not used, version)
  - Breaking changes identified
  - Version compatibility matrix

- [ ] Populate Migration Tasks Section:
  - Phase A: Pre-migration Tasks
    - For each H2 identified in discovery: Create task
    - Format: `- [ ] [Task name]`
    - Record source page and H2 section header
  
  - Phase C: Post-migration Tasks
    - Package Upgrade section
    - PrimeNG Migration section (if used)
    - Nx Migration section (if used)
    - Error Resolution section
    - Final Validation section

- [ ] Populate Current Session Context:
  - Last executed step: (none - Phase 1 starting)
  - Next planned step: (all Phase A tasks pending)
  - Open issues/blockers: (none yet)

- [ ] Populate Phase Completion Checklist:
  - Phase 1: [list all items]
  - Mark items complete as Phase 1 runs

- [ ] Save MIGRATION_PROGRESS.md in workspace root

**Report**: "✓ MIGRATION_PROGRESS.md created with full structure and discovery details"

### Step 6: Present Plan to User

**Print Complete Summary**:

```
==============================================================================
PHASE 1 COMPLETE - MIGRATION PLAN READY
==============================================================================

Configuration:
  ✓ Project: {projectName}
  ✓ Angular Version: {version}
  ✓ Branch: {branch}
  ✓ Target: 18 → {version}

Baseline Metrics:
  ✓ npm install: PASS
  ✓ npm test: {PASS/FAIL} ({test_count} tests, {coverage}% coverage)
  ✓ npm build: {PASS/FAIL}
  ✓ npm lint: {warnings} warnings, {errors} errors

Documentation Discovery:
  ✓ Pages discovered: {count}
  ✓ H2 tasks identified: {count}
  ✓ Recursive expansion: Complete

Migration Task Breakdown:
  • Phase A (Pre-migration): {count} tasks
  • Phase C (Post-migration):
    - Error Resolution: [scope]
    - PrimeNG Migration: {used/N/A}
    - Nx Migration: {used/N/A}
    - Package Upgrades: @onecx packages identified

Dependencies:
  ✓ @onecx packages: {count} identified from docs
  ✓ PrimeNG: {used/not used} - v{current} → v{target}
  ✓ Nx: {used/not used} - v{current}

Plan Location: MIGRATION_PROGRESS.md in workspace root

REVIEW READY:
  1. Read MIGRATION_PROGRESS.md in full
  2. Verify task breakdown makes sense
  3. Confirm @onecx package versions from docs are correct

Ready? Type "start" to begin Phase A (pre-migration tasks).
(Default: start)
==============================================================================
```

- [ ] Wait for user to approve plan (say "start" or press enter)

---

## ERROR HANDLING

- [ ] If branch = main/master/develop:
  - Report back: "BLOCKED - Switch to feature branch"
  - Exit Phase 1

- [ ] If npm install fails:
  - Report back: "BLOCKED - npm install failed"
  - Show last 20 lines of error
  - Exit Phase 1

- [ ] If documentation fetch fails (MCP + fallback both):
  - Report back: "BLOCKED - Cannot fetch documentation"
  - Suggest: Check MCP servers are running, or manual entry of docs URL
  - Exit Phase 1

- [ ] If discovery is ambiguous:
  - Ask user for clarification: Show ambiguity, ask how to proceed
  - Continue after user clarifies

---

## COMPLETION CRITERIA

Phase 1 complete when:
- ✓ Branch verified (not main/master/develop)
- ✓ npm install PASS
- ✓ Baseline metrics captured (test, build, lint)
- ✓ Documentation fully discovered (all pages, H1/H2, recursive)
- ✓ Dependency analysis complete (@onecx, PrimeNG, Nx)
- ✓ MIGRATION_PROGRESS.md fully populated
- ✓ Plan reviewed and ready for user approval
- ✓ User approves to proceed ("start")

---

## REPORT BACK TO ORCHESTRATOR

After Phase 1 complete:

```
Phase 1 Status: COMPLETE ✓

Plan Summary:
  • Pre-migration tasks (Phase A): {count} tasks identified
  • PrimeNG migration (Phase C): {used/N/A}
  • Nx migration (Phase C): {used/N/A}
  • Error tasks (Phase C): [scope]

Documentation:
  • Pages discovered: {count}
  • Source: MCP / fallback URL
  • Last updated: [timestamp]

MIGRATION_PROGRESS.md created and ready.

User approval: Pending "start" command to proceed to Phase A.

Next: Wait for orchestrator to present plan to user and get approval.
```

---

**References**:
- Rules: `.github/rules/00-core-constraints.md`, `.github/rules/01-documentation-discovery-rules.md`
- Config: `.github/migration-config.json`
- Output: `MIGRATION_PROGRESS.md` (workspace root)
