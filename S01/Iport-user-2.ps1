# Chemin du fichier CSV
$cheminCSV = "C:\chemin\vers\utilisateurs.csv"

# Mot de passe par défaut
$motDePasseParDefaut = "Azerty1*"

# Domaine Active Directory
$domaine = "BILLU.lan"

# Importer les utilisateurs depuis le fichier CSV
$utilisateurs = Import-Csv -Path $cheminCSV

foreach ($utilisateur in $utilisateurs) {
    # Construire le chemin de l'OU
    $cheminOU = "OU=" + ($utilisateur.OU -replace "/", ",OU=") + ",DC=BILLU,DC=lan"

    # Vérifier si l'OU existe
    if (-not (Get-ADOrganizationalUnit -Filter "DistinguishedName -eq '$cheminOU'" -ErrorAction SilentlyContinue)) {
        Write-Host "L'OU $($utilisateur.OU) n'existe pas. Veuillez vérifier." -ForegroundColor Red
        continue
    }

    # Construire le nom complet de l'utilisateur
    $nomComplet = "$($utilisateur.Prenom) $($utilisateur.Nom)"

    # Construire le nom complet du manager
    $managerNomComplet = "$($utilisateur.'Manager-Prenom') $($utilisateur.'Manager-Nom')"

    # Créer l'utilisateur
    try {
        New-ADUser `
            -SamAccountName "$($utilisateur.Prenom).$($utilisateur.Nom)" `
            -Name $nomComplet `
            -GivenName $utilisateur.Prenom `
            -Surname $utilisateur.Nom `
            -DisplayName $nomComplet `
            -EmailAddress "$($utilisateur.Prenom).$($utilisateur.Nom)@$($utilisateur.Societe).com" `
            -Department $utilisateur.Departement `
            -Title $utilisateur.Fonction `
            -Office $utilisateur.Site `
            -Company $utilisateur.Societe `
            -Manager $managerNomComplet `
            -AccountPassword (ConvertTo-SecureString $motDePasseParDefaut -AsPlainText -Force) `
            -Enabled $true `
            -Path $cheminOU `
            -ChangePasswordAtLogon $true `
            -OtherAttributes @{
                'TelephoneNumber' = $utilisateur.'Telephone fixe';
                'Mobile' = $utilisateur.'Telephone portable';
                'Description' = "Télétravail : $($utilisateur.Télétravail)";
                'DateOfBirth' = $utilisateur.'Date de naissance'
            } `
            -PassThru | Out-Null

        Write-Host "Utilisateur $nomComplet créé avec succès dans $($utilisateur.OU)." -ForegroundColor Green
    } catch {
        Write-Host "Erreur lors de la création de l'utilisateur $nomComplet : $_" -ForegroundColor Red
    }
}