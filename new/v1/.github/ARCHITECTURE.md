# Angular Migration Architecture - Complete Setup

## Configuration & Setup

**Before starting**: Edit `.github/migration-config.json` with your project details:
- Target Angular version (19, 20, or 21)
- Project name
- Repository path
- Git branch

## Directory Structure

```
.github/
├── migration-config.json              ← User configuration (fill in once)
├── QUICK_START.md                     ← 5-minute setup guide
├── MIGRATION_RULES.md                 ← Consolidated rules overview
├── rules/                             ← Detailed rule files
│   ├── 00-core-constraints.md        ← Absolute non-negotiable rules
│   ├── 01-documentation-discovery-rules.md  ← Discovery & rediscovery rules
│   ├── 02-phase-a-pre-migration-rules.md    ← Phase A task execution rules
│   ├── 03-phase-b-core-upgrade-rules.md     ← Phase B decision & ownership rules
│   └── 04-phase-c-post-migration-rules.md   ← Phase C stabilization rules
├── agents/                            ← Phase-specific agents
│   ├── orchestrator.agent.md          ← Main coordinator (delegates phases)
│   ├── phase-1-initializer.agent.md   ← Phase 1: initialization & planning
│   ├── phase-a-pre-migration.agent.md ← Phase A: pre-migration execution
│   ├── phase-b-core-upgrade.agent.md  ← Phase B: core upgrade decision/ownership
│   └── phase-c-post-migration.agent.md← Phase C: post-migration & finalization
└── templates/                         ← Reusable templates
    ├── MIGRATION_PROGRESS.template.md ← Master knowledge base template
    ├── tasks.json                     ← VS Code tasks template
    └── USER_CUSTOM_RULES.template.md  ← Custom rules override template

[After Phase 1]
└── MIGRATION_PROGRESS.md              ← Created by Phase 1, updated continuously
```

## Quick Start

### 1. Configuration
```bash
# Edit this file with your project details
.github/migration-config.json
```

### 2. Optional Setup
```bash
# If VS Code tasks missing, copy template
cp .github/templates/tasks.json .vscode/tasks.json

# If you have custom rules, create from template
cp .github/templates/USER_CUSTOM_RULES.template.md USER_CUSTOM_RULES.md
```

### 3. Start Migration
In VS Code chat:
```
@agents migration-orchestrator
```

Then type: `start`

## Multi-Agent Architecture

All phases are **delegated** to specialized agents:

1. **Orchestrator** (main coordinator)
   - Loads config and rules
   - Delegates phases to specialized agents
   - Handles user commands

2. **Phase 1: Initializer**
   - Branch protection check
   - npm baseline capture
   - Complete documentation discovery (recursive, all pages, H1/H2 hierarchy)
   - Dependency analysis (@onecx, PrimeNG, Nx)
   - Creates MIGRATION_PROGRESS.md template with full structure

3. **Phase A: Pre-migration**
   - Executes OneCX pre-migration tasks
   - Rediscovers documentation at each step
   - Strict validation: Build → Lint → Test after each task
   - Halts after each task for user confirmation

4. **Phase B: Core Upgrade**
   - Fetches OneCX upgrade documentation
   - Asks developer: YES/NO decision
   - Decides ownership: Assistant executes OR Developer executes
   - If Assistant: Runs core upgrade commands, creates commit
   - If Developer: Provides handover package, waits for confirmation

5. **Phase C: Post-migration**
   - Captures and fixes all build/lint/test errors
   - Updates Copilot-instructions.md
   - Upgrades @onecx packages (per documentation)
   - Migrates PrimeNG v17→v19 (if used)
   - Migrates Nx (if used)
   - Final validation: all three PASS

## Rules & Constraints

**All rules defined in `.github/rules/`**:

### Core Constraints (00)
- Halt after each step
- Build → Lint → Test order (strict, never changes)
- MIGRATION_PROGRESS.md as single source of truth
- Never skip steps for complexity
- Applicability: read full content, not just title

### Documentation Discovery (01)
- Recursive expansion of all pages
- H1 = grouping context, H2 = independent tasks
- Rediscover documentation at START of each step
- Build complete documentation map in Phase 1

### Phase A Rules (02)
- Pre-migration = OneCX-specific only (NOT core upgrade)
- Build/Lint/Test after every change
- Validation must all PASS before next task
- Only upgrade @onecx packages mentioned in docs

### Phase B Rules (03)
- Decision point: Ask developer YES/NO
- Ownership: Assistant (default) or Developer
- If Assistant: Execute core upgrade + create commit
- If Developer: Provide handover package, wait for confirmation

### Phase C Rules (04)
- Fix ALL errors (don't skip difficulty)
- Update @onecx packages, PrimeNG, Nx (per docs)
- PrimeNG v17→v18→v19 (both guides, v19 priority)
- Nx optional (only if package.json has "@nx/")
- Final validation: build + lint + test all PASS

## Knowledge Base

**MIGRATION_PROGRESS.md** (single source of truth):
- Created by Phase 1 with complete template
- Updated continuously (not at end)
- Contains: config, rules, docs, baseline, dependencies, tasks, errors, decisions
- Survives across chat sessions (read before each step)

## Commands During Execution

- `next` or `continue` (default) → Proceed to next step
- `SKIP~N` → Skip next N tasks
- `review` → Show progress from MIGRATION_PROGRESS.md
- `retry` → Retry last command
- `questions` → Ask for clarification

**Phase B specific**:
- `yes` or `continue` (default) → Assistant executes core upgrade
- `manual` → Developer executes manually
- `no` → Defer core upgrade

## Success Criteria

✅ All phases delegated (not single-agent)  
✅ All rules followed (build/lint/test order, halts, etc.)  
✅ MIGRATION_PROGRESS.md is complete knowledge base  
✅ Pre-migration: build → lint → test PASS  
✅ Core upgrade executed or handed over  
✅ Post-migration: all errors fixed, PrimeNG/Nx migrated  
✅ Final: build → lint → test PASS  
✅ Ready for deployment  

## Session Resumption

If interrupted:
1. On resume, orchestrator reads MIGRATION_PROGRESS.md
2. Checks "Current Session Context" for last completed step
3. Resumes from first incomplete step (does NOT skip)
4. Updates MIGRATION_PROGRESS.md as work continues

## Deployment

When migration complete:
- All commits created (Phase A, B, C)
- MIGRATION_PROGRESS.md has final summary
- Code coverage compared
- Build/Lint/Test all PASS
- ✓ Ready for deployment

---

## Next Steps

1. Edit: `.github/migration-config.json`
2. Type: `@agents migration-orchestrator`
3. Follow prompts
4. Review: `MIGRATION_PROGRESS.md` at each checkpoint

---

**Created**: 2024-01-15  
**For**: Angular 19, 20, 21 migrations with OneCX  
**Architecture**: Multi-Agent Delegation
