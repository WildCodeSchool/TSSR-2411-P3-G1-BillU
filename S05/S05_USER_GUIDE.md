# Journal de bord - Semaine 5

📝 **Nouvelle méthodologie de travail**

 -planning avec des priorité plus détaillé
 - Optimisation des taches
 - avancées plus rapide et precise des besoins

📡 **Schéma CPT avec VLANs fonctionnels :**
- Révision du schéma réseau avec ajustement des VLANs.
- Optimisation de la configuration du switch et vérification des routages inter-VLAN.


👥 **Active Directory : Groupes, Ordinateurs, Utilisateurs :**
- Création des ordinateurs dans l'AD.
- Ajustement de l'arborescence et mise à jour des groupes d'utilisateurs.
- Tests de connexion des machines au domaine et application des stratégies de groupe.

🖥️ **GLPI : Intégration des machines :**
- Importation réussie de plusieurs machines dans GLPI.
- Validation de la remontée automatique des informations.

💾 **Veeam : Mise en place d'un serveur de sauvegarde :**
- Création d'un nouveau serveur dédié à Veeam.
- Installation et configuration initiale du logiciel de sauvegarde.
- Début de la configuration des politiques de sauvegarde.

🗂️ **Disque  en RAID 1 sur le serveur principal :**
- Mise en place du RAID 1 sur le serveur principal.
- Création de l'arborescence des dossiers avec application des droits d'accès basés sur les groupes AD.
- Tests d'accès aux ressources partagées par les utilisateurs.

📜 **Script PowerShell : Intégration automatique des serveurs AD :**
- Développement d'un script PowerShell pour ajouter automatiquement un serveur au domaine Active Directory.
- Test et validation du script avec succès.

📈 **Télémétrie en cours :**
- Développement en cours d'un script PowerShell pour la mise en place et la gestion de la télémétrie.
- Tests initiaux en cours pour la collecte des métriques système et réseau.

Les avancées de cette semaine sont prometteuses, avec des résultats concrets sur la majorité des tâches prévues.



# 🚀 Guide de Déploiement Automatisé AD-DS

Ce guide détaille la procédure d'automatisation du déploiement d'Active Directory Domain Services (AD-DS) sur un serveur Windows Core en utilisant PowerShell.

## 📜 Scripts PowerShell

### 1. ⚙️ config.ps1
```powershell
# Configuration du déploiement AD-DS
# À placer dans C:\DeployAD\config.ps1

# Configuration du serveur cible
$RemoteServer = "172.18.0.2"        # IP du serveur Core
$RemoteFolder = "C:\Scripts\AD"      # Dossier de destination sur le serveur Core
$SessionUser = "Administrateur"      # Compte administrateur

# Configuration AD-DS
$ServerName = "SRV-DC"              # Nom du serveur
$DomainName = "BILLU.lan"           # Nom du domaine
$DNSAddress = "172.18.0.2"          # Adresse IP du DNS (même que le serveur)
$AdminUser = "Administrateur"        # Compte administrateur du domaine

# Configuration WinRM (pour la connexion à distance)
$WinRMConfig = @{
    TrustedHosts = "*"              # Hôtes autorisés pour WinRM
    Force = $true                   # Forcer la configuration
}
```

### 2. 🔄 deploy-adc.ps1
```# Script principal de déploiement AD-DS
# À placer dans C:\DeployAD\deploy-adc.ps1

# Importation de la configuration
$configPath = Join-Path $PSScriptRoot "config.ps1"
if (!(Test-Path $configPath)) {
    Write-Error "Fichier de configuration non trouvé : $configPath"
    exit 1
}
. $configPath

# Fonction pour configurer WinRM sur le serveur local
function Configure-LocalWinRM {
    Write-Host "Configuration de WinRM en local..."
    Enable-PSRemoting -Force
    Set-Item WSMan:\localhost\Client\TrustedHosts -Value $WinRMConfig.TrustedHosts -Force
    Restart-Service WinRM
}

# Fonction pour préparer le serveur distant
function Prepare-RemoteServer {
    param (
        [System.Management.Automation.Runspaces.PSSession]$Session
    )
    
    Write-Host "Préparation du serveur distant..."
    Invoke-Command -Session $Session -ScriptBlock {
        # Création du dossier de destination
        if (!(Test-Path $using:RemoteFolder)) {
            New-Item -Path $using:RemoteFolder -ItemType Directory -Force
        }
        
        # Configuration de WinRM
        Enable-PSRemoting -Force
        Set-Item WSMan:\localhost\Client\TrustedHosts -Value "*" -Force
        Restart-Service WinRM
    }
}

# Fonction pour installer AD-DS
function Install-ADDS {
    param (
        [System.Management.Automation.Runspaces.PSSession]$Session
    )

    Write-Host "Installation d'AD-DS..."
    Invoke-Command -Session $Session -ScriptBlock {
        # Vérification du domaine
        $domainStatus = Get-WmiObject -Class Win32_ComputerSystem | 
            Select-Object -ExpandProperty Domain
        if ($domainStatus -eq $using:DomainName) {
            Write-Host "Le serveur est déjà membre du domaine $using:DomainName."
            return
        }

        # Installation du rôle AD-DS
        $addsRole = Get-WindowsFeature AD-Domain-Services
        if (!$addsRole.Installed) {
            Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
        }

        # Configuration d'AD-DS
        Import-Module ADDSDeployment
        Install-ADDSDomainController `
            -DomainName $using:DomainName `
            -InstallDns:$true `
            -DatabasePath "C:\Windows\NTDS" `
            -SysvolPath "C:\Windows\SYSVOL" `
            -LogPath "C:\Windows\NTDS" `
            -NoGlobalCatalog:$false `
            -Force:$true
    }
}

# Script principal
try {
    # Configuration de WinRM en local
    Configure-LocalWinRM

    # Création de la session distante
    Write-Host "Connexion au serveur distant..."
    $securePassword = Read-Host -Prompt "Mot de passe Administrateur" -AsSecureString
    $credential = New-Object System.Management.Automation.PSCredential($SessionUser, $securePassword)
    $session = New-PSSession -ComputerName $RemoteServer -Credential $credential

    # Préparation et déploiement
    Prepare-RemoteServer -Session $session
    Install-ADDS -Session $session

    Write-Host "Déploiement terminé avec succès!"

} catch {
    Write-Error "Erreur durant le déploiement: $_"
} finally {
    # Nettoyage
    if ($session) {
        Remove-PSSession $session
    }
}
```

## 📋 Procédure de Déploiement

# 🛠️ Procédure de Déploiement d'un Contrôleur de Domaine AD-DS avec PowerShell


## 🚦 **Étapes du déploiement :**

### 1. **Importation de la configuration :**
```powershell
$configPath = Join-Path $PSScriptRoot "config.ps1"
if (!(Test-Path $configPath)) {
    Write-Error "Fichier de configuration non trouvé : $configPath"
    exit 1
}
. $configPath
```
- Charge les paramètres du fichier `config.ps1`.
- Arrête le script si le fichier est manquant.

---

### 2. **Configuration de WinRM en local :**
```powershell
function Configure-LocalWinRM {
    Write-Host "Configuration de WinRM en local..."
    Enable-PSRemoting -Force
    Set-Item WSMan:\localhost\Client\TrustedHosts -Value $WinRMConfig.TrustedHosts -Force
    Restart-Service WinRM
}
```
- Active PowerShell Remoting.
- Définit les hôtes de confiance pour WinRM.
- Redémarre le service WinRM.

---

### 3. **Préparation du serveur distant :**
```powershell
function Prepare-RemoteServer {
    param ([System.Management.Automation.Runspaces.PSSession]$Session)
    Write-Host "Préparation du serveur distant..."
    Invoke-Command -Session $Session -ScriptBlock {
        if (!(Test-Path $using:RemoteFolder)) {
            New-Item -Path $using:RemoteFolder -ItemType Directory
        }
    }
}
```
- Crée un dossier spécifique sur le serveur distant si nécessaire.

---

### 4. **Installation d'AD-DS :**
```powershell
function Install-ADDS {
    param ([System.Management.Automation.Runspaces.PSSession]$Session)
    Write-Host "Installation d'AD-DS..."
    Invoke-Command -Session $Session -ScriptBlock {
        $domainStatus = Get-WmiObject -Class Win32_ComputerSystem | Select-Object -ExpandProperty Domain
        if ($domainStatus -eq $using:DomainName) {
            Write-Host "Le serveur est déjà membre du domaine $using:DomainName."
            return
        }
        $addsRole = Get-WindowsFeature AD-Domain-Services
        if (!$addsRole.Installed) {
            Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
        }
        Import-Module ADDSDeployment
        Install-ADDSDomainController `
            -DomainName $using:DomainName `
            -InstallDns:$true `
            -DatabasePath "C:\Windows\NTDS" `
            -SysvolPath "C:\Windows\SYSVOL" `
            -LogPath "C:\Windows\NTDS" `
            -NoGlobalCatalog:$false `
            -Force:$true
    }
}
```
- Vérifie si le serveur est déjà membre du domaine.
- Installe le rôle AD-DS si nécessaire.
- Configure et promeut le serveur en tant que contrôleur de domaine.

---

### 5. **Exécution du script principal :**
```powershell
try {
    Configure-LocalWinRM
    Write-Host "Connexion au serveur distant..."
    $securePassword = Read-Host -Prompt "Mot de passe Administrateur" -AsSecureString
    $credential = New-Object System.Management.Automation.PSCredential($SessionUser, $securePassword)
    $session = New-PSSession -ComputerName $RemoteServer -Credential $credential
    Prepare-RemoteServer -Session $session
    Install-ADDS -Session $session
    Write-Host "Déploiement terminé avec succès!"
} catch {
    Write-Error "Erreur durant le déploiement: $_"
} finally {
    if ($session) {
        Remove-PSSession $session
    }
}
```
- Configure WinRM.
- Établit une session distante sécurisée.
- Exécute les fonctions de préparation et d'installation.
- Nettoie la session en fin de script.

---





## 🎉 Succès du Déploiement
Une fois le déploiement terminé avec succès, vous aurez :
- ✅ Un contrôleur de domaine fonctionnel
- ✅ Active Directory correctement configuré
- ✅ DNS installé et configuré
- ✅ Une base solide pour votre infrastructure
