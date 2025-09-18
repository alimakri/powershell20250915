function Get-DiskReport {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [string]$ComputerName = $env:COMPUTERNAME,

        [Parameter(Mandatory=$false)]
        [string]$ExportPath = "D:\poub\Rapports\DiskReport.csv"
    )

    # Vérifie si le dossier d’export existe
    if (!(Test-Path -Path (Split-Path $ExportPath))) {
        New-Item -ItemType Directory -Path (Split-Path $ExportPath) -Force
    }

    try {
        $disks = Get-WmiObject -Class Win32_LogicalDisk -ComputerName $ComputerName -Filter "DriveType=3"
        $report = foreach ($disk in $disks) {
            [PSCustomObject]@{
                Ordinateur     = $ComputerName
                Lecteur        = $disk.DeviceID
                TailleTotaleGB = [math]::Round($disk.Size / 1GB, 2)
                EspaceLibreGB  = [math]::Round($disk.FreeSpace / 1GB, 2)
                PourcentageLibre = [math]::Round(($disk.FreeSpace / $disk.Size) * 100, 2)
            }
        }

        $report | Export-Csv -Path $ExportPath -NoTypeInformation -Encoding UTF8
        Write-Host "Rapport exporté vers $ExportPath" -ForegroundColor Green
    }
    catch {
        Write-Error "Erreur lors de la récupération des informations disque : $_"
    }
}
