# Documentation Discovery & Step Execution Rules

## Documentation Expansion (Phase 1 Mandatory)

### Discovery Process
1. **Fetch Main Index**:
   - OneCX Angular 19 migration index (MCP or fallback)
   - Record URL and title in MIGRATION_PROGRESS.md
   
2. **Record Complete Structure**:
   - All pages linked from index with URLs and titles
   - For each linked page:
     - List H1 (page grouping context)
     - List ALL H2 headers (independent executable steps)
     - Record H3/H4 as subordinate implementation details (NOT separate steps)
     - Record all secondary links to other pages

3. **Recursive Expansion**:
   - For each linked page discovered:
     - Read FULL page content completely
     - Extract H1 and H2 boundaries for tasking
     - Identify concrete action steps within each H2
     - Extract actual keywords and selectors from content
     - If page links to other pages → fetch those too using same rules
     - Apply recursively until all chains exhausted

4. **Task Decomposition by Header Hierarchy**:
   - **H1** = Page-level grouping context (NOT an independent task)
   - **H2** = Independent executable task (ONE TASK PER H2)
   - **H3/H4** = Implementation details under corresponding H2 (subordinate, not separate tasks)
   - Each H2 becomes one line in MIGRATION_PROGRESS.md Migration Tasks section

5. **Example Discovery Recording** (in MIGRATION_PROGRESS.md):
   ```
   ## Documentation Discovery
   
   ### Main Index Page
   - URL: https://onecx.github.io/docs/...
   - Title: OneCX Angular 19 Migration Guide
   - H1 Sections:
     - Pre-migration Preparation
     - Core Angular Upgrade
     - Post-migration Stabilization
   
   ### Page: OneCX Angular 19 Migration Guide (linked from index)
   - URL: https://onecx.github.io/docs/...
   - H1: Pre-migration Preparation
   - H2 headers (independent tasks):
     - Update @onecx Packages
     - Configure Build Environment
     - Run Pre-migration Tests
   - Secondary links:
     - OneCX Package Compatibility Matrix
     - PrimeNG Migration Guide
   ```

## Step Execution Workflow (Discovery → Plan → Execute → Validate → Checkpoint)

### Phase Naming (MANDATORY ORDER)
- **Phase 1** — Initialization and Planning
- **Phase A** — OneCX Pre-migration Execution
- **Phase B** — Core Angular Upgrade Decision, Ownership, and Execution/Handover
- **Phase C** — Post-migration Stabilization and Finalization

### At START of Each Step Execution

**1. REDISCOVERY** (Fresh Knowledge):
   - Fetch fresh documentation for that specific step from MCP or fallback URL
   - Do NOT rely on earlier discovery notes
   - Read the FULL section for this step (not just summary)
   - Extract actual keywords and content from documentation
   - If documentation links to other pages, fetch those too

**2. DECISION on APPLICABILITY**:
   - Based on ACTUAL content, not title:
     - Read full section in documentation
     - Search repository using actual keywords from documentation content
     - If no evidence found → [-] not applicable with reason and search details
     - If evidence found → [x] or [ ] based on status
   - Record in MIGRATION_PROGRESS.md:
     - "Applicability determination: YES [evidence] / NO [evidence]"
     - Search terms used
     - Search results

**3. PLAN** execution before executing:
   - Document planned action in MIGRATION_PROGRESS.md
   - List exact steps to be taken
   - List expected file changes (paths and line numbers)
   - List expected validation (build/lint/test)

**4. EXECUTE** exactly as planned:
   - Capture all command outputs and results
   - Record exact file paths and line numbers of changes
   - Note timestamps
   - Record any unexpected findings or decision changes
   - Update MIGRATION_PROGRESS.md "Execution steps" section during execution

**5. VALIDATE** after execution:
   - Run: npm run build (must pass, no errors)
   - Run: npm run lint (must be 0 warnings, 0 errors)
   - Run: npm run test (must pass all tests)
   - Capture full validation results
   - If failures: Document in error log, troubleshoot, resolve

**6. CHECKPOINT** (HALT AND WAIT):
   - Update MIGRATION_PROGRESS.md with:
     - Execution steps taken
     - Files changed (exact paths and line ranges)
     - Validation results (build/lint/test output)
     - Edge cases or issues encountered
   - Set task state marker: [x] completed, [ ] in progress/blocked, or [-] not applicable
   - HALT and wait for developer to say:
     - "next" or "continue" (default: continue) → proceed to next step
     - "SKIP~N" → skip next N steps (mark as [-] with reason "Skipped by user")
     - "review" → show progress so far
     - "retry" → retry last command

## Evidence Requirements for Task Completion

Before marking a step [x] completed, verify ALL of:
- [ ] Linked page was fetched and read (full content, not title)
- [ ] Repository evidence found using actual keywords from documentation
- [ ] All sub-pages or linked pages were fetched and read (if they exist)
- [ ] Step executed exactly as documented
- [ ] Validation (build/lint/test) passed
- [ ] All changes recorded in MIGRATION_PROGRESS.md

If any missing → step must remain [ ] not started or become [-] not applicable.

## "Not Applicable" Determination Standards

Mark step [-] not applicable ONLY with specific evidence:
- What searches were performed (exact grep/find commands)
- What was found or not found
- Repository state evidence (file listings, package.json excerpt, etc.)
- Reason based on repository state, not assumptions

**Example**:
```
[-] Remove PrimeNG DataTable Component
  - Evidence: grep -r "DataTable" found 0 results in src/
  - Package check: primeng ^17.0.0 in package.json, no components imported
  - Reason: PrimeNG not used in this project
```

## Rediscovery Requirement

**CRITICAL**: At the START of each step execution:
- Fetch fresh documentation from MCP or fallback URL for that specific step
- Do NOT rely solely on earlier discovery notes in MIGRATION_PROGRESS.md
- Read the FULL section or page for this step again
- This ensures you catch any recent documentation updates
- Each step should have current documentation context appended to its MIGRATION_PROGRESS.md entry
