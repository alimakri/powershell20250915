# Get-Process | Where-Object {$_.ProcessName -eq 'svchost' }
# Get-Service | where {$_.Status -eq 'Running' }

# Get-Service | Where-Object { $_.Status -eq 'Running' -and $_.Name -like '!A*' }

Get-Service | Where-Object {
    $_.Status -eq 'Running' -and $_.Name -match '^A.*'
}

Get-Service | Select-Object Name, Status | Export-Csv -Path "d:\serv.csv"

$servicesImport = Import-Csv -Path "d:\serv.csv"

$servicesImport | gm

Get-Service | Format-Wide
