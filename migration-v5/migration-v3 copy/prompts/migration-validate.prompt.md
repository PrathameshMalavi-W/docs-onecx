---
name: migration-validate
description: Validate the latest leaf task and update completion gating.
argument-hint: Optionally specify which leaf to validate if the latest one is ambiguous.
agent: migration-validator
---

Re-read `MIGRATION_PROGRESS.md` and validate the latest executed leaf task.

Rules:
- validate the leaf first
- prefer targeted static validation for leaf work
- use full build, lint, or test only when the current phase or current leaf actually requires it
- do not treat a temporary mid-migration compile failure as automatic proof that a valid documented change must be reverted
- update completion state only when evidence is sufficient
- update parent completion gates if all children are resolved
- stop after validation
