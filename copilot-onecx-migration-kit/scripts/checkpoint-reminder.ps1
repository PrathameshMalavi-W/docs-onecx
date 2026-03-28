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
            'Migration checkpoint: re-read MIGRATION_PROGRESS.md before continuing migration work.'
        }
        else {
            'Migration checkpoint: if this is a migration session, create or refresh MIGRATION_PROGRESS.md before executing steps.'
        }
    }
    'PreCompact' {
        if ($hasProgress) {
            'Before context compaction, summarize the current step in MIGRATION_PROGRESS.md. On resume, re-read the file before continuing.'
        }
        else {
            'Before context compaction, create MIGRATION_PROGRESS.md if this session is doing migration work.'
        }
    }
    'Stop' {
        if ($hasProgress) {
            'Before ending the session, make sure MIGRATION_PROGRESS.md reflects the latest completed or unresolved step.'
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
