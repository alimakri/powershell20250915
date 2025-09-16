# URL de l'API CoinGecko
$url = "https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=eur"

# Requête HTTP GET
$response = Invoke-RestMethod -Uri $url

# Affichage du prix
$prix = $response.bitcoin.eur
Write-Host "💸 Prix actuel du Bitcoin : $prix EUR"
