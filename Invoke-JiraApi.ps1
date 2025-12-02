function Invoke-JiraApi {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [pscustomobject]$Jira,

        [Parameter(Mandatory)]
        [string]$Method,

        [Parameter(Mandatory)]
        [string]$Endpoint,

        [psobject]$Body
    )

    $uri = "$($Jira.BaseUrl)/rest/api/3/$Endpoint"

    $headers = @{
        "Authorization" = $Jira.AuthHeader
        "Accept"        = "application/json"
        "Content-Type"  = "application/json"
    }

    if ($Body) {
        $json = $Body | ConvertTo-Json -Depth 10
        return Invoke-RestMethod -Uri $uri -Method $Method -Headers $headers -Body $json
    }
    else {
        return Invoke-RestMethod -Uri $uri -Method $Method -Headers $headers
    }
}
