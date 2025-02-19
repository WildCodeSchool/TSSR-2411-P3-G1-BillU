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