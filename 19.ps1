<# 
    Export des services Windows vers Excel via COM Automation (Excel installé requis)
    - Crée l'application Excel
    - Ajoute un classeur et prépare la feuille
    - Écrit les données Get-Service
    - Met en forme (en-têtes, table, AutoFilter, gel de la ligne 1, AutoFit)
    - Enregistre et libère proprement les objets COM
#>

param(
    [string]$Path = "$env:USERPROFILE\Desktop\Services_Automation.xlsx",
    [string]$WorksheetName = "Services"
)

# Constantes Excel (évite les références COM d’énums)
# xlOpenXMLWorkbook = 51, xlSrcRange = 1, xlYes = 1
$xlOpenXMLWorkbook = 51
$xlSrcRange        = 1
$xlYes             = 1

# Utilitaires pour libérer proprement le COM
function Release-ComObject {
    param([Parameter(Mandatory=$true)]$ComObject)
    try {
        if ($null -ne $ComObject) {
            [void][System.Runtime.InteropServices.Marshal]::ReleaseComObject($ComObject)
        }
    } catch { } finally {
        $script:ComObject = $null
    }
}

# 1) Créer l'application Excel
$excel = $null
$workbook = $null
$worksheet = $null

try {
    # Accélère l’exécution et évite les popups
    $excel = New-Object -ComObject Excel.Application
    $excel.Visible = $false
    $excel.DisplayAlerts = $false
    $excel.ScreenUpdating = $false
    $excel.Calculation = -4135   # xlCalculationManual

    # 2) Créer le classeur
    $workbook = $excel.Workbooks.Add()

    # 3) Récupérer la feuille active et la nommer
    $worksheet = $workbook.Worksheets.Item(1)
    $worksheet.Name = $WorksheetName

    # 4) Préparer les en-têtes
    $headers = @('Name','DisplayName','Status','StartType')
    $headerRange = $worksheet.Range("A1").Resize(1, $headers.Count)
    $headerRange.Value2 = ($headers -as [object[]])

    # Style en-têtes
    $headerRange.Font.Bold = $true
    $headerRange.Interior.Color = 0xEEEEEE  # gris clair
    $headerRange.Borders.LineStyle = 1

    # 5) Récupérer les données services
    $services = Get-Service | Select-Object Name, DisplayName, Status, StartType
    $rowCount = $services.Count

    if ($rowCount -eq 0) {
        # Pas de données : on pose juste l’AutoFilter et on sauvegarde
        $headerRange.AutoFilter()
    } else {
        # 6) Construire un tableau 2D pour un collage rapide
        $data = New-Object 'object[,]' $rowCount, $headers.Count

        $r = 0
        foreach ($svc in $services) {
            $data[$r,0] = $svc.Name
            $data[$r,1] = $svc.DisplayName
            $data[$r,2] = [string]$svc.Status
            $data[$r,3] = [string]$svc.StartType
            $r++
        }

        # 7) Déposer les données sous les en-têtes
        $dataRange = $worksheet.Range("A2").Resize($rowCount, $headers.Count)
        $dataRange.Value2 = $data

        # 8) Créer un tableau (ListObject) avec style
        $fullRange = $worksheet.Range("A1").Resize($rowCount + 1, $headers.Count)
        $listObjects = $worksheet.ListObjects
        $listObject = $listObjects.Add($xlSrcRange, $fullRange, $null, $xlYes)
        $listObject.Name = "ServicesTable"
        $listObject.TableStyle = "TableStyleMedium6"  # style moderne

        # 9) AutoFilter (activé par le ListObject, mais on s’assure)
        $fullRange.AutoFilter()

        # 10) Geler la ligne d’en-tête
        $worksheet.Range("A2").Select() | Out-Null
        $excel.ActiveWindow.SplitRow = 1
        $excel.ActiveWindow.FreezePanes = $true
    }

    # 11) Ajuster la largeur des colonnes
    $worksheet.UsedRange.Columns.AutoFit() | Out-Null

    # 12) Masquer la grille pour un rendu propre
    $worksheet.Application.ActiveWindow.DisplayGridlines = $false

    # 13) Pied de page simple (optionnel)
    $worksheet.PageSetup.CenterFooter = "Services Windows - Généré le $(Get-Date -Format 'yyyy-MM-dd HH:mm')"

    # 14) Sauvegarder en .xlsx
    # Crée le dossier si nécessaire
    $dir = Split-Path $Path -Parent
    if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }

    $workbook.SaveAs($Path, $xlOpenXMLWorkbook)

} finally {
    # Rétablir les options Excel
    if ($excel) {
        try {
            $excel.Calculation = -4105  # xlCalculationAutomatic
            $excel.ScreenUpdating = $true
            $excel.DisplayAlerts = $true
        } catch { }
    }

    # Fermer proprement
    if ($workbook) {
        try { $workbook.Close($true) } catch { }
        Release-ComObject $worksheet
        Release-ComObject $workbook
    }

    if ($excel) {
        try { $excel.Quit() } catch { }
        Release-ComObject $excel
    }

    # Nettoyage mémoire
    [GC]::Collect()
    [GC]::WaitForPendingFinalizers()
}

Write-Host "Fichier Excel généré : $Path"
