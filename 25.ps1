$chemin = "C:\Windows\System32\drivers\etc\hosts"
$hash = Get-FileHash -Path $chemin -Algorithm SHA256
Write-Host "Hash actuel : $($hash.Hash)"
