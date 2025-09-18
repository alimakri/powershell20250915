function Get-Bonjour {
    param (
        [string]$Nom = "Invité"
    )
    Write-Host "Bonjour, $Nom ! Bienvenue dans PowerShell." -ForegroundColor Cyan
}
# Get-Module -ListAvailable
