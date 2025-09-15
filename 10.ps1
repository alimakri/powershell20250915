Clear-Host
$pointsJoueur = 0
$pointsMachine = 0

# $listeChoix = @("Aucun";"Pierre";"Feuille";"Ciseau")
enum ChoixEnum {
    Pierre = 1
    Feuille = 2
    Ciseau = 3
}

while($pointsJoueur -lt 3 -and $pointsMachine -lt 3){
    Write-host "Faîtes un choix : `n1.Pierre `n2.Feuille `n3.Ciseau" -ForegroundColor Green
    $choixJoueur = [ChoixEnum] (Read-Host) 

    $choixMachine = [ChoixEnum] (Get-Random -Minimum 1 -Maximum 4)


    if ($choixJoueur -eq $choixMachine){
        $pointsJoueur=0
        $pointsMachine =0
    }
    elseif (
        ($choixMachine -eq 1 -and $choixJoueur -eq 3) -or
        ($choixMachine -eq 2 -and $choixJoueur -eq 1) -or
        ($choixMachine -eq 3 -and $choixJoueur -eq 2)
        ){
        $pointsMachine++;
        $pointsJoueur=0;
        }
    else{
        $pointsJoueur++;
        $pointsMachine=0;
    }
    write-host "$choixMachine - $choixJoueur"
    Write-host "Machine: $pointsMachine - Joueur: $pointsJoueur"
}