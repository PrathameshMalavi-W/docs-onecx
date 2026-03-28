Apply these instructions whenever this workspace uses the runtime-driven migration workflow.

Core behavior:
- Treat `MIGRATION_PROGRESS.md` as the source of truth.
- Re-read `MIGRATION_PROGRESS.md` before continuing migration work.
- Derive tasks from docs at runtime rather than from hardcoded version-specific checklists.
- Build parent, child, and leaf tasks when the docs require it.
- Execute one leaf task at a time.
- Prefer autonomy for routine work.

Completion behavior:
- Do not mark a task `[x] completed` from the title alone.
- Do not mark a parent `[x] completed` while any executable child remains unresolved.
- Use `[-] not applicable` only after reading the linked docs and checking the repository with evidence.

User interaction behavior:
- Prompt the user only for major decisions, missing required input, phase gates, protected branch issues, or external actions.
- Do not ask the user routine questions that the docs or repo can answer.
- At the core-upgrade phase gate, ask for approval, not for manual execution by default.
- If the user approves, the agent should perform the core upgrade itself unless a real blocker requires user-side action.

Validation behavior:
- Prefer VS Code tasks for build, lint, and test when suitable tasks exist.
- Do not rely only on return codes.
- Record useful failed validation output in `MIGRATION_PROGRESS.md`.
