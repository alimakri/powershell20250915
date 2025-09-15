$chemin = "d:\poub"
$fichiers = Get-ChildItem -Path $chemin -File

$rapport = @()

foreach ($fichier in $fichiers) {
    $tailleKo = [math]::Round($fichier.Length / 1KB, 2)
    $type = if ($fichier.Extension -eq ".txt") { "Texte" } else { "Autre" }

    $objet = @{
        Nom         = $fichier.Name
        TailleKo    = $tailleKo
        Extension   = $fichier.Extension
        Type        = $type
        DateModif   = $fichier.LastWriteTime
    }

    $rapport += $objet
}

$rapport | Format-Table -AutoSize
