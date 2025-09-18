# tous les chemins reconnus par PowerShell
$env:PSModulePath -split ';'


Import-Module "$env:USERPROFILE\Documents\PowerShell\Modules\MonModule\MonModule.psm1"
Get-Bonjour -Nom "Alice"
