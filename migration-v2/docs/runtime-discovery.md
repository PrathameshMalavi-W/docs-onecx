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

### 3. Read the migration index

The planner should:
- open the main migration index page
- collect linked migration pages
- collect phase boundaries
- collect any conditional branches such as Nx-specific paths

### 4. Expand linked pages

For every linked page:
- read the full page
- detect whether it is:
  - directory page
  - procedural page
  - simple page
- collect headings
- collect materially relevant linked follow-up pages

### 5. Build task hierarchy

Use these rules:
- directory page -> parent task + child page tasks
- procedural page -> parent task + child section tasks
- simple page -> one leaf task
- notes/examples are not tasks unless they contain a required action

### 6. Check repository applicability

Before marking something not applicable:
- inspect the repository
- capture evidence
- attach it to the task entry

### 7. Persist the result

Write the discovered task tree into `MIGRATION_PROGRESS.md`.

## Good runtime behavior

The planner should adapt to:
- OneCX 18 to 19
- OneCX 19 to 20
- future versions
- repositories that only use some documented areas

## Bad runtime behavior

Avoid:
- hardcoded version-specific checklists when the docs are available
- marking steps complete during planning
- assuming headings always equal executable work
- asking the user routine questions that can be inferred from the repo
