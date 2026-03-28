---
name: onecx-verify-step
description: Validate the current migration step and decide whether it can be marked completed.
argument-hint: Optionally specify which step to verify if it is ambiguous.
agent: onecx-validator
---

Validate the current migration step in `MIGRATION_PROGRESS.md`.

Rules:
- Validate the current leaf step first, then check whether its parent completion gate can now be satisfied.
- Do not mark the step `[x] completed` unless the required evidence is present.
- Run the required build, lint, or test validation for the current step.
- If validation fails or the evidence is incomplete, keep the step unresolved and document why.
- Stop after validation.
