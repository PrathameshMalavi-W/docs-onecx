# Core Constraints (Non-Negotiable)

## 1. HALT After Each Step Execution
- **Rule**: After executing each step (in Phase A, B, or C), halt immediately.
- **Checkpoint**: Wait for developer to explicitly say "next" or "continue" (default: continue).
- **Effect**: Developer retains full control and can review state before proceeding.
- **Skip Command**: Developer can say "SKIP~N" to skip next N steps (mark as [-] not applicable "Skipped by user").

## 2. Build → Lint → Test Order is STRICT
- **Rule**: This order NEVER changes and is executed after EVERY package or code change.
- **Sequence**:
  1. npm run build (must complete, no errors)
  2. npm run lint (must be 0 warnings, 0 errors unless explicitly relaxed)
  3. npm run test (all tests must pass)
- **Failure Handling**: If any step fails, halt, document error (last 20+ lines), and troubleshoot before proceeding.
- **Non-Negotiable**: Build/Lint/Test is not negotiable; it runs after every change.

## 3. MIGRATION_PROGRESS.md as Single Source of Truth
- **Rule**: MIGRATION_PROGRESS.md is the PRIMARY knowledge base, not supplementary.
- **Update Timing**: Update CONTINUOUSLY during execution, not at the end.
- **Reference Before Each Step**: Always read MIGRATION_PROGRESS.md before starting any step to understand current context.
- **Content**: Must contain ALL rules, knowledge, data, context, and logs.
- **Resumed Work**: When resuming work in a new chat session:
  1. Read MIGRATION_PROGRESS.md in full
  2. Review "Current Session Context"
  3. Review "Open issues/blockers"
  4. Review last executed step and its result
  5. Only then proceed with next step

## 4. NEVER Skip Steps Due to Complexity
- **Rule**: Complex tasks are reasons to break down and execute methodically, NOT to defer or skip.
- **Default Behavior**: Commit to completing every task.
- **Escalation**: Only suggest user intervention if genuinely impossible (not just complex).
- **Execution Discipline**: Treat complexity as a planning challenge, not a blocker.

## 5. Strict Documentation Source Hierarchy
1. **Primary**: MCP servers (OneCX, PrimeNG, Nx)
2. **Secondary**: node_modules CHANGELOG.md files (authoritative version-specific info)
3. **Tertiary**: Fallback URLs (official documentation)
4. **Never Guess**: If unclear, stop and ask rather than assume.

## 6. PRE-MIGRATION COMPLETION CRITERIA (MANDATORY)
- Pre-migration task can ONLY be marked [x] completed AFTER ALL of:
  - [ ] npm run build completes successfully with no errors
  - [ ] npm run lint completes with 0 warnings and 0 errors (unless developer explicitly relaxes)
  - [ ] npm run test passes all tests
  - [ ] All changes committed with message "Pre-migration: prepare for Angular {version} upgrade"
- **If any fails**: Capture last 20 lines, map to root cause, resolve before proceeding to Phase B.

## 7. POST-MIGRATION COMPLETION CRITERIA (MANDATORY)
- Post-migration task can ONLY be marked [x] completed AFTER ALL of:
  - [ ] All errors documented in MIGRATION_PROGRESS.md with root causes
  - [ ] All errors systemically addressed (or marked as acceptable trade-offs with justification)
  - [ ] PrimeNG migration completed (v17→v19) with evidence or marked [-] not applicable
  - [ ] Nx migration completed (if used) with evidence or marked [-] not applicable
  - [ ] npm run build completes successfully with no errors
  - [ ] npm run lint completes with 0 warnings and 0 errors (unless developer explicitly relaxes)
  - [ ] npm run test passes all tests
  - [ ] Code coverage comparison documented (post vs Phase 1 baseline)
  - [ ] All migration steps marked [x] completed or [-] not applicable with justification
  - [ ] Final summary report generated in MIGRATION_PROGRESS.md

## 8. Error Capture Minimum (50+ Lines)
- **Rule**: When build/lint/test fails, capture last 20-50 lines minimum of error output.
- **Mapping**: Map each error to its root cause, not just summarizing.
- **Documentation**: Record in MIGRATION_PROGRESS.md Error Log Repository with:
  - Timestamp
  - Full error output (20+ lines)
  - Root cause analysis
  - Resolution attempt
  - Result/outcome

## 9. @onecx Package Version Rule
- **Rule**: For each @onecx package:
  - ONLY update if OneCX documentation EXPLICITLY specifies a version
  - Use documented version as-is (e.g., ^6.x.y means latest stable of version 6)
  - If documentation does NOT mention a specific package, SKIP that package (don't update it)
- **Record in MIGRATION_PROGRESS.md**:
  - Each @onecx package updated with documented version and source
  - Each @onecx package skipped with reason "Not mentioned in OneCX documentation"

## 10. Applicability Determination Rule (READ FULL CONTENT)
- **Rule**: NEVER decide if task is applicable by reading title alone.
- **For Every Step**:
  1. Fetch and READ the linked documentation page COMPLETELY
  2. If page has multiple sections, linked follow-up pages, or component guides → FETCH and READ those too
  3. Look for ACTUAL keywords in content (not inferred synonyms):
     - Title says "MenuService" but section describes "AppMenu components"? → Search for "AppMenu"
     - Read full section to find actual selectors and search terms
  4. Search repository using actual keywords from documentation
  5. Only after reading FULL page AND all sub-pages AND finding evidence → decide applicability
  6. Mark [-] not applicable with specific evidence (what was searched, what wasn't found)
