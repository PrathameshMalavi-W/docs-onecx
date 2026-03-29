# Deep Discovery Protocol

## Purpose

Enable agents to thoroughly discover all tasks and subtasks within migration documentation without lazy evaluation or assumption-based skipping.

## Core Principles

1. **No Assumption Based on Headlines**: Headlines are often abstractions. The actual task keywords and requirements live in the page content.
2. **Every Link is a Task**: If a page contains 4 links to subtasks, the agent must visit ALL 4 pages. Do not assume you understand the page from its title.
3. **Subsections Are Subtasks**: Each major subsection (H2 heading) within a procedural page is a distinct subtask, not just documentation.
4. **Full Context Persistence**: Maintain complete context across all visited pages. Do not discard previously read pages when moving to new ones.
5. **Permission Gating**: When a task appears complex or blocked, ask the user for permission to proceed rather than skipping it.

## Discovery Workflow

### Phase 1: Page Entry

When encountering ANY migration documentation page:

```
1. Identify the page structure:
   - Is this a directory page (mostly links to other pages)?
   - Is this a procedural page (numbered steps, subsections)?
   - Is this a simple page (single focused topic)?

2. For DIRECTORY pages:
   - Do NOT assume you understand the linked pages from their titles
   - Mark each linked page as a "subtask discovery point"
   - Create a subtask entry for each link
   - Record: link text, URL, discovered status

3. For PROCEDURAL pages:
   - Extract ALL H2 headings (these are subsections)
   - Each H2 or logical section = one subtask
   - Never collapse multiple sections into one task
   - Check for referenced links within sections

4. For SIMPLE pages:
   - Treat the entire page as one leaf task
   - But check for any embedded links to other pages
   - Create follow-up subtasks if links exist
```

### Phase 2: Link Traversal

For each discovered link:

```
1. Visit the link (do not skip)
2. Read the full page content
3. Determine page type (repeat Phase 1)
4. Extract structure
5. Record findings:
   - Page title
   - Page type (directory/procedural/simple)
   - All discovered subsections
   - All nested links
6. Return findings to parent discovery context
```

### Phase 3: Subsection Extraction

For procedural pages, extract subsections as subtasks:

```
For each H2 heading or logical section:
  - Extract heading text as task title
  - Extract opening paragraph as description
  - Check for:
    * numbered sub-steps
    * code blocks or examples
    * conditional language ("if...", "when...")
    * required tools or dependencies
  - Check for links within section (create follow-up tasks)
  - Mark as: [?] discovered
```

### Phase 4: Context Stacking

Maintain a discovery context stack:

```
Context Stack:
├── Root page: [page title] [L1 tasks]
│   ├── Child page 1: [page title] [L2 tasks]
│   │   └── Child page 1.1: [page title] [L3 tasks]
│   └── Child page 2: [page title] [L2 tasks]
└── Root page 2: ...

Rules:
- Never discard a parent context when opening a child page
- Always return to parent context after child discovery
- Record all discovered pages in the final MIGRATION_PROGRESS.md
```

## Task Blocking and Escalation

### When to Block a Discovered Task

A task should be marked `[?] blocked - needs permission` if:

1. **Potential destructive change**: Modifies core patterns, templates, or infrastructure
2. **Complex with branching logic**: Multiple conditional paths or unclear prerequisites
3. **Ambiguous applicability**: Unclear from docs whether it applies to this repo
4. **External dependency**: Requires manual action or third-party API/service
5. **Protected or critical section**: Requires explicit user approval

### Escalation Pattern

```markdown
[?] blocked - needs permission | [Section Title]
  - reason: describe why this is blocked
  - prerequisite: what approval is needed
  - consequence: what happens if approved/denied
  - source: [link to docs page]
```

Example:
```markdown
[?] blocked - needs permission | Upgrade Angular Material
  - reason: This is a major version bump that affects component APIs repo-wide
  - prerequisite: User must confirm this repo is ready for Material API changes
  - consequence: If approved, agent will upgrade @angular/material. Some components may need breaking-change fixes.
  - source: [Angular Material Migration](docs/migration/angular-material.md)
```

## MCP Usage Patterns

When using onecx MCP server:

```
1. Narrow query result = discovery hint only
   - Do NOT implement based on narrow snippet
   - Always fetch the FULL page before implementation

2. Multiple links in narrow result = multiple subtasks
   - If MCP query shows 4 links, visit all 4
   - Do not assume 1 link is the only task

3. Page structure discovery via MCP:
   - First query: "What is this page?" (get structure)
   - Second query: "List all links and headings" (get nested structure)
   - Third fetch: Read each linked page (get details)
```

## Pseudocode: Thorough Discovery

```
function discoverTasks(pageUrl, parentContext) {
  page = fetchFullPage(pageUrl);
  structure = analyzePageStructure(page);
  
  if (structure.type === "directory") {
    subtasks = [];
    for each link in page.links {
      subtask = {
        status: "discovered",
        title: link.text,
        url: link.href,
        source: pageUrl,
        childTasks: [] // will be populated by recursive call
      };
      
      // Recurse: don't just assume from title
      subtask.childTasks = discoverTasks(link.href, parentContext);
      subtasks.push(subtask);
    }
    return subtasks;
  }
  
  else if (structure.type === "procedural") {
    subtasks = [];
    for each heading_h2 in page.headings {
      section = extractSection(page, heading_h2);
      subtask = {
        status: "discovered",
        title: heading_h2.text,
        description: section.firstParagraph,
        pageUrl: pageUrl,
        sectionAnchor: heading_h2.anchor,
        nestedLinks: section.links,
        source: pageUrl
      };
      
      // Check for nested links - create follow-up tasks
      for each link in section.links {
        if (isExternalCrossReference(link)) {
          subtask.followUpTasks.push({
            title: link.text,
            url: link.href,
            type: "follow-up"
          });
        }
      }
      
      subtasks.push(subtask);
    }
    return subtasks;
  }
  
  else { // simple page
    return [{
      status: "discovered",
      title: page.title,
      description: page.summary,
      pageUrl: pageUrl,
      type: "simple",
      source: pageUrl
    }];
  }
}
```

## Red Flags: When to Stop and Ask

Stop discovery and ask user permission if you encounter:

1. **"Optional" or "if applicable" sections**: These need repo evidence
2. **"Advanced" or "expert-only" sections**: These may need user judgment
3. **Large structural changes**: Refactors that affect multiple components
4. **Deprecated pattern migrations**: Where old and new patterns coexist
5. **Performance-impacting changes**: That require benchmarking
6. **Security-related changes**: That require review/approval

Message pattern:
```
Found [task title] which is [reason]. 

This task is complex/optional/requires repo evidence. 

Before I continue, should I:
a) Execute it (I'll need permission)
b) Mark it as "not applicable" 
c) Mark it as "blocked - needs user action"

Current repo state: [evidence]
```

## Task Entry Format

Every discovered task must have:

```markdown
[?] discovered | [Task Title]
  - source: [link to docs page or section]
  - type: parent|child|leaf
  - complexity: simple|moderate|complex
  - applicability: must-have|nice-to-have|unknown
  - description: [brief description or opening sentence from docs]
  - prerequisites: [list any dependencies or gates]
```

Example:
```markdown
[?] discovered | Update @angular/material to v19
  - source: [https://onecx.docs/migration/19/material](https://onecx.docs/migration/19/material#upgrade-material)
  - type: leaf
  - complexity: complex (affects multiple components)
  - applicability: must-have (repo uses Material)
  - description: Upgrade Angular Material to v19 and resolve component API breaking changes
  - prerequisites:
    * @angular/core updated to v19
    * Review [Material Breaking Changes](https://material.angular.io/guide/migration)
```

## Task Progression

```
[?] discovered          → Initial discovery
[?] blocked - ...       → User permission needed
[~] in-progress         → Agent actively working
[x] completed           → Task done, validated
[-] not-applicable      → Evidence-based skip
```

Only transition to `[x]` after validation confirms the task is done.
Never move from `[?] discovered` to `[x] completed` without execution.
