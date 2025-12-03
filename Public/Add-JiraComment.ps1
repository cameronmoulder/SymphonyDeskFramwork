function Add-JiraComment {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [psobject]$Jira,          # Object returned by Connect-Jira

        [Parameter(Mandatory)]
        [string]$IssueKey,

        [Parameter(Mandatory)]
        [string]$Comment
    )

    try {
        # Basic sanity check – don't kill the runbook if Jira isn't wired up yet
        if (-not $Jira) {
            Write-SDLog "Add-JiraComment: Jira object is null. Skipping comment for issue '$IssueKey'."
            return
        }

        $baseUrl = $Jira.BaseUrl
        if (-not $baseUrl) {
            Write-SDLog "Add-JiraComment: Jira.BaseUrl is missing. Skipping comment for issue '$IssueKey'."
            return
        }

        # Build REST endpoint
        $uri = "$($baseUrl.TrimEnd('/'))/rest/api/3/issue/$IssueKey/comment"

        # Simple text body – good enough for MVP; you can upgrade to Atlassian doc format later
        $payload = @{
            body = $Comment
        } | ConvertTo-Json

        # Build Invoke-RestMethod parameters dynamically based on what Connect-Jira gave us
        $invokeParams = @{
            Method = 'Post'
            Uri    = $uri
            Body   = $payload
        }

        if ($Jira.Headers) {
            # Typical pattern: Connect-Jira returns @{ BaseUrl=..; Headers=@{ Authorization=..; 'Content-Type'='application/json' } }
            $invokeParams['Headers'] = $Jira.Headers
        }
        elseif ($Jira.Credential) {
            # Alternative pattern: Connect-Jira returned a PSCredential
            $invokeParams['Credential']  = $Jira.Credential
            $invokeParams['ContentType'] = 'application/json'
        }
        else {
            Write-SDLog "Add-JiraComment: Jira object has no Headers or Credential. Skipping comment for issue '$IssueKey'."
            return
        }

        Write-SDLog "Add-JiraComment: Posting comment to Jira issue '$IssueKey'."
        $response = Invoke-RestMethod @invokeParams

        Write-SDLog "Add-JiraComment: Comment successfully added to '$IssueKey'."
        return $response
    }
    catch {
        Write-SDLog "Add-JiraComment: Failed to post comment to '$IssueKey' - $($_.Exception.Message)"
        # Don't rethrow – we don't want Jira failures to kill the runbook
    }
}
