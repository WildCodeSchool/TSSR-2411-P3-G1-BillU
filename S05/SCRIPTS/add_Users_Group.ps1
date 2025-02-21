# Import du module Active Directory
Import-Module ActiveDirectory

# Définition du domaine
$domainDN = (Get-ADDomain).DistinguishedName

# Définition du chemin du fichier CSV
$CSVFile = "C:\Users-BILLU.csv"

# Importation des utilisateurs depuis le fichier CSV
$Users = Import-Csv -Path $CSVFile -Delimiter ";" -Encoding UTF8

# Structure des OUs et leurs groupes (basée sur CreatGROUP.ps1)
$ouStructure = @{
    "Direction" = @("SG_Direction", "DG_Direction_Read", "DG_Direction_Write")
    "DSI" = @("SG_DSI", "DG_DSI_Read", "DG_DSI_Write")
    "Administration Systèmes et Réseaux" = @("SG_Administration_Systèmes_et_Réseaux", "DG_Administration_Systèmes_et_Réseaux_Read", "DG_Administration_Systèmes_et_Réseaux_Write")
    "Développement et Intégration" = @("SG_Développement_et_Intégration", "DG_Développement_et_Intégration_Read", "DG_Développement_et_Intégration_Write")
    "Exploitation" = @("SG_Exploitation", "DG_Exploitation_Read", "DG_Exploitation_Write")
    "Support" = @("SG_Support", "DG_Support_Read", "DG_Support_Write")
    "Développement logiciel" = @("SG_Développement_logiciel", "DG_Développement_logiciel_Read", "DG_Développement_logiciel_Write")
    "Analyse et conception" = @("SG_Analyse_et_conception", "DG_Analyse_et_conception_Read", "DG_Analyse_et_conception_Write")
    "Développement" = @("SG_Développement", "DG_Développement_Read", "DG_Développement_Write")
    "Recherche et Prototype" = @("SG_Recherche_et_Prototype", "DG_Recherche_et_Prototype_Read", "DG_Recherche_et_Prototype_Write")
    "Test et qualité" = @("SG_Test_et_qualité", "DG_Test_et_qualité_Read", "DG_Test_et_qualité_Write")
    "Service Commercial" = @("SG_Service_Commercial", "DG_Service_Commercial_Read", "DG_Service_Commercial_Write")
    "ADV" = @("SG_ADV", "DG_ADV_Read", "DG_ADV_Write")
    "B2B" = @("SG_B2B", "DG_B2B_Read", "DG_B2B_Write")
    "Service Achat" = @("SG_Service_Achat", "DG_Service_Achat_Read", "DG_Service_Achat_Write")
    "Service Client" = @("SG_Service_Client", "DG_Service_Client_Read", "DG_Service_Client_Write")
    "Finance et Comptabilité" = @("SG_Finance_et_Comptabilité", "DG_Finance_et_Comptabilité_Read", "DG_Finance_et_Comptabilité_Write")
    "Finance" = @("SG_Finance", "DG_Finance_Read", "DG_Finance_Write")
    "Fiscalité" = @("SG_Fiscalité", "DG_Fiscalité_Read", "DG_Fiscalité_Write")
    "Service Comptabilité" = @("SG_Service_Comptabilité", "DG_Service_Comptabilité_Read", "DG_Service_Comptabilité_Write")
    "QHSE" = @("SG_QHSE", "DG_QHSE_Read", "DG_QHSE_Write")
    "Certification" = @("SG_Certification", "DG_Certification_Read", "DG_Certification_Write")
    "Contrôle Qualité" = @("SG_Contrôle_Qualité", "DG_Contrôle_Qualité_Read", "DG_Contrôle_Qualité_Write")
    "Gestion Environnementale" = @("SG_Gestion_Environnementale", "DG_Gestion_Environnementale_Read", "DG_Gestion_Environnementale_Write")
    "Département Juridique" = @("SG_Département_Juridique", "DG_Département_Juridique_Read", "DG_Département_Juridique_Write")
    "Droit des sociétés" = @("SG_Droit_des_sociétés", "DG_Droit_des_sociétés_Read", "DG_Droit_des_sociétés_Write")
    "Propriété intellectuelle" = @("SG_Propriété_intellectuelle", "DG_Propriété_intellectuelle_Read", "DG_Propriété_intellectuelle_Write")
    "Protection des données et conformité" = @("SG_Protection_des_données_et_conformité", "DG_Protection_des_données_et_conformité_Read", "DG_Protection_des_données_et_conformité_Write")
    "Communication et Relations publiques" = @("SG_Communication_et_Relations_publiques", "DG_Communication_et_Relations_publiques_Read", "DG_Communication_et_Relations_publiques_Write")
    "Communication interne" = @("SG_Communication_interne", "DG_Communication_interne_Read", "DG_Communication_interne_Write")
    "Gestion des marques" = @("SG_Gestion_des_marques", "DG_Gestion_des_marques_Read", "DG_Gestion_des_marques_Write")
    "Relation Médias" = @("SG_Relation_Médias", "DG_Relation_Médias_Read", "DG_Relation_Médias_Write")
    "Service recrutement" = @("SG_Service_recrutement", "DG_Service_recrutement_Read", "DG_Service_recrutement_Write")
}

# Fonction pour ajouter un utilisateur à un groupe
function Add-UserToGroup {
    param (
        [string]$UserSamAccountName,
        [string]$GroupName
    )
    try {
        # Vérifier si le groupe existe
        $Group = Get-ADGroup -Filter "Name -eq '$GroupName'" -ErrorAction SilentlyContinue
        if ($Group) {
            # Ajouter l'utilisateur au groupe
            Add-ADGroupMember -Identity $GroupName -Members $UserSamAccountName -ErrorAction SilentlyContinue
            Write-Host "Utilisateur $UserSamAccountName ajouté au groupe $GroupName" -ForegroundColor Green
        } else {
            Write-Host "Le groupe $GroupName n'existe pas" -ForegroundColor Yellow
        }
    } catch {
        Write-Host "Erreur lors de l'ajout de l'utilisateur $UserSamAccountName au groupe $GroupName : $_" -ForegroundColor Red
    }
}

# Parcours de chaque utilisateur dans le fichier CSV
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
            # Identifier l'OU de l'utilisateur
            $OUPath = $User.OU
            $OUName = ($OUPath -split ",")[0] -replace "OU=", ""

            # Ajouter l'utilisateur aux groupes de son OU
            if ($ouStructure.ContainsKey($OUName)) {
                foreach ($GroupName in $ouStructure[$OUName]) {
                    Add-UserToGroup -UserSamAccountName $SamAccountName -GroupName $GroupName
                }
            } else {
                Write-Host "Aucun groupe défini pour l'OU $OUName" -ForegroundColor Yellow
            }
        } else {
            Write-Host "L'utilisateur $($User.displayName) n'existe pas dans Active Directory" -ForegroundColor Red
        }
    } catch {
        Write-Host "Erreur lors du traitement de l'utilisateur $($User.displayName): $_" -ForegroundColor Red
    }
}

Write-Host "Traitement terminé" -ForegroundColor Green