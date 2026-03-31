# MIGRATION RULES - Extracted from ai-prompt.md

## Critical Constraints (DO NOT VIOLATE)

### 1. Halt After Each Step
- After executing each step, halt and wait for developer to explicitly say:
  - "next" or "continue" (default: continue)
  - "SKIP~N" (skip next N steps)
  - "yes/no" (Phase B only)
- Do NOT proceed automatically

### 2. Build/Lint/Test Order (STRICT - NEVER DEVIATE)
1. npm run build → PASS required before proceeding
2. npm run lint → PASS required (0 warnings, 0 errors) before proceeding
3. npm run test → PASS required (all tests pass)

**Order is MANDATORY. Never skip any step. Never run out of order.**

### 3. Phase Completion Criteria (ENFORCE)

**Phase A Pre-migration can ONLY be [x] completed when:**
- npm run build: SUCCESS (no errors)
- npm run lint: SUCCESS (0 warnings/0 errors)  
- npm run test: SUCCESS (all tests pass)
- If ANY fails: Do NOT mark complete. Resolve errors first.

**Phase C Post-migration can ONLY be [x] completed when:**
- All errors documented with 50+ lines context
- All errors resolved (or documented as acceptable trade-offs)
- PrimeNG migration: [x] completed or [-] not applicable
- Nx migration: [x] completed or [-] not applicable
- npm run build: SUCCESS
- npm run lint: SUCCESS (0 warnings/0 errors)
- npm run test: SUCCESS (all tests pass)

### 4. NO TASK SKIPPING EXEMPTION
- NEVER suggest deferring complex tasks
- Complex tasks = Break down into sub-steps + Execute methodically
- Default behavior = Complete EVERY task if user approves
- Only mark [-] not applicable with file-based evidence

### 5. Documentation-Driven Execution
- Primary source: MCP servers (ALWAYS query first)
- Fallback: Documented fallback URLs
- Tertiary: node_modules CHANGELOG.md files
- NEVER guess. NEVER assume. Read FULL documentation.

### 6. Error Capture & Analysis
- Minimum 50+ lines of error context ALWAYS captured
- Map EACH error line to root cause
- Document: Timestamp, error output, suspected cause, resolution attempt, result
- Never skip error resolution

### 7. MIGRATION_PROGRESS.md as Single Source of Truth
- Update CONTINUOUSLY during work (not at end)
- Reference BEFORE each step to get current context
- Contains: All rules, knowledge, data, context, logs
- Use to maintain state across sessions

### 8. Applicability Determination (CRITICAL)
- NEVER decide applicability by title alone
- For every task/step: Read FULL section/page content
- Search repository using ACTUAL keywords from docs (not guesses)
- Only after reading complete content: Decide if [x] applicable or [-] not applicable
- Exception keywords must be found via search

### 9. Rediscovery at Each Step
- At START of each step execution: Fetch fresh documentation
- Do NOT rely on memory from earlier in conversation
- Query MCP or fallback URLs for that specific step
- Ensures you catch recent documentation updates

### 10. Commit Strategy
- After Phase 1 complete: Commit "Phase 1: discovery and planning"
- After Phase A complete: Commit "Phase A: pre-migration tasks"
- After Phase B complete: Commit "Phase B: core upgrade"
- After Phase C complete: Commit "Phase C: post-migration stabilization"
- Total: 4 strategic commits minimum

## Custom Rules Override

If USER_CUSTOM_RULES.md exists in workspace:
- Read it at session start
- Treat as overrides to DEFAULT rules
- Record in MIGRATION_PROGRESS.md: "Custom Rules & Constraints" section
- Follow custom rules strictly

## MCP Server Usage

Always start with:
```
1. mcp_onecx-docs-mc_about_onecx
2. mcp_primeng_* (if available)
3. Nx MCP (if available)
```

If MCP unavailable: Use fallback URLs
If fallback fails: Check node_modules CHANGELOG.md

## Documentation Expansion Rules

When fetching documentation:
1. Read MAIN index page completely
2. Identify ALL linked pages
3. For EACH linked page: Read completely
4. Extract: H1 (grouping context), H2 (independent tasks), H3 (implementation notes)
5. Recursively expand: Any links within those pages
6. Continue until no new pages found

## Task Decomposition

- H1 header = Page-level grouping (NOT a task)
- H2 header = Independent executable task (CREATE ONE TASK PER H2)
- H3 header = Implementation details under parent H2 (NOT separate tasks)
- Linked pages = Apply same H1/H2 decomposition rules recursively

## Package Version Rules

### @onecx Package Updates
- ONLY update if documentation explicitly specifies version
- Use documented version exactly
- If documentation does NOT mention package: SKIP (don't update)
- Record in MIGRATION_PROGRESS.md: "Updated: X" and "Skipped: Y (not in docs)"

### Version Format in package.json
- Keep caret notation (^) for module federation compatibility
- If docs say "^6": Find latest stable 6.x.y and use exact version
- Example: If docs say "^6" and latest is 6.5.2 → use "6.5.2" (exact)
- If version not available: SKIP (keep current, don't break build)

## PrimeNG Migration (Phase C)
- Breaking changes occur v17→v18 AND v18→v19
- DO NOT skip either transition
- Check node_modules/primeng/CHANGELOG.md for complete list
- ALWAYS use MCP or https://primeng.org/migration/v[VERSION] before changes
- Common issues:
  - Import paths may change
  - CSS class names may change
  - Template syntax changes
  - Theming/styling changes
  - Icons/iconography changes

## Nx Migration (Phase C - if applicable)
- ALWAYS check package.json for "@nx/" packages first
- If Nx NOT found: Mark [-] not applicable with evidence
- If Nx found:
  - Query Nx MCP or https://nx.dev/docs/technologies/angular/migrations
  - Check node_modules/nx/CHANGELOG.md
  - Update nx.json per documentation exactly (NO GUESSING)
  - Affects: plugin configs, build executors, dependency graph, lint rules

## Error Handling During Execution

### If Build/Lint/Test Fails
- Capture last 50 lines of error
- Map each error to root cause
- Document in error log BEFORE proceeding
- DO NOT skip to next phase
- Work through EVERY error until resolved

### If Framework Migration Error Occurs
- Check framework CHANGELOG.md (node_modules)
- Query MCP for known issues
- Search for exact error message in documentation
- Only then attempt fix

### Standalone Component Error
- If error: "Component is standalone, and cannot be declared in NgModule"
- Add: standalone: false where appropriate
- Document why in MIGRATION_PROGRESS.md

## Discovery Phase Process

1. START MCP servers
2. Query for Angular [VERSION] migration index
3. Read MAIN index page completely
4. Extract ALL linked pages (recursive)
5. For each page: Extract H1/H2/H3 structure
6. Build complete page map in MIGRATION_PROGRESS.md
7. Extract @onecx package versions (ALL mentioned)
8. Extract PrimeNG scope (if used)
9. Extract Nx scope (if used)
10. Create task list with H2-level granularity
11. Present to developer for review
12. WAIT for developer "start" confirmation

## Execution Phase Process

For each task:
1. **DISCOVERY**: Fetch fresh docs from MCP for THIS TASK
2. **PLAN**: Document exact action (files, line numbers, commands)
3. **EXECUTE**: Apply changes, record timestamps
4. **VALIDATE**: Run build → lint → test
5. **CHECKPOINT**: Halt and wait for developer confirmation

## Session Resumption

At start of every session:
1. Open MIGRATION_PROGRESS.md
2. Read "Current Session Context" section
3. Read "Open issues/blockers"
4. Identify last completed step
5. Resume from first [ ] not started task
6. Continue execution without re-running completed steps

## Success Criteria

Migration complete when:
- ✅ All Phase 1 planning approved by developer
- ✅ All Phase A tasks [x] completed
- ✅ build → lint → test ALL PASS after Phase A
- ✅ Core Angular upgrade [x] completed
- ✅ All Phase C tasks [x] completed
- ✅ build → lint → test ALL PASS after Phase C
- ✅ All errors resolved and documented
- ✅ MIGRATION_PROGRESS.md fully documented
- ✅ All 4 phases committed to git
- ✅ Coverage comparison recorded (if available)

## Developer Communication

Keep responses BRIEF + INFORMATIVE:
- State current phase/task
- Show what changed (file list + line ranges)
- Report validation result (build/lint/test status)
- Ask for next action: "Ready for next task? (Type 'next')"
- DO NOT continue automatically

---

**These rules are NON-NEGOTIABLE and must be followed exactly.**
