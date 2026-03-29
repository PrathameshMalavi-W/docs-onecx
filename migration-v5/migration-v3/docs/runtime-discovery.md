# Runtime Discovery

## Why runtime discovery matters

Migration steps should be derived at runtime because:
- documentation evolves
- version targets change
- repositories vary in what they actually use
- some steps are only applicable if certain packages, components, or patterns are present

## Discovery pipeline

### 1. Infer migration context

The planner should infer:
- current framework/library version
- likely target version
- whether a local docs folder exists
- whether an MCP source is available

Sources:
- package.json
- workspace config files
- repository docs
- user request

If still unclear, ask the user one concise major question.

### 2. Identify the migration source set

The planner should determine the canonical source order:
1. MCP docs
2. local repository migration docs
3. public fallback URL

For a real OneCX app repo, this usually means:
1. OneCX MCP
2. PrimeNG MCP if relevant
3. Nx docs or Nx MCP if relevant
4. fallback URLs

Local repository docs are optional and should not be assumed.

Important rule:
- treat narrow MCP query results as discovery aids, not as final implementation authority
- if a query returns unrelated snippets or an unclear page, fetch the broader canonical page before planning or coding

### 3. Read the migration index

The planner should:
- open the main migration index page
- collect linked migration pages
- collect phase boundaries
- collect any conditional branches such as Nx-specific paths

### 4. DEEP DISCOVERY: Expand linked pages (REVISED - Critical)

**DO NOT assume meaning from page titles.**

For every linked page:
- Visit the FULL page (do not rely on MCP snippet results)
- Read the complete content
- Detect page type:
  - directory page (mostly links)
  - procedural page (steps, H2 sections)
  - simple page (focused topic)
- Extract ALL H2 headings (these become leaf tasks)
- Collect ALL nested links (check each one too)
- For each subsection: record opening paragraph as task description
- Count total subsections discovered
- Record page traversal in MIGRATION_PROGRESS.md

**Examples of what NOT to do:**
- Page title: "Material Migration" → assume it's only package upgrades (NO - visit and read all sections)
- Page title: "Optional Features" → assume skip all (NO - check each option against repo)
- See 2 links in narrow MCP result → plan only 2 tasks (NO - visit and count actual links)

**Example of what TO do:**
```
Page: "Angular 19 Component Refactor"
- Visit full page
- Find H2 sections:
  1. Standalone Components
  2. Signal-based State
  3. Event Binding Changes
  4. Template Syntax Updates
- Create 4 subtask entries
- Each subsection = 1 leaf task
- Discover nested links within each section
- Record all in MIGRATION_PROGRESS.md before continuing
```

### 5. Build task hierarchy (REVISED)

Use these rules:
- directory page → parent task + one child task per link (visit all links first)
- procedural page → parent task + one leaf task per H2 section
- simple page → one leaf task
- notes/examples are not tasks unless they contain a required action
- keep package updates in dedicated package/version leaf tasks instead of mixing them into unrelated refactors
- **do NOT collapse subsections into parent tasks** - each subsection is executable leaf
- **do NOT skip subsections due to complexity** - escalate if needed, but do not skip

### 6. Check repository applicability

Before marking something not applicable:
- inspect the repository
- capture evidence
- attach it to the task entry

**Critical:** "Optional" or "if applicable" subsections require repo evidence check.
Never skip without reading the page and checking the repo.

Validation note:
- use targeted repository evidence for leaf-level validation by default
- do not require a full build after every intermediate migration step

### 7. Persist the result

Write the discovered task tree into `MIGRATION_PROGRESS.md` with full metadata:
```markdown
[?] discovered | [Task Title]
  - source: https://onecx.docs/migration/19/...#section
  - type: parent|child|leaf
  - complexity: simple|moderate|complex
  - applicability: must-have|nice-to-have|unknown
  - subsectionsCount: [number]
  - pageVisited: [timestamp]
  - description: [from opening paragraph]
```

## Good runtime behavior

The planner should adapt to:
- OneCX 18 to 19
- OneCX 19 to 20
- future versions
- repositories that only use some documented areas
- **visiting EVERY page before giving up or assuming**
- **extracting EVERY H2 section as a subtask**
- **maintaining full context of all discovered pages**

## Bad runtime behavior

- Do NOT assume task meaning from headlines
- Do NOT skip complex subsections
- Do NOT shrink directory pages into single tasks
- Do NOT mark steps complete during planning
- Do NOT ask user routine questions the repo can answer
- Do NOT traverse only 1-2 links from a directory and assume they're all the tasks
- Do NOT collapse nested subsections into parent task entries
- Do NOT mark task `[x] completed` without full execution and validation

## DEEP DISCOVERY Reference

For comprehensive protocol: see [deep-discovery-protocol.md](./deep-discovery-protocol.md)

Key points:
- Phase 1: Page Entry (identify type)
- Phase 2: Link Traversal (visit all)
- Phase 3: Subsection Extraction (extract all H2s)
- Phase 4: Context Stacking (maintain full tree)
- Escalation: Never skip, always ask permission

Avoid:
- hardcoded version-specific checklists when the docs are available
- marking steps complete during planning
- assuming headings always equal executable work
- asking the user routine questions that can be inferred from the repo
