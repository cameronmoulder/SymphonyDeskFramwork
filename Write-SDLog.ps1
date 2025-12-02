function Write-SDLog {
    param(
        [string]$Message
    )

    $timestamp = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
    $logFile = "C:\SymphonyDesk\Framework\Logs\SymphonyDesk.log"

    Add-Content -Path $logFile -Value "$timestamp - $Message"
}
