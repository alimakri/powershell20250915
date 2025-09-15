$p1 = New-Object -TypeName PSCustomObject -Property @{ Nom=  "MAKRI"; Prenom='Ali'; Ville="Lyon"}
$p2 = New-Object -TypeName PSCustomObject -Property @{ Nom=  "Dupont"; Prenom='Henri'; Ville="Lyon"}
$o1 = @{}
$listep = @()
$listep += $p1
$listep += $p2

$listep[1].Prenom

