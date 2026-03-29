Apply these instructions whenever this workspace uses the runtime-driven migration workflow.

Core behavior:

- Treat `MIGRATION_PROGRESS.md` as the source of truth.
- Re-read `MIGRATION_PROGRESS.md` before continuing migration work.
- Require the user to state the intended target version at migration start.
- During initialization, audit dependency/test readiness, branch protection, repository instructions, and task configuration before creating the migration plan.
- Derive tasks from docs at runtime rather than from hardcoded version-specific checklists.
- Build parent, child, and leaf tasks when the docs require it.
- Execute one leaf task at a time, but execute it COMPLETELY (all subsections).
- Prefer autonomy for routine work.
- Include PrimeNG and Nx docs in the runtime source set when the repository actually uses them.
- Treat narrow MCP query results as discovery hints only. Verify the full linked page before implementing from them.
- Infer the current repo version from repository evidence.
- Take the intended migration target from the init prompt.
- Validate that the repo state matches the chosen docs guide before execution.
- If the target version is missing or the signals conflict, stop and ask one concise major question.

DEEP DISCOVERY BEHAVIOR (NEW - Critical):

- Visit EVERY documented link, do not assume meaning from headlines alone.
- Extract every H2 heading as a potential subtask, never collapse subsections.
- For directory pages: each link is a subtask requiring full page visit (no assumptions).
- For procedural pages: each H2 section is a leaf task, treat separately.
- Maintain full context stack: do not discard parent page context when visiting child pages.
- Record all page visits, subsection counts, and findings in MIGRATION_PROGRESS.md.
- Use [deep-discovery-protocol.md](../docs/deep-discovery-protocol.md) as authoritative reference.

DELEGATION AND ESCALATION BEHAVIOR (NEW - Critical):

- NEVER skip a task due to complexity. Instead, ask for user permission.
- When a task is complex, ambiguous, or risky: mark `[?] blocked - needs permission` and ask user.
- Give user 2-3 clear options:
  - Execute it (proceed with caution)
  - Defer it (mark as blocked)
  - Skip it (only with repo evidence that it's not applicable)
- Wait for explicit user response before proceeding.
- Use [delegation-policy.md](../docs/delegation-policy.md) as authoritative reference.

ESCALATION EXAMPLES:

- Ambiguous optional: "This step says 'if using [feature]'. Your repo has [evidence]. Execute? (Y/N)"
- Risky large change: "This refactors [N] files. Proceed? (Y/N)"
- Missing external input: "This needs [config]. Do you have it? (Y/N/defer)"
- Complex decision: "Found [conflicting patterns]. Which should I prioritize?"

Package behavior:

- Do not rewrite `package.json` during planning.
- Change `package.json` only during an explicit package/version task or the approved core-upgrade task.
- Only change packages named by the docs or by a verified blocker.
- Do not invent placeholder versions such as `6.0.0`.
- When `nx migrate` is required, use a fixed documented version instead of `latest`.
- If documented Angular or OneCX package updates require caret ranges, preserve them where the repository or module-federation strategy depends on them.

Completion behavior:

- Do not mark a task `[x] completed` from the title alone.
- Do not mark a parent `[x] completed` while any executable child remains unresolved.
- Use `[-] not applicable` only after reading the linked docs and checking the repository with evidence.
- Never mark `[x] completed` if validation is still needed (leave for validator).

User interaction behavior:

- Prompt the user for major decisions, missing required input, phase gates, protected branch issues, or external actions.
- Do not ask the user routine questions that the docs or repo can answer.
- At the core-upgrade phase gate, ask for approval, not for manual execution by default.
- If the user approves, the agent should perform the core upgrade itself unless a real blocker requires user-side action.
- Use [delegation-policy.md](../docs/delegation-policy.md) for escalation message patterns.

Validation behavior:

- Prefer targeted static validation for leaf tasks.
- Use VS Code tasks for build, lint, and test when suitable tasks exist and the current phase actually needs them.
- Do not rely only on return codes.
- Record useful failed validation output in `MIGRATION_PROGRESS.md`.
- Do not revert valid migration work only because the repository is temporarily uncompilable in an intermediate migration state.
- If initialization runs install, build, or test, record the outcome in `MIGRATION_PROGRESS.md` and inspect the full output rather than relying on return codes alone.
- If task configuration changes are needed, keep `.vscode/tasks.json` aligned with build, lint, and test tasks where supported, set `CI=true` on created or updated tasks, and prefer non-watch tests with coverage when supported.

Component behavior:

- Fully remove old imports, selectors, tags, modules, and compatibility code when a migration replaces them unless the docs explicitly require coexistence.
- Do not replace `<ocx-portal-viewport>` template usage with a different structure. Only migrate its import or module source when required.
- For `ocx-interactive-data-view`, preserve filtering behavior, avoid DOM-event based integrations, and prefer `[actionColumnPosition]="'left'"` unless repo patterns clearly require something else.
- If the docs require `styles.scss` changes, apply them exactly. If the correct integration path is ambiguous between Nx styles arrays and Sass `@import`, stop and surface the ambiguity instead of guessing.
- If the repo hits `Component is standalone, and cannot be declared in an NgModule`, add `standalone: false` only where the migration docs and repository context support it, and record why.
- If PrimeNG components or imports break during migration, consult the PrimeNG migration docs and apply only documented fixes.

Remote component behavior:

- When `bootstrap.ts` already owns `REMOTE_COMPONENT_CONFIG` or translation providers, remove duplicates from component or module providers.

Context preservation behavior (NEW):

- Always record detailed execution findings in MIGRATION_PROGRESS.md entries
- Include source page links, subsection counts, discovered nested links
- Never silently discard task information
- On task completion, record: timestamp, evidence (file changes, command output), next steps
- Hand off validation hints to validator agent
