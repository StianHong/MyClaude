# Claude Code Status Line Script
# Reads session JSON from stdin and outputs a formatted status line.

$rawInput = [Console]::In.ReadToEnd()
if (-not $rawInput -or $rawInput.Trim() -eq '') { exit 0 }

try {
    $data = $rawInput | ConvertFrom-Json

    $dir       = $data.workspace.current_dir
    $model     = $data.model.display_name
    $remaining = $data.context_window.remaining_percentage

    $parts = @()
    if ($dir)                 { $parts += $dir }
    if ($model)               { $parts += $model }
    if ($null -ne $remaining) { $parts += "Context: $($remaining)% remaining" }

    if ($parts.Count -gt 0) {
        Write-Output ($parts -join " | ")
    }
} catch {
    # Silently ignore parse errors
    exit 0
}
