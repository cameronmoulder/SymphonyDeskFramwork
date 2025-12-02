function ConvertTo-SDObject {
    param([string]$Json)
    return $Json | ConvertFrom-Json
}
