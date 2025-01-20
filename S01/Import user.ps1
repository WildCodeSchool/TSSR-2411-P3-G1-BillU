# Importer le module Active Directory
Import-Module ActiveDirectory

# Chemin du fichier Excel
$excelPath = "C:\chemin\vers\s01_BillU.xlsx"

# Charger les données Excel
$users = Import-Excel -Path $excelPath -WorksheetName "Feuille 1"

# Parcourir chaque utilisateur dans le fichier Excel
foreach ($user in $users) {
    # Définir les paramètres de l'utilisateur
    $FirstName = $user.Prenom
    $LastName = $user.Nom
    $UserName = ($FirstName.Substring(0,1) + $LastName).ToLower() # Exemple : adumas
    $Password = "Azerty1*" # Mot de passe par défaut (à personnaliser)
    $OU = $user.OU # L'OU doit être spécifiée dans le fichier Excel
    $Manager = $user."Manager-Prenom" + " " + $user."Manager-Nom"
    $Title = $user.fonction
    $Department = $user.Departement
    $Service = $user.Service
    $OfficePhone = $user."Telephone fixe"
    $MobilePhone = $user."Telephone portable"
    $PCName = $user."Nom de PC"
    $PCBrand = $user."Marque PC"
    $BirthDate = $user."Date de naissance"
    $Telework = $user."Télétravail"

    # Créer le nom complet (Full Name)
    $FullName = "$FirstName $LastName"

    # Créer l'utilisateur dans Active Directory
    New-ADUser `
        -SamAccountName $UserName `
        -Name $FullName `
        -GivenName $FirstName `
        -Surname $LastName `
        -Title $Title `
        -Department $Department `
        -Description $Service `
        -OfficePhone $OfficePhone `
        -MobilePhone $MobilePhone `
        -EmailAddress "$UserName@billu.lan" `
        -Path $OU `
        -AccountPassword (ConvertTo-SecureString $Password -AsPlainText -Force) `
        -Enabled $true `
        -ChangePasswordAtLogon $true

    # Ajouter le manager si spécifié
    if ($Manager -ne " ") {
        $ManagerDN = Get-ADUser -Filter {Name -eq $Manager} | Select-Object -ExpandProperty DistinguishedName
        Set-ADUser -Identity $UserName -Manager $ManagerDN
    }

    # Ajouter des attributs personnalisés
    Set-ADUser -Identity $UserName `
        -Add @{
            "extensionAttribute1" = $PCName; # Nom de PC
            "extensionAttribute2" = $PCBrand; # Marque PC
            "extensionAttribute3" = $BirthDate; # Date de naissance
            "extensionAttribute4" = $Telework; # Télétravail
        }

    Write-Host "Utilisateur $FullName créé avec succès dans $OU"
}