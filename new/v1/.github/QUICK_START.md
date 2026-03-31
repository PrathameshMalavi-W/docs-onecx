# QUICK START: Angular Migration

## 5-Minute Setup

### 1. Fill in Config (Once)
Edit: `.github/migration-config.json`

```json
{
  "migration": {
    "targetAngularVersion": "19",     // ← 19, 20, or 21
    "projectName": "my-app",
    "gitBranch": "feature/angular-upgrade"
  }
}
```

That's it. Orchestrator auto-detects everything else.

### 2. Optional: Add Custom Rules (if needed)
Copy: `.github/templates/USER_CUSTOM_RULES.template.md` → `USER_CUSTOM_RULES.md` (workspace root)

Only if you have project-specific constraints.

### 3. Optional: Setup VS Code Tasks (if missing)
Copy: `.github/templates/tasks.json` → `.vscode/tasks.json`

If `.vscode/tasks.json` doesn't exist. (Orchestrator can work without it, but improves validation output.)

### 4. Start Migration
In VS Code chat:
```
@agents migration-orchestrator
```

Or: Call orchestrator with "start migration"

## What Happens

```
Phase 1 (Auto): Discovery & Planning
├─ Read config
├─ Check for custom rules
├─ Start MCP servers
├─ Fetch & expand documentation
├─ Create MIGRATION_PROGRESS.md plan
└─ Wait for your "start" command

Phase A (With Pauses): Pre-migration Tasks
├─ Execute each task one by one
├─ Fetch fresh docs for each task
├─ Validate: build → lint → test
└─ Halt after each task for "next"

Phase B: Core Upgrade
├─ Ask: "Ready? (yes/manual/no)"
├─ Execute or provide checklist
└─ Record evidence

Phase C: Post-Migration
├─ Fix all errors
├─ Migrate PrimeNG (if used)
├─ Migrate Nx (if used)
├─ Final validation
└─ Generate summary
```

## Commands During Migration

| Command | Meaning |
|---------|---------|
| `next` | Proceed to next task |
| `continue` | Same as next (default) |
| `SKIP~3` | Skip next 3 tasks |
| `review` | Show progress so far |
| `retry` | Retry last command |
| `no` | Don't proceed (defer) |
| `yes` | Proceed (Phase B core upgrade) |
| `manual` | You execute (Phase B core upgrade) |

## Check Progress Anytime

Open: `MIGRATION_PROGRESS.md`

It contains:
- Current phase and step
- All completed tasks
- All errors encountered
- What changed in files
- Next action

## If Interrupted

Orchestrator maintains state:
1. Read MIGRATION_PROGRESS.md
2. Find "Current Session Context"
3. Resume from first uncompleted step
4. Call orchestrator agent again

Everything picks up where you left off.

## Success Looks Like

```
✓ Phase 1: Discovery complete + plan approved
✓ Phase A: All tasks complete + build/lint/test PASS
✓ Phase B: Core upgrade complete
✓ Phase C: All errors fixed + PrimeNG/Nx migrated + build/lint/test PASS
✓ Ready for deployment
```

## Troubleshooting

### "I want different default for Phase B"
Edit `migration-config.json`:
```json
"phaseB": {
  "defaultOwnership": "developer"  // ← I execute instead of assistant
}
```

### "My project doesn't use PrimeNG"
Let orchestrator auto-detect. Phase C will mark PrimeNG [-] not applicable automatically.

### "I want to skip lint warnings"
Create `USER_CUSTOM_RULES.md` with:
```
### Lint Tolerance
- Allow warnings (only require errors = 0)
- Reason: Legacy project
```

### "Build is slow, want to defer validation"
Can't defer. Build/Lint/Test runs after every change (non-negotiable per rules).

### "Error persists after fix"
1. Review error in MIGRATION_PROGRESS.md error log
2. Understand root cause
3. Try different fix
4. Type `retry` to re-run validation
5. Orchestrator will document all attempts

## Files Structure

```
.github/
├── migration-config.json          ← FILL THIS IN (once)
├── MIGRATION_RULES.md              ← Rules (read-only)
├── agents/
│   └── orchestrator.agent.md       ← Main agent (runs migration)
└── templates/
    ├── tasks.json                  ← Copy to .vscode/tasks.json if missing
    └── USER_CUSTOM_RULES.template.md ← Copy to root if needed

[After Phase 1]
MIGRATION_PROGRESS.md               ← Created automatically (knowledge base)
```

## Need Help?

1. **Migration docs unclear?**  
   Type: `@agents migration-orchestrator` + ask question

2. **Error not understood?**  
   Review MIGRATION_PROGRESS.md error log for full context

3. **Process questions?**  
   Read: `.github/MIGRATION_RULES.md` (all rules explained)

4. **Custom rules needed?**  
   Copy template: `.github/templates/USER_CUSTOM_RULES.template.md`

---

**Ready?**  
1. Edit `.github/migration-config.json` (fill in target version)
2. Type: `@agents migration-orchestrator`
3. Follow prompts

That's all. Orchestrator handles the rest. 🚀
