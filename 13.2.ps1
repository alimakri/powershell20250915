# Base de données
# Définis les paramètres de connexion
$server = ".\SQLEXPRESS"
$database = "AdventureWorks2017"
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

# Exécute la requête
Invoke-Sqlcmd -ServerInstance $server -Database $database -Query $query
