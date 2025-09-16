# Définir l'URL de l'API
$uri = "https://jsonplaceholder.typicode.com/posts"

# Créer le corps de la requête en tant qu'objet PowerShell
$body = @{
    title = "Hello from PowerShell"
    body  = "Ceci est un test POST"
    userId = 42
}

# Convertir le corps en JSON
$jsonBody = $body | ConvertTo-Json

# Envoyer la requête POST
$response = Invoke-RestMethod -Uri $uri -Method POST -Body $jsonBody -ContentType "application/json"

# Afficher la réponse
Write-Host "✅ Réponse de l'API :"
$response
