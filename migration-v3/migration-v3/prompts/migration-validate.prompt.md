---
name: migration-validate
description: Validate the latest leaf task and update completion gating.
argument-hint: Optionally specify which leaf to validate if the latest one is ambiguous.
agent: migration-validator
---

Re-read `MIGRATION_PROGRESS.md` and validate the latest executed leaf task.

Rules:
- validate the leaf first
- update completion state only when evidence is sufficient
- update parent completion gates if all children are resolved
- stop after validation
