# Migration-V6 Detailed Setup Guide

**Complete setup workflow with verification, folder structure, and first-run walkthrough.**

---

## Part 1: Prerequisites Verification

### Required Tools

**VS Code with GitHub Copilot**
```bash
# Verify VS Code is installed
code --version
# Output should be: X.X.X (at least version 1.80+)

# Verify GitHub Copilot Chat extension is installed
# In VS Code: Extensions panel (Ctrl+Shift+X)
# Search: "GitHub Copilot Chat"
# Status: Should show "Installed"
```

**Git Repository**
```bash
# Verify you're in a git repository with OneCX app
cd /path/to/your/onecx-app
git status
# Output should show: "On branch feature-branch"
# NOT on main/master (create feature branch if needed)

# Create feature branch if needed
git checkout -b angular-19-migration
git pull origin main --ff-only
```

**npm and Node.js**
```bash
# Verify npm is installed
npm --version
# Output: v18.0.0 or higher

# Verify Node.js version
node --version
# Output: v20.0.0 or higher

# Install dependencies
npm install
```

**OneCX Repository Structure**
```bash
# Verify OneCX app structure exists
ls -la
# Should see: package.json, nx.json (if Nx app), src/, angular.json, etc.
```

---

## Part 2: Choose Setup Option

### **Option 1: Copy to Your Repository** ⭐ RECOMMENDED

**Best for**: Team collaboration, CI/CD integration

**Step 1: Prepare folder in your repo**
```bash
# From your OneCX app root directory
mkdir -p .github/migration-v6

echo "Created: .github/migration-v6/"
```

**Step 2: Copy migration-v6 files**
```bash
# Copy from docs-onecx to your repo
# Windows (PowerShell):
Copy-Item -Path "path/to/docs-onecx/migration-v6/agents" `
          -Destination ".github/migration-v6/agents" -Recurse
Copy-Item -Path "path/to/docs-onecx/migration-v6/templates" `
          -Destination ".github/migration-v6/templates" -Recurse
Copy-Item -Path "path/to/docs-onecx/migration-v6/docs" `
          -Destination ".github/migration-v6/docs" -Recurse

# OR Linux/macOS (bash):
cp -r path/to/docs-onecx/migration-v6/agents .github/migration-v6/
cp -r path/to/docs-onecx/migration-v6/templates .github/migration-v6/
cp -r path/to/docs-onecx/migration-v6/docs .github/migration-v6/
```

**Step 3: Verify folder structure**
```bash
# You should see:
.github/migration-v6/
  ├── agents/
  │   ├── migration-orchestrator-v6.agent.md
  │   ├── migration-planner-v6.agent.md
  │   └── migration-executor-v6.agent.md
  ├── templates/
  │   ├── MIGRATION_PROGRESS.template.md
  │   └── README.md
  └── docs/
      ├── AGENT-RULES.md
      ├── HARD-RULES.md
      ├── VERSION-AWARE-UPGRADE-PROTOCOL.md
      └── ... (12+ documentation files)

# Verify (Linux/macOS):
find .github/migration-v6 -type f | wc -l
# Should show: 18+ files

# Verify (Windows PowerShell):
(Get-ChildItem -Path ".github/migration-v6" -Recurse -File).Count
# Should show: 18+ files
```

**Step 4: Commit to git**
```bash
git add .github/migration-v6
git commit -m "Add migration-v6 tools"
git push origin angular-19-migration
```

**Result**: ✅ Agents accessible in VS Code Copilot Chat

---

### **Option 2: Copy to VS Code User Prompts** (Personal)

**Best for**: Individual developer, personal machine

**Step 1: Determine your VS Code config directory**

```bash
# Windows:
# %APPDATA%\Code\User\globalStorage\github.copilot\prompts\

# macOS:
# ~/.config/Code/User/globalStorage/github.copilot/prompts/

# Linux:
# ~/.config/Code/User/globalStorage/github.copilot/prompts/

# Verify directory exists:
# Windows PowerShell:
Test-Path "$env:APPDATA\Code\User\globalStorage\github.copilot\prompts"

# macOS/Linux:
ls ~/.config/Code/User/globalStorage/github.copilot/prompts
```

**Step 2: Copy migration-v6 folder**

```bash
# Windows PowerShell:
Copy-Item -Path "path/to/docs-onecx/migration-v6" `
          -Destination "$env:APPDATA\Code\User\globalStorage\github.copilot\prompts\migration-v6" `
          -Recurse

# macOS/Linux bash:
cp -r path/to/docs-onecx/migration-v6 \
      ~/.config/Code/User/globalStorage/github.copilot/prompts/migration-v6
```

**Step 3: Restart Copilot Chat**

```
VS Code menu: View → Command Palette → "Copilot: Clear chat history"
Then: Reload window (Ctrl+R or Cmd+R)
```

**Result**: ✅ Agents available as slash commands (`@migration-orchestrator-v6`, etc.)

---

### **Option 3: Use from Docs Folder** (Shared Access)

**Best for**: Documentation reference, minimal copying

**Prerequisites**:
```bash
# Clone docs-onecx repo if not already present
git clone https://github.com/onecx/docs-onecx.git

# Navigate to migration-v6
cd docs-onecx/migration-v6
```

**How to use**:
1. In VS Code, open your OneCX app workspace
2. Create symbolic link (Option A) or use relative path (Option B)

**Option 3A: Create Symbolic Link**
```bash
# From your repo root
mkdir -p .github
cd .github

# Windows (PowerShell - Run as Admin):
New-Item -ItemType SymbolicLink -Name migration-v6 `
         -Target "path/to/docs-onecx/migration-v6"

# macOS/Linux:
ln -s path/to/docs-onecx/migration-v6 migration-v6

# Verify:
ls -la migration-v6
# Should show arrow pointing to actual folder
```

**Option 3B: Reference in Copilot Chat**
```
When asked to use agents, provide full path:
@/full/path/to/docs-onecx/migration-v6/agents/migration-orchestrator-v6

(Not recommended - use Option 1 or 2 instead)
```

**Result**: ✅ Agents reference shared folder (no duplication)

---

## Part 3: Folder Structure Explanation

### What Gets Copied & Why

```
.github/migration-v6/
│
├── agents/                                    # 3 agents, 2000+ lines
│   ├── migration-orchestrator-v6.agent.md     # Router & state manager
│   ├── migration-planner-v6.agent.md          # Task discovery & doc fetching
│   └── migration-executor-v6.agent.md         # Task execution & validation
│
├── templates/                                 # State file templates
│   ├── MIGRATION_PROGRESS.template.md         # Copy to repo as MIGRATION_PROGRESS.md
│   └── README.md                              # Quick start guide
│
└── docs/                                      # Reference documentation, 3500+ lines
    ├── AGENT-RULES.md                         # When agents ask, ambiguity rule
    ├── HARD-RULES.md                          # 20 non-negotiable constraints
    ├── NEVER-SKIP-ALWAYS-FIX-PROTOCOL.md      # Task completion rules
    ├── VERSION-AWARE-UPGRADE-PROTOCOL.md      # Version handling, ^X→stable
    ├── MULTI-PHASE-ERROR-TRACKING.md          # Phase A vs C error handling
    ├── EXECUTOR-PHASE-SUPPORT.md              # Phase behavior overview
    ├── RUNTIME-DISCOVERY-PIPELINE.md          # Doc discovery process
    ├── CONTEXT-PRESERVATION-MANDATE.md        # State maintenance
    ├── REAL-WORLD-FINDINGS.md                 # 10 real issues & fixes
    ├── V6-REAL-WORLD-IMPROVEMENTS.md          # V6 quality improvements
    ├── V2-V3-BORROWING-PLAN.md                # Design patterns from v2/v3
    └── SKIP-FUNCTIONALITY.md                  # Skip~N command reference
```

### Agent Files Explained

**migration-orchestrator-v6.agent.md** (Router)
- Invokes other agents in sequence
- Manages MIGRATION_PROGRESS.md state
- Handles skip~N commands
- Entry point for all migrations
- Size: ~800 lines

**migration-planner-v6.agent.md** (Planner)
- Reads OneCX documentation via MCP
- Expands all links (strict doc expansion)
- Creates task tree for Phase 1
- Size: ~600 lines

**migration-executor-v6.agent.md** (Executor)
- Executes ONE task per invocation
- Collects evidence (dependencies, files changed)
- Handles errors with fix protocol
- Version-aware upgrades with permission gates
- Size: ~600 lines

---

## Part 4: Create State File

### Step 1: Copy template

```bash
# From your repo root
cp .github/migration-v6/templates/MIGRATION_PROGRESS.template.md MIGRATION_PROGRESS.md

# Verify
ls -la MIGRATION_PROGRESS.md
# Should show: file size ~2-3 KB
```

### Step 2: Review initial state

```bash
# Open file
cat MIGRATION_PROGRESS.md

# Should show:
# - Section 1: [Phase 1 - Dependency Discovery] with [ ] tasks
# - Section 2: [Phase A - Upgrade Dependencies] with [ ] tasks
# - Section 3: [Phase B - Manual Developer] with [ ] tasks
# - Section 4: [Phase C - Post-Migration Cleanup] with [ ] tasks
```

### Step 3: Update repo context (Optional)

```bash
# Edit MIGRATION_PROGRESS.md header:
# - Target Angular version: 19
# - Target Nx version: 20 (if applicable)
# - Baseline build status: [your current status]

git add MIGRATION_PROGRESS.md
git commit -m "Create migration progress file"
```

---

## Part 5: Verify Setup in VS Code

### Method 1: Check Copilot Chat Agent Discovery

**Step 1**: Open VS Code with your OneCX repo
```bash
code /path/to/your-onecx-app
```

**Step 2**: Open Copilot Chat
```
Ctrl+Shift+L (or View → Copilot Chat)
```

**Step 3**: Type agent name
```
@migration-orchestrator-v6
```

**Expected Result**: 
- Agent appears in dropdown list
- Shows description: "Execute ONE Angular 19 migration task per invocation..."

### Method 2: Check Folder Permissions

```bash
# Verify agents folder is readable
ls -la .github/migration-v6/agents/

# All files should show: r-- (readable)
# If not: chmod +r .github/migration-v6/agents/*.md

# Verify templates folder
ls -la MIGRATION_PROGRESS.md
# Should show: file exists and readable
```

### Method 3: Verify File Contents

```bash
# Check orchestrator agent exists and has content
head -20 .github/migration-v6/agents/migration-orchestrator-v6.agent.md
# Should show: YAML frontmatter with name, description, argument-hint

# Check executor agent version protocol
grep -n "Version-Aware Upgrade Protocol" .github/migration-v6/agents/migration-executor-v6.agent.md
# Should find match at line ~350+
```

---

## Part 6: Troubleshooting

### Agent Not Appearing in Dropdown

**Problem**: Typing `@migration-orchestrator-v6` doesn't show agent

**Solution 1: Check folder path**
```bash
# Verify exact folder structure
find .github/migration-v6 -name "*.agent.md" -type f

# Should show 3 files:
# .github/migration-v6/agents/migration-orchestrator-v6.agent.md
# .github/migration-v6/agents/migration-planner-v6.agent.md
# .github/migration-v6/agents/migration-executor-v6.agent.md
```

**Solution 2: Clear Copilot cache**
```
View → Command Palette → "Copilot: Clear chat history"
Wait 5 seconds
Reload window (Ctrl+R)
```

**Solution 3: Verify file format**
```bash
# Check first line of agent file
head -1 .github/migration-v6/agents/migration-orchestrator-v6.agent.md
# Should show: ---

# Check agent name is in file
grep "^name:" .github/migration-v6/agents/migration-orchestrator-v6.agent.md
# Should show: name: migration-orchestrator-v6
```

### Permission Denied Errors

```bash
# Make all .md files readable
chmod +r .github/migration-v6/**/*.md

# Make all folders traversable
chmod +x .github/migration-v6 .github/migration-v6/agents .github/migration-v6/docs .github/migration-v6/templates
```

### MIGRATION_PROGRESS.md Not Found

```bash
# Verify file exists and is in repo root
ls -la MIGRATION_PROGRESS.md

# If missing, recreate from template
cp .github/migration-v6/templates/MIGRATION_PROGRESS.template.md MIGRATION_PROGRESS.md

# Commit it
git add MIGRATION_PROGRESS.md
git commit -m "Add migration progress file"
```

---

## Part 7: First-Run Walkthrough

### Step 1: Verify Everything Works

```bash
# Terminal in VS Code
npm run build    # Should succeed with baseline
npm run lint     # Check current lint status
npm run test     # Record baseline test count
```

### Step 2: Start Orchestrator Agent

1. Open **Copilot Chat** (Ctrl+Shift+L)
2. Type: `@migration-orchestrator-v6`
3. Select agent from dropdown
4. Send message: `"Start Phase 1"`

**Expected Output**:
```
Starting Phase 1: Dependency Discovery

Reading OneCX documentation...
Found X tasks to complete:
- [ ] Task 1: Update @angular/core...
- [ ] Task 2: Update @nrwl/nx...
...

MIGRATION_PROGRESS.md updated with all Phase 1 tasks.
Next step: Continue to Phase A (automatic upgrades) or wait for manual review.
```

### Step 3: Check Progress File

```bash
# View current state
cat MIGRATION_PROGRESS.md | head -50

# Should show:
# [x] or [ ] markers for Phase 1 tasks
# Evidence fields for each completed task
```

### Step 4: Execute First Task

1. Open **Copilot Chat**
2. Type: `@migration-executor-v6`
3. Send message: `"Continue execution"`

**Expected Output**:
```
Executing: [Task 1] Update @angular/core to 19.x

Step 1: Read MIGRATION_PROGRESS.md
Step 2: Fetch documentation
Step 3: Parse version requirements
Step 4: Check repository context
Step 5: Ask permission...

"Should I proceed with core upgrade?
Default: Yes
Current: @angular/core ^18.5.0 → Target: 19.2.1"
```

**If you see permission prompt**:
- Type: `yes` to proceed with upgrade
- OR: `no` to get manual instructions

---

## Part 8: Quick Reference

### Commands by Phase

**Phase 1 (Discovery)**
```
@migration-orchestrator-v6
"Start Phase 1"
```

**Continue Execution**
```
@migration-executor-v6
"Continue execution"
```

**Skip N tasks**
```
@migration-orchestrator-v6
"Skip~3"
```

**Check Status**
```
@migration-orchestrator-v6
"Show status"
```

### Key Files Location

| File | Purpose | Location |
|------|---------|----------|
| MIGRATION_PROGRESS.md | State file (single source of truth) | Repo root |
| Agents | Executable migration logic | .github/migration-v6/agents/ |
| Docs | Reference documentation | .github/migration-v6/docs/ |
| Templates | Initial templates | .github/migration-v6/templates/ |

### Documentation by Topic

| Topic | File | Read Time |
|-------|------|-----------|
| Agent behavior | AGENT-RULES.md | 5 min |
| Version handling | VERSION-AWARE-UPGRADE-PROTOCOL.md | 15 min |
| Error handling | MULTI-PHASE-ERROR-TRACKING.md | 10 min |
| All constraints | HARD-RULES.md | 10 min |

---

## Part 9: Workflow Overview

```
1. VERIFY SETUP
   └─ npm run build     (baseline)
   └─ @migration-orchestrator-v6 appears in Copilot Chat
   └─ MIGRATION_PROGRESS.md exists

2. START PHASE 1 (Discovery)
   └─ @migration-orchestrator-v6 "Start Phase 1"
   └─ Agents read OneCX docs
   └─ Tasks created in MIGRATION_PROGRESS.md

3. EXECUTE PHASE A (Auto Upgrades)
   └─ @migration-executor-v6 "Continue execution"
   └─ Per task: Ask permission → Execute if yes → Document if no
   └─ npm run build/lint/test after each task
   └─ Continue until all Phase A complete

4. PHASE B (Manual Developer)
   └─ You run: npm run build, npm run lint, npm run test
   └─ Fix any remaining errors
   └─ Mark Phase B complete in MIGRATION_PROGRESS.md

5. EXECUTE PHASE C (Post-Migration Cleanup)
   └─ @migration-executor-v6 "Continue execution"
   └─ Complete all cleanup tasks
   └─ Build errors expected (will fix in Phase C post-validation)

6. PHASE C POST-VALIDATION
   └─ Final: npm run build, npm run lint, npm run test
   └─ Review recorded errors from earlier Phase C tasks
   └─ Verify all errors now fixed
   └─ Update MIGRATION_PROGRESS.md with final status
```

---

## Next Steps

1. **Complete Setup**: Follow Part 2 for your chosen option
2. **Verify Setup**: Follow Part 5 verification steps
3. **Read Documentation**: [USAGE.md](./USAGE.md) - Complete usage guide
4. **Start Migration**: Run Phase 1 discovery (Part 7, Step 2)

**Questions?** Check [INDEX.md](./INDEX.md) for documentation map
