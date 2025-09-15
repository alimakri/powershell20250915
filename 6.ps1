$jour = (Get-Date).DayOfWeek

switch ($jour) {
    "monday"   { Write-Output "Début de la semaine de travail." }
    "friday" { Write-Output "Fin de la semaine de travail." }
    "saturday"  { Write-Output "Week-end !" }
    "sunday" { Write-Output "Repos bien mérité." }
    default   { Write-Output "Jour de semaine classique." }
}
