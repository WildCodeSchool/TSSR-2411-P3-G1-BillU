# Import du module Active Directory
Import-Module ActiveDirectory

# Définir le chemin racine du disque réseau
$NetworkDrive = "E:\"

# Structure des départements et services
$DepartmentStructure = @{
    "Communication et Relations publiques" = @("Communication interne", "Gestion des marques", "Relation Médias")
    "Département Juridique" = @("Droit des sociétés", "Propriété intellectuelle", "Protection des données et conformité")
    "Développement logiciel" = @("Analyse et conception", "Développement", "Recherche et Prototype", "Test et qualité")
    "DSI" = @("Administration Systèmes et Réseaux", "Développement et Intégration", "Exploitation", "Support")
    "Finance et Comptabilité" = @("Finance", "Fiscalité", "Service Comptabilité")
    "QHSE" = @("Certification", "Contrôle Qualité", "Gestion Environnementale")
    "Service Commercial" = @("ADV", "B2B", "Service Achat", "Service Client")
    "Service recrutement" = @()
}

# Importation des utilisateurs depuis le fichier CSV
$CSVFile = "C:\BILLU\Users6.csv"
$Users = Import-Csv -Path $CSVFile -Delimiter ";" -Encoding UTF8

# Fonction pour créer un dossier avec des permissions spécifiques
function Create-FolderWithPermissions {
    param (
        [string]$FolderPath,
        [string]$GroupName
    )
    try {
        # Créer le dossier s'il n'existe pas
        if (-not (Test-Path -Path $FolderPath)) {
            New-Item -ItemType Directory -Path $FolderPath -Force
            Write-Host "Dossier créé : $FolderPath" -ForegroundColor Green
        } else {
            Write-Host "Le dossier existe déjà : $FolderPath" -ForegroundColor Yellow
        }

        # Configurer les permissions
        $Acl = Get-Acl -Path $FolderPath
        $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("$GroupName", "FullControl", "ContainerInherit,ObjectInherit", "None", "Allow")
        $Acl.SetAccessRule($AccessRule)
        Set-Acl -Path $FolderPath -AclObject $Acl
        Write-Host "Permissions configurées pour $GroupName sur $FolderPath" -ForegroundColor Green
    } catch {
        Write-Host "Erreur lors de la création ou de la configuration des permissions pour $FolderPath : $_" -ForegroundColor Red
    }
}

# Création des dossiers pour les départements et services
foreach ($Department in $DepartmentStructure.Keys) {
    # Chemin du dossier du département
    $DepartmentPath = Join-Path -Path $NetworkDrive -ChildPath $Department

    # Créer le dossier du département
    Create-FolderWithPermissions -FolderPath $DepartmentPath -GroupName "SG_$($Department -replace ' ', '_')"

    # Créer les dossiers pour les services
    foreach ($Service in $DepartmentStructure[$Department]) {
        $ServicePath = Join-Path -Path $DepartmentPath -ChildPath $Service
        Create-FolderWithPermissions -FolderPath $ServicePath -GroupName "SG_$($Service -replace ' ', '_')"
    }
}

# Création des dossiers personnels pour chaque utilisateur
foreach ($User in $Users) {
    try {
        $SamAccountName = $User.sAMAccountName
        if ($SamAccountName -eq $null) {
            Write-Host "Erreur : Impossible de trouver le SamAccountName pour $($User.displayName)" -ForegroundColor Red
            continue
        }

        # Chemin du dossier personnel
        $PersonalFolderPath = Join-Path -Path $NetworkDrive -ChildPath "Users\$SamAccountName"

        # Créer le dossier personnel
        if (-not (Test-Path -Path $PersonalFolderPath)) {
            New-Item -ItemType Directory -Path $PersonalFolderPath -Force
            Write-Host "Dossier personnel créé : $PersonalFolderPath" -ForegroundColor Green
        } else {
            Write-Host "Le dossier personnel existe déjà : $PersonalFolderPath" -ForegroundColor Yellow
        }

        # Configurer les permissions pour l'utilisateur
        $Acl = Get-Acl -Path $PersonalFolderPath
        $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("$SamAccountName", "FullControl", "ContainerInherit,ObjectInherit", "None", "Allow")
        $Acl.SetAccessRule($AccessRule)
        Set-Acl -Path $PersonalFolderPath -AclObject $Acl
        Write-Host "Permissions configurées pour $SamAccountName sur $PersonalFolderPath" -ForegroundColor Green
    } catch {
        Write-Host "Erreur lors de la création ou de la configuration des permissions pour le dossier personnel de $($User.displayName) : $_" -ForegroundColor Red
    }
}

Write-Host "Création des dossiers et configuration des permissions terminées" -ForegroundColor Green