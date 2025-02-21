# Import du module Active Directory
Import-Module ActiveDirectory

# Définition du chemin du fichier CSV
$CSVFile = "C:\Users-BILLU.csv"

# Importation des utilisateurs depuis le fichier CSV
$Users = Import-Csv -Path $CSVFile -Delimiter ";" -Encoding UTF8

# Définition du domaine
$domainDN = (Get-ADDomain).DistinguishedName

# Nom et chemin du groupe GLPI
$GLPIGroupName = "GLPI-Users"
$GLPIGroupPath = "OU=ListeUtilisateurs,$domainDN"

# Vérifier si le groupe GLPI existe, sinon le créer
if (-not (Get-ADGroup -Filter "Name -eq '$GLPIGroupName'" -SearchBase $GLPIGroupPath -ErrorAction SilentlyContinue)) {
    New-ADGroup -Name $GLPIGroupName `
        -Path $GLPIGroupPath `
        -GroupScope Global `
        -GroupCategory Security `
        -Description "Groupe global pour tous les utilisateurs GLPI"
    Write-Host "Groupe '$GLPIGroupName' créé avec succès dans $GLPIGroupPath" -ForegroundColor Green
} else {
    Write-Host "Le groupe '$GLPIGroupName' existe déjà dans $GLPIGroupPath" -ForegroundColor Yellow
}

# Ajout des utilisateurs au groupe GLPI
foreach ($User in $Users) {
    try {
        # Récupérer le SamAccountName
        $SamAccountName = $User.sAMAccountName
        if ($SamAccountName -eq $null) {
            Write-Host "Erreur : Impossible de trouver le SamAccountName pour $($User.displayName)" -ForegroundColor Red
            continue
        }

        # Vérifier si l'utilisateur existe dans Active Directory
        $ADUser = Get-ADUser -Filter {SamAccountName -eq $SamAccountName} -ErrorAction SilentlyContinue
        if ($ADUser) {
            # Ajouter l'utilisateur au groupe GLPI
            Add-ADGroupMember -Identity $GLPIGroupName -Members $ADUser.SamAccountName -ErrorAction SilentlyContinue
            Write-Host "Utilisateur $($User.displayName) ajouté au groupe '$GLPIGroupName'" -ForegroundColor Green
        } else {
            Write-Host "L'utilisateur $($User.displayName) n'existe pas dans Active Directory" -ForegroundColor Red
        }
    } catch {
        Write-Host "Erreur lors de l'ajout de l'utilisateur $($User.displayName) au groupe '$GLPIGroupName': $_" -ForegroundColor Red
    }
}

Write-Host "Ajout des utilisateurs au groupe '$GLPIGroupName' terminé" -ForegroundColor Green