$ErrorActionPreference = 'Stop'

$rawInput = [Console]::In.ReadToEnd()
$payload = $null

if (-not [string]::IsNullOrWhiteSpace($rawInput)) {
    try {
        $payload = $rawInput | ConvertFrom-Json
    }
    catch {
        $payload = $null
    }
}

$cwd = $pwd.Path
$eventName = 'Unknown'

if ($payload) {
    if ($payload.cwd) {
        $cwd = $payload.cwd
    }
    if ($payload.hookEventName) {
        $eventName = $payload.hookEventName
    }
}

$progressPath = Join-Path $cwd 'MIGRATION_PROGRESS.md'
$hasProgress = Test-Path $progressPath

$message = switch ($eventName) {
    'SessionStart' {
        if ($hasProgress) {
            'Migration checkpoint: re-read MIGRATION_PROGRESS.md and continue from the next unresolved leaf task.'
        }
        else {
            'Migration checkpoint: discover the migration context at runtime and create MIGRATION_PROGRESS.md before executing migration steps.'
        }
    }
    'PreCompact' {
        if ($hasProgress) {
            'Before context compaction, ensure MIGRATION_PROGRESS.md reflects the latest leaf task and the next active leaf.'
        }
        else {
            'Before context compaction, create MIGRATION_PROGRESS.md if this session is doing migration work.'
        }
    }
    'Stop' {
        if ($hasProgress) {
            'Before stopping, ensure MIGRATION_PROGRESS.md records the latest state and any user-required next action.'
        }
        else {
            'Session stopped without MIGRATION_PROGRESS.md. Create one first if this was migration work.'
        }
    }
    default {
        'Migration checkpoint reminder.'
    }
}

$output = @{
    continue = $true
    systemMessage = $message
}

$output | ConvertTo-Json -Compress
