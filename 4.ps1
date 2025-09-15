$d = Get-Date -Format "Services_yyyyMMdd_HHmmss"
get-service | export-csv -Path "d:\poub\$d.csv"