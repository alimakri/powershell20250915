# Postes.csv
# ---------
# NomMachine
# PC001
# PC002
# PC003

# Charger la liste des machines
$machines = Import-Csv -Path "C:\Scripts\Postes.csv"

# Résultats
$resultats = @()

foreach ($machine in $machines) {
    try {
        $edgeInstallé = Invoke-Command -ComputerName $machine.NomMachine  -ScriptBlock {
            Get-ItemProperty "HKLM:\Software\Microsoft\Edge" -ErrorAction SilentlyContinue
        }

        $status = if ($edgeInstallé) { "Edge installé" } else { "Edge NON installé" }

    } catch {
        $status = "Machine inaccessible"
    }

    $resultats += [PSCustomObject]@{
        Machine = $machine.NomMachine
        Statut  = $status
    }
}

# Exporter les résultats
$resultats | Export-Csv -Path "C:\Scripts\Audit_Edge.csv" -NoTypeInformation
