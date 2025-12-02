# ================================
# SymphonyDeskFramework.psm1
# Core module loader
# ================================

# Import Public Functions
Get-ChildItem -Path $PSScriptRoot/Public/*.ps1 | ForEach-Object {
    try { . $_.FullName }
    catch { Write-Error "Failed to load public function $($_.Name): $_" }
}

# Import Private Functions
Get-ChildItem -Path $PSScriptRoot/Private/*.ps1 | ForEach-Object {
    try { . $_.FullName }
    catch { Write-Error "Failed to load private function $($_.Name): $_" }
}

Write-Verbose "SymphonyDeskFramework loaded."
