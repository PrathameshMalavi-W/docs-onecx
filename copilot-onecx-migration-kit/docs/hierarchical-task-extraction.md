# Hierarchical Task Extraction Rules

This document defines how the planner should translate the OneCX Angular 19 migration docs into `MIGRATION_PROGRESS.md`.

The main goal is to prevent a common failure mode:
- the migration plan looks complete
- but the agent only read page titles or top-level pages
- and then marked broad steps complete without executing the real child actions

## Core principle

Treat every independently executable migration action as its own task.

This means:
- a page from the index is not always a leaf task
- some pages are parent containers only
- some pages must be split by section
- some child pages may need sub-sub-tasks

## Stable hierarchy format

Use hierarchical IDs:
- parent: `A.3`
- child: `A.3.1`
- grandchild: `A.3.1.a`

Rules:
- parent tasks summarize a migration area
- child and grandchild tasks hold executable work
- the executor should choose the first unresolved leaf task, not a parent task

## Page classification rules

### 1. Directory page

A directory page is a page whose main purpose is to link to more specific migration pages.

Example from the OneCX Angular 19 docs:
- `switch-to-new-components.adoc`

Planner behavior:
- create one parent task for the directory page
- create one child task for each linked migration page
- do not mark the parent complete until all child tasks are resolved

### 2. Procedural page with multiple actionable sections

A procedural page contains multiple imperative sections that can be executed independently.

Examples from the OneCX Angular 19 docs:
- `update-component-imports.adoc`
- `update-translations.adoc`
- `remove-portal-layout-styles.adoc`
- `upgrade-nx-angular-version.adoc`
- `provide-theme-config.adoc`

Planner behavior:
- create one parent task for the page
- create child tasks for each independently actionable `==` or `===` section
- if a section itself contains multiple executable branches, split it further into grandchild tasks

### 3. Simple page

A simple page contains one compact migration action with examples and notes, but not multiple independent actions.

Examples that are often leaf-like:
- `adjust-packages-in-webpack-config.adoc`
- `update-filtertype-value.adoc`

Planner behavior:
- create a single leaf task
- examples, notes, and tips remain evidence or guidance, not separate tasks

## Headings that should usually become tasks

Promote a section to a task when it describes a concrete change such as:
- update imports
- remove package usage
- replace component or API
- change bootstrap or providers
- update webpack or project configuration
- run install or migrate command
- verify all imports are migrated

## Headings that should usually NOT become tasks

Do not create separate tasks for headings that are only:
- `Example`
- `Examples`
- `Note`
- `Notes`
- `Tip`
- `Additional Notes`
- `Properties Mapping`

Exception:
- if a note or example introduces a required action not already captured elsewhere, create a child task for that action

## Parent completion rule

A parent task may become `[x] completed` only when:
- all executable child tasks are `[x] completed` or `[-] not applicable`
- the parent summary is updated
- the parent contains source pages and an overall outcome

If any child is unresolved, the parent must remain `[ ] not started`.

## Leaf execution rule

The executor must:
- re-read `MIGRATION_PROGRESS.md`
- find the first unresolved leaf task whose dependencies are satisfied
- re-open the linked documentation page for that leaf task
- execute only that one leaf task

The executor must not:
- execute an entire parent task in one go
- mark a parent complete while children remain unresolved

## Docs-lib-informed examples

### Example: `switch-to-new-components.adoc`

This page is a directory page.

Expected shape:
- `A.3 Replace removed components`
  - `A.3.1 Replace DataViewControlsComponent with InteractiveDataViewComponent`
  - `A.3.2 Replace PageContentComponent with OcxContentComponent or OcxContentContainerComponent`
  - `A.3.3 Replace SearchCriteriaComponent with SearchHeaderComponent`
  - `A.3.4 Replace ButtonDialogComponent with OcxDialogInlineComponent`

### Example: `update-component-imports.adoc`

This page is a procedural page with multiple child tasks.

Expected shape:
- `A.2 Update component imports`
  - `A.2.1 Move imports from @onecx/portal-integration-angular to @onecx/angular-accelerator`
  - `A.2.2 Move imports from @onecx/portal-integration-angular to @onecx/angular-utils`
  - `A.2.3 Move imports from @onecx/portal-integration-angular to @onecx/shell-core`
  - `A.2.4 Move imports from @onecx/angular-accelerator to @onecx/angular-utils`
  - `A.2.5 Remove deleted APIs from @onecx/angular-accelerator`
  - `A.2.6 Remove deleted APIs from @onecx/angular-integration-interface`
  - `A.2.7 Remove deleted APIs from @onecx/portal-integration-angular`
  - `A.2.8 Replace same-library helper imports and usages`
  - `A.2.9 Handle remote-component migrations if used`

### Example: `update-translations.adoc`

Expected shape:
- `A.7 Update translations`
  - `A.7.1 Update translation-related imports`
  - `A.7.2 Replace translationPathFactory with provideTranslationPathFromMeta`
  - `A.7.3 Replace remoteComponentTranslationPathFactory with provideTranslationPathFromMeta`
  - `A.7.4 Move remote component translation providers to bootstrap`
  - `A.7.5 Verify webpack importMeta compatibility`

### Example: `remove-portal-layout-styles.adoc`

Expected shape:
- `C.6 Remove @onecx/portal-layout-styles`
  - `C.6.1 Uninstall the deprecated package`
  - `C.6.2 Update style imports and references`
  - `C.6.3 Expose styles.css for Nx applications if required`
  - `C.6.4 Expose styles.css for Angular CLI applications if required`
  - `C.6.5 Adjust local development style serving if required`
  - `C.6.6 Import OneCX library styles if needed`

## Applicability rule

It is valid for many child tasks to become `[-] not applicable`.

But only after:
- the linked page was read
- the relevant repository files were checked
- file-based evidence was recorded

## Validation rule

Leaf tasks need validation.
Parent tasks need completion gating.

That means:
- validate leaf tasks with build, lint, test, or targeted evidence as appropriate
- validate parent tasks by checking child resolution state
