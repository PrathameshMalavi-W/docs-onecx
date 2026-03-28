---
name: onecx-next-step
description: Execute the next unresolved OneCX migration step and stop.
argument-hint: Optionally add extra context about the current blocker or target step.
agent: onecx-step-executor
---

Re-read `MIGRATION_PROGRESS.md` and execute only the first unresolved migration step whose dependencies are satisfied.

Rules:
- Execute only the first unresolved leaf step. If a parent has unresolved children, do not execute the parent.
- Re-open and read the linked documentation page for that step before making changes.
- Update the step entry with:
  - Source pages
  - Summary
  - Repository evidence
  - Files changed
  - Validation
  - Edge Cases or Issues
- If the step does not apply, mark it `[-] not applicable` with file-based evidence.
- Stop after that one step.
