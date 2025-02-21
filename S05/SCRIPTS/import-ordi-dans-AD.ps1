# Importer le fichier CSV
$CSVPath = "C:\Scripts\test-debug-AD-COMPLET.csv"
$Computers = Import-Csv -Path $CSVPath -Delimiter ";"

# Vérifier si le fichier est bien chargé
if (-not $Computers) {
    Write-Host "Erreur : Le fichier CSV est vide ou introuvable à l'emplacement $CSVPath" -ForegroundColor Red
    exit
}

# Afficher les colonnes détectées
Write-Host "Colonnes détectées dans le CSV :" -ForegroundColor Cyan
$Computers[0] | Get-Member -MemberType NoteProperty

foreach ($Computer in $Computers) {
    # S'assurer que les colonnes sont bien récupérées et supprimer les espaces
    $ComputerName = $Computer."ComputerName".Trim()
    $UserName = $Computer."UserName".Trim()
    $OU = $Computer."OU".Trim()
    
    if (-not $ComputerName) {
        Write-Host "Erreur : ComputerName est vide pour une ligne du CSV" -ForegroundColor Red
        continue
    }
    
    # Vérifier si l'ordinateur existe déjà dans AD
    if (-not (Get-ADComputer -Filter { Name -eq $ComputerName })) {
        # Ajouter le nouvel ordinateur
        New-ADComputer -Name $ComputerName -Path $OU -Enabled $true
        Write-Host "PC $ComputerName ajouté à $OU" -ForegroundColor Green
    } else {
        Write-Host "PC $ComputerName existe déjà dans AD" -ForegroundColor Yellow
    }
    
    # Lier le PC à l'utilisateur en ajoutant une description
    Set-ADComputer -Identity $ComputerName -Description "Affecté à $UserName"
    Write-Host "Description mise à jour pour $ComputerName : Affecté à $UserName" -ForegroundColor Cyan
}

Write-Host "Import terminé." -ForegroundColor Green
