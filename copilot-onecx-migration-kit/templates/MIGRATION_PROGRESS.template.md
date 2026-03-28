# MIGRATION_PROGRESS

## Context
- Project: `<project-name>`
- Goal: OneCX-specific preparation and finalization for Angular 18 to 19 migration
- Core Angular framework upgrade: `NOT executed`
- Date: `<yyyy-mm-dd>`

## Documentation Sources (with enforcement)
- OneCX source:
- PrimeNG source:
- Nx source:

### Relevant documentation harvested
- OneCX pre-migration pages:
- OneCX Nx page:
- OneCX post-migration pages:
- PrimeNG pages:
- Nx pages:

---

## Phase 1 - Initialization and Planning

### 1) Dependency and Test Audit
- [ ] Run dependency install
  - Source pages:
  - Summary:
  - Repository evidence:
  - Files changed:
  - Validation:
  - Edge Cases or Issues:

- [ ] Run tests
  - Source pages:
  - Summary:
  - Repository evidence:
  - Files changed:
  - Validation:
  - Edge Cases or Issues:

### 2) Branch Protection
- [ ] Check branch
  - Source pages:
  - Summary:
  - Repository evidence:
  - Files changed:
  - Validation:
  - Edge Cases or Issues:

### 3) Coverage Audit
- [ ] Capture baseline coverage
  - Source pages:
  - Summary:
  - Repository evidence:
  - Files changed:
  - Validation:
  - Edge Cases or Issues:

### 4) Instructions Audit
- [ ] Read Copilot instructions
  - Source pages:
  - Summary:
  - Repository evidence:
  - Files changed:
  - Validation:
  - Edge Cases or Issues:

### 5) Task Configuration Audit
- [ ] Verify build, lint, and test tasks
  - Source pages:
  - Summary:
  - Repository evidence:
  - Files changed:
  - Validation:
  - Edge Cases or Issues:

### 6) Detailed migration plan creation
- [ ] Plan created
  - Source pages:
  - Summary:
  - Repository evidence:
  - Files changed:
  - Validation:
  - Edge Cases or Issues:

### 7) Plan review
- [ ] Reviewed for ordering ambiguity
  - Source pages:
  - Summary:
  - Repository evidence:
  - Files changed:
  - Validation:
  - Edge Cases or Issues:

---

## Workspace Discovery Before Code Changes

- [ ] Full workspace search completed
  - Source pages:
  - Summary:
  - Repository evidence:
  - Files changed:
  - Validation:
  - Edge Cases or Issues:

---

## Ordered Execution Plan (OneCX + PrimeNG + Nx)

### Hierarchy Rules for This File

- Parent task IDs use the format `A.3`
- Child task IDs use the format `A.3.1`
- Grandchild task IDs use the format `A.3.1.a`
- Execute only unresolved leaf tasks
- Parent tasks are completion containers and summaries
- A parent task may be marked `[x] completed` only when all executable children are `[x] completed` or `[-] not applicable`

## Phase A - Pre-Migration

- [ ] A.1 OneCX pre-step: Remove `@onecx/keycloak-auth`
  - Dependencies:
  - Source pages:
  - Summary:
  - Repository evidence:
  - Files changed:
  - Validation:
  - Edge Cases or Issues:
  - Expand into child tasks during planning:
    - `A.1.1` Update packages
    - `A.1.2` Update module imports
    - `A.1.3` Check whether `keycloak-js` is still required

- [ ] A.2 OneCX pre-step: Update component imports
  - Dependencies:
  - Source pages:
  - Summary:
  - Repository evidence:
  - Files changed:
  - Validation:
  - Edge Cases or Issues:
  - Expand into child tasks during planning:
    - `A.2.1` Move imports from `@onecx/portal-integration-angular` to `@onecx/angular-accelerator`
    - `A.2.2` Move imports from `@onecx/portal-integration-angular` to `@onecx/angular-utils`
    - `A.2.3` Move imports from `@onecx/portal-integration-angular` to `@onecx/shell-core`
    - `A.2.4` Move imports from `@onecx/angular-accelerator` to `@onecx/angular-utils`
    - `A.2.5` Remove deleted APIs from `@onecx/angular-accelerator`
    - `A.2.6` Remove deleted APIs from `@onecx/angular-integration-interface`
    - `A.2.7` Remove deleted APIs from `@onecx/portal-integration-angular`
    - `A.2.8` Replace same-library helper imports and usages
    - `A.2.9` Handle remote-component migrations if used

- [ ] A.3 OneCX pre-step: Replace removed components
  - Dependencies:
  - Source pages:
  - Summary:
  - Repository evidence:
  - Files changed:
  - Validation:
  - Edge Cases or Issues:
  - Treat this as a parent task:
    - `A.3.1` Replace `DataViewControlsComponent` with `InteractiveDataViewComponent`
    - `A.3.2` Replace `PageContentComponent` with `OcxContentComponent` or `OcxContentContainerComponent`
    - `A.3.3` Replace `SearchCriteriaComponent` with `SearchHeaderComponent`
    - `A.3.4` Replace `ButtonDialogComponent` with `OcxDialogInlineComponent`

- [ ] A.4 OneCX pre-step: Adjust webpack shared package config
  - Dependencies:
  - Source pages:
  - Summary:
  - Repository evidence:
  - Files changed:
  - Validation:
  - Edge Cases or Issues:

- [ ] A.5 OneCX pre-step: Adjust standalone mode
  - Dependencies:
  - Source pages:
  - Summary:
  - Repository evidence:
  - Files changed:
  - Validation:
  - Edge Cases or Issues:
  - Expand into child tasks during planning:
    - `A.5.1` Update standalone-mode packages
    - `A.5.2` Update standalone-mode imports and providers

- [ ] A.6 OneCX pre-step: Remove `MenuService` usage
  - Dependencies:
  - Source pages:
  - Summary:
  - Repository evidence:
  - Files changed:
  - Validation:
  - Edge Cases or Issues:

- [ ] A.7 OneCX pre-step: Update translation path and provider setup
  - Dependencies:
  - Source pages:
  - Summary:
  - Repository evidence:
  - Files changed:
  - Validation:
  - Edge Cases or Issues:
  - Expand into child tasks during planning:
    - `A.7.1` Update translation-related imports
    - `A.7.2` Replace `translationPathFactory` with `provideTranslationPathFromMeta`
    - `A.7.3` Replace `remoteComponentTranslationPathFactory` with `provideTranslationPathFromMeta`
    - `A.7.4` Configure translation providers for remote components
    - `A.7.5` Verify webpack `importMeta` compatibility

- [ ] A.8 Pre-handover package preparation
  - Dependencies:
  - Source pages:
  - Summary:
  - Repository evidence:
  - Files changed:
  - Validation:
  - Edge Cases or Issues:

- [ ] A.9 Nx migration branch
  - Dependencies:
  - Source pages:
  - Summary:
  - Repository evidence:
  - Files changed:
  - Validation:
  - Edge Cases or Issues:
  - Expand into child tasks only if this is an Nx workspace:
    - `A.9.1` Update `@onecx/nx-plugin`
    - `A.9.2` Update Nx packages with the documented fixed version
    - `A.9.3` Update package versions in `package.json`
    - `A.9.4` Run `nx migrate --run-migrations`

## Phase B - Handover and Commit

- [ ] Commit all pre-migration changes
  - Source pages:
  - Summary:
  - Repository evidence:
  - Files changed:
  - Validation:
  - Edge Cases or Issues:

- [ ] Ensure clean working tree
  - Source pages:
  - Summary:
  - Repository evidence:
  - Files changed:
  - Validation:
  - Edge Cases or Issues:

- [ ] Provide upgrade cheat sheet and explicit next developer actions
  - Source pages:
  - Summary:
  - Repository evidence:
  - Files changed:
  - Validation:
  - Edge Cases or Issues:

## Phase C - Post-Migration and Finalization

- [ ] Apply documented post-migration steps
  - Source pages:
  - Summary:
  - Repository evidence:
  - Files changed:
  - Validation:
  - Edge Cases or Issues:
  - Expand into child tasks during planning:
    - `C.1` Required package updates
    - `C.2` Update `FilterType` values
    - `C.3` Update `ConfigurationService` usage
    - `C.4` Update component imports after migration
    - `C.5` Update `PortalApiConfiguration`
    - `C.6` Remove `@onecx/portal-layout-styles`
    - `C.7` Remove `addInitializeModuleGuard()`
    - `C.8` Remove `PortalCoreModule`
    - `C.9` Replace `BASE_URL`
    - `C.10` Update theme service usage
    - `C.11` Add Webpack plugin for PrimeNG
    - `C.12` Add Webpack plugin for Angular Material
    - `C.13` Provide `ThemeConfig`
  - Known parent tasks that usually need children:
    - `C.6` Remove `@onecx/portal-layout-styles`
    - `C.8` Remove `PortalCoreModule`
    - `C.9` Replace `BASE_URL`
    - `C.13` Provide `ThemeConfig`

- [ ] Validate build, lint, and test after post-migration work
  - Source pages:
  - Summary:
  - Repository evidence:
  - Files changed:
  - Validation:
  - Edge Cases or Issues:

- [ ] Compare post-migration coverage vs baseline
  - Source pages:
  - Summary:
  - Repository evidence:
  - Files changed:
  - Validation:
  - Edge Cases or Issues:

---

## Current Status Snapshot
- Phase 1:
- Phase A progress:
- Next active step:
