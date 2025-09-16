# Charger les données depuis la feuille FData
$data = Import-Excel -Path "C:\chemin\vers\ton\fichier.xlsx" -WorksheetName "FData"

foreach ($ligne in $data) {
    $nomPC = $ligne.PC
    $ip    = $ligne.IP
    $dns   = $ligne.DNS

    Invoke-Command -ComputerName $nomPC -ScriptBlock {
        param($ip, $dns)

        # Adapter le nom de l'interface réseau si nécessaire
        $interface = Get-NetAdapter | Where-Object { $_.Status -eq 'Up' } | Select-Object -First 1

        # Affecter l'adresse IP
        New-NetIPAddress -InterfaceAlias $interface.Name -IPAddress $ip -PrefixLength 24 -DefaultGateway "192.168.1.1"

        # Configurer le DNS
        Set-DnsClientServerAddress -InterfaceAlias $interface.Name -ServerAddresses $dns
    } -ArgumentList $ip, $dns
}
