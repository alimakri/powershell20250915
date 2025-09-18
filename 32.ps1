# Prérequis

# Le poste distant doit avoir WinRM activé
Enable-PSRemoting -Force
# Les deux machines doivent pouvoir communiquer sur le port 5985 (HTTP) ou 5986 (HTTPS).

# Le pare-feu doit autoriser les connexions WinRM

# Si les machines ne sont pas dans le même domaine, tu peux configurer une liste d’hôtes approuvés
Set-Item WSMan:\localhost\Client\TrustedHosts -Value "PC-DISTANT"




# Nom ou IP du poste distant
$serveur = "PC-DISTANT"

# Script à exécuter sur le poste distant
$script = {
    Get-Process | Where-Object { $_.CPU -gt 100 }
}

# Créer une session distante
$session = New-PSSession -ComputerName $serveur

# Exécuter le script dans la session distante
Invoke-Command -Session $session -ScriptBlock $script

# Fermer la session
Remove-PSSession $session
