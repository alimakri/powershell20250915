Clear-Host
enum ChoixEnum {
    Pierre = 1
    Feuille = 2
    Ciseau = 3
}

$pointsJoueur = 0
$pointsMachine = 0

while ($pointsJoueur -lt 3 -and $pointsMachine -lt 3) {
    Write-Host "`nFaîtes un choix :" -ForegroundColor Green
    Write-Host "1. Pierre"
    Write-Host "2. Feuille"
    Write-Host "3. Ciseau"

    $input = Read-Host "Votre choix (1-3)"
    
    if ($input -notin '1','2','3') {
        Write-Host "⛔ Entrée invalide. Veuillez choisir 1, 2 ou 3." -ForegroundColor Red
        continue
    }

    $choixJoueur = [ChoixEnum] $input
    $choixMachine = [ChoixEnum] (Get-Random -Minimum 1 -Maximum 4)

    Write-Host "`n🧠 Joueur a choisi : $choixJoueur"
    Write-Host "🤖 Machine a choisi : $choixMachine"

    if ($choixJoueur -eq $choixMachine) {
        Write-Host "⚖️ Égalité ! Personne ne marque de point." -ForegroundColor Yellow
    }
    elseif (
        ($choixMachine -eq [ChoixEnum]::Pierre -and $choixJoueur -eq [ChoixEnum]::Ciseau) -or
        ($choixMachine -eq [ChoixEnum]::Feuille -and $choixJoueur -eq [ChoixEnum]::Pierre) -or
        ($choixMachine -eq [ChoixEnum]::Ciseau -and $choixJoueur -eq [ChoixEnum]::Feuille)
    ) {
        $pointsMachine++
        Write-Host "❌ La machine gagne ce tour !" -ForegroundColor Magenta
    }
    else {
        $pointsJoueur++
        Write-Host "✅ Vous gagnez ce tour !" -ForegroundColor Cyan
    }

    Write-Host "`nScore : Machine $pointsMachine - Joueur $pointsJoueur"
}

# Fin de partie
if ($pointsJoueur -eq 3) {
    Write-Host "`n🎉 Bravo ! Vous avez gagné la partie !" -ForegroundColor Green
} else {
    Write-Host "`n😢 La machine a gagné. Réessayez !" -ForegroundColor Red
}
