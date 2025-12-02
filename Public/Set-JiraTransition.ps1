function Set-JiraTransition {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [pscustomobject]$Jira,

        [Parameter(Mandatory)]
        [string]$IssueKey,

        [Parameter(Mandatory)]
        [string]$TransitionName
    )

    # Get transitions for issue
    $transitions = Invoke-JiraApi -Jira $Jira -Method "GET" -Endpoint "issue/$IssueKey/transitions"

    $transition = $transitions.transitions | Where-Object { $_.name -eq $TransitionName }

    if (!$transition) {
        throw "Transition '$TransitionName' not found for issue $IssueKey"
    }

    $body = @{
        transition = @{
            id = $transition.id
        }
    }

    Invoke-JiraApi -Jira $Jira -Method "POST" -Endpoint "issue/$IssueKey/transitions" -Body $body
}
