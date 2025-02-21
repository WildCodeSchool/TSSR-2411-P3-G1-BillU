# Script de gestion de la télémétrie Windows 10/11
# À exécuter avec des privilèges administratifs

# Configuration des paramètres d'audit
$LogPath = "C:\Logs\TelemetryConfig.log"
$DateFormat = "yyyy-MM-dd HH:mm:ss"

# Fonction de journalisation
function Write-Log {
    param($Message)
    $LogMessage = "$(Get-Date -Format $DateFormat) - $Message"
    Add-Content -Path $LogPath -Value $LogMessage
    Write-Host $LogMessage
}

# Création du dossier de logs s'il n'existe pas
if (-not (Test-Path (Split-Path $LogPath))) {
    New-Item -ItemType Directory -Path (Split-Path $LogPath) -Force
}

Write-Log "Début de la configuration de la télémétrie"

try {
    # 1. Désactivation des services de télémétrie
    $TelemetryServices = @(
        "DiagTrack"                    # Service de suivi et diagnostic connecté
        "dmwappushservice"             # Service de messagerie WAP Push
    )

    foreach ($Service in $TelemetryServices) {
        $ServiceStatus = Get-Service -Name $Service -ErrorAction SilentlyContinue
        if ($ServiceStatus) {
            Stop-Service -Name $Service -Force
            Set-Service -Name $Service -StartupType Disabled
            Write-Log "Service $Service désactivé avec succès"
        }
    }

    # 2. Configuration des stratégies de télémétrie
    $TelemetryPolicies = @{
        "AllowTelemetry"                       = 0  # 0 = Sécurité (minimum)
        "DisableEnterpriseAuthProxy"           = 1
        "DisableSettings"                      = 1
        "DisableTelemetryOptInChangeNotification" = 1
        "DisableWindowsSpotlightFeatures"      = 1
    }

    foreach ($Policy in $TelemetryPolicies.GetEnumerator()) {
        $RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"
        if (-not (Test-Path $RegPath)) {
            New-Item -Path $RegPath -Force | Out-Null
        }
        Set-ItemProperty -Path $RegPath -Name $Policy.Key -Value $Policy.Value -Type DWord
        Write-Log "Politique $($Policy.Key) configurée avec la valeur $($Policy.Value)"
    }

    # 3. Désactivation des tâches planifiées de télémétrie
    $TelemetryTasks = @(
        "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser"
        "\Microsoft\Windows\Application Experience\ProgramDataUpdater"
        "\Microsoft\Windows\Autochk\Proxy"
        "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator"
        "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip"
        "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector"
    )

    foreach ($Task in $TelemetryTasks) {
        $ScheduledTask = Get-ScheduledTask -TaskPath (Split-Path $Task) -TaskName (Split-Path $Task -Leaf) -ErrorAction SilentlyContinue
        if ($ScheduledTask) {
            Disable-ScheduledTask -TaskPath (Split-Path $Task) -TaskName (Split-Path $Task -Leaf)
            Write-Log "Tâche planifiée $Task désactivée"
        }
    }

    # 4. Configuration des pare-feu pour bloquer la télémétrie
    $TelemetryEndpoints = @(
        "vortex.data.microsoft.com"
        "vortex-win.data.microsoft.com"
        "telecommand.telemetry.microsoft.com"
        "telecommand.telemetry.microsoft.com.nsatc.net"
        "oca.telemetry.microsoft.com"
        "oca.telemetry.microsoft.com.nsatc.net"
        "sqm.telemetry.microsoft.com"
        "sqm.telemetry.microsoft.com.nsatc.net"
    )

    foreach ($Endpoint in $TelemetryEndpoints) {
        $Rule = "Block-Telemetry-$($Endpoint.Split('.')[0])"
        New-NetFirewallRule -DisplayName $Rule -Direction Outbound -Action Block -RemoteAddress $Endpoint -ErrorAction SilentlyContinue
        Write-Log "Règle de pare-feu créée pour bloquer $Endpoint"
    }

    Write-Log "Configuration de la télémétrie terminée avec succès"
}
catch {
    Write-Log "ERREUR: $($_.Exception.Message)"
    throw
}
finally {
    Write-Log "Fin du script"
}
