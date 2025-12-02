function Get-SDCredential {
    param(
        [Parameter(Mandatory)]
        [pscustomobject]$Secrets
    )

    $securePwd = $Secrets.ExchangePwd | ConvertTo-SecureString
    $cred = New-Object System.Management.Automation.PSCredential ($Secrets.ExchangeUser, $securePwd)
    return $cred
}
