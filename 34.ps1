# Paramètres
$GpoName = "Install_Microsoft_Edge"
$MsiPath = "\\SERVEUR\SOFTWARE\MicrosoftEdgeEnterpriseX64.msi"  # Chemin réseau du MSI
$OuTarget = "OU=PostesClients,DC=mondomaine,DC=local"            # OU cible

# Créer la GPO
New-GPO -Name $GpoName -Comment "Installation automatique de Microsoft Edge"

# Lier la GPO à l'OU
New-GPLink -Name $GpoName -Target $OuTarget -LinkEnabled Yes

# Monter l'objet GPO
$Gpo = Get-GPO -Name $GpoName

# Ajouter le package MSI à la configuration ordinateur
$InstallerPath = "Software\Policies\Microsoft\Windows\Installer"
$Gpo | Set-GPRegistryValue -Key $InstallerPath -ValueName "AlwaysInstallElevated" -Type DWord -Value 1

# Créer le script d'installation MSI
$ScriptInstall = @"
cmd /c start /wait msiexec /i `"$MsiPath`" /qn /norestart
"@

# Enregistrer le script dans le dossier de scripts de démarrage
$ScriptPath = "\\SERVEUR\GPO_Scripts\InstallEdge.ps1"
$ScriptInstall | Set-Content -Path $ScriptPath -Encoding UTF8

# Ajouter le script de démarrage à la GPO
Set-GPStartupScript -ScriptName "InstallEdge.ps1" -ScriptParameters "" -GpoName $GpoName -ScriptPath $ScriptPath
