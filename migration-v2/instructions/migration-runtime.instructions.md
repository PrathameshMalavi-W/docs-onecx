Apply these instructions whenever this workspace uses the runtime-driven migration workflow.

Core behavior:
- Treat `MIGRATION_PROGRESS.md` as the source of truth.
- Re-read `MIGRATION_PROGRESS.md` before continuing migration work.
- Require the user to state the intended target version at migration start.
- Derive tasks from docs at runtime rather than from hardcoded version-specific checklists.
- Build parent, child, and leaf tasks when the docs require it.
- Execute one leaf task at a time.
- Prefer autonomy for routine work.

Initialization behavior:
- Start with dependency install and test audit.
- Check branch protection before migration edits.
- Capture coverage baseline if available.
- Audit Copilot instructions for version-specific cleanup later.
- Verify build, lint, and test tasks and use task-based execution whenever suitable tasks exist.
- Do not assume success from return code alone; use actual output.

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
- Use VS Code tasks for build, lint, and test when suitable tasks exist.
- Do not rely only on return codes.
- Record useful failed validation output in `MIGRATION_PROGRESS.md`.
- Capture the last 20 useful log lines when validation fails and map them to likely causes.
- Keep lint fully clean unless the docs explicitly justify a temporary exception.

Documentation behavior:
- Use OneCX MCP first when available.
- Use PrimeNG MCP if the repo uses PrimeNG.
- Use Nx docs or Nx MCP when the repo is an Nx workspace.
- Use fallback URLs only when MCP is unavailable.
- Infer the current repo version from repository evidence.
- Take the intended migration target from the init prompt.
- Validate that the repo state matches the chosen docs guide before execution.
- If the target version is missing or the signals conflict, stop and ask one concise major question.
- If documentation is unclear, stop and ask one concise major question.

OneCX-specific migration rules:
- Use a fixed documented `nx migrate` version when Nx migration is required.
- Never use `latest` for Nx migration versions.
- Keep Angular package versions with a caret (`^`) when that matches the module federation strategy.
- If styles handling is ambiguous, ask whether to use the Nx styles array or Sass `@import` pattern.
- If the standalone component error appears, add `standalone: false` where appropriate and document why.
- If PrimeNG imports or components break after the upgrade, consult PrimeNG migration docs and apply only documented fixes.

Phase boundary behavior:
- At the pre-migration boundary, prepare a clean checkpoint summary before the core-upgrade approval gate.
- Include commit readiness, working tree status, and a concise core-upgrade cheat-sheet in the handover.
- After the core upgrade, resume only when the upgrade result and validation state are recorded in `MIGRATION_PROGRESS.md`.
