Apply these instructions whenever this workspace is being used for a OneCX Angular 18 to 19 migration.

Core behavior:
- Treat `MIGRATION_PROGRESS.md` as the source of truth.
- Re-read `MIGRATION_PROGRESS.md` before continuing migration work in an existing session.
- Never mark a migration step completed from the title alone.
- Read the linked migration page before planning or executing a step.
- Read materially relevant linked sub-pages before deciding applicability or completion.
- Build hierarchical tasks when the docs require it.
- Execute one leaf migration step at a time.
- Prefer evidence over assumptions.

Completion rule:
- A step may only become `[x] completed` if its entry includes:
  - Source pages
  - Summary
  - Repository evidence
  - Files changed or explicit note that none were needed
  - Validation
  - Edge Cases or Issues

Planning rule:
- During planning, future action steps should normally stay `[ ] not started`.
- Use `[-] not applicable` only after reading the linked page and checking the repository with file-based evidence.
- If a page is only a directory of links, create a parent step and child steps.
- If a page contains multiple independently actionable sections, split it into child steps.
- Do not mark a parent step completed until all child steps are resolved.

Validation rule:
- Prefer VS Code tasks for build, lint, and test when suitable tasks exist.
- Do not rely only on return codes.
- If build, lint, or test fails, capture the last 20 log lines and record them in `MIGRATION_PROGRESS.md`.
