function Connect-ExchangeOnPrem {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [pscredential]$Credential,

        [Parameter(Mandatory)]
        [string]$ExchangeUri
    )

    Write-SDLog "Connecting to On-Prem Exchange at $ExchangeUri"

    $session = New-PSSession -ConfigurationName Microsoft.Exchange `
                             -ConnectionUri $ExchangeUri `
                             -Credential $Credential `
                             -Authentication Kerberos

    Import-PSSession $session -DisableNameChecking -AllowClobber | Out-Null

    return $session
}
