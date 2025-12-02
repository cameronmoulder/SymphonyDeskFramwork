function Connect-Jira {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [pscustomobject]$Config,

        [Parameter(Mandatory)]
        [pscustomobject]$Secrets
    )

    return [PSCustomObject]@{
        BaseUrl       = $Config.JiraBaseUrl.TrimEnd('/')
        Email         = $Secrets.JiraUser
        ApiToken      = $Secrets.JiraApiToken
        AuthHeader    = ("Basic {0}" -f [Convert]::ToBase64String(
                            [Text.Encoding]::ASCII.GetBytes("$($Secrets.JiraUser):$($Secrets.JiraApiToken)")
                         ))
    }
}
