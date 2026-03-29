Apply these instructions whenever this workspace uses the low-request bundled migration workflow.

Core behavior:
- Treat `MIGRATION_PROGRESS.md` as the source of truth.
- Re-read `MIGRATION_PROGRESS.md` before every migration run.
- Discover the migration path at runtime instead of hardcoding one version path.
- Plan in detail, but execute at top-level-step granularity.
- A top-level step may include many substeps, child pages, or child actions.
- Execute one top-level step per prompt.
- Require the user to state the intended target version at migration start.

Initialization behavior:
- Run `npm install`.
- Run tests before planning continues.
- Stop if install or tests fail.
- Check whether the branch is protected.
- Capture coverage baseline if available.
- Audit Copilot instructions for version-specific cleanup later.
- Verify build, lint, and test tasks.
- Prefer tasks over manual terminal commands when suitable tasks exist.
- Do not assume success from return code alone.

Documentation behavior:
- Use OneCX MCP first when available.
- Use PrimeNG docs only when the repo uses PrimeNG or the docs require it.
- Use Nx docs when the repo is an Nx workspace.
- Use fallback URLs only when MCP is unavailable.
- For each top-level step, fetch the linked child docs and relevant sub-docs inside the same run.
- Infer the migration version path from repo evidence first:
  - current Angular major from `@angular/core`
  - current OneCX library major from `@onecx/*`
  - explicit user target from the init prompt
- Validate that repo state matches the chosen docs guide before execution.
- If version signals conflict, stop and ask one concise major question.
- If the user did not specify a target version, stop and ask for it before planning.

Completion behavior:
- Do not mark a step complete from its title alone.
- Do not mark a step `[x] completed` until all of its required internal substeps are done or inapplicable with evidence.
- Use `[-] not applicable` only after reading the relevant docs and checking the repo with evidence.
- Record failures, useful logs, and likely causes in `MIGRATION_PROGRESS.md`.

Validation behavior:
- Use build, lint, and test tasks when suitable tasks exist.
- Keep lint fully clean unless the docs explicitly justify a temporary exception.
- If validation fails, capture the last 20 useful log lines and likely causes.
- Do not proceed to the next top-level step until the current one is resolved.

Approval behavior:
- Do not perform the core Angular or Angular+Nx upgrade without explicit user approval.
- After approval, the agent should perform the upgrade itself unless a real blocker requires user action.

OneCX-specific rules:
- Use a fixed documented `nx migrate` version when Nx migration is required.
- Never use `latest` for `nx migrate`.
- Keep Angular package versions with a caret (`^`) when that matches the module federation strategy.
- If styles handling is ambiguous, ask whether to use the Nx styles array or Sass `@import` pattern.
- If the standalone component error appears, add `standalone: false` where appropriate and document why.
- If PrimeNG imports or components break after upgrade, consult PrimeNG migration docs and apply documented fixes only.
