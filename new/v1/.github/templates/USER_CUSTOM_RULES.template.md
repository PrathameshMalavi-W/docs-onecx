# USER_CUSTOM_RULES.md

**Purpose**: Override default migration rules with project-specific constraints.

**Location**: Workspace root (`d:\onecx\Ahe\USER_CUSTOM_RULES.md`)

**If this file exists**, orchestrator will:
1. Read it at session start
2. Apply these rules instead of defaults
3. Record all custom rules in MIGRATION_PROGRESS.md
4. Update config and agent behavior accordingly

## Example Custom Rules

### Relaxed Lint Requirements
```
## Custom Rules

### Lint Tolerance
- Allow up to 5 warnings (instead of 0)
- Critical only for errors (must be 0)
- Reason: Legacy code warnings acceptable for MVP
```

### Build Configuration
```
### Build Environment
- CI environment: false (use development build settings)
- Coverage not required (skip coverage comparison)
- Reason: Running on developer machine, not CI/CD
```

### Package Version Overrides
```
### Package Constraints
- @onecx/portal-integration: MUST stay at ^4.x (cannot upgrade to ^5)
- Reason: Breaking changes in v5 not compatible with app
```

### Phase Skipping
```
### Phase Decisions
- Skip PrimeNG migration (not used in project)
- Skip Nx migration (using standalone Angular)
- Reason: Verified with package.json
```

### MCP Server Configuration
```
### Documentation Sources
- Disable: primeng MCP (use direct URLs instead)
- Disable: nx MCP (not needed)
- Reason: Faster to use fallback URLs
```

### Developer Ownership
```
### Phase B Ownership Default
- Change default to: developer (not assistant)
- Reason: Developer wants to execute core upgrade manually
```

### Error Handling
```
### Error Tolerance
- Accept TypeScript strict mode errors if documented
- Reason: Migrating incrementally, strict mode later
```

## Template

Copy and modify for your project:

```markdown
# Custom Rules for [Project Name]

## Section: [Rule Category]

- Rule: [Description]
- Override: [What changes from default]
- Reason: [Why this is needed]

---

## Section: [Another Category]

- Rule: [Description]
- Override: [What changes]
- Reason: [Why]
```

## Notes

- These rules are read at session START only
- If you add/change rules mid-migration, restart the orchestrator
- All custom rules recorded in MIGRATION_PROGRESS.md Decision Log
- Custom rules override defaults (higher precedence)

## When to Create This File

You probably need custom rules if:
- ✓ Your project has lint/test/build tolerances
- ✓ You can't upgrade certain packages
- ✓ Your project uses custom MCP servers
- ✓ You want different default ownership (Phase B)
- ✓ You're skipping certain migration steps (PrimeNG, Nx)

Leave this file EMPTY or DELETE IT if:
- Your project follows default migration rules
- You want orchestrator to auto-detect everything
