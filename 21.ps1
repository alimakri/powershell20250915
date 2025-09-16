# Assure-toi que le module ImportExcel est installé
# Install-Module -Name ImportExcel -Scope CurrentUser -Force

# Chemin vers ton fichier Excel
$fichier = "d:\poub\Classeur1.xlsx"

# Importer les données de la feuille FData
$data = Import-Excel -Path $fichier -WorksheetName "Data"

# Créer des objets personnalisés avec les propriétés PC, IP et DNS
$objets = foreach ($ligne in $data) {
    [PSCustomObject]@{
        PC  = $ligne.PC
        IP  = $ligne.IP
        DNS = $ligne.DNS
    }
}

# Afficher les objets
$objets[0].PC
