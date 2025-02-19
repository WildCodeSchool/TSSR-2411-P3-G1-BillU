
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

### 🎯 Prérequis
1. 💻 Un serveur Windows avec interface graphique (serveur source)
2. 🖥️ Un serveur Windows Core (serveur cible)
3. 🌐 Les deux serveurs doivent être sur le même réseau
4. ⚡ PowerShell 5.1 ou supérieur sur les deux serveurs

### 🔄 Étapes de Déploiement

1. **🛠️ Préparation du Serveur Source**
   - 📁 Créez le dossier `C:\DeployAD`
   - 📝 Copiez les fichiers `config.ps1` et `deploy-adc.ps1` dans ce dossier
   - ⚙️ Modifiez `config.ps1` avec vos paramètres spécifiques :
     * 🌐 IP du serveur cible
     * 🏢 Nom de domaine souhaité
     * 🔑 Identifiants administrateur

2. **📡 Vérification du Réseau**
   - 🔍 Testez la connectivité entre les serveurs :
     ```powershell
     Test-NetConnection -ComputerName 172.18.0.2 -Port 5985
     ```

3. **▶️ Exécution du Déploiement**
   - 🚀 Ouvrez PowerShell en administrateur
   - 📂 Naviguez vers le dossier des scripts :
     ```powershell
     cd C:\DeployAD
     ```
   - ⚡ Exécutez le script :
     ```powershell
     .\deploy-adc.ps1
     ```

4. **✅ Vérification du Déploiement**
   - 🔌 Connectez-vous au serveur distant :
     ```powershell
     Enter-PSSession -ComputerName 172.18.0.2 -Credential $credential
     ```
   - 🔍 Vérifiez le statut d'AD-DS :
     ```powershell
     Get-Service adws,kdc,netlogon,dns
     ```

## 🔍 Explication du Fonctionnement

### ⚙️ Configuration (config.ps1)
- 📊 Centralise tous les paramètres de déploiement
- 🔄 Facilite la réutilisation et la modification
- 🧩 Sépare la configuration de la logique de déploiement

### 🚀 Déploiement (deploy-adc.ps1)
1. **📝 Préparation**
   - 🔧 Configure WinRM pour la communication à distance
   - 🔒 Établit une session PowerShell sécurisée

2. **💿 Installation**
   - ✔️ Vérifie l'état actuel du serveur
   - 📦 Installe les rôles nécessaires
   - ⚙️ Configure AD-DS selon les paramètres

3. **🔐 Sécurité**
   - 🛡️ Utilise des sessions PowerShell sécurisées
   - ⚠️ Gère les erreurs et le nettoyage
   - 🔑 Protège les identifiants sensibles

## 🛠️ Dépannage

### ⚡ Problèmes Courants
1. **❌ Erreur WinRM**
   - ✅ Vérifiez que WinRM est activé sur les deux serveurs
   - 🛡️ Vérifiez les pare-feu
   - 🔍 Vérifiez les TrustedHosts

2. **⛔ Échec d'Installation AD-DS**
   - 📋 Vérifiez les prérequis système
   - 📜 Consultez les journaux d'événements
   - 💾 Vérifiez l'espace disque disponible

3. **🔌 Problèmes de Connexion**
   - 🔑 Vérifiez les identifiants
   - 🌐 Vérifiez la résolution DNS
   - 📡 Vérifiez la connectivité réseau

## 💡 Astuces Bonus
- 🔄 Faites toujours une sauvegarde avant le déploiement
- 📝 Gardez une trace des modifications apportées
- ⏰ Planifiez le déploiement pendant les heures creuses
- 📞 Ayez un plan de support à portée de main

## 🎉 Succès du Déploiement
Une fois le déploiement terminé avec succès, vous aurez :
- ✅ Un contrôleur de domaine fonctionnel
- ✅ Active Directory correctement configuré
- ✅ DNS installé et configuré
- ✅ Une base solide pour votre infrastructure
