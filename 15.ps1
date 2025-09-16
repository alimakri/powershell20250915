$login = Read-Host 
$pwd = Read-Host
$query = "select count(*) from Coffre where Login='$login' and Password='$pwd'"
Invoke-Sqlcmd -ServerInstance ".\SQLEXPRESS" -Database "Secret" -Query $query


# select count(*) from Coffre where Login='aaa' and Password='' or '1'='1'
# ' or '1'='1