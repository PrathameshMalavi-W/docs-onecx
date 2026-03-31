---
name: phase-b-core-upgrade
description: >
  Execute Phase B: Core Angular upgrade decision and ownership. Fetch documentation,
  ask developer YES/NO, decide ownership (Assistant/Developer), execute or handover.
applyTo:
  - .md
codeBlockLanguage: markdown
---

# Phase B: Core Upgrade Agent

**Responsibility**: Core upgrade decision (YES/NO), ownership (Assistant/Developer), execution OR handover  
**Input**: MIGRATION_PROGRESS.md (from Phase A)  
**Output**: Core upgrade executed (with evidence) OR handover package (waiting for developer)  
**Rules to follow**: 00-core-constraints.md, 03-phase-b-core-upgrade-rules.md

---

## PHASE B WORKFLOW

### Step 1: Fetch OneCX Upgrade Documentation

- [ ] Query MCP: `mcp_onecx-docs-mc_about_onecx` with query "Angular {version} upgrade core migration"
  - Replace {version} with target version (19/20/21) from config
  
- [ ] Fallback URL: https://onecx.github.io/docs/documentation/current/onecx-portal-ui-libs/migrations/angular-{version}/

- [ ] Read COMPLETE upgrade documentation:
  - Core upgrade procedures
  - Version requirements
  - Whether Nx or standalone Angular
  - Links to detailed steps
  - Known gotchas
  - Command sequence

- [ ] Document in temporary notes:
  - Core upgrade procedures found
  - Command sequence
  - Version requirements
  - Key gotchas

### Step 2: Create Cheat Sheet

- [ ] From documentation, extract and document:
  - **Exact command sequence**: Step-by-step commands from docs
  - **Flags and options**: All required flags for each command
  - **Version requirements**: Specific Angular, TypeScript, other versions needed
  - **Compatibility matrix**: Which packages work with which versions
  - **Known gotchas**: Version-specific issues and solutions
  - **Rollback instructions**: How to revert if needed
  - **Estimated duration**: Time each step typically takes

- [ ] Save cheat sheet internally (use in Step 4 if Developer chooses manual)

### Step 3: Ask Developer - YES/NO Decision

**Print to user**:

```
==============================================================================
PHASE B: CORE ANGULAR {VERSION} UPGRADE
==============================================================================

OneCX upgrade documentation reviewed.

Are you ready for core Angular {version} upgrade?

Options:
  - 'yes' or 'continue' (default) → I execute core upgrade using documented procedures
  - 'manual' → I provide cheat sheet, you execute manually
  - 'no' / 'defer' → Defer upgrade, I'll provide cheat sheet for later

Response? (Default: yes, press Enter)
==============================================================================
```

- [ ] Wait for user response:
  - If `"yes"` or `"continue"` or empty → Go to Step 4a (Assistant Executes)
  - If `"manual"` → Go to Step 4b (Developer Executes)
  - If `"no"` → Go to Step 4c (Defer)

---

### Step 4a: If "yes" (Assistant Executes)

**Before Execution:**
- [ ] Verify all Phase A changes committed
  - Check: `git status` should show clean working directory
  - If not committed: Commit now: `git commit -m "Phase A: pre-migration tasks"`

**Execute Core Upgrade:**
- [ ] Run: Exact commands from documentation (in order)
  - Record: Each command, full output, timestamps
  - If error: Investigate, resolve, document attempt and result

- [ ] Record all outputs:
  - npm install output
  - ng update outputs (if used)
  - Any build artifacts generated
  - package.json changes (diff before/after)
  - package-lock.json changes

- [ ] **Create Milestone Commit**:
  - `git commit -m "Core: upgrade Angular to {version}"`
  - Verify commit created
  - Record commit hash

- [ ] Run Initial Validation (failures expected—Phase C fixes):
  - `npm run build` → Record result (may FAIL)
  - `npm run lint` → Record result (may FAIL)
  - `npm run test` → Record result (may FAIL)
  - Note: Failures here are EXPECTED - Phase C fixes them

**Update MIGRATION_PROGRESS.md**:
- Phase B Core Upgrade section:
  - Ownership: Assistant
  - Commands executed: [list with outputs]
  - Files changed in core upgrade: [list]
  - Commit created: [hash] "Core: upgrade Angular to {version}"
  - Initial validation: build [{result}], lint [{result}], test [{result}]
  - Status: COMPLETE

**Report back**: "Phase B complete - Core upgrade executed by Agent. Commit {hash}. Initial validations recorded (failures expected - Phase C will fix). Ready for Phase C."

---

### Step 4b: If "manual" (Developer Executes)

**Create Handover Package:**
- [ ] Prepare CORE_UPGRADE_HANDOVER.md in workspace root:
  - Exact command sequence (numbered list)
  - Expected output for each command
  - Troubleshooting guide
  - Rollback instructions
  - Contact info if stuck

**Template**:

```
# Core Angular {Version} Upgrade - Developer Handover

## Prerequisites
- [ ] All Phase A pre-migration tasks complete and committed
- [ ] Working directory clean (git status)
- [ ] Backup of current branch (optional but recommended)

## Step-by-Step Procedure

### Step 1: [Command from docs]
```
npm [exact command with flags]
```
Expected output: [what should appear]
If error: [troubleshooting]

### Step 2: [Next command]
...

## Validation
After all steps:
```
npm run build
npm run lint
npm run test
```

## If Something Goes Wrong
[Rollback instructions from docs]

## When Complete
Share: Last 20 lines of npm run build output
```

- [ ] Provide handover package to developer
- [ ] Ask developer to review and confirm understanding
- [ ] Wait for developer confirmation: "Core upgrade complete. Output: [...]"

**Update MIGRATION_PROGRESS.md**:
- Phase B Core Upgrade section:
  - Ownership: Developer
  - Handover package: CORE_UPGRADE_HANDOVER.md
  - Status: WAITING for developer completion
  - Date/time submitted: [timestamp]

**Report back**: "Phase B - Handover package created (CORE_UPGRADE_HANDOVER.md). Waiting for developer to execute core upgrade and provide completion evidence."

---

### Step 4c: If "no" (Defer)

**Update MIGRATION_PROGRESS.md**:
- Phase B Core Upgrade section:
  - Status: DEFERRED
  - Reason: Developer not ready (choose manual upgrade later)
  - Cheat sheet: Provided to developer below
  - Date deferred: [timestamp]

**Provide Cheat Sheet to Developer**:

Print cheat sheet (from Step 2):
- Command sequence
- Flags and options
- Version requirements
- Gotchas and solutions
- Rollback instructions

**Report back**: "Phase B deferred. Cheat sheet provided to developer. Core upgrade can be completed manually anytime. I'll await developer confirmation to proceed to Phase C."

---

## CHECKPOINTS

**After Step 4a (Assistant executed)**:
- ✓ Core upgrade executed with full evidence
- ✓ Commit created: "Core: upgrade Angular to {version}"
- ✓ Initial validation recorded (pass or fail expected)
- → Ready for Phase C immediately

**After Step 4b (Developer to execute)**:
- ✓ Handover package created (CORE_UPGRADE_HANDOVER.md)
- ✓ Developer has clear instructions
- → Wait for developer completion confirmation

**After Step 4c (Deferred)**:
- ✓ Cheat sheet provided
- → Can resume later when developer ready

---

## REPORT BACK TO ORCHESTRATOR

**If Assistant Executed**:
```
Phase B Status: COMPLETE ✓ (Assistant)

Core Upgrade Execution:
  • Commands: [list of what ran]
  • Commit: {hash} "Core: upgrade Angular to {version}"
  • Initial validation: build [{PASS/FAIL}], lint [{PASS/FAIL}], test [{PASS/FAIL}]
  
Note: Failures in initial validation are expected. Phase C will resolve.

Next: Ready for Phase C (error resolution, framework migrations, finalization).
```

**If Developer to Execute**:
```
Phase B Status: WAITING ✓ (Developer)

Handover Package: CORE_UPGRADE_HANDOVER.md created

Awaiting: Developer's core upgrade execution and completion confirmation.

When developer confirms "Core upgrade complete": Will proceed to Phase C.
```

**If Deferred**:
```
Phase B Status: DEFERRED ✓

Cheat sheet provided to developer.

Can resume core upgrade anytime developer is ready.

Awaiting: Developer's confirmation of readiness to proceed.
```

---

**References**:
- Rules: `.github/rules/` (00, 03)
- Knowledge base: `MIGRATION_PROGRESS.md`
- Config: `.github/migration-config.json`
