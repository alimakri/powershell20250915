# Crée une instance Excel
$excel = New-Object -ComObject Excel.Application
# $excel.Visible = $false
$excel.DisplayAlerts = $false

# Ajoute un nouveau classeur
$workbook = $excel.Workbooks.Add()
$worksheet = $workbook.Worksheets.Item(1)
$worksheet.Name = "Exemple"

# Données à écrire
$headers = @("Nom", "Statut")
$values  = @(
    @("Spooler", "Running"),
    @("W32Time", "Stopped"),
    @("WinDefend", "Running")
)

# Écrit les en-têtes
for ($i = 0; $i -lt $headers.Count; $i++) {
    $worksheet.Cells.Item(1, $i + 1).Value2 = $headers[$i]
    $worksheet.Cells.Item(1, $i + 1).Font.Bold = $true
}

# Écrit les données
for ($row = 0; $row -lt $values.Count; $row++) {
    for ($col = 0; $col -lt $values[$row].Count; $col++) {
        $worksheet.Cells.Item($row + 2, $col + 1).Value2 = $values[$row][$col]
    }
}

# Ajuste la largeur des colonnes
$worksheet.Columns.AutoFit()

# Sauvegarde le fichier
$path = "d:\poub\Exemple_Services.xlsx"
$workbook.SaveAs($path, 51)  # 51 = xlOpenXMLWorkbook (.xlsx)

# Ferme Excel proprement
#$workbook.Close($true)
#$excel.Quit()

# Libère les objets COM
[System.Runtime.InteropServices.Marshal]::ReleaseComObject($worksheet) | Out-Null
[System.Runtime.InteropServices.Marshal]::ReleaseComObject($workbook) | Out-Null
[System.Runtime.InteropServices.Marshal]::ReleaseComObject($excel) | Out-Null
[GC]::Collect()
[GC]::WaitForPendingFinalizers()

Write-Host "Fichier Excel créé : $path"
