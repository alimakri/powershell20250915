# Récupération des services
$services = Get-Service | Sort-Object DisplayName

# Construction des lignes HTML
$rows = foreach ($svc in $services) {
    $statusClass = switch ($svc.Status) {
        "Running" { "running" }
        "Stopped" { "stopped" }
        default   { "other" }
    }

    "<tr class='$statusClass'><td>$($svc.Name)</td><td>$($svc.DisplayName)</td><td>$($svc.Status)</td></tr>"
}

# HTML complet avec CSS
$html = @"
<!DOCTYPE html>
<html lang='fr'>
<head>
<meta charset='UTF-8'>
<title>Liste des services Windows</title>
<style>
  body {
    font-family: Segoe UI, sans-serif;
    background-color: #0f172a;
    color: #e5e7eb;
    padding: 20px;
  }
  h1 {
    color: #22d3ee;
  }
  table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
  }
  th, td {
    padding: 10px;
    border-bottom: 1px solid #1f2937;
    text-align: left;
  }
  th {
    background-color: #111827;
    color: #9ca3af;
  }
  tr.running td {
    color: #22c55e;
    font-weight: bold;
  }
  tr.stopped td {
    color: #ef4444;
    font-weight: bold;
  }
  tr.other td {
    color: #f59e0b;
    font-weight: bold;
  }
</style>
</head>
<body>
<h1>Services Windows</h1>
<p>Généré le $(Get-Date -Format "dd/MM/yyyy HH:mm:ss")</p>
<table>
  <thead>
    <tr>
      <th>Nom</th>
      <th>Nom affiché</th>
      <th>Statut</th>
    </tr>
  </thead>
  <tbody>
    $($rows -join "`n")
  </tbody>
</table>
</body>
</html>
"@

# Sauvegarde dans un fichier HTML
$path = "d:\poub\Services.html"
$html | Out-File -FilePath $path -Encoding UTF8
Start-Process $path
