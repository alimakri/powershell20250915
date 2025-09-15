Add-Type -AssemblyName PresentationFramework

# XAML pour l'interface
$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        Title="Pierre - Feuille - Ciseau" Height="300" Width="400"
        WindowStartupLocation="CenterScreen">
    <Grid Margin="10">
        <Grid.RowDefinitions>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="*"/>
        </Grid.RowDefinitions>

        <StackPanel Grid.Row="0" Orientation="Horizontal" HorizontalAlignment="Center" Margin="0,10">
            <Button Name="btnPierre" Content="Pierre" Width="100" Margin="5"/>
            <Button Name="btnFeuille" Content="Feuille" Width="100" Margin="5"/>
            <Button Name="btnCiseau" Content="Ciseau" Width="100" Margin="5"/>
        </StackPanel>

        <TextBlock Name="txtResultat" Grid.Row="1" FontSize="14" TextAlignment="Center" Margin="0,10" />

        <TextBlock Name="txtScore" Grid.Row="2" FontSize="16" FontWeight="Bold" TextAlignment="Center" VerticalAlignment="Center"/>
    </Grid>
</Window>
"@

# Charger le XAML
$reader = [System.Xml.XmlReader]::Create([System.IO.StringReader]$xaml)
$window = [Windows.Markup.XamlReader]::Load($reader)

# Récupérer les contrôles
$btnPierre = $window.FindName("btnPierre")
$btnFeuille = $window.FindName("btnFeuille")
$btnCiseau = $window.FindName("btnCiseau")
$txtResultat = $window.FindName("txtResultat")
$txtScore = $window.FindName("txtScore")

# Enum des choix
enum ChoixEnum {
    Pierre = 1
    Feuille = 2
    Ciseau = 3
}

# Variables de score
$pointsJoueur = 0
$pointsMachine = 0

# Fonction de jeu
function Jouer($choixJoueur) {
    $choixMachine = [ChoixEnum] (Get-Random -Minimum 1 -Maximum 4)

    if ($choixJoueur -eq $choixMachine) {
        $txtResultat.Text = "Égalité !"
    }
    elseif (
        ($choixMachine -eq [ChoixEnum]::Pierre -and $choixJoueur -eq [ChoixEnum]::Ciseau) -or
        ($choixMachine -eq [ChoixEnum]::Feuille -and $choixJoueur -eq [ChoixEnum]::Pierre) -or
        ($choixMachine -eq [ChoixEnum]::Ciseau -and $choixJoueur -eq [ChoixEnum]::Feuille)
    ) {
        $pointsMachine++
        $txtResultat.Text = "La machine a choisi $choixMachine. Elle gagne ce tour !"
    }
    else {
        $pointsJoueur++
        $txtResultat.Text = "La machine a choisi $choixMachine. Vous gagnez ce tour !"
    }

    $txtScore.Text = "Score - Joueur: $pointsJoueur | Machine: $pointsMachine"

    if ($pointsJoueur -eq 3 -or $pointsMachine -eq 3) {
        $message = if ($pointsJoueur -eq 3) { "🎉 Vous avez gagné !" } else { "😢 La machine a gagné !" }
        [System.Windows.MessageBox]::Show($message, "Fin de partie")
        $pointsJoueur = 0
        $pointsMachine = 0
        $txtScore.Text = "Score - Joueur: 0 | Machine: 0"
        $txtResultat.Text = ""
    }
}

# Événements des boutons
$btnPierre.Add_Click({ Jouer([ChoixEnum]::Pierre) })
$btnFeuille.Add_Click({ Jouer([ChoixEnum]::Feuille) })
$btnCiseau.Add_Click({ Jouer([ChoixEnum]::Ciseau) })

# Afficher la fenêtre
$window.ShowDialog() | Out-Null
