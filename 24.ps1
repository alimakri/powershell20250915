Get-EventLog -LogName Security -Newest 1000 | Where-Object {
    $_.EventID -eq 4624
} | Select TimeGenerated, Message
