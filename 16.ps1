# URL de l'API
$url = "https://restcountries.com/v3.1/name/deutschland"

# Appel de l'API
try {
    $response = Invoke-RestMethod -Uri $url -Method Get

    # Affichage des infos principales
    foreach ($country in $response) {
        Write-Host "Nom commun     : $($country.name.common)"
        Write-Host "Nom officiel   : $($country.name.official)"
        Write-Host "Capitale       : $($country.capital -join ', ')"
        Write-Host "Région         : $($country.region)"
        Write-Host "Population     : $($country.population)"
        Write-Host "Langues        : $($country.languages.Values -join ', ')"
        Write-Host "Monnaie        : $($country.currencies.EUR.name) ($($country.currencies.EUR.symbol))"
        Write-Host "Drapeau        : $($country.flags.png)"
        Write-Host "`n---`n"
    }
}
catch {
    Write-Error "Erreur lors de l'appel à l'API : $_"
}
