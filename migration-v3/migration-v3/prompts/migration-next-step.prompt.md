---
name: migration-next-step
description: Execute the next unresolved leaf task from MIGRATION_PROGRESS.md and stop.
argument-hint: Optionally add blocker or context notes for the next leaf.
agent: migration-step-executor
---

Re-read `MIGRATION_PROGRESS.md` and execute only the first unresolved leaf task whose dependencies are satisfied.

Rules:
- do not execute a parent task while child tasks remain unresolved
- re-open the leaf task's documentation page before changing code
- do not make speculative package.json edits unless the current leaf is an explicit package/version step
- if the current leaf requires `nx migrate`, use a fixed documented version instead of `latest`
- preserve documented caret ranges when package updates depend on repo or module-federation conventions
- fully remove deprecated imports, selectors, and compatibility code when the docs replace them
- never replace `<ocx-portal-viewport>` with a different template structure
- if the docs require `styles.scss` changes, apply them exactly; if Nx styles-array versus Sass `@import` usage is still ambiguous, stop and report the ambiguity instead of guessing
- if the repo hits `Component is standalone, and cannot be declared in an NgModule`, add `standalone: false` only where the docs and repo context support it, and document why
- if PrimeNG imports or components break, verify the PrimeNG migration guide before changing code
- if bootstrap.ts already owns translation or REMOTE_COMPONENT_CONFIG providers, remove duplicates from component/module providers
- update evidence in `MIGRATION_PROGRESS.md`
- stop after that one leaf task
