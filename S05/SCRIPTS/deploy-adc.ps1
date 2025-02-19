# Script principal de déploiement AD-DS
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