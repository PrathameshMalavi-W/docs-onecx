# Migration-V6 Setup (5 Minutes)

**Minimal setup. No configuration files. Copy and go.**

---

## What You Need

- VS Code with Copilot Chat
- OneCX app repository
- Feature branch (not main/master)
- npm installed locally

---

## Setup Steps (Choose One)

### Option 1: Copy to Your Repo (Recommended)

```bash
# From your repo root
mkdir -p .github/migration-v6

# Copy agents folder
cp -r migration-v6/agents .github/migration-v6/

# Copy templates folder  
cp -r migration-v6/templates .github/migration-v6/

# Done. Ready to use.
```

### Option 2: Copy to VS Code User Prompts (Personal)

```bash
# Windows
cp -r migration-v6 "%APPDATA%\Code\User\prompts\onecx-migration-v6"

# OR macOS/Linux
cp -r migration-v6 ~/.config/Code/User/globalStorage/github.copilot/prompts/onecx-migration-v6

# Agent files become slash commands in Copilot Chat
```

### Option 3: Use from Docs Folder

```bash
# Reference agents directly from docs-onecx repo
# (agents auto-discover template location)

# No copying needed.
```

---

## Verify Setup

In VS Code Copilot Chat, type:

```
@migration-orchestrator-v6
```

**Expected**: Agent appears in dropdown

If not:
- Agents are in wrong folder (check absolute path)
- Restart Copilot Chat (`Ctrl+Shift+P` > "Copilot > Clear chat history")
- Reload VS Code window

---

## That's It

No config files. No environment variables. No database.

**Next**: Read [USAGE.md](./USAGE.md)
