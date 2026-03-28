param(
    [Parameter(Mandatory = $true)]
    [string]$IndexFile,

    [string]$DocsRoot,

    [switch]$IncludeNestedXrefs
)

$ErrorActionPreference = 'Stop'

if (-not (Test-Path $IndexFile)) {
    throw "Index file not found: $IndexFile"
}

$indexPath = (Resolve-Path $IndexFile).Path

if (-not $DocsRoot) {
    $DocsRoot = Split-Path -Parent $indexPath
}

$docsRootPath = (Resolve-Path $DocsRoot).Path

function Get-XrefsFromFile {
    param(
        [string]$Path
    )

    $content = Get-Content $Path
    $matches = @()

    foreach ($line in $content) {
        $regexMatches = [regex]::Matches($line, 'xref:(?:\./)?([^\[\]#]+\.adoc)')
        foreach ($m in $regexMatches) {
            $matches += $m.Groups[1].Value
        }
    }

    $matches | Select-Object -Unique
}

function Get-HeadingsFromFile {
    param(
        [string]$Path
    )

    $content = Get-Content $Path
    foreach ($line in $content) {
        if ($line -match '^(=+)\s+(.+)$') {
            [pscustomobject]@{
                Level = $Matches[1].Length
                Heading = $Matches[2].Trim()
            }
        }
    }
}

$indexLinks = Get-XrefsFromFile -Path $indexPath

Write-Output "# Migration Outline"
Write-Output ""
Write-Output "- Index file: `$indexPath`"
Write-Output "- Docs root: `$docsRootPath`"
Write-Output ""
Write-Output "## Linked Pages"

foreach ($relativeLink in $indexLinks) {
    $linkedPath = Join-Path $docsRootPath $relativeLink

    if (-not (Test-Path $linkedPath)) {
        Write-Output "- Missing page: `$relativeLink`"
        continue
    }

    $resolvedLinkedPath = (Resolve-Path $linkedPath).Path
    Write-Output "- Page: `$relativeLink`"
    Write-Output "  - Full path: `$resolvedLinkedPath`"

    $headings = Get-HeadingsFromFile -Path $resolvedLinkedPath
    if ($headings) {
        Write-Output "  - Headings:"
        foreach ($heading in $headings) {
            $indent = '    '
            Write-Output "$indent- Level $($heading.Level): $($heading.Heading)"
        }
    }

    if ($IncludeNestedXrefs) {
        $nestedLinks = Get-XrefsFromFile -Path $resolvedLinkedPath
        if ($nestedLinks) {
            Write-Output "  - Nested xrefs:"
            foreach ($nested in $nestedLinks) {
                Write-Output "    - `$nested`"
            }
        }
    }

    Write-Output ""
}
