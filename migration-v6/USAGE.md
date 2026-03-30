# Migration-V6 Usage Guide

**Quick reference for running migrations with minimal interaction.**

---

## ⚠️ CRITICAL: Single Source of Truth

**MIGRATION_PROGRESS.md IS THE ONLY STATE SOURCE**

Each agent invocation:
1. ✅ Agents READ `MIGRATION_PROGRESS.md` FIRST (before any action)
2. ✅ Agents VERIFY current state (phase, completed tasks, pending tasks)
3. ✅ Agents ACT based only on file state (not memory, not assumptions)
4. ✅ Agents UPDATE file IMMEDIATELY after completing work
5. ✅ File reflects ground truth (don't trust agent memory)

**If you see inconsistency between agent output and MIGRATION_PROGRESS.md**: 
→ **Trust the file**, don't trust the agent's memory

---

## 5-Minute Start

### 1. Create Feature Branch

```bash
git checkout -b feature/angular-19-upgrade
```

### 2. Start Phase 1 (Planning)

In VS Code Copilot Chat:

```
@migration-orchestrator-v6 Start Phase 1
Description: Migrate OneCX app from Angular 18 to Angular 19
```

**What happens**:
- Agent audits npm dependencies ✓
- Reads all migration docs (visits EVERY link)
- Creates MIGRATION_PROGRESS.md
- Shows task list
- Stops (waits for you)

**Time**: 5-10 minutes for first run

### 3. Review Generated Plan

Open: `MIGRATION_PROGRESS.md`

Check:
- [ ] All tasks visible
- [ ] No "[TBD]" fields  
- [ ] Source pages listed for each task
- [ ] ALL tasks marked [ ] not started (NOT [x])
- [ ] File format: 3 markers only ([ ][x][-])

**This file is your source of truth going forward.** Bookmark it.

If unclear: Ask agent to clarify, verify agent re-read file for context

### 4. Execute Phase A (Loop)

```
@migration-orchestrator-v6 Continue execution
```

**What happens per invocation (agents ALWAYS READ FILE FIRST)**:
1. Agent reads `MIGRATION_PROGRESS.md` (verify state)
2. Agent finds first [ ] uncompleted task
3. Agent executes that task EXACTLY
4. Agent validates by **inspection** (not npm build):
   - Grep: Old imports removed? New imports added?
   - Template: Old components replaced? New components added?
   - Config: Changes applied correctly? No duplicates?
   - Compare to working examples in workspace
5. Agent updates `MIGRATION_PROGRESS.md` WITH FULL EVIDENCE
6. Agent stops

**Why not npm build in Phase A?**: Project won't compile until ALL tasks complete. Use inspection validation instead.

**Between invocations**: Always check `MIGRATION_PROGRESS.md` to verify agent processed correctly.

**Repeat** until Phase A complete (usually 5-10 tasks)

### 5. Phase B (Handover)

Agent prepares:
- What was done ✓
- What you must do (core upgrade)
- Commit message ready

**You do**:
1. Run `npm run build` (NOW it should pass)
2. Run `npm run test` (verify green)
3. Upgrade Angular core (official tools)
4. Run `npm run test` (verify still green)

**Tell agent**:
```
All tests green, proceed to Phase C
```

### 6. Phase C (Post-Migration)

```
@migration-orchestrator-v6 Continue execution
```

Agent:
- Cleans up Angular 18-specific rules
- Handles PrimeNG v19 migration
- Installs required PrimeNG modules (CheckboxModule, ButtonModule, MessageModule)
- Final validation (`npm run build`, `npm run lint`, `npm run test` must all pass)
- Coverage report

**Done only when build, lint, and tests are all green.**

---

## ⚠️ Phase Gates & Approval Boundaries

**Three critical phase transition gates** (learn them):

### Gate 1: Feature Branch (Phase 1 Start)

**Automatic check**: When you invoke Phase 1, agent verifies you're on a feature branch.

```
❌ Agent STOPS if: Current branch is main, master, or develop
✅ Agent CONTINUES if: On any feature branch
```

**What you should do**:
```bash
git checkout -b feature/angular-19-upgrade  # Before Phase 1
```

**Why**: Protects main branch from incomplete changes. Every developer gets their own branch.

---

### Gate 2: Core Upgrade Approval (Phase B Gate - EXPLICIT APPROVAL REQUIRED)

**This is the hard stop.** Agent will NOT perform the core Angular upgrade without explicit user approval.

**Before Phase B**, agent prepares:
- Summary of all Phase A changes (what was modified)
- Working tree status (git diff summary)
- Validation checklist (what passed, what failed)
- Upgrade cheat-sheet (what core upgrade command to run)

**Then agent asks**:
```
Ready to approve core Angular upgrade?
All Phase A tasks completed. Requirements:

✓ Phase A complete (all templates/imports/configs updated)
✓ npm run build passes (after Phase A only)
✓ npm run test passes (green)

Awaiting your approval to upgrade @angular/core and related packages.

Shall I proceed?
```

**Your decision points**:
```
YOU SAY                          WHAT HAPPENS
─────────────────────────────────────────────────────
"Yes, approve upgrade"          →  Agent runs npm upgrade, core upgrade
"No, wait"                       →  Agent pauses, stays ready for approval
"Help me debug this first"       →  Agent stops, you fix locally, then re-ask
"Skip this, something's wrong"   →  Agent marks Phase B not applicable, jumps to C
```

**CRITICAL**: Agent does NOT perform upgrade automatically
- Approval ≠ Execution by you (you don't run the command)
- Approval = Permission (agent will run the command for you)
- You're signing off on the current state being ready

**Why**: Gives you final go/no-go. Prevents agent from upgrading while you're debugging.

---

### Gate 3: Post-Upgrade Resume (Phase C Gate)

**After core upgrade completes**, agent verifies:
- Build still passes (npm run build)
- Tests still pass (npm run test)
- No new errors introduced

**Then agent asks**:
```
Core upgrade complete.
Build: ✓ passing | Tests: ✓ passing

Ready to proceed to Phase C cleanup?
```

**Your options**:
```
YOU SAY                        WHAT HAPPENS  
──────────────────────────────────────────────────────
"Yes, continue"                →  Agent executes Phase C cleanup
"Wait, I need to investigate"  →  Agent pauses, awaits your signal
"Rollback"                     →  Agent suggests git reset-hard to last good commit
```

**Why**: Phase C removes old Angular 18 rules and deprecated code. Don't do this until core upgrade is stable.

---

## Phase Transition Checkpoint Template

**Use this before crossing any gate:**

```bash
# Gate 1 (Phase 1 → Phase A)
git branch  # Show current branch ✓

# Gate 2 (Phase A → Phase B) - APPROVAL GATE
git diff --stat  # Show changed files
npm run build    # Verify passes
npm run lint     # Verify 0 errors
npm run test     # Verify passes

# Gate 3 (Phase B → Phase C)  
npm run build    # Verify still passes
npm run test     # Verify still passes (coverage vs baseline)
```

**Never cross a gate if** any checkpoint fails. Ask agent for help before approving.

---

## Phase Transition Safety

If you're uncertain before a gate:
1. Don't approve yet
2. Ask agent: "Let me investigate first"
3. Agent pauses (doesn't proceed)
4. You run commands locally, check status
5. Ask agent to show checkpoint summary again
6. Then approve or ask for modification

**The gates exist to prevent**: Halfway completions, broken builds, silent failures.

---

## ⚠️ Important Constraints

### Prohibited Component Replacements

**NEVER replace these components** (no replacement exists):
- `<ocx-portal-viewport>`: Keep as-is
- `<ocx-shell>`: Keep as-is

Agent will check BEFORE attempting replacement. If agent tries anyway, it's broken.

### Phase A Validation

Phase A uses **inspection validation only**, NO `npm build`:
- ✅ Grep for imports (show removed/added)  
- ✅ Check templates (show old→new components)
- ✅ Verify config changes (show before/after)
- ✅ Compare to working examples (show reference)
- ❌ Do NOT run npm build (project won't compile yet)

Build validation happens in **Phase B** (manual validation).

### PrimeNG Migration

**Also migrate according to**: https://primeng.org/migration/v19

Key changes:
- `InputTextareaModule` → `TextareaModule`
- Add `CheckboxModule`, `ButtonModule`, `MessageModule` to shared module exports
- `p-checkbox [label]` → separate `<label>` element
- Check guide for other module name changes

---

## Skip Tasks (Save Credits/Time)

### Example

You have 12 pre-migration tasks. You know tasks 1-3 don't apply.

```
@migration-orchestrator-v6 Skip~3
```

**What happens**:
1. Marks tasks 1, 2, 3 as `[-] not applicable`
2. Records: "Skipped by developer decision"
3. Jumps to task 4 (ready to execute)
4. Updates MIGRATION_PROGRESS.md

### When to Use Skip

- ✅ You know a task doesn't apply to your repo
- ✅ You already completed it manually
- ✅ Prerequisite dependency hasn't been met yet
- ✅ You need to save credits on obvious steps

### When NOT to Use Skip

- ❌ "I think this might not apply" (check first)
- ❌ "Sounds complex, skip it" (ask for permission instead)
- ❌ You haven't read the link yet OX (click link, read it, then decide)

---

## Commands (Quick Reference)

| Command              | What It Does                                        |
| -------------------- | --------------------------------------------------- |
| `Start Phase 1`      | Begin initialization and planning                   |
| `Continue execution` | Run next uncompleted task                           |
| `Skip~3`             | Mark next 3 tasks as not applicable, jump to task 4 |
| `Validate`           | Re-run validation on latest task                    |
| `Status`             | Show current phase and progress                     |
| `Help`               | Show command menu                                   |
| `Rollback`           | Reset to last commit (git reset --hard)             |

---

## Example Workflow

```
You: "@orchestrator Start Phase 1"
Agent: [Creates plan with 15 tasks, shows list]

You: "Continue execution"
Agent: [Executes task 1, validates, updates file]

You: "Continue execution"
Agent: [Executes task 2, validates, updates file]

You: "Skip~2"
Agent: [Marks tasks 3-4 not applicable, ready for task 5]

You: "Continue execution"
Agent: [Executes task 5, validates, updates file]

... repeat until Phase A done ~

Agent: "Phase A complete. Show handover?"
You: "Yes"
Agent: [Prepares Phase B handover]

You: [Performs core Angular upgrade]
You: "All tests green, proceed to Phase C"

Agent: [Executes Phase C, records deferred errors task-by-task if needed]
Agent: [Runs final post-migration build/lint/test validation]
Agent: "Migration complete. Status: successful"   # only if all validations pass
# If any validation still fails, agent keeps status blocked and does NOT mark complete
```

---
**Open `MIGRATION_PROGRESS.md` between EVERY agent invocation to verify**:
- Current phase is correct
- Task markers are accurate ([ ][x][-])
- Which tasks are done, which are pending
- Build/lint/test results captured
- Coverage changes recorded
- Source pages match what agent said it visited

**Important**: If file shows different state than agent claims → trust the file, not agent memory
- Which are pending
- Build/lint/test results
- Coverage baseline vs final

---MUST capture last 20 lines in `MIGRATION_PROGRESS.md`. Check:
1. See error in MIGRATION_PROGRESS.md (agent should have recorded it)
2. Verify task is marked [ ] (not started) if failed
3. Run `npm run build` locally to debug
4. Ask agent: "Help debug build error" (agent will re-read file, should have context)

**Verify**: After asking for help, check MIGRATION_PROGRESS.md was updated

### Test Failed or Pending

Similar to build:
1. Error MUST be in MIGRATION_PROGRESS.md
2. Verify task is [ ] (not started) so agent will retry
3. Review error output, check latest file changes
4. Ask agent for help
5. Verify file updated before next command

### MIGRATION_PROGRESS.md Disappeared

```bash
git status
git log --oneline | head -5
```

If file accidentally deleted:
```bash
git checkout MIGRATION_PROGRESS.md
```

If file corrupted: 
```bash
git reset --hard <last-good-commit>
@orchestrator Status  # Agent will read and report
```

### Need to Redo a Task

Task must still be [ ] not started (agent skips [x] tasks):

```
@orchestrator Continue execution  # Agent reads file, finds [ ] task
```

Agent picks it again and retries.

**Verify** MIGRATION_PROGRESS.md shows task was [ ] before agent started

### Agent Says "Task Already Done" but File Shows [ ]

→ **Trust the file**. Agent lost context.

```
@orchestrator Status
```

Agent will re-read file and correct itself.

### Need to Reset Everything

```bash
git reset --hard <Phase-1-commit>
rm MIGRATION_PROGRESS.md

@orchestrator Status
```

If file doesn't exist, agent will prompt to start Phase 1 again
```bash
git reset --hard <Phase-1-commit>
rm MIGRATION_PROGRESS.md
```

Then start Phase 1 again.

---

## Offline / No MCP Server

If OneCX MCP server unavailable:

Agent automatically uses fallback URLs:
- https://onecx.github.io/docs/documentation/current/.../
- https://primeng.org/migration/v19
- https://nx.dev/docs/...

Migration continues with public docs.

---

## Team Usage

**One person per repo. One branch per person.**

```
developer-1: feature/angular-19-a
developer-2: feature/angular-19-b

Each runs migration on their own branch
Then merge to main (same PR, different repos)
```

---

## Budget / Credits

**Typical migration costs**:

| Phase     | Tasks   | Time        | Credits  |
| --------- | ------- | ----------- | -------- |
| Phase 1   | 1       | 5-10 min    | medium   |
| Phase A   | 8-12    | 30-60 min   | high     |
| Phase B   | 1       | 10-30 min   | low      |
| Phase C   | 3-5     | 15-30 min   | medium   |
| **Total** | **~20** | **1-2 hrs** | **high** |

**Tips to save credits**:
- Use `skip~N` for obvious non-applicable tasks
- Run locally to debug first, then ask agent
- Batch similar tasks (agent can handle 2-3 per invocation)

---

## Support

**Issue**: Not sure if task applies  
**Action**: Read the linked page first. Then ask agent.

**Issue**: Agent is giving wrong suggestion  
**Action**: Say "No, let me explain..." and provide context

**Issue**: Migration got stuck  
**Action**: Check MIGRATION_PROGRESS.md. Find last completed task. Ask agent to look at error output.

---

**That's it. Simple. Fast. Go migrate.**

Next: [READ THE AGENTS](./agents/) to understand how they work (optional but helpful)
