$ip = "192.168.1.1"
$ports = 1..1024

# Scanner de ports
foreach ($port in $ports) {
    try {
        $tcp = New-Object System.Net.Sockets.TcpClient
        $tcp.Connect($ip, $port)
        Write-Host "Port $port ouvert sur $ip"
        $tcp.Close()
    } catch {
            Write-Host "Port $port fermé sur $ip"
        }
}
