Clear-Host
$nombreADeviner = Get-Random -Minimum 1 -Maximum 99
# $nombreADeviner
$nombrePropose = -1
$nCoup = 0
$PartieEnCours = $true

while($PartieEnCours)
{
    $nCoup++
    $nombrePropose = Read-host "Donnez un nombre ($nCoup/7)"
    if ($nCoup -eq 7)
    {
        Write-Host "Perdu"
        $PartieEnCours = $false
    }
    elseif ($nombrePropose -lt $nombreADeviner)
    {
        Write-Host "Trop petit"
    }
    elseif ($nombrePropose -gt $nombreADeviner)
    {
        Write-Host "Trop grand"
    }
    else
    {
       Write-Host "Gagné" 
       $PartieEnCours = $false
    }
}
