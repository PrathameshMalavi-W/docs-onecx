# Phase B: Core Angular Upgrade Decision & Ownership Rules

## Phase B Workflow (MANDATORY)

### 1. Fetch OneCX Upgrade Documentation (BEFORE asking developer)
- **Use**: MCP server with query "Angular {version} upgrade core migration" (where version = target 19/20/21)
- **Fallback**: https://onecx.github.io/docs/documentation/current/onecx-portal-ui-libs/migrations/angular-{version}/index.html
- **Read**: Entire upgrade guide, including:
  - Whether project uses Nx or standalone Angular
  - Core upgrade task list
  - Links to detailed task pages
  - Version requirements
  - Known gotchas and compatibility notes

### 2. Create Cheat Sheet from Documentation
Document must contain:
- **Command sequence**: Exact commands to run in order
- **Flags and options**: All required flags for each command
- **Version requirements**: Specific versions needed (Angular, TypeScript, etc.)
- **Compatibility matrix**: Which packages work with which Angular versions
- **Known gotchas**: Version-specific issues from documentation
- **Rollback instructions**: How to revert if needed
- **Estimated duration**: Time each step typically takes

### 3. Developer Confirmation (YES/NO Decision)
**Ask developer**: "Ready for core Angular upgrade? (Default: Yes)"
- **If NO**:
  - Provide cheat sheet to developer
  - Explain what will be automated in core upgrade
  - Wait for developer to confirm readiness in next session
  - Update MIGRATION_PROGRESS.md: "Core upgrade deferred - awaiting developer confirmation"
  
- **If YES (or default)**:
  - Proceed to ownership decision
  - Update MIGRATION_PROGRESS.md: "Developer confirmed: YES, ready for core upgrade"

### 4. Ownership Decision (MANDATORY before execution)
**Two options**:

**Option A: Assistant Executes Core Upgrade**
- Uses documented commands and procedures
- Executes core upgrade within this session
- Captures all outputs and changes
- Records evidence in MIGRATION_PROGRESS.md

**Option B: Developer Executes Core Upgrade Manually**
- Assistant provides detailed cheat sheet with exact steps
- Generates step-by-step checklist
- Halts and waits for developer completion confirmation
- Records developer's completion in MIGRATION_PROGRESS.md

**Default ownership**: If developer says YES without specifying owner → **Assistant executes**

**Record in MIGRATION_PROGRESS.md**:
- "Ownership: Assistant / Developer"
- "Rationale: [why this choice]"
- "Timestamp: [decision time]"

## Phase B Execution (if Developer Said YES)

### Pre-execution Checklist
- [ ] All Phase A changes are committed
- [ ] Working directory is clean (git status shows no uncommitted changes)
- [ ] Target Angular version confirmed: [19/20/21]
- [ ] Ownership explicitly documented: Assistant / Developer

### If Assistant Executes

1. **Mandatory Commit First**:
   - Ensure all pre-migration changes committed
   - Commit message: `"Pre-migration: prepare for Angular {version} upgrade"`
   - Verify: `git status` shows clean working directory

2. **Execute Core Upgrade Commands**:
   - Follow documented procedures from OneCX upgrade guide
   - Record each command output
   - Record files changed during core upgrade
   - Timestamp each step in MIGRATION_PROGRESS.md

3. **Capture Evidence**:
   - Full command outputs
   - git diff output for file changes
   - package.json changes (before/after)
   - package-lock.json updates

4. **Create Milestone Commit**:
   - After core upgrade commands complete
   - Commit message: `"Core: upgrade Angular to {version}"`
   - Record commit hash in MIGRATION_PROGRESS.md

5. **Initial Validation** (may fail, that's ok):
   - Run: npm run build
   - Run: npm run lint
   - Run: npm run test
   - Record results (pass or fail details)
   - Update MIGRATION_PROGRESS.md with initial validation state

6. **Transition to Phase C**:
   - Record: "Phase B core upgrade complete, ready for Phase C post-migration"
   - Proceed to Phase C immediately for error resolution

### If Developer Executes Manually

1. **Generate Detailed Handover Package**:
   - Step-by-step checklist with exact commands
   - Expected outputs for each step
   - Troubleshooting guide for common issues
   - Rollback instructions if needed
   - Save as: `CORE_UPGRADE_HANDOVER.md` in project root

2. **Provide Cheat Sheet to Developer**:
   - Share the handover package
   - Explain each section
   - Ask developer to confirm understanding
   - Update MIGRATION_PROGRESS.md: "Core upgrade ownership: Developer - awaiting execution"

3. **Halt and Wait**:
   - Wait for developer to complete core upgrade
   - Wait for developer to confirm: "Core upgrade complete, ready for post-migration"
   - Record developer's confirmation timestamp in MIGRATION_PROGRESS.md

4. **Verification When Developer Confirms**:
   - Ask developer to provide output of final npm run build/lint/test
   - Record in MIGRATION_PROGRESS.md under "Developer-provided completion evidence"
   - Proceed to Phase C

## Phase B Completion Output

**For Assistant-executed core upgrade**:
- ✓ Core upgrade executed with full command outputs
- ✓ Files changed documented
- ✓ Milestone commit created ("Core: upgrade Angular to {version}")
- ✓ Initial validation results recorded (may have failures - that's Phase C's job)
- ✓ Ownership: Assistant
- Ready to proceed to Phase C

**For Developer-executed core upgrade**:
- ✓ Handover package (CORE_UPGRADE_HANDOVER.md) delivered
- ✓ Developer provided execution confirmation
- ✓ Developer-provided validation results recorded
- ✓ Ownership: Developer
- Ready to proceed to Phase C

## Recording in MIGRATION_PROGRESS.md

**Phase B - Core Angular Upgrade section**:
```
- Ownership decision: Assistant / Developer
- Rationale for ownership: [why this choice]
- Core upgrade status: Complete / Deferred
- If complete:
  - Commands executed: [list]
  - Files changed: [list with line ranges]
  - Commit hash: [core upgrade commit]
  - Initial build/lint/test result: [pass/fail with output]
- If deferred:
  - Handover package: CORE_UPGRADE_HANDOVER.md
  - Developer completion status: Pending
```

## Version-Specific Considerations

### Angular 19 Upgrade
- Check for standalone API changes
- Review RxJS operator changes
- Check template syntax changes
- Verify module federation compatibility (if used)

### Angular 20 Upgrade
- [Review Angular 20 specific changes from documentation]

### Angular 21 Upgrade
- [Review Angular 21 specific changes from documentation]

**Always source these from documentation, never assume**.
