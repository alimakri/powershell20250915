$services = Get-Service
foreach($s in $services){
    if ($s.Status -eq 'Running')
    {
        $couleur = "Green"
    }
    else
    {
        $couleur = "red"
    }
    Write-Host $s.Name -ForegroundColor $couleur
}
Write-Host "-----------------------------------------------------------------------------"
$services = Get-Service
for($i=0; $i -lt $services.Count; $i++){
    if ($services[$i].Status -eq 'Running')
    {
        $couleur = "Green"
    }
    else
    {
        $couleur = "red"
    }
    Write-Host $services[$i].Name -ForegroundColor $couleur
}
