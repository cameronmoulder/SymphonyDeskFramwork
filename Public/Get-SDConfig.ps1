function Get-SDConfig {
    param(
        [Parameter(Mandatory)]
        [string]$Customer
    )

    $configPath = "C:\SymphonyDesk\customers\$Customer\config\config.json"
    $secretsPath = "C:\SymphonyDesk\customers\$Customer\config\secrets.json"

    if (!(Test-Path $configPath)) { throw "Missing config.json for $Customer" }
    if (!(Test-Path $secretsPath)) { throw "Missing secrets.json for $Customer" }

    $config = Get-Content $configPath | ConvertFrom-Json
    $secrets = Get-Content $secretsPath | ConvertFrom-Json

    return [PSCustomObject]@{
        Config  = $config
        Secrets = $secrets
    }
}
