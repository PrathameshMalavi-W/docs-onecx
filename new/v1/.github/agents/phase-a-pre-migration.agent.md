---
name: phase-a-pre-migration
description: >
  Execute Phase A: Pre-migration tasks. For each task: rediscover documentation,
  determine applicability, plan, execute, validate (build/lint/test), checkpoint.
  HALT after each task. All tasks tracked in MIGRATION_PROGRESS.md.
applyTo:
  - .md
codeBlockLanguage: markdown
---

# Phase A: Pre-migration Agent

**Responsibility**: Execute OneCX pre-migration tasks one by one with halts  
**Input**: MIGRATION_PROGRESS.md (from Phase 1)  
**Output**: All Phase A tasks [x] completed or [-] not applicable, MIGRATION_PROGRESS.md updated  
**Validation**: Build → Lint → Test (STRICT order) after each task  
**Rules to follow**: 00-core-constraints.md, 01-documentation-discovery-rules.md, 02-phase-a-pre-migration-rules.md

---

## PHASE A EXECUTION LOOP

**For each [ ] task in MIGRATION_PROGRESS.md (Phase A section)**:

### Step 1: REDISCOVER Documentation

- [ ] Read rule: .github/rules/01-documentation-discovery-rules.md ("Rediscovery Requirement" section)
- [ ] For this specific task:
  - Use MCP server query: "{task name} documentation"
  - Fallback: URL recorded in MIGRATION_PROGRESS.md for this task's source page
  - Read: COMPLETE section/page (not just title)
  - Extract: Actual keywords and content
  - Record timestamp: [fetched at HH:MM:SS]

### Step 2: Determine APPLICABILITY

- [ ] Based on FULL content read (not title):
  - Search repository for evidence using actual keywords from documentation
  - Record exact grep/find commands used
  - Record: What was found or not found
  
- [ ] Decision:
  - If evidence found AND applicable → Continue to Step 3 (PLAN)
  - If no evidence or explicitly not applicable → Mark [-] not applicable with reason
  - Update MIGRATION_PROGRESS.md: "Applicability determination: [YES/NO] - [evidence]"

### Step 3: PLAN Execution

- [ ] Before executing, document the plan:
  - Exact changes to make
  - File paths and line numbers
  - Expected outcomes
  - Build/lint/test expected results
- [ ] Record in MIGRATION_PROGRESS.md: "Planned action: [detailed steps]"

### Step 4: EXECUTE

- [ ] Execute planned actions exactly:
  - Make code changes (exact paths and line ranges)
  - Run commands (capture outputs)
  - Record timestamps
- [ ] Update MIGRATION_PROGRESS.md "Execution steps": [timestamped actual steps]

### Step 5: VALIDATE (Build → Lint → Test)

**STRICT ORDER - Never varies:**

**Build**:
- [ ] Run: `npm run build`
- [ ] Record: PASS or FAIL
- [ ] If FAIL:
  - Capture last 20+ lines of error
  - Record in MIGRATION_PROGRESS.md Error Log
  - Troubleshoot (search docs, fix)
  - Re-run: `npm run build`
  - Continue until PASS

**Lint** (only after Build PASS):
- [ ] Run: `npm run lint`
- [ ] Record: 0 warnings? 0 errors? (or accepted exceptions)
- [ ] If FAIL:
  - Capture full lint output
  - Record in Error Log
  - Fix (minimal fixes only, per rules)
  - Re-run until 0 warnings, 0 errors

**Test** (only after Build AND Lint PASS):
- [ ] Run: `npm run test`
- [ ] Record: All tests pass? Any failures?
- [ ] If FAIL:
  - Capture failure output (20+ lines)
  - Record in Error Log
  - Troubleshoot
  - Re-run until PASS

**Only when ALL THREE = PASS → Continue to Checkpoint**

### Step 6: UPDATE MIGRATION_PROGRESS.md

- [ ] Task record update:
  - Documentation source: [URL/MCP]
  - Applicability: [YES/NO with evidence]
  - Repository evidence: [search results, file locations]
  - Planned action: [steps documented before execution]
  - Execution steps: [actual timestamped steps taken]
  - Files changed: [exact paths and line ranges modified]
  - Build/Lint/Test result: [PASS/PASS/PASS or failures with details]
  - Edge cases or issues: [any blockers encountered]

- [ ] Current Session Context:
  - Last executed step: [this task name and outcome PASS]
  - Next planned step: [next task name or Phase A complete]
  - Open issues/blockers: [clear or note any]

### Step 7: CHECKPOINT - HALT & WAIT

- [ ] Print status:
  ```
  ✓ Task: [task name]
    - Source: [documentation page/section]
    - Files changed: [list]
    - Build: PASS ✓
    - Lint: PASS ✓
    - Test: PASS ✓
  
  Ready for next task? Type 'next' or 'continue' (default).
  Other commands: 'SKIP~N', 'review', 'retry'
  ```

- [ ] Wait for user input:
  - `"next"` or `"continue"` or empty → Process next task
  - `"SKIP~N"` → Skip next N tasks (mark as [-] "Skipped by user")
  - `"review"` → Show progress so far from MIGRATION_PROGRESS.md
  - `"retry"` → Retry last task (if developer fixed something locally)

---

## PHASE A COMPLETION

- [ ] All [ ] tasks processed:
  - Marked [x] completed with full execution details, OR
  - Marked [-] not applicable with specific evidence

- [ ] All validations PASS:
  - npm build ✓
  - npm lint ✓ (0 warnings, 0 errors)
  - npm test ✓ (all tests passing)

- [ ] Final commit:
  - `git commit -m "Phase A: pre-migration tasks"`
  - Verify commit created

- [ ] MIGRATION_PROGRESS.md Final Update:
  - Phase Completion Checklist: Phase A section marked COMPLETE
  - Current Session Context: "Phase A complete, ready for Phase B"

---

## REPORT BACK TO ORCHESTRATOR

```
Phase A Status: COMPLETE ✓

Tasks Summary:
  • Total tasks: {count}
  • Completed: {count}
  • Not applicable: {count}
  • Blocked: {count}

Validation:
  ✓ npm build: PASS
  ✓ npm lint: PASS (0 warnings, 0 errors)
  ✓ npm test: PASS

Commit: "Phase A: pre-migration tasks" [{hash}]

MIGRATION_PROGRESS.md updated with all execution details.

Next: Ready for Phase B (core Angular upgrade decision and ownership).
```

---

**References**:
- Rules: `.github/rules/` (00, 01, 02)
- Knowledge base: `MIGRATION_PROGRESS.md`
- Config: `.github/migration-config.json`
