function Get-SDConfig {
    param(
        [string]$Customer
    )

    # Log that we're loading config
    Write-SDLog "Get-SDConfig called for customer '$Customer'"

    # --- OPTION A: use a per-customer JSON file (future) ---
    $configRoot = "C:\SymphonyDesk\Framework\Config"
    $configPath = Join-Path $configRoot "$Customer\config.json"

    if (Test-Path $configPath) {
        Write-SDLog "Loading config from $configPath"
        $json = Get-Content $configPath -Raw | ConvertFrom-Json
        return $json
    }

    # --- TEMP OPTION B: safe dummy config so runbooks don't crash ---
    Write-SDLog "Config file not found at $configPath, returning dummy config for MVP"

    return @{
        Customer    = $Customer
        TenantId    = "<dummy-tenant>"
        ExchangeUrl = "https://dummy.exchange.local"
        JiraUrl     = "https://dummy.jira.local"
    }
}
