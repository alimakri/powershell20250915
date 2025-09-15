$services = Get-Service 
$s1 = $services[0]
$S2 = $s1

[decimal]$i=10.3
$j=$i

$b1 = $true
$b2 = (1 -eq 2) -or $true

$s1 -is [System.ServiceProcess.ServiceController]
$d1 = Get-Date
$d2 = Get-Date -Year 2000 -Month 1 -Day 1

$nJours = ($d2-$d1).Days
$nJours
