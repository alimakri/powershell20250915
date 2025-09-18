# Créer le dossier du module
New-Item -ItemType Directory -Path "$env:USERPROFILE\Documents\PowerShell\Modules\MonModule" -Force

# Créer le fichier avec la fonction
$command1 = @"
function Get-Bonjour {
    param([string]`$Nom = `"Invité`")
    `"Bonjour, `$Nom !`"
}
Export-ModuleMember -Function Get-Bonjour
"@

# Écrire dans le fichier .psm1
$command1 | Set-Content -Path "$env:USERPROFILE\Documents\PowerShell\Modules\MonModule\MonModule.psm1"
