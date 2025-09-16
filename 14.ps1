# Paramètres de connexion
$connectionString = "Server=.\SQLEXPRESS;Database=AdventureWorks2017;Integrated Security=True;"
$query = @"
SELECT TOP 10     
    Person.Person.BusinessEntityID, 
    Person.Person.FirstName, 
    Person.Person.LastName, 
    Person.Address.City
FROM            
    Person.Address 
    INNER JOIN Person.BusinessEntityAddress ON Person.Address.AddressID = Person.BusinessEntityAddress.AddressID 
    INNER JOIN Person.BusinessEntity ON Person.BusinessEntityAddress.BusinessEntityID = Person.BusinessEntity.BusinessEntityID 
    INNER JOIN Person.Person ON Person.BusinessEntity.BusinessEntityID = Person.Person.BusinessEntityID
"@

# Crée la connexion et la commande
$connection = New-Object System.Data.SqlClient.SqlConnection $connectionString
try{
    $connection.Open()
    # $command = $connection.CreateCommand()
    $command = New-Object System.Data.SqlClient.SqlCommand
    $command.Connection = $connection 
    $command.CommandText = $query

    # Exécute
    [System.Data.SqlClient.SqlDataReader]$reader = $command.ExecuteReader()

    $lignes = @()

    # Affiche les résultats
    while ($reader.Read()) {
        $obj = [PSCustomObject]@{
                BusinessEntityID = $reader["BusinessEntityID"]
                FirstName        = $reader["FirstName"]
                LastName         = $reader["LastName"]
                City             = $reader["City"]
            }
        $lignes += $obj
    }

    # Ferme la connexion
    $reader.Close()
    $connection.Close()
    ($lignes) | Export-Csv -Path "d:\poub\personnes.csv"
}
catch{
    Write-Error "Erreur lors de l'ouverture de la connexion SQL"
}


