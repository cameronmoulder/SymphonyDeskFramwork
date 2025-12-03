function Write-SDLog {
    param(
        [string]$Message
    )

    $timestamp = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")

    # Use runner logs instead (never deleted by framework sync)
    $logDir  = "C:\SymphonyDesk\Runner\Logs"
    $logFile = Join-Path $logDir "Framework.log"   # keep separate from Runner.log

    if (-not (Test-Path $logDir)) {
        New-Item -ItemType Directory -Path $logDir -Force | Out-Null
    }

    if (-not (Test-Path $logFile)) {
        New-Item -ItemType File -Path $logFile -Force | Out-Null
    }

    Add-Content -Path $logFile -Value "$timestamp - $Message"
}
