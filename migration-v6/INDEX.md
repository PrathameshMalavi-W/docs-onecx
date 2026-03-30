# Migration-V6 Index

**OneCX Angular 18 → 19 Migration System**  
**Minimal design | Maximum autonomy | Full evidence**

---

## 📖 Start Here

**New to migration-v6?** Start in this order:
1. [README.md](README.md) — 5-min overview, design principles
2. [PHASE-1-INTEGRATION-SUMMARY.md](PHASE-1-INTEGRATION-SUMMARY.md) — What was added from v2/v3 patterns
3. [SETUP.md](SETUP.md) — Choose setup option, verify
4. [USAGE.md](USAGE.md) — Commands, skip~N, error handling, **phase gates**
5. [templates/README.md](templates/README.md) — Full 30-min workflow

**Experienced?** Jump to [USAGE.md](USAGE.md) and run: `@migration-orchestrator-v6 "Start Phase 1"`

---

## 🤖 Agent Files

Located in `agents/`:
- [migration-orchestrator-v6.agent.md](agents/migration-orchestrator-v6.agent.md) — Router, skip handler, state manager
- [migration-planner-v6.agent.md](agents/migration-planner-v6.agent.md) — Phase 1 planning, task discovery
- [migration-executor-v6.agent.md](agents/migration-executor-v6.agent.md) — Task execution, evidence collection

**Agent count**: 3 (minimal design)  
**Delegation pattern**: Orchestrator routes → Planner discovers → Executor executes

---

## 📋 Templates

Located in `templates/`:
- [MIGRATION_PROGRESS.template.md](templates/MIGRATION_PROGRESS.template.md) — State file (Phase 1/A/B/C sections)
- [README.md](templates/README.md) — Quick start guide (copy into template/)

Use template to create `MIGRATION_PROGRESS.md` in your repo.

---

## 📚 Documentation

Located in `docs/`:

| Doc                                                                         | Topic                                  | When to use                                                               |
| --------------------------------------------------------------------------- | -------------------------------------- | ------------------------------------------------------------------------- |
| [AGENT-RULES.md](docs/AGENT-RULES.md)                                       | Core behavior contract                 | Understanding agent limits & when agents ask users                        |
| [HARD-RULES.md](docs/HARD-RULES.md)                                         | Non-negotiable constraints (H1–H20)    | Understanding mandatory safety guardrails                                 |
| [NEVER-SKIP-ALWAYS-FIX-PROTOCOL.md](docs/NEVER-SKIP-ALWAYS-FIX-PROTOCOL.md) | Task completion & error-fixing rules   | Executor must complete tasks and fix all errors                           |
| [MULTI-PHASE-ERROR-TRACKING.md](docs/MULTI-PHASE-ERROR-TRACKING.md)         | Phase-specific error handling          | Pre-migration vs post-migration error tracking                            |
| [EXECUTOR-PHASE-SUPPORT.md](docs/EXECUTOR-PHASE-SUPPORT.md)                 | Executor phase behavior overview       | Understand Phase A/B/C error handling differences                         |
| [VERSION-AWARE-UPGRADE-PROTOCOL.md](docs/VERSION-AWARE-UPGRADE-PROTOCOL.md) | Version resolution & upgrade execution | How executor handles ^X→stable, MCP-first fetching, user permission gates |
| [RUNTIME-DISCOVERY-PIPELINE.md](docs/RUNTIME-DISCOVERY-PIPELINE.md)         | 7-stage doc discovery process          | Understanding how planner builds task tree                                |
| [CONTEXT-PRESERVATION-MANDATE.md](docs/CONTEXT-PRESERVATION-MANDATE.md)     | How agents maintain state              | Preventing lazy context loss                                              |
| [REAL-WORLD-FINDINGS.md](docs/REAL-WORLD-FINDINGS.md)                       | Issues from actual migrations          | Understanding what failed and why                                         |
| [V6-REAL-WORLD-IMPROVEMENTS.md](docs/V6-REAL-WORLD-IMPROVEMENTS.md)         | How V6 addresses real-world issues     | Quality improvements in v6                                                |
| [V2-V3-BORROWING-PLAN.md](docs/V2-V3-BORROWING-PLAN.md)                     | Patterns borrowed from v2/v3           | Understanding v6 architecture decisions                                   |
| [SKIP-FUNCTIONALITY.md](docs/SKIP-FUNCTIONALITY.md)                         | Skip~N command                         | Using skip~N to advance quickly                                           |
| [STRICT-DOC-EXPANSION.md](docs/STRICT-DOC-EXPANSION.md)                     | No-assumption rule                     | Understanding why planner fetches all links                               |

---

## ⚡ Quick Commands

```bash
# Start planning
@migration-orchestrator-v6
"Start Phase 1"

# Execute one task
@migration-orchestrator-v6
"Continue execution"

# Skip N tasks
@migration-orchestrator-v6
"Skip~3"

# Show current status
@migration-orchestrator-v6
"Status"

# Re-validate latest task
@migration-orchestrator-v6
"Validate"

# Get help
@migration-orchestrator-v6
"Help"
```

---

## 🎯 Workflow at a Glance

```
Phase 1 (Planning)
└─ Run: @orchestrator "Start Phase 1"
└─ Output: MIGRATION_PROGRESS.md with 30-50 tasks
└─ Time: ~5 min

Phase A (Pre-Migration Execution)
└─ Run: @orchestrator "Continue execution" [repeat N times]
└─ Each invocation: Execute 1 task, collect evidence, validate
└─ Time: 2-10 min per task

Phase B (Manual Sign-Off)
└─ You: npm build, npm lint, npm test locally
└─ You: Sign off in MIGRATION_PROGRESS.md

Phase C (Post-Migration Execution)
└─ Run: @orchestrator "Continue execution" [repeat M times]
└─ Each invocation: Execute 1 task, collect evidence, validate
└─ Time: 2-10 min per task

Total: 30-60 minutes (varies by repo size)
```

---

## 🔧 Setup Options

**Already set up?** Skip to [USAGE.md](USAGE.md)

### Option 1: Copy to repo (Recommended)
```bash
cp -r migration-v6 /path/to/repo/.copilot/
```
Agents auto-discovered in `.copilot/agents/`

### Option 2: Symlink from docs-onecx
```bash
ln -s /path/to/docs-onecx/migration-v6 /path/to/repo/.copilot/
```
Agents loaded from symlink

### Option 3: Reference externally
Add to `copilot-instructions.md`:
```markdown
Migration guide: /path/to/docs-onecx/migration-v6/

Agents:
- @migration-orchestrator-v6
- @migration-planner-v6
- @migration-executor-v6
```

See [SETUP.md](SETUP.md) for detailed instructions.

---

## 🆘 Troubleshooting

| Issue                     | Fix                                      | Docs                                                    |
| ------------------------- | ---------------------------------------- | ------------------------------------------------------- |
| npm install fails         | Fix dependency, retry Phase 1            | [USAGE.md](USAGE.md#troubleshooting)                    |
| Build warns but passes    | Still mark failing (0 warnings required) | [AGENT-RULES.md](docs/AGENT-RULES.md)                   |
| Not sure if task applies  | Run task, let executor decide            | [AGENT-RULES.md](docs/AGENT-RULES.md)                   |
| Want to skip complex task | Use Skip~N (carefully!)                  | [SKIP-FUNCTIONALITY.md](docs/SKIP-FUNCTIONALITY.md)     |
| Planner skipped a link    | Report issue, planner must visit all     | [STRICT-DOC-EXPANSION.md](docs/STRICT-DOC-EXPANSION.md) |

---

## ✨ Key Features

✅ **3-agent system** (minimal design)  
✅ **Strict doc expansion** (visit all links, no assumptions)  
✅ **Skip~N support** (skip up to N tasks, jump ahead)  
✅ **Evidence collection** (8 fields per task)  
✅ **Full validation** (npm build/lint/test required)  
✅ **Error handling** (capture, map, resolve)  
✅ **Phase gating** (manual sign-off at Phase B)  
✅ **One-task-per-run** (executor handles one, stops)  

---

## 📊 File Statistics

```
agents/              3 files  (~1.5K lines)
docs/                3 files  (~1.5K lines)
templates/           2 files  (~0.5K lines)
Root files           3 files  (~0.5K lines)
─────────────────────
Total              11 files  (~4K lines)
```

**Total documentation**: ~4,000 lines (comprehensive coverage)

---

## 🚀 First-Time Checklist

- [ ] Copy migration-v6 to `.copilot/` in repo
- [ ] Open VS Code Copilot Chat
- [ ] Type: `@migration-orchestrator-v6`
- [ ] Run: `"Start Phase 1"`
- [ ] Wait ~5 min for planning to complete
- [ ] Review generated `MIGRATION_PROGRESS.md`
- [ ] Run: `@migration-orchestrator-v6 "Continue execution"`
- [ ] Repeat until Phase A complete
- [ ] Manually run npm tests in Phase B
- [ ] Resume Phase C execution

**Estimated total time**: 30-60 minutes

---

## 📞 Reference

| Need                | Where                                                        |
| ------------------- | ------------------------------------------------------------ |
| Setup help          | [SETUP.md](SETUP.md)                                         |
| Command reference   | [USAGE.md](USAGE.md)                                         |
| Full workflow       | [templates/README.md](templates/README.md)                   |
| Agent behavior      | [docs/AGENT-RULES.md](docs/AGENT-RULES.md)                   |
| Skip explanation    | [docs/SKIP-FUNCTIONALITY.md](docs/SKIP-FUNCTIONALITY.md)     |
| Doc discovery rules | [docs/STRICT-DOC-EXPANSION.md](docs/STRICT-DOC-EXPANSION.md) |
| Design overview     | [README.md](README.md)                                       |

---

## 📝 Version Info

- **System**: Migration-V6
- **Release Date**: 2025-01-15
- **Angular Target**: 19.x
- **Components**: 3 agents, 11 docs/templates
- **Status**: ✅ Production Ready

---

**Ready?** Start with [SETUP.md](SETUP.md). Questions? See [USAGE.md](USAGE.md).
