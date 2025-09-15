Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Enum des choix
enum ChoixEnum {
    Pierre = 1
    Feuille = 2
    Ciseau = 3
}

# Variables de score
$pointsJoueur = 0
$pointsMachine = 0

# Créer le formulaire
$form = New-Object Windows.Forms.Form
$form.Text = "Pierre - Feuille - Ciseau"
$form.Size = New-Object Drawing.Size(400,300)
$form.StartPosition = "CenterScreen"

# Label de score
$scoreLabel = New-Object Windows.Forms.Label
$scoreLabel.Location = New-Object Drawing.Point(20,20)
$scoreLabel.Size = New-Object Drawing.Size(350,30)
$scoreLabel.Font = New-Object Drawing.Font("Arial",12,[Drawing.FontStyle]::Bold)
$form.Controls.Add($scoreLabel)

# Label de résultat
$resultLabel = New-Object Windows.Forms.Label
$resultLabel.Location = New-Object Drawing.Point(20,60)
$resultLabel.Size = New-Object Drawing.Size(350,30)
$form.Controls.Add($resultLabel)

# Fonction de jeu
function Jouer($choixJoueur) {
    $choixMachine = [ChoixEnum] (Get-Random -Minimum 1 -Maximum 4)

    if ($choixJoueur -eq $choixMachine) {
        $resultLabel.Text = "Égalité !"
    }
    elseif (
        ($choixMachine -eq [ChoixEnum]::Pierre -and $choixJoueur -eq [ChoixEnum]::Ciseau) -or
        ($choixMachine -eq [ChoixEnum]::Feuille -and $choixJoueur -eq [ChoixEnum]::Pierre) -or
        ($choixMachine -eq [ChoixEnum]::Ciseau -and $choixJoueur -eq [ChoixEnum]::Feuille)
    ) {
        $pointsMachine++
        $resultLabel.Text = "La machine gagne ce tour !"
    }
    else {
        $pointsJoueur++
        $resultLabel.Text = "Vous gagnez ce tour !"
    }

    $scoreLabel.Text = "Score - Joueur: $pointsJoueur | Machine: $pointsMachine"

    if ($pointsJoueur -eq 3 -or $pointsMachine -eq 3) {
        $message = if ($pointsJoueur -eq 3) { "🎉 Vous avez gagné !" } else { "😢 La machine a gagné !" }
        [System.Windows.Forms.MessageBox]::Show($message, "Fin de partie")
        $pointsJoueur = 0
        $pointsMachine = 0
        $scoreLabel.Text = "Score - Joueur: 0 | Machine: 0"
        $resultLabel.Text = ""
    }
}

# Boutons
$btnPierre = New-Object Windows.Forms.Button
$btnPierre.Text = "Pierre"
$btnPierre.Location = New-Object Drawing.Point(20,120)
$btnPierre.Size = New-Object Drawing.Size(100,40)
$btnPierre.Add_Click({ Jouer([ChoixEnum]::Pierre) })
$form.Controls.Add($btnPierre)

$btnFeuille = New-Object Windows.Forms.Button
$btnFeuille.Text = "Feuille"
$btnFeuille.Location = New-Object Drawing.Point(140,120)
$btnFeuille.Size = New-Object Drawing.Size(100,40)
$btnFeuille.Add_Click({ Jouer([ChoixEnum]::Feuille) })
$form.Controls.Add($btnFeuille)

$btnCiseau = New-Object Windows.Forms.Button
$btnCiseau.Text = "Ciseau"
$btnCiseau.Location = New-Object Drawing.Point(260,120)
$btnCiseau.Size = New-Object Drawing.Size(100,40)
$btnCiseau.Add_Click({ Jouer([ChoixEnum]::Ciseau) })
$form.Controls.Add($btnCiseau)

# Afficher le formulaire
[Windows.Forms.Application]::EnableVisualStyles()
$form.ShowDialog()
